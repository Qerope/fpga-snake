// helper: set a single bit of an 8x8 frame from x/y
module pixel_to_frame (
    input [2:0] x, y,
    output [63:0] frame
);
    assign frame = 64'd1 << {y, x};
endmodule
