module debounce (
    input clk,
    input in,
    output reg out
);
    reg [15:0] cnt = 0;
    reg sync0 = 1, sync1 = 1;  // buttons are active low

    always @(posedge clk) begin
        sync0 <= in;
        sync1 <= sync0;
        if (sync1 == out) begin
            cnt <= 0;
        end else begin
            cnt <= cnt + 1;
            if (cnt == 16'hFFFF) out <= sync1;
        end
    end
endmodule
