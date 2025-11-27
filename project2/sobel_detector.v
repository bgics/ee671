`include "valid_3x3_generator.v"
`include "sobel_operation.v"

module sobel_detector (
  input wire clk,
  input wire rst,
  
  input wire [7:0] pixel_in,
  input wire pixel_valid,

  input wire [7:0] threshold_value,
  input wire threshold_wr_en, 

  output wire done_out,
  
  output wire [7:0] pixel_out,

  output wire [7:0] row_out,
  output wire [7:0] col_out,

  output wire valid_out
);

wire [7:0] z0;
wire [7:0] z1;
wire [7:0] z2;
wire [7:0] z3;
wire [7:0] z4;
wire [7:0] z5;
wire [7:0] z6;
wire [7:0] z7;
wire [7:0] z8;

wire valid_matrix;

wire [7:0] row;
wire [7:0] col;

wire done;

valid_3x3_generator i_valid_3x3_generator (
  .clk(clk),
  .rst(rst),

  .data_in(pixel_in),
  .pixel_valid(pixel_valid),

  .done(done),
  .valid_matrix(valid_matrix),

  .row(row),
  .col(col),

  .z0(z0),
  .z1(z1),
  .z2(z2),
  .z3(z3),
  .z4(z4),
  .z5(z5),
  .z6(z6),
  .z7(z7),
  .z8(z8)
);

sobel_operation i_sobel_operation (
  .clk(clk),
  .rst(rst),

  .z0(z0),
  .z1(z1),
  .z2(z2),
  .z3(z3),
  .z4(z4),
  .z5(z5),
  .z6(z6),
  .z7(z7),
  .z8(z8),

  .threshold_value(threshold_value),
  .threshold_wr_en(threshold_wr_en),

  .valid_matrix(valid_matrix),

  .row_in(row),
  .col_in(col),

  .done_in(done),

  .valid_out(valid_out),

  .pixel_out(pixel_out),

  .row_out(row_out),
  .col_out(col_out),

  .done_out(done_out)
);

endmodule
