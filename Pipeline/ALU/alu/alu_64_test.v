module alu_64_test; 

reg signed [63 : 0] a, b; 
reg signed [1 : 0] Control; 
wire signed [63:0] Sum; 
wire Overflow; 

alu_64 uut(a, b, Control, Sum, Overflow); 

initial begin
    $dumpfile("alu_64_test.vcd"); 
    $dumpvars(0, alu_64_test); 

    a = 64'd1012138011; 
    b = -64'd562979321112984; 
    Control = 2'b0; //add
    #10
    $display("Sum: %d", Sum); 
    
    a = 64'd1012138011; 
    b = -64'd562979321112984; 
    Control = 2'b1; 
    #10   //diff
    $display("Sum: %d", Sum);  
    
    a = 64'b100_10_10111;    
    b = 64'b100_01_00011; 
    Control = 2'b10; 
    #10  //and
    $display("Sum: %b", Sum); 
    
    a = 64'b100_10_10111;    
    b = 64'b001_10_10111; 
    Control = 2'b11;
    #10
    $display("Sum: %b", Sum); 
    
    $finish(); 
end
endmodule