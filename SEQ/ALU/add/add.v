module add(A, B, CarryIn, Sum, CarryOut); 
    input A, B, CarryIn; 
    output Sum, CarryOut; 

    //assign Sum = A xor B xor CarryIn; 
    wire x1; 
    xor(x1, A, B); 
    xor(Sum, x1, CarryIn); 

    //assign CarryOut = (A and B) or (B and CarryIn) or (CarryIn and A); 
    wire x2, x3, x4, x5; 
    and(x2, A, B); 
    and(x3, B, CarryIn); 
    and(x4, CarryIn, A); 
    or(x5, x2, x3); 
    or(CarryOut, x5, x4); 
endmodule 