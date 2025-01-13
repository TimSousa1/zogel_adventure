const std = @import("std");
const mystruct = struct { name: i32, age: u16 };

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "zogel",
        .root_source_file = b.path("src/main.zig"),
        .target = b.standardTargetOptions(.{}),
        .optimize = b.standardOptimizeOption(.{}),
    });


    const raylib_dep = b.dependency("raylib-zig", .{
        // .target = ,
        // .optimize = optimize,
    });

    const raylib = raylib_dep.module("raylib"); // main raylib module
    const raygui = raylib_dep.module("raygui"); // raygui module
    const raylib_artifact = raylib_dep.artifact("raylib"); // raylib C library

    exe.linkLibrary(raylib_artifact);
    exe.root_module.addImport("raylib", raylib);
    exe.root_module.addImport("raygui", raygui);

    b.installArtifact(exe);
}
