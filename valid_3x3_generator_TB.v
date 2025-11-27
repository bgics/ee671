`timescale 1ns/1ps

module tb_control_block;

reg clk;
reg rst;
reg pixel_valid;
reg [7:0] data_in;

wire done;
wire valid_matrix;
wire [7:0] row;
wire [7:0] col;
wire [7:0] z [8:0];

valid_3x3_generator dut (
  .clk(clk),
  .rst(rst),
  .data_in(data_in),
  .pixel_valid(pixel_valid),
  .done(done),
  .valid_matrix(valid_matrix),
  .row(row),
  .col(col),
  .z0(z[0]),
  .z1(z[1]),
  .z2(z[2]),
  .z3(z[3]),
  .z4(z[4]),
  .z5(z[5]),
  .z6(z[6]),
  .z7(z[7]),
  .z8(z[8])
);

always #10 clk = ~clk;

integer i;

initial begin
  $dumpfile("dump.vcd");
  $dumpvars(0, tb_control_block);

  clk = 0;
  rst = 1;
  pixel_valid = 1;
  data_in = 0;

  #50 rst = 0;

  @(negedge clk);
  data_in = 0;

  for (i = 0; i < (256*256) + 100; i = i + 1) begin
    @(negedge clk);
    data_in = i + 1;
    @(posedge clk);
  end

  $finish;
end

endmodule
