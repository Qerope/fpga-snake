// Sends 16 bit words MSB first, mode 0, clk/8
module spi_master (
    input clk,
    input start,
    input [15:0] data,
    output reg mosi,
    output reg sclk,
    output reg cs,
    output reg busy
);
    reg [2:0] div = 0;
    reg [4:0] bit_cnt = 0;
    reg [15:0] shift = 0;

    initial begin sclk = 0; cs = 1; busy = 0; mosi = 0; end

    always @(posedge clk) begin
        if (!busy) begin
            if (start) begin
                shift <= data;
                bit_cnt <= 0;
                busy <= 1;
                cs <= 0;
                div <= 0;
            end
        end else begin
            div <= div + 1;
            if (div == 3'd3) begin
                sclk <= 1;
            end else if (div == 3'd7) begin
                sclk <= 0;
                shift <= {shift[14:0], 1'b0};
                bit_cnt <= bit_cnt + 1;
                if (bit_cnt == 15) begin
                    busy <= 0;
                    cs <= 1;
                end
            end
            mosi <= shift[15];
        end
    end
endmodule
