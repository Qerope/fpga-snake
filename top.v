module top (
    input clk,
    output mosi, sclk, cs,
    output led0
);
    wire [63:0] frame_bits = 64'h0000_0000_0008_0000;
    max7219 disp (.clk(clk), .frame(frame_bits), .mosi(mosi), .sclk(sclk), .cs(cs));
    assign led0 = 1'b0;
endmodule
