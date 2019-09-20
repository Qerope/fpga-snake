module top (
    input clk,
    output mosi, sclk, cs,
    output led0
);
    max7219 disp (.clk(clk), .mosi(mosi), .sclk(sclk), .cs(cs));
endmodule
