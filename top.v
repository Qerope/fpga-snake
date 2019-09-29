module top (
    input clk,
    input btn_up, btn_down, btn_left, btn_right,
    output mosi, sclk, cs,
    output led0
);
    wire [63:0] frame_bits = 64'h0000_0000_0008_0000;
    max7219 disp (.clk(clk), .frame(frame_bits), .mosi(mosi), .sclk(sclk), .cs(cs));
    assign led0 = 1'b0;
    wire up, down, left, right;
    debounce d0 (.clk(clk), .in(btn_up), .out(up));
    debounce d1 (.clk(clk), .in(btn_down), .out(down));
    debounce d2 (.clk(clk), .in(btn_left), .out(left));
    debounce d3 (.clk(clk), .in(btn_right), .out(right));
endmodule
