const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const target = b.standardTargetOptions(.{});
    const mode  = b.standardReleaseOptions();
    const exe = b.addExecutable("zanther", "src/main.zig");

    exe.setTarget(target);   
    exe.setBuildMode(mode);

    exe.linkLibC();
    exe.addIncludeDir("./cInclude/");
    exe.addLibPath("./usr/local/lib/");
    exe.linkSystemLibraryName("BearLibTerminal");
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Run program");
    run_step.dependOn(&run_cmd.step);
}