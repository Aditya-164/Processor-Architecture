module and_64_test; 

reg signed [63 : 0] a, b; 
wire signed [63 : 0] Out; 

and_64 uut(a, b, Out); 

initial begin
    $dumpfile("and_64_test.vcd"); 
    $dumpvars(0, and_64_test); 
    
    a = 64'b100_10_10111;    
    b = 64'b100_01_00011; 
    #10
    $display("Out: %b", Out); 
    

    $finish(); 
end
endmodule