module threshold_compare (
    input wire clk,
    input wire rst,
    input wire [7:0] value_in,
    input wire wr_en,
    input wire [7:0] data_in,
    output wire [7:0] value_out
);

reg [7:0] threshold;

always @(posedge clk) begin
  if (rst) begin
    threshold <= 128;
  end else if (wr_en) begin
    threshold <= data_in;
  end
end

assign value_out = (value_in > threshold) ? 255 : 0;

endmodule
