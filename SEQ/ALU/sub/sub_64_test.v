module sub_64_test; 

reg signed [63 : 0] a, b; 
wire signed [63 : 0] Diff; 
wire Overflow; 

sub_64 uut(a, b, Diff, Overflow); 

initial begin
    $dumpfile("sub_64_test.vcd"); 
    $dumpvars(0, sub_64_test); 
    
    //2 positive
    a = 64'd100_10_10111;    
    b = 64'd100_01_00011; 
    #10
    $display("Diff: %d", Diff); 
    
    //negative greater than positive
    a = 64'd1012138011; 
    b = -64'd562979321112984; 
    #10
    $display("Diff: %d", Diff); 

    //positive greater than negative
    a = 64'd98928291938;    //overflow
    b = -64'd8928922; 
    #10
    $display("Diff: %d", Diff); 

    //both negative
    a = -64'd91897814987;     //overflow
    b = -64'd979847891798; 
    #10
    $display("Diff: %d", Diff); 

    //positive greater than negative
    a = 64'd987987; 
    b = -64'd80974; 
    #10
    $display("Diff: %d", Diff); 

    //negative greater than positive
    a = 64'd987225; 
    b = -64'd29480233; 
    #10
    $display("Diff: %d", Diff); 
    
    //small numbers
    a = 64'd10; 
    b = -64'd15; 
    #10
    $display("Diff: %d", Diff); 

    a = 64'd15; 
    b = -64'd10; 
    #10
    $display("Diff: %d", Diff); 

    a = 64'd10; 
    b = -64'd10; 
    #10
    $display("Diff: %d", Diff); 

    a = 64'd10; 
    b = 64'd20; 
    #10
    $display("Diff: %d", Diff); 
    
    a = 64'd10104; 
    b = 64'd190890179; 
    #10
    $display("Diff: %d", Diff); 

    a = -64'd1029; 
    b = 64'd19829929; 
    #10
    $display("Diff: %d", Diff); 

    $finish(); 
end
endmodule