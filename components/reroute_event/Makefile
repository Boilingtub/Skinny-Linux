TEST_ARGS = Touch /dev/null

TEST_FLAGS = -Wall -Wextra -Wshadow -g -static-libasan -fanalyzer -fsanitize=address
FIN_FLAGS = -Wall -Wextra -Werror -Wshadow -O3 
SRC = ./
CFILES = $(SRC)reroute_event.c 
LIBS = 
OUTPUT = reroute_event

test: $(CFILES)
	gcc $(TEST_FLAGS) -g $(CFILES) -o $(OUTPUT) $(LIBS)
	#gdb -ex=r --batch --args ./$(OUTPUT) $(TEST_ARGS);
	./$(OUTPUT) $(TEST_ARGS)

final: $(CFILES)
	gcc $(FIN_FLAGS) -Os $(CFILES) -o $(OUTPUT) $(LIBS)
