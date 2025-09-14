`timescale 1ns/1ps

module tb;
    reg a1, a2, b1;
    wire y;

    logic_gate dut(.a1(a1), .a2(a2), .b1(b1), .y(y));

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);

        a1=0; a2=0; b1=0; #10;
        a1=0; a2=0; b1=1; #10;
        a1=0; a2=1; b1=0; #10;
        a1=0; a2=1; b1=1; #10;
        a1=1; a2=0; b1=0; #10;
        a1=1; a2=0; b1=1; #10;
        a1=1; a2=1; b1=0; #10;
        a1=1; a2=1; b1=1; #10;

        $finish;
    end
endmodule
