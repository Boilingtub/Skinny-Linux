pub const packages = struct {
    pub const @"pixman-0.3.0-LClMnz2VAAAs7QSCGwLimV5VUYx0JFnX5xWU6HwtMuDX" = struct {
        pub const build_root = "/home/hendrik/.cache/zig/p/pixman-0.3.0-LClMnz2VAAAs7QSCGwLimV5VUYx0JFnX5xWU6HwtMuDX";
        pub const build_zig = @import("pixman-0.3.0-LClMnz2VAAAs7QSCGwLimV5VUYx0JFnX5xWU6HwtMuDX");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
        };
    };
    pub const @"wayland-0.4.0-lQa1khbMAQAsLS2eBR7M5lofyEGPIbu2iFDmoz8lPC27" = struct {
        pub const build_root = "/home/hendrik/.cache/zig/p/wayland-0.4.0-lQa1khbMAQAsLS2eBR7M5lofyEGPIbu2iFDmoz8lPC27";
        pub const build_zig = @import("wayland-0.4.0-lQa1khbMAQAsLS2eBR7M5lofyEGPIbu2iFDmoz8lPC27");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
        };
    };
    pub const @"wlroots-0.19.3-jmOlcuL_AwBHhLCwpFsXbTizE3q9BugFmGX-XIxqcPMc" = struct {
        pub const build_root = "/home/hendrik/.cache/zig/p/wlroots-0.19.3-jmOlcuL_AwBHhLCwpFsXbTizE3q9BugFmGX-XIxqcPMc";
        pub const build_zig = @import("wlroots-0.19.3-jmOlcuL_AwBHhLCwpFsXbTizE3q9BugFmGX-XIxqcPMc");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
            .{ "pixman", "pixman-0.3.0-LClMnz2VAAAs7QSCGwLimV5VUYx0JFnX5xWU6HwtMuDX" },
            .{ "wayland", "wayland-0.4.0-lQa1khbMAQAsLS2eBR7M5lofyEGPIbu2iFDmoz8lPC27" },
            .{ "xkbcommon", "xkbcommon-0.3.0-VDqIe3K9AQB2fG5ZeRcMC9i7kfrp5m2rWgLrmdNn9azr" },
        };
    };
    pub const @"xkbcommon-0.3.0-VDqIe3K9AQB2fG5ZeRcMC9i7kfrp5m2rWgLrmdNn9azr" = struct {
        pub const build_root = "/home/hendrik/.cache/zig/p/xkbcommon-0.3.0-VDqIe3K9AQB2fG5ZeRcMC9i7kfrp5m2rWgLrmdNn9azr";
        pub const build_zig = @import("xkbcommon-0.3.0-VDqIe3K9AQB2fG5ZeRcMC9i7kfrp5m2rWgLrmdNn9azr");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
        };
    };
};

pub const root_deps: []const struct { []const u8, []const u8 } = &.{
    .{ "pixman", "pixman-0.3.0-LClMnz2VAAAs7QSCGwLimV5VUYx0JFnX5xWU6HwtMuDX" },
    .{ "wayland", "wayland-0.4.0-lQa1khbMAQAsLS2eBR7M5lofyEGPIbu2iFDmoz8lPC27" },
    .{ "wlroots", "wlroots-0.19.3-jmOlcuL_AwBHhLCwpFsXbTizE3q9BugFmGX-XIxqcPMc" },
    .{ "xkbcommon", "xkbcommon-0.3.0-VDqIe3K9AQB2fG5ZeRcMC9i7kfrp5m2rWgLrmdNn9azr" },
};
