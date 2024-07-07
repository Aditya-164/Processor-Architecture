module Xor(A, B, Out); 
    input A, B; 
    output Out; 

    //assign Out = A ^ B; 
    xor(Out, A, B); 
endmodule