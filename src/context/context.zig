const gs = @import("game_context.zig");
const mmc = @import("mmenu_context.zig");

 pub const Context = union {
     game_context: gs.GameContext,
     mmenu_context: mmc.MMenuContext,
 };