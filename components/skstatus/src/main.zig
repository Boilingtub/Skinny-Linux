const components = @import("components");
const wait = components.wait;
const print = components.print;
const Battery = components.Battery;
const Backlight = components.Backlight;
const DateTime = components.DateTime;
const Wifi = components.Wifi;
const Week_day_names = components.Week_day_names;

pub fn main() !void {
    const interval = 3000;
    while (true) {
        const BAT = Battery.query("BAT0");
        const BL = Backlight.query();
        const DT = DateTime.query(-4);
        const WF = Wifi.query("wlp0s20f3");
        print(" ({c}):{d}%[{d}h {d}m] :{d}%  :{s}[{d}] | {d}:{d:0>2} {s} {d}/{d:0>2}/{d}\n", .{
            BAT.status,BAT.capacity,BAT.time_remaining[0],BAT.time_remaining[1],
            BL.percent,
            WF.ssid[0..], WF.signal,
            DT.Hour,DT.Minute,Week_day_names[DT.Week_day], DT.Year,DT.Month,DT.Day});
        wait(interval); 
    }
}
