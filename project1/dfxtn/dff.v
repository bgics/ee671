`timescale 1ns/1ps

module dff(
    input D,
    input clk,
    output reg Q
);
    always @(negedge clk) begin
        Q <= D;
    end
endmodule
