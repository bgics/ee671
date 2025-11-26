module row_counter (
    input  wire clk,
    input  wire rst,
    output reg [7:0] row,
    output reg done
);

always @(posedge clk) begin
    if (rst) begin
        row <= 0;
        done <= 0;
    end else begin
      if (done == 0) begin 
        if (row == 255) begin
            row <= 0;
            done <= 1;
        end else begin
            row <= row + 1;
        end
      end
    end
end

endmodule
