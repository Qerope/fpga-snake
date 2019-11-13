module snake (
    input clk,
    input up, down, left, right,
    input [5:0] rnd,
    output reg [63:0] frame,
    output reg game_over
);
    reg [21:0] tick_cnt = 0;
    wire tick = (tick_cnt == 22'd2_999_999);  // 4 Hz at 12 MHz
    always @(posedge clk) tick_cnt <= tick ? 0 : tick_cnt + 1;

    reg [2:0] hx = 3'd3, hy = 3'd3;
    reg [1:0] dir = 2'd3;  // 0 up, 1 down, 2 left, 3 right
    reg [5:0] body [0:15];
    reg [3:0] len = 4'd1;
    integer i;
    reg [5:0] food = 6'd36;
    reg grow = 0;

    always @(posedge clk) begin
        if (game_over) begin
            if (up | down | left | right) begin
                hx <= 3; hy <= 3; dir <= 3; game_over <= 0;
                len <= 1;
            end
        end else begin
        if (up) dir <= 0;
        else if (down) dir <= 1;
        else if (left) dir <= 2;
        else if (right) dir <= 3;
        if (up && dir != 1) dir <= 0;
        else if (down && dir != 0) dir <= 1;
        else if (left && dir != 3) dir <= 2;
        else if (right && dir != 2) dir <= 3;
        if (tick) begin
            case (dir)
                2'd0: hy <= hy - 1;
                2'd1: hy <= hy + 1;
                2'd2: hx <= hx - 1;
                2'd3: hx <= hx + 1;
            endcase
            for (i = 15; i > 0; i = i - 1) body[i] <= body[i - 1];
            body[0] <= {hy, hx};
            if ({hy, hx} == food) begin
                if (len < 15) len <= len + 1;
                food <= rnd;
                // don't drop food on the head; body check is skipped, rare enough on 8x8
                if (rnd == {hy, hx}) food <= rnd + 6'd1;
            end
            for (i = 0; i < 16; i = i + 1)
                if (i < len && body[i] == {hy, hx}) game_over <= 1;
        end
        end
    end

    always @* begin
        frame = 64'd0;
        frame[{hy, hx}] = 1'b1;
        for (i = 0; i < 16; i = i + 1)
            if (i < len) frame[body[i]] = 1'b1;
        frame[food] = 1'b1;
    end
endmodule
