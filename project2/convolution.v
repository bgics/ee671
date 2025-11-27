module convolution (
  input wire [7:0] z0, z1, z2,
  input wire [7:0] z3, z4, z5,
  input wire [7:0] z6, z7, z8,
  output wire signed [10:0] gx,
  output wire signed [10:0] gy
);

wire signed [10:0] z0_s = {3'b000, z0};
wire signed [10:0] z1_s = {3'b000, z1};
wire signed [10:0] z2_s = {3'b000, z2};
wire signed [10:0] z3_s = {3'b000, z3};
wire signed [10:0] z4_s = {3'b000, z4};
wire signed [10:0] z5_s = {3'b000, z5};
wire signed [10:0] z6_s = {3'b000, z6};
wire signed [10:0] z7_s = {3'b000, z7};
wire signed [10:0] z8_s = {3'b000, z8};

wire signed [10:0] d60 = z6_s - z0_s;
wire signed [10:0] d71 = z7_s - z1_s;
wire signed [10:0] d82 = z8_s - z2_s;

wire signed [10:0] d20 = z2_s - z0_s;
wire signed [10:0] d53 = z5_s - z3_s;
wire signed [10:0] d86 = z8_s - z6_s;

wire signed [10:0] d71_x2 = d71 << 1;
wire signed [10:0] d53_x2 = d53 << 1;

assign gx = d60 + d71_x2 + d82;
assign gy = d20 + d53_x2 + d86;

endmodule
