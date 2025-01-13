const std = @import("std");
const rl = @import("raylib");

const FPS: i16 = 60;
const width: i32 = 300;

pub fn main() void {
    rl.initWindow(width, 300, "first test");
    rl.setTargetFPS(60);

    var pos: i32 = 150;
    var delta_pos: i16 = 100 / FPS;
    const radius: i16 = 30;

    while (!rl.windowShouldClose()) {
        pos += delta_pos;
        rl.beginDrawing();

        rl.clearBackground(rl.Color.white);
        rl.drawCircle(pos, 150, radius, rl.Color.red);

        if (pos+radius >= width or pos-radius <= 0) {
            delta_pos *= -1;
        }

        rl.endDrawing();
    }

}
