module top (
    input clk,
    output led0
);
    reg [23:0] cnt = 0;
    always @(posedge clk) cnt <= cnt + 1;
    assign led0 = cnt[23];
endmodule
