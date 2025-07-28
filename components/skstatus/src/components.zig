const std = @import("std");
const version = "0.0.1";
pub const POWER_SUPPLY_PATH = "/sys/class/power_supply/";
pub const BACKLIGHT_PATH = "/sys/class/backlight/";
pub const BACKLIGHT_NAME = "intel_backlight";

var gpa = std.heap.GeneralPurposeAllocator(.{}){};

pub const Week_day_names:[7][3]u8 = .{
    .{'M','o','n'},.{'T','u','e'},.{'W','e','d'},.{'T','h','u'},.{'F','r','i'},
    .{'S','a','t'},.{'S','u','n'},
};  
pub const Month_Names:[12][3]u8 = .{
    .{'J','a','n'},.{'F','e','b'},.{'M','a','r'},.{'A','p','r'},.{'M','a','y'},
    .{'J','u','n'},.{'J','u','l'},.{'A','u','g'},.{'S','e','p'},.{'N','o','v'},
    .{'D','e','c'},
};

pub inline fn wait(comptime i: u64) void {
    std.Thread.sleep(i*1000000); 
}

pub inline fn print(comptime fmt:[]const u8,args: anytype) void {
    const stdout = std.io.getStdOut();
    var buf = std.io.bufferedWriter(stdout.writer());
    var w = buf.writer();
    w.print(fmt, args) catch {
        unreachable;
    };
    buf.flush() catch {
        unreachable;
    };
}

pub fn read_full_file(allocator: std.mem.Allocator, path: []const u8) ![]u8 {
    const file = try std.fs.cwd().openFile(path,.{});
    defer file.close();
    const stat = try file.stat();
    const buff = try file.readToEndAlloc(allocator, stat.size);
    return buff;
}

pub fn read_file_first_char(path: []const u8) !u8 {
    var file = try std.fs.cwd().openFile(path, .{});
    defer file.close();
    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();
    const byte = try in_stream.readByte();
    return byte;
}

pub fn read_file_to_int(T:type,path: []const u8) !T {
    var file = try std.fs.cwd().openFile(path, .{});
    defer file.close();
    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();
    var buf: [64]u8 = undefined; 
    const str = try in_stream.readUntilDelimiterOrEof(&buf, '\n');
    return std.fmt.parseInt(T,str.?,10);
}

pub fn read_file_to_float(T:type,path: []const u8) !T {
    var file = try std.fs.cwd().openFile(path, .{});
    defer file.close();
    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();
    var buf: [64]u8 = undefined; 
    const str = try in_stream.readUntilDelimiterOrEof(&buf, '\n');
    return std.fmt.parseFloat(T,str.?);
}

pub fn exec_cmd(allocator:std.mem.Allocator,
                argv: []const []const u8,
                max_size: usize) !std.ArrayListUnmanaged(u8) {
    var child = std.process.Child.init(argv, allocator);
    child.stdout_behavior = .Pipe;
    child.stderr_behavior = .Pipe;

    var stdout: std.ArrayListUnmanaged(u8) = .empty;
    var stderr: std.ArrayListUnmanaged(u8) = .empty;
    defer stderr.deinit(allocator);
    
    try child.spawn();
    try child.collectOutput(allocator, &stdout, &stderr, max_size);
    const term = try child.wait();
    try std.testing.expectEqual(term, std.process.Child.Term{ .Exited = 0});
    return stdout;
    
}


pub const Battery = struct {
    capacity: u8,
    time_remaining: [2]u8,
    status: u8,
    pub fn query(comptime bat_name: []const u8) !Battery {
        const bat_capacity = POWER_SUPPLY_PATH++bat_name++"/capacity";
        const bat_charge_now = POWER_SUPPLY_PATH++bat_name++"/charge_now";
        const bat_current_now = POWER_SUPPLY_PATH++bat_name++"/current_now";
        const bat_status = POWER_SUPPLY_PATH++bat_name++"/status";
        

        const found_status = try read_file_first_char(bat_status);
        var status: u8 = 'E';
        switch (found_status) {
            'D' => status = '-',
            'C' => status = '+',
            'F' => status = 'o',
            else => {},
        }

        const charge_now = try read_file_to_float(f32, bat_charge_now);
        const current_now = try read_file_to_float(f32, bat_current_now);
        const capacity = try read_file_to_int(u8,bat_capacity);

        const timeleft = @abs(charge_now / current_now);
	var h = @floor(timeleft);
	var m = @floor((timeleft - h) * 60);
        if (h > 254) {
            h = 0;
            m = 0;
        }

        return Battery {
            .capacity = capacity,
            .time_remaining = .{
                @as(u8, @intFromFloat(h)),
                @as(u8,@intFromFloat(m))
            }, 
            .status = status, 
        };
    } 
};

pub const Backlight = struct {
    percent: u8,
    pub fn query() !Backlight {
        const max_bright_path = 
            BACKLIGHT_PATH++BACKLIGHT_NAME++"/max_brightness";
        const bright_path = 
            BACKLIGHT_PATH++BACKLIGHT_NAME++"/brightness";

        const max_bright = try read_file_to_float(f32, max_bright_path);
        const bright = try read_file_to_float(f32, bright_path);
        const frac = @as(u8,@intFromFloat((bright/max_bright)*100));
        return Backlight {
            .percent = frac,
        };
    }
};

