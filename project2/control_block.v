module control_block (
  input wire clk,
  input wire rst,

  input wire [7:0] data_in,

  input wire pixel_valid,

  output wire done,
  output reg valid_matrix,

  output reg [7:0] row,
  output reg [7:0] col,

  output wire [7:0] z0,
  output wire [7:0] z1,
  output wire [7:0] z2,
  output wire [7:0] z3,
  output wire [7:0] z4,
  output wire [7:0] z5,
  output wire [7:0] z6,
  output wire [7:0] z7,
  output wire [7:0] z8
);

wire row_clk;

wire [7:0] internal_row;
wire [7:0] internal_col;

wire [7:0] fifo_1_out;
wire [7:0] fifo_2_out;

column_counter i_col (
  .clk(clk),
  .rst(rst),
  .pixel_valid(pixel_valid),
  .done(done),
  .col(internal_col),
  .row_clk(row_clk)
);

row_counter i_row (
  .clk(row_clk),
  .rst(rst),
  .row(internal_row),
  .done(done)
);

fifo i_fifo_1 (
  .clk(clk),
  .rst(rst),
  .pixel_valid(pixel_valid),
  .done(done),
  .data_in(data_in),
  .data_out(fifo_1_out)
);

fifo i_fifo_2 (
  .clk(clk),
  .rst(rst),
  .pixel_valid(pixel_valid),
  .done(done),
  .data_in(fifo_1_out),
  .data_out(fifo_2_out)
);

sr i_sr_1 (
  .clk(clk),
  .rst(rst),
  .pixel_valid(pixel_valid),
  .done(done),
  .data_in(data_in),
  .data_out_2(z6),
  .data_out_1(z7),
  .data_out_0(z8)
);

sr i_sr_2 (
  .clk(clk),
  .rst(rst),
  .pixel_valid(pixel_valid),
  .done(done),
  .data_in(fifo_1_out),
  .data_out_2(z3),
  .data_out_1(z4),
  .data_out_0(z5)
);

sr i_sr_3 (
  .clk(clk),
  .rst(rst),
  .pixel_valid(pixel_valid),
  .done(done),
  .data_in(fifo_2_out),
  .data_out_2(z0),
  .data_out_1(z1),
  .data_out_0(z2)
);

always @(posedge clk) begin
  if (rst) begin
    row <= 0;
    col <= 0;
    valid_matrix <= 0;
  end else begin 
    valid_matrix <= (internal_row == 3 && internal_col >= 3) || (internal_row > 3 && (internal_col == 0 || internal_col >= 3));

    if (internal_row > 2) begin 
      row <= internal_row - 3;
    end else begin
      row <= 0;
    end

    if (internal_col > 2) begin 
      col <= internal_col - 3;
    end else begin
      col <= 0;
    end
  end 
end

endmodule
