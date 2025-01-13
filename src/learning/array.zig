const std = @import("std");

pub fn main() void {
    std.debug.print("running..\n", .{});

    const string: []const u8 = "this is a string";

    for (string, 0..) |char, idx| {
        std.debug.print("\'{c}\' -> {d}\n", .{char, idx});
    }

    for (0..512 + 1) |i| {
        std.debug.print("{d} ", .{i});
    }

}
