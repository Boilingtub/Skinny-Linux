pub const packages = struct {
    pub const @"fcft-2.0.0-zcx6C5EaAADIEaQzDg5D4UvFFMjSEwDE38vdE9xObeN9" = struct {
        pub const build_root = "/home/hendrik/.cache/zig/p/fcft-2.0.0-zcx6C5EaAADIEaQzDg5D4UvFFMjSEwDE38vdE9xObeN9";
        pub const build_zig = @import("fcft-2.0.0-zcx6C5EaAADIEaQzDg5D4UvFFMjSEwDE38vdE9xObeN9");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
            .{ "pixman", "pixman-0.3.0-LClMnz2VAAAs7QSCGwLimV5VUYx0JFnX5xWU6HwtMuDX" },
        };
    };
    pub const @"pixman-0.3.0-LClMnz2VAAAs7QSCGwLimV5VUYx0JFnX5xWU6HwtMuDX" = struct {
        pub const build_root = "/home/hendrik/.cache/zig/p/pixman-0.3.0-LClMnz2VAAAs7QSCGwLimV5VUYx0JFnX5xWU6HwtMuDX";
        pub const build_zig = @import("pixman-0.3.0-LClMnz2VAAAs7QSCGwLimV5VUYx0JFnX5xWU6HwtMuDX");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
        };
    };
    pub const @"wayland-0.3.0-lQa1kjPIAQDmhGYpY-zxiRzQJFHQ2VqhJkQLbKKdt5wl" = struct {
        pub const build_root = "/home/hendrik/.cache/zig/p/wayland-0.3.0-lQa1kjPIAQDmhGYpY-zxiRzQJFHQ2VqhJkQLbKKdt5wl";
        pub const build_zig = @import("wayland-0.3.0-lQa1kjPIAQDmhGYpY-zxiRzQJFHQ2VqhJkQLbKKdt5wl");
        pub const deps: []const struct { []const u8, []const u8 } = &.{
        };
    };
};

pub const root_deps: []const struct { []const u8, []const u8 } = &.{
    .{ "pixman", "pixman-0.3.0-LClMnz2VAAAs7QSCGwLimV5VUYx0JFnX5xWU6HwtMuDX" },
    .{ "wayland", "wayland-0.3.0-lQa1kjPIAQDmhGYpY-zxiRzQJFHQ2VqhJkQLbKKdt5wl" },
    .{ "fcft", "fcft-2.0.0-zcx6C5EaAADIEaQzDg5D4UvFFMjSEwDE38vdE9xObeN9" },
};
