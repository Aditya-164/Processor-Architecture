`include "ALU/not/not_64.v"
`include "ALU/add/add_64.v"

module sub_64(A, B, Diff, Overflow); 
    input signed [63:0] A, B; 
    output signed [63:0] Diff; 
    output Overflow; 
    wire signed [63:0]negB; 
    wire signed [63:0]complementB;

    not_64 not_64_1(
        .A(B), 
        .Out(negB) 
    ); 

    wire lastBit = 64'd0000001; 
    wire ignore; 

    add_64 add_64_1(
        .A(negB), 
        .B(lastBit), 
        .Sum(complementB), 
        .Overflow(ignore) 
    ); 
    
    add_64 add_64_2(
        .A(A), 
        .B(complementB), 
        .Sum(Diff), 
        .Overflow(Overflow) 
    ); 
    
endmodule