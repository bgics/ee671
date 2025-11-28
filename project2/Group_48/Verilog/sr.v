module sr (
  input wire clk,
  input wire rst,

  input wire done,
  input wire pixel_valid,

  input wire [7:0] data_in,

  output reg [7:0] data_out_0,
  output reg [7:0] data_out_1,
  output reg [7:0] data_out_2
);

always @(posedge clk) begin
  if (rst) begin
    data_out_0 <= 0;
    data_out_1 <= 0;
    data_out_2 <= 0;
  end else begin
    if (!done && pixel_valid) begin
      data_out_2 <= data_out_1;
      data_out_1 <= data_out_0;
      data_out_0 <= data_in;
    end
  end
end

endmodule
