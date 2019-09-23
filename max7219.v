// Initialises the MAX7219 and keeps refreshing the 8 rows from `frame`
module max7219 (
    input clk,
    input [63:0] frame,
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
                4'd4:  word <= {8'h01, frame[7:0]};
                4'd5:  word <= {8'h02, frame[15:8]};
                4'd6:  word <= {8'h03, frame[23:16]};
                4'd7:  word <= {8'h04, frame[31:24]};
                4'd8:  word <= {8'h05, frame[39:32]};
                4'd9:  word <= {8'h06, frame[47:40]};
                4'd10: word <= {8'h07, frame[55:48]};
                4'd11: begin word <= {8'h08, frame[63:56]}; step <= 4; end
                default: start <= 0;
            endcase
        end
    end
endmodule
