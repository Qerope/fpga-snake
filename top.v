module top (
    input clk,
    input btn_up, btn_down, btn_left, btn_right,
    output mosi, sclk, cs,
    output led0
);
    wire [63:0] game_frame;
    wire game_over;
    max7219 disp (.clk(clk), .frame(game_frame), .mosi(mosi), .sclk(sclk), .cs(cs));
    assign led0 = 1'b0;
    snake game (.clk(clk), .up(up), .down(down), .left(left), .right(right),
                .frame(game_frame), .game_over(game_over));
    wire up, down, left, right;
    debounce d0 (.clk(clk), .in(btn_up), .out(up));
    debounce d1 (.clk(clk), .in(btn_down), .out(down));
    debounce d2 (.clk(clk), .in(btn_left), .out(left));
    debounce d3 (.clk(clk), .in(btn_right), .out(right));
endmodule
