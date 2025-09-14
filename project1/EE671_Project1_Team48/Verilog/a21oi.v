module logic_gate (
    input a1,
    input a2,
    input b1,
    output y
);
    assign y = ~((a1 & a2) | b1);
endmodule
