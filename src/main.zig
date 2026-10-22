const std = @import("std");
const rl = @import("raylib");

const win_w: u32 = 800;
const win_h: u32 = 450;
const FPS:   f32 = 60.0;

var ball_x:  i32 = 50;
var ball_y:  i32 = 50;
var ball_sz: f32 = 20.0;
var ball_dx: f32 = 400.0;
var ball_dy: f32 = 400.0;

const Unit = struct {
    pos: rl.Vector2 = rl.Vector2Zero(),
};

pub fn main() !void {
    rl.InitWindow(win_w, win_h, "Hello from Zig!");
    rl.SetTargetFPS(FPS);
    var dt:  f32 = 0;
    while(!rl.WindowShouldClose()){
        dt = rl.GetFrameTime();

        if(ball_x + @as(i32, @intFromFloat(ball_dx * dt)) > win_w - @as(u32, @intFromFloat(ball_sz)) or ball_x + @as(i32, @intFromFloat(ball_dx * dt)) < @as(i32, @intFromFloat(ball_sz))){
            ball_dx *= -1.0;
        }
        ball_x += @as(i32, @intFromFloat(ball_dx * dt));

        if(ball_y + @as(i32, @intFromFloat(ball_dy * dt)) > win_h - @as(u32, @intFromFloat(ball_sz)) or ball_y + @as(i32, @intFromFloat(ball_dy * dt)) < @as(i32, @intFromFloat(ball_sz))){
            ball_dy *= -1.0;
        }
        ball_y += @as(i32, @intFromFloat(ball_dy * dt));

        rl.BeginDrawing();
        rl.ClearBackground(rl.GetColor(0x202020FF));
        rl.DrawCircle(ball_x, ball_y, ball_sz, rl.GetColor(0x20FF20FF));
        rl.EndDrawing();
    }
    rl.CloseWindow();
}
