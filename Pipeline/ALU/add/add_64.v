`include "ALU/add/add.v"

module add_64(A, B, Sum, Overflow); 
    input signed [63:0] A, B; 
    output signed [63:0] Sum; 
    output Overflow; 
    
    wire[64:0] carry; 
    assign carry[0] = 0;  

    genvar i; 
    generate 
        for(i = 0; i < 64; i = i + 1) begin : adder_loop
            add add1(
                .A(A[i]), 
                .B(B[i]), 
                .CarryIn(carry[i]), 
                .Sum(Sum[i]), 
                .CarryOut(carry[i + 1])
            ); 
        end
    endgenerate

    assign Overflow = carry[64]; 
endmodule