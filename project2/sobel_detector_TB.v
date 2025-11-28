`timescale 1ns/1ps

module tb_sobel_detector;

reg clk;
reg rst;

reg [7:0] pixel_in;
reg pixel_valid;

reg [7:0] threshold_value;
reg threshold_wr_en;

wire done_out;

wire [7:0] pixel_out;
wire [7:0] row_out;
wire [7:0] col_out;
wire valid_out;

sobel_detector dut (
  .clk(clk),
  .rst(rst),
  .pixel_in(pixel_in),
  .pixel_valid(pixel_valid),
  .threshold_value(threshold_value),
  .threshold_wr_en(threshold_wr_en),
  .done_out(done_out),
  .pixel_out(pixel_out),
  .row_out(row_out),
  .col_out(col_out),
  .valid_out(valid_out)
);

initial begin
  clk = 0;
  forever #10 clk = ~clk;
end

reg [7:0] img_mem [0:65535];
integer   out_file;
integer   i;

initial begin
  $dumpfile("dump.vcd");
  $dumpvars(0,
    tb_sobel_detector.clk,
    tb_sobel_detector.rst,
    tb_sobel_detector.pixel_in,
    tb_sobel_detector.pixel_valid,
    tb_sobel_detector.threshold_value,
    tb_sobel_detector.threshold_wr_en,
    tb_sobel_detector.done_out,
    tb_sobel_detector.pixel_out,
    tb_sobel_detector.row_out,
    tb_sobel_detector.col_out,
    tb_sobel_detector.valid_out
  );

  $readmemh("cameraman.hex", img_mem);

  out_file = $fopen("output.hex", "w");

  rst = 1;
  pixel_in = 0;
  pixel_valid = 0;
  threshold_value = 0;
  threshold_wr_en = 0;

  repeat(5) @(posedge clk);
  rst = 0;

  @(negedge clk);
  threshold_value = 128;
  threshold_wr_en = 1;

  @(negedge clk);
  threshold_wr_en = 0;

  @(negedge clk);
  pixel_in = img_mem[0];

  @(negedge clk);
  pixel_valid = 1;

  for (i = 1; i < 256*256; i = i + 1) begin
    @(negedge clk);
    pixel_in = img_mem[i];
  end

  $dumpoff;

  repeat(3000) @(negedge clk);

  $fclose(out_file);
  $finish;
end

always @(posedge clk) begin
  if (valid_out) begin
    $fwrite(out_file, "%02h %02h %02h\n",
            row_out, col_out, pixel_out);
  end
end

endmodule
