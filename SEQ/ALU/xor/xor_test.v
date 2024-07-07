module xor_test; 

reg a, b; 
wire out; 

Xor uut(a, b, out); 

initial begin
    $dumpfile("xor.vcd"); 
    $dumpvars(0, xor_test); 

    a = 0; 
    b = 0; 
    #10

    b = 1; 
    #10
    
    a = 1; 
    b = 0; 
    #10
    b = 1; 
    #10

    $finish(); 
end

endmodule