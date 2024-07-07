module Not(A, Out); 
    input A;
    output Out; 
    
    //assign Out = ~A; 
    not(Out, A); 
endmodule