pub const Wifi = struct {
    ssid: std.ArrayList(u8),
    signal: i16,
    pub fn query(comptime wifi_device: []const u8) !Wifi {
        const allocator = gpa.allocator();

        const iw_argv = [_][]const u8{
            "iw","dev",wifi_device,"link",
        };
        var wifi_data_raw = try exec_cmd(allocator, &iw_argv, 1024);
        defer wifi_data_raw.deinit(allocator);

        const wifi_ssid_start = std.mem.indexOf(
            u8, wifi_data_raw.items[0..], "SSID: "
        ).? + 6;
        const wifi_ssid_end = std.mem.indexOf(
            u8, wifi_data_raw.items[wifi_ssid_start..], "\n"
        ).?;
        const wifi_ssid = wifi_data_raw.items[wifi_ssid_start..
            wifi_ssid_start+wifi_ssid_end];

        const wifi_signal_start = std.mem.indexOf(
            u8, wifi_data_raw.items[0..], "signal: ").? + 8;
        const wifi_signal_end = std.mem.indexOf(u8,
            wifi_data_raw.items[wifi_signal_start..], " ").?;
        const wifi_signal:i16 = @as(
            i16,
            @intCast(
                try std.fmt.parseInt(
                    i16,
                    wifi_data_raw.items[wifi_signal_start..
                        wifi_signal_start+wifi_signal_end],
                    10 
                )
            )
        );

        var wf = Wifi {
            .ssid = try std.ArrayList(u8).initCapacity(allocator,wifi_ssid.len),
            .signal = wifi_signal,
        };
        try wf.ssid.appendSlice(wifi_ssid);
        return wf;
    }
    pub fn deinit(self:Wifi) void {
        self.ssid.deinit();
    }
};

pub const DateTime = struct {
    Year: u16,
    Month: u8,
    Day: u8,
    Week_day:u8, 
    Hour: u8,
    Minute: u8,
    Second: u8,
    pub fn query(comptime timezone_shift: i16) DateTime {
        const ts = std.time.timestamp() + (timezone_shift*60*60);

        const addYear:f64 = @as(f64,@floatFromInt(ts))/60/60/24/365.25;
        const curYear:u16 = 1970+@as(u16,@intFromFloat(@floor(addYear)));
        const restYear:f64 = addYear-@floor(addYear);

        const realDay:u16 = @as(u16,@intFromFloat(@ceil(restYear*365.25)));
        const restDay:f64 = (restYear*365.25)-@floor(restYear*365.25);

        var addMonth:u8 = undefined;
        var addMonthDays:u16 = undefined; 
        if ((curYear % 4) == 0) {
            switch(realDay) {
                0...31    => {addMonth = 1;  addMonthDays=0;},
                32...60   => {addMonth = 2;  addMonthDays=31;},
                61...91   => {addMonth = 3;  addMonthDays=60;},
                92...121  => {addMonth = 4;  addMonthDays=91;},
                122...152 => {addMonth = 5;  addMonthDays=121;},
                153...182 => {addMonth = 6;  addMonthDays=152;},
                183...213 => {addMonth = 7;  addMonthDays=182;},
                214...244 => {addMonth = 8;  addMonthDays=213;},
                245...274 => {addMonth = 9;  addMonthDays=244;},
                275...305 => {addMonth = 10; addMonthDays=274;},
                306...335 => {addMonth = 11; addMonthDays=305;},
                336...366 => {addMonth = 12; addMonthDays=335;},
                else => unreachable,
            }
        } else {
            switch(realDay) {
                0...31    => {addMonth = 1;  addMonthDays=0;},
                32...59   => {addMonth = 2;  addMonthDays=31;},
                60...90   => {addMonth = 3;  addMonthDays=59;},
                91...120  => {addMonth = 4;  addMonthDays=90;},
                121...151 => {addMonth = 5;  addMonthDays=120;},
                152...181 => {addMonth = 6;  addMonthDays=151;},
                182...212 => {addMonth = 7;  addMonthDays=181;},
                213...243 => {addMonth = 8;  addMonthDays=212;},
                244...273 => {addMonth = 9;  addMonthDays=243;},
                274...304 => {addMonth = 10; addMonthDays=273;},
                305...334 => {addMonth = 11; addMonthDays=304;},
                335...365 => {addMonth = 12; addMonthDays=334;},
                else => unreachable,
            }
        }
        
        const addHours = @floor(restDay*24); 
        const restHours = (restDay*24)-(addHours);

        const addMins = @floor(restHours*60);
        const restMins = (restHours*60) - addMins;
        
        const addWeek = ((@as(f64,@floatFromInt(ts)) / 60 / 60 / 24 )-3) / 7;
        const Week_day:u8 = @as(u8,@intFromFloat((addWeek-@floor(addWeek))*7));

        const addSec = @floor(restMins*60);
        return DateTime {
            .Year = curYear,
            .Month = addMonth,
            .Day = @intCast(realDay - addMonthDays),
            .Week_day = Week_day,
            .Hour = @as(u8,@intFromFloat(addHours)),
            .Minute = @as(u8,@intFromFloat(addMins)),
            .Second = @as(u8,@intFromFloat(addSec)),
        };
    }
};
