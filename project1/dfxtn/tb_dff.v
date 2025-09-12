`timescale 1ns/1ps

module tb;
    reg D;
    reg clk;
    wire Q;

    dff dut(.D(D), .clk(clk), .Q(Q));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb);
        D = 0;
        #7 D = 1;
        #8 D = 0;
        #12 D = 1;
        #3 D = 0;
        #20 D = 1;
        #30 $finish;
    end
endmodule
