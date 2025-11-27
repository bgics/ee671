module counter (
  input  wire clk,
  input  wire rst,
  input  wire pixel_valid,
  output reg done,
  output reg [7:0] col,
  output reg [7:0] row
);

always @(posedge clk) begin
  if (rst) begin
    col <= 0;
    row <= 0;
    done <= 0;
  end else begin
    if (!done && pixel_valid) begin
      if (col == 255) begin
        col <= 0;
        if (row == 255) begin
          row <= 0;
          done <= 1;
        end else begin
          row <= row + 1;
        end
      end else begin
        col <= col + 1;
      end
    end
  end
end

endmodule
