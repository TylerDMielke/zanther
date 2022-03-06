const std = @import("std");
const blt = @cImport({
    @cInclude("BearLibTerminal.h");
});
const gc = @import("game_context.zig");

pub fn run() ?gc.GameContext {
    var cont_update: bool = true;
    var cont_draw: bool = true;

    while(cont_update and cont_draw) {
        cont_update = update();
        cont_draw = draw();
    }
    var cur = gc.Cursor { .sprite="[color=red]x", .x=10, .y=10 };
    return gc.GameContext{ .cursor=cur };
}

fn draw() bool {
    _ = blt.terminal_clear();
    _ = blt.terminal_print(10,5,"Menu");
    _ = blt.terminal_refresh();
    return true;
}

fn update() bool {
    while(blt.terminal_has_input() != 0) {
        return handleInput();
    }
    return true;
}

fn handleInput() bool { 
    var input: i32 = blt.terminal_read();
    switch(input) {
        blt.TK_ESCAPE => return false,
        else => return true,
    }
    return true;
}