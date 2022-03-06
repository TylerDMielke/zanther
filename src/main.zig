const blt = @cImport({
    @cInclude("BearLibTerminal.h");
});
const context = @import("context/context.zig");
const mcontext = @import("context/mmenu_context.zig");
const std = @import("std");

const print = std.debug.print;

pub fn main() !void {

    initTerm();
    updateTerm();
    closeTerm();

    print("Zanther has successfully ended!\n", .{});
}

fn initTerm() void {
    _ = blt.terminal_open();
}

fn closeTerm() void {
    _ = blt.terminal_close();
}

fn updateTerm() void {
    var ctx: context.Context = mcontext.MMenuContext;
    while (true) {
        ctx = context.run();
    }
}