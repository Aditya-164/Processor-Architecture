module And(A, B, Out); 
    input A, B; 
    output Out; 

    //assign Out = A & B; 
    and(Out, A, B); 
endmodule