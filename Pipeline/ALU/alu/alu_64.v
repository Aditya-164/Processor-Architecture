`include "ALU/and/and_64.v"
`include "ALU/sub/sub_64.v"
`include "ALU/xor/xor_64.v"

module alu_64(A, B, Control, Sum, Overflow); 
    input signed [63:0] A, B; 
    input [1:0] Control; 
    output signed [63:0] Sum; 
    output signed Overflow; 

    wire signed [63:0] Sum_add, Sum_sub, Sum_and, Sum_xor; 
    wire Overflow_add, Overflow_sub; 

    add_64 add_64_1(
        .A(A), 
        .B(B), 
        .Sum(Sum_add), 
        .Overflow(Overflow_add)
    ); 

    sub_64 sub_64_1(
        .A(A), 
        .B(B), 
        .Diff(Sum_sub), 
        .Overflow(Overflow_sub)
    ); 

    and_64 and_64_1(
        .A(A), 
        .B(B), 
        .Out(Sum_and)
    ); 

    Xor_64 xor_64_1(
        .A(A), 
        .B(B), 
        .Out(Sum_xor)
    ); 
    
    assign Sum = (Control == 2'b00) ? Sum_add :
                 (Control == 2'b01) ? Sum_sub :
                 (Control == 2'b10) ? Sum_and :
                                       Sum_xor;
    
    assign Overflow = (Control == 2'b00) ? Overflow_add :
                      (Control == 2'b01) ? Overflow_sub :
                                            1'b0;
    
endmodule