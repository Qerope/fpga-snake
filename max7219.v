// Initialises the MAX7219 and keeps refreshing the 8 rows from `frame`
module max7219 (
    input clk,
    output mosi, sclk, cs
);
    reg start = 0;
    reg [15:0] word = 0;
    wire busy;
    spi_master spi (.clk(clk), .start(start), .data(word), .mosi(mosi), .sclk(sclk), .cs(cs), .busy(busy));

    reg [3:0] step = 0;
    always @(posedge clk) begin
        start <= 0;
        if (!busy && !start) begin
            step <= step + 1;
            start <= 1;
            case (step)
                4'd0: word <= 16'h0C01;  // normal operation
                4'd1: word <= 16'h0900;  // no decode
                4'd2: word <= 16'h0B07;  // scan all 8 digits
                4'd3: word <= 16'h0A03;  // low brightness
                4'd4: word <= 16'h0108;  // row 1: one pixel
                default: begin word <= 16'h0000; start <= 0; end
            endcase
        end
    end
endmodule
