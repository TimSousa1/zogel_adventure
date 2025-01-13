const std = @import("std");
const rl = @import("raylib");

const Color = struct {r:u8, g:u8, b: u8};

const screen_width  = 300;
const screen_height = 300;
var screen: [screen_width*screen_height]Color = undefined;

const window_width  = 1000;
const window_height = 1000;

fn dump_tex(data:[]Color, max_x: usize) void {
    for (data, 0..) |pixel, i| {
        std.debug.print("{d} {d} {d}   ", .{pixel.r, pixel.g, pixel.b});
        if (i % max_x == 0) std.debug.print("\n", .{});
    }
}


fn convert(x: usize, y: usize, max_x: usize) usize {
    return y*max_x + x;
}


pub fn main() !void {
    @memset(&screen, .{.r = 255, .g = 0, .b = 0});

    rl.initWindow(screen_width, screen_height, "zogel");

    for (0..screen_width) |x| {
        for (0..screen_height) |y| {
            const r = @as(u8, @intCast(x % 255));
            const g = @as(u8, @intCast(y % 255));
            const col: Color = .{.r = r, .g = g, .b = 0};
            screen[convert(x, y, screen_width)] = col;
        }
    }

    const scr_img: rl.Image = .{
        .data = &screen,
        .width = screen_width,
        .height = screen_height,
        .format = rl.PixelFormat.uncompressed_r8g8b8, .mipmaps = 1,
    };

    const scr_tex: rl.Texture2D = try rl.loadTextureFromImage(scr_img);
    defer rl.unloadTexture(scr_tex);

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();

        rl.drawTexturePro(scr_tex, .{.x = 0, .y = 0, .width = screen_width, .height = screen_height}, 
                                   .{.x = 0, .y = 0, .width = window_width, .height = window_height}, 
                                   .{.x = 0, .y = 0}, 0, rl.Color.white);
        rl.endDrawing();
    }
}
