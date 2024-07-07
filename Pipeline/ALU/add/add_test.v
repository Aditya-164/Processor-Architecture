module add_test; 

reg a, b, CarryIn;
wire Sum, CarryOut; 

add uut(a, b, CarryIn, Sum, CarryOut); 

initial begin
    $dumpfile("add_test.vcd"); 
    $dumpvars(0, add_test); 

    a = 0; 
    b = 0; 
    CarryIn = 0; 
    #10
    CarryIn = 1; 
    #10

    b = 1; 
    CarryIn = 0;
    #10
    CarryIn = 1; 
    #10

    a = 1; 
    b = 0; 
    CarryIn = 0; 
    #10
    CarryIn = 1; 
    #10

    b = 1; 
    CarryIn = 0; 
    #10
    CarryIn = 0; 
    #10

    $finish();     
end

endmodule