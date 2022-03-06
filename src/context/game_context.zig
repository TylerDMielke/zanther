const std = @import("std");
const blt = @cImport({
    @cInclude("BearLibTerminal.h");
});

pub const GameContext = struct {
    cursor: Cursor,

    pub fn run(self: *GameContext) void {
        var cont_update: bool = true;
        var cont_draw: bool = true;

        while(cont_update and cont_draw) {
            cont_update = self.update();
            cont_draw = self.draw();
        }
    }

    fn update(self: *GameContext) bool {
        while(blt.terminal_has_input() != 0) {
            return self.handleInput();
        }
        return true;
    }

    fn draw(self: *GameContext) bool {
        _ = blt.terminal_clear();
        self.cursor.draw();
        _ = blt.terminal_print(1,1,"Hello");
        _ = blt.terminal_refresh();
        return true;
    }

    fn handleInput(self: *GameContext) bool { 
        var input: i32 = blt.terminal_read();
        switch(input) {
            blt.TK_ESCAPE => return false,
            blt.TK_H => self.cursor.move(self.cursor.x - 1, self.cursor.y),
            blt.TK_J => self.cursor.move(self.cursor.x, self.cursor.y + 1),
            blt.TK_K => self.cursor.move(self.cursor.x, self.cursor.y - 1),
            blt.TK_L => self.cursor.move(self.cursor.x + 1, self.cursor.y),
            else => return true,
        }
        return true;
    }
};

pub const Cursor = struct {
    sprite: [*]const u8,
    x: u8,
    y: u8,

    pub fn move(self: *Cursor, new_x: u8, new_y: u8) void {
        // TODO: When these go offscreen we segfault. Figure out how to tell if we are going to go off screen.
        self.x = new_x; 
        self.y = new_y;
    }

    pub fn draw(self: *Cursor) void {
        _ = blt.terminal_print(self.x, self.y, self.sprite);
    }
};