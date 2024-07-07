module decode_tb; 

reg [3:0] icode, rA, rB; 
wire [63:0] valA, valB; 

decode uut(rA, rB, icode, valA, valB);

initial begin
    $dumpfile("decode_tb.vcd"); 
    $dumpvars(0, decode_tb); 

    rA = 2; 
    rB = 3; 
    icode = 0; //halt
    #5 
    
    $display("valA: %d, valB: %d", valA, valB);
    
    icode = 1; //nop
    #5
    $display("valA: %d, valB: %d", valA, valB);

    icode = 2; //rrmovq
    #5
    $display("valA: %d, valB: %d", valA, valB);

    icode = 3; //irmovq
    #5
    $display("valA: %d, valB: %d", valA, valB);
    
    icode = 4; //rmmovq
    #5 
    $display("valA: %d, valB: %d", valA, valB);

    icode = 5; //mrmovq
    #5
    $display("valA: %d, valB: %d", valA, valB);

    icode = 6; //opq
    #5
    $display("valA: %d, valB: %d", valA, valB);

    icode = 7; //jxx
    #5
    $display("valA: %d, valB: %d", valA, valB);

    icode = 8; //call 
    #5
    $display("valA: %d, valB: %d", valA, valB);

    icode = 9; //ret
    #5 
    $display("valA: %d, valB: %d", valA, valB);

    icode = 10; //pushq
    #5
    $display("valA: %d, valB: %d", valA, valB);

    icode = 11; //popq
    #5
    $display("valA: %d, valB: %d", valA, valB);

    #5 $finish(); 
end
endmodule