`include "ALU/xor/xor.v"

module Xor_64(A, B, Out); 
    input signed [63:0] A, B; 
    output signed [63:0] Out; 
    
    genvar i; 
    generate 
        for(i = 0; i < 64; i = i + 1) begin : adder_loop
            Xor xor1(
                .A(A[i]), 
                .B(B[i]), 
                .Out(Out[i])
            ); 
        end
    endgenerate
endmodule