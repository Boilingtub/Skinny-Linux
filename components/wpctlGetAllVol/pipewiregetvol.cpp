#include<iostream>

std::string exec(const char* cmd) {
    char buffer[512];
    std::string result = "";
    FILE *pipe = popen(cmd,"r");
    if(!pipe) throw std::runtime_error("popen() failed!");
    try {
        while(fgets(buffer, sizeof(buffer), pipe) != NULL) {
            result += buffer;
        }
    } catch (...) {
        pclose(pipe);
        throw;
    }
    pclose(pipe);
    return result;
}

int main(int argc, char* argv[]) {
    if(argc <= 1) {
        std::cout << "no arguments\n";
        return 1;
    }

    std::string cmd_out = exec("wpctl status");
    size_t sinks_pos = cmd_out.find("Sinks")+13;
    size_t sources_pos = cmd_out.find("Sources");
    if( std::string(argv[1]) == "sinks"&& 
        sinks_pos != std::string::npos && 
        sources_pos != std::string::npos) {
        
        std::string data_sinks;
        data_sinks = cmd_out.substr(sinks_pos,sources_pos-sinks_pos-16);
        size_t vol_start_pos = data_sinks.find("[vol:")+6;
        size_t vol_end_pos =  data_sinks.find("]");
        int vol_sinks = std::stof(data_sinks.substr(vol_start_pos,vol_end_pos-vol_start_pos))*100;

        
        std::cout << vol_sinks << "%\n";
    }

    sources_pos += 15;
    size_t filters_pos = cmd_out.find("Filters");
    if( std::string(argv[1]) == "sources"&& 
        sources_pos != std::string::npos &&
        filters_pos != std::string::npos) {

        std::string data_sources;
        data_sources = cmd_out.substr(sources_pos,filters_pos-sources_pos-16);
        size_t vol_start_pos = data_sources.find("[vol:")+6;
        size_t vol_end_pos =  data_sources.find("]");
        float vol_sources = std::stof(data_sources.substr(vol_start_pos,vol_end_pos-vol_start_pos))*100;

        std::cout << vol_sources << "%\n";
    }

}
