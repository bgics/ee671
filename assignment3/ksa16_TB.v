

`timescale 10ns / 1ps

module ksa16_TB;

    // Inputs
    reg clock;
    reg reset;
    reg [15:0] a;
    reg [15:0] b;
    reg cin;

    // Outputs
    wire [15:0] sum;
    wire carryout;

    // Instantiate the Unit Under Test (UUT)
    ksa16 uut (
        .clock(clock),
        .reset(reset),
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .carryout(carryout)
    );

    // Clock generation: 10ns period
    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    // Stimulus
    initial begin
        // Waveform dump setup
       //$dumpfile("waveforms.vcd");
       //$dumpvars(0, tb_ksa16);

        // Initialize inputs
        a = 0;
        b = 0;
        cin = 0;
        reset = 1;

        // Apply reset
        //#10 
            reset = 0;

        // Test vector 1
        #10 a = 16'h0001; b = 16'h0001; cin = 0;

        // Test vector 2
        #10 a = 16'h00FF; b = 16'h0001; cin = 1;

        // Test vector 3
        #10 a = 16'hFFFF; b = 16'h0001; cin = 0;

        // Test vector 4
        //#10 a = 16'h1234; b = 16'h4321; cin = 1;

        // Test vector 5
        #10 a = 16'hAAAA; b = 16'h5555; cin = 0;

        // Test vector 6
        #10 a = 16'h8000; b = 16'h8000; cin = 1;

        // Test vector 7
        #10 a = 16'h7FFF; b = 16'h0001; cin = 0;

        // Test vector 8
        //#10 a = 16'hF0F0; b = 16'h0F0F; cin = 1;

        // Test vector 9
        #10 a = 16'h0000; b = 16'h0000; cin = 0;

        // Test vector 10
        #10 a = 16'hDEAD; b = 16'hBEEF; cin = 1;

        // Finish simulation
        #20 $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t | a=%h b=%h cin=%b => sum=%h carryout=%b",
                 $time, a, b, cin, sum, carryout);
        	 $dumpfile("waveforms.vcd");
	$dumpvars(0,uut);
    end

endmodule


