module not_test; 

reg a; 
wire out; 

Not uut(a, out); 

initial begin
    $dumpfile("not_test.vcd"); 
    $dumpvars(0, not_test); 
    
    a = 0; 
    #10

    a = 1; 
    #10
    
    $finish(); 
end

endmodule