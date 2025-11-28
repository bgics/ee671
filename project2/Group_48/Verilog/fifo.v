module fifo (
  input wire clk,
  input wire rst,

  input wire pixel_valid,
  input wire done,
  
  input wire [7:0] data_in,

  output wire [7:0] data_out
);

reg [7:0] mem [255:0];
integer i;

always @(posedge clk) begin
  if (rst) begin
    for (i = 0; i < 256; i = i + 1) begin
      mem[i] <= 0;
    end
  end else begin
    if (!done && pixel_valid) begin
      for (i = 255; i > 0; i = i - 1) begin
        mem[i] <= mem[i - 1];
      end

      mem[0] <= data_in;
    end
  end
end

assign data_out = mem[255];

endmodule
