module not_64_test; 

reg signed [63 : 0] a; 
wire signed [63 : 0] Out; 

not_64 uut(a, Out); 

initial begin
    $dumpfile("not_64_test.vcd"); 
    $dumpvars(0, not_64_test); 
    
    a = 64'b100_10_10111;    
    #10
    $display("Out: %b", Out); 
    

    $finish(); 
end
endmodule