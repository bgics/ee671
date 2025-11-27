module gradient_magnitude (
  input wire signed [10:0] gx,
  input wire signed [10:0] gy,
  output reg [7:0] magnitude
);

wire signed [10:0] gx_s = gx;
wire signed [10:0] gy_s = gy;

wire signed [10:0] neg_gx = -gx_s;
wire signed [10:0] neg_gy = -gy_s;

wire [10:0] abs_gx_11 = gx_s[10] ? $unsigned(neg_gx) : $unsigned(gx_s);
wire [10:0] abs_gy_11 = gy_s[10] ? $unsigned(neg_gy) : $unsigned(gy_s);

wire [9:0] abs_gx = abs_gx_11[9:0];
wire [9:0] abs_gy = abs_gy_11[9:0];

wire [10:0] sum_abs = {1'b0, abs_gx} + {1'b0, abs_gy};

always @(*) begin
  if (sum_abs > 255) begin
    magnitude = 255;
  end else begin
    magnitude = sum_abs[7:0];
  end
end

endmodule
