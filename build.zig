const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const mod = b.addModule("zig_raylib", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
    });

    const rl_deps = b.dependency("raylib", .{
        .target = target,
        .optimize = optimize,
    });
    const rl = rl_deps.artifact("raylib");

    const exe = b.addExecutable(.{
        .name = "zig_raylib",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
            .imports = &.{
                .{ .name = "zig_raylib", .module = mod },
            },
        }),
    });
    exe.root_module.addImport("raylib", rl_deps.module("raylib"));
    exe.root_module.linkLibrary(rl);

    b.installArtifact(exe);
    const run_step = b.step("run", "Run the app");
    const run_cmd = b.addRunArtifact(exe);
    run_step.dependOn(&run_cmd.step);
    run_cmd.step.dependOn(b.getInstallStep());
    run_cmd.addPassthruArgs();
}
