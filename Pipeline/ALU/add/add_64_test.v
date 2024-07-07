module add_64_test; 

reg signed [63 : 0] a, b; 
wire signed [63 : 0] Sum; 
wire Overflow; 

add_64 uut(a, b, Sum, Overflow); 

initial begin
    $dumpfile("add_64_test.vcd"); 
    $dumpvars(0, add_64_test); 
    
    //2 positive
    a = 64'd100_10_10111;    
    b = 64'd100_01_00011; 
    #10
    $display("Sum: %d", Sum); 
    
    //negative greater than positive
    a = 64'd1012138011; 
    b = -64'd562979321112984; 
    #10
    $display("Sum: %d", Sum); 

    //positive greater than negative
    a = 64'd98928291938;    //overflow
    b = -64'd8928922; 
    #10
    $display("Sum: %d", Sum); 

    //both negative
    a = -64'd91897814987;     //overflow
    b = -64'd979847891798; 
    #10
    $display("Sum: %d", Sum); 

    //positive greater than negative
    a = 64'd987987; 
    b = -64'd80974; 
    #10
    $display("Sum: %d", Sum); 

    //negative greater than positive
    a = 64'd987225; 
    b = -64'd29480233; 
    #10
    $display("Sum: %d", Sum); 
    
    //small numbers
    a = 64'd10; 
    b = -64'd15; 
    #10
    $display("Sum: %d", Sum); 

    a = 64'd15; 
    b = -64'd10; 
    #10
    $display("Sum: %d", Sum); 

    a = 64'd10; 
    b = -64'd10; 
    #10
    $display("Sum: %d", Sum); 


    $finish(); 
end
endmodule