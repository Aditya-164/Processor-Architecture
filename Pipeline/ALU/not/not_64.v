`include "ALU/not/Not.v"

module not_64(A, Out); 
    input signed [63:0] A; 
    output signed [63:0] Out; 
    
    genvar i; 
    generate 
        for(i = 0; i < 64; i = i + 1) begin : adder_loop
            Not not1(
                .A(A[i]), 
                .Out(Out[i])
            ); 
        end
    endgenerate
endmodule