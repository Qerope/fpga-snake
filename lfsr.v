// 6 bit maximal length LFSR (x^6 + x^5 + 1)
module lfsr (
    input clk,
    output [5:0] out
);
    reg [5:0] r = 6'b000001;
    assign out = r;
    always @(posedge clk) r <= {r[4:0], r[5] ^ r[4]};
endmodule
