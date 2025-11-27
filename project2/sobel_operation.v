`include "convolution.v"
`include "gradient_magnitude.v"
`include "threshold_compare.v"

module sobel_operation (
  input wire clk,
  input wire rst,

  input wire [7:0] z0, z1, z2,
  input wire [7:0] z3, z4, z5,
  input wire [7:0] z6, z7, z8,

  input wire [7:0] threshold_value,
  input wire threshold_wr_en,

  input wire valid_matrix,

  input wire [7:0] row_in,
  input wire [7:0] col_in,

  input wire done_in,

  output reg valid_out,

  output reg [7:0] pixel_out,

  output reg [7:0] row_out,
  output reg [7:0] col_out,
  
  output reg done_out
);

wire signed [10:0] gx;
wire signed [10:0] gy;

wire [7:0] magnitude;
wire [7:0] threshold_out;

convolution i_convolution (
  .z0(z0),
  .z1(z1),
  .z2(z2),
  .z3(z3),
  .z4(z4),
  .z5(z5),
  .z6(z6),
  .z7(z7),
  .z8(z8),
  .gx(gx),
  .gy(gy)
);

gradient_magnitude i_gradient_magnitude (
  .gx(gx),
  .gy(gy),
  .magnitude(magnitude)
);

threshold_compare i_threshold_compare (
  .clk(clk),
  .rst(rst),
  .wr_en(threshold_wr_en),
  .data_in(threshold_value),
  .value_in(magnitude),
  .value_out(threshold_out)
);

always @(posedge clk) begin
  if (rst) begin
    valid_out <= 0;
    pixel_out <= 0;
    row_out <= 0;
    col_out <= 0;
    done_out <= 0;
  end else begin
    if (valid_matrix && !valid_out) begin
      valid_out <= 1;
    end

    if (valid_matrix && !done_out) begin
      pixel_out <= threshold_out;
      row_out <= row_in;
      col_out <= col_in;
      done_out <= done_in;
    end
  end
end

endmodule
