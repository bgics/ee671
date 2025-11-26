module column_counter (
    input  wire clk,
    input  wire rst,
    input  wire pixel_valid,
    input  wire done,
    output reg [7:0] col,
    output reg row_clk
);

always @(posedge clk) begin
    if (rst) begin
        col <= 0;
        row_clk <= 1;
    end else begin
      row_clk <= 0;
      if (done == 0 && pixel_valid == 1) begin
        if (col == 255) begin
            col <= 0;
            row_clk <= 1;
        end else begin
            col <= col + 1;
        end
      end
    end
end

endmodule
