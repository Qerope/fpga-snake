module snake (
    input clk,
    input up, down, left, right,
    output reg [63:0] frame,
    output reg game_over
);
    reg [21:0] tick_cnt = 0;
    wire tick = (tick_cnt == 22'd2_999_999);  // 4 Hz at 12 MHz
    always @(posedge clk) tick_cnt <= tick ? 0 : tick_cnt + 1;

    reg [2:0] hx = 3'd3, hy = 3'd3;
    reg [1:0] dir = 2'd3;  // 0 up, 1 down, 2 left, 3 right

    always @(posedge clk) begin
        if (up) dir <= 0;
        else if (down) dir <= 1;
        else if (left) dir <= 2;
        else if (right) dir <= 3;
        if (tick) begin
            case (dir)
                2'd0: hy <= hy - 1;
                2'd1: hy <= hy + 1;
                2'd2: hx <= hx - 1;
                2'd3: hx <= hx + 1;
            endcase
        end
    end

    always @* begin
        frame = 64'd0;
        frame[{hy, hx}] = 1'b1;
    end
endmodule
