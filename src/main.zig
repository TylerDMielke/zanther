const blt = @cImport({
    @cInclude("BearLibTerminal.h");
});
const context = @import("game_context.zig");
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
    var cursor = context.Cursor { .sprite="x", .x=10, .y=10};
    var ctx = context.GameContext { .cursor=cursor };
    ctx.run();
}