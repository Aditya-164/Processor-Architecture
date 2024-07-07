`timescale 1ns / 1ps

module execute_tb;

    reg [3:0] icode;
    reg [3:0] ifun;
    reg [63:0] valA;
    reg [63:0] valB;
    reg [63:0] valC;

    wire [63:0] valE;
    wire Cnd;
    wire zero_flag;
    wire sign_flag;
    wire overflow_flag;

    execute uut (
        .icode(icode), 
        .ifun(ifun), 
        .valA(valA), 
        .valB(valB), 
        .valC(valC), 
        .valE(valE), 
        .Cnd(Cnd), 
        .zero_flag(zero_flag), 
        .sign_flag(sign_flag), 
        .overflow_flag(overflow_flag)
    );

    initial begin
        icode = 0; //halt
        ifun = 0;
        valA = 64'dx;
        valB = 64'dx;
        valC = 64'dx;

        #10;
        $display("valE: %d, zero_flag: %b, sign_flag: %b, overflow_flag: %b, Cnd: %b", $signed(valE), zero_flag, sign_flag, overflow_flag, Cnd);
        
        icode = 1;  //nop
        ifun = 0; 
        valA = 64'dx; 
        valB = 64'dx; 
        valC = 64'dx; 
        #10;
        $display("valE: %d, zero_flag: %b, sign_flag: %b, overflow_flag: %b, Cnd: %b", $signed(valE), zero_flag, sign_flag, overflow_flag, Cnd);
        
        icode = 2; //rrmovq
        ifun = 0; 
        valA = 64'd10; 
        valB = 64'd15; 
        valC = 64'd12; 
        
        #10; 
        $display("valE: %d, zero_flag: %b, sign_flag: %b, overflow_flag: %b, Cnd: %b", $signed(valE), zero_flag, sign_flag, overflow_flag, Cnd);
        
        icode = 3; //irmovq
        ifun = 0; 
        valA = 64'd15; 
        valB = 64'd10; 
        valC = 64'd8; 
        
        #10; 
        $display("valE: %d, zero_flag: %b, sign_flag: %b, overflow_flag: %b, Cnd: %b", $signed(valE), zero_flag, sign_flag, overflow_flag, Cnd);

        icode = 4; //rmmovq 
        ifun = 0; 
        valA = 64'd10; 
        valB = 64'd15; 
        valC = 64'd12; 

        #10; 
        $display("valE: %d, zero_flag: %b, sign_flag: %b, overflow_flag: %b, Cnd: %b", $signed(valE), zero_flag, sign_flag, overflow_flag, Cnd);
    
        icode = 5; //mrmovq
        ifun = 0; 
        valA = 64'd10; 
        valB = 64'd15; 
        valC = 64'd12; 

        #10 
        $display("valE: %d, zero_flag: %b, sign_flag: %b, overflow_flag: %b, Cnd: %b", $signed(valE), zero_flag, sign_flag, overflow_flag, Cnd);
        
        icode = 6; //opq
        ifun = 0; 
        valA = 64'd10; 
        valB = 64'd15; 
        
        #10
        $display("valE: %d, zero_flag: %b, sign_flag: %b, overflow_flag: %b, Cnd: %b", $signed(valE), zero_flag, sign_flag, overflow_flag, Cnd);
        
        icode = 6;  //opq
        ifun = 1; 
        valA = 64'd10; 
        valB = 64'd15; 
        
        #10
        $display("valE: %d, zero_flag: %b, sign_flag: %b, overflow_flag: %b, Cnd: %b", $signed(valE), zero_flag, sign_flag, overflow_flag, Cnd);
    
        icode = 6; //opq
        ifun = 1; 
        valA = 64'd10; 
        valB = 64'd10; 

        #10
        $display("valE: %d, zero_flag: %b, sign_flag: %b, overflow_flag: %b, Cnd: %b", $signed(valE), zero_flag, sign_flag, overflow_flag, Cnd);
        
        icode = 7; //jxx
        ifun = 2; 
        valC = 64'd12; 

        #10
        $display("valE: %d, zero_flag: %b, sign_flag: %b, overflow_flag: %b, Cnd: %b", $signed(valE), zero_flag, sign_flag, overflow_flag, Cnd);

        icode = 8; //call
        ifun = 0; 
        valB = 64'd10; 
        valC = 64'd12; 

        #10
        $display("valE: %d, zero_flag: %b, sign_flag: %b, overflow_flag: %b, Cnd: %b", $signed(valE), zero_flag, sign_flag, overflow_flag, Cnd);
        
        icode = 9; //ret
        ifun = 0; 
        valB = 64'd10;
        ifun = 0; 

        #10
        $display("valE: %d, zero_flag: %b, sign_flag: %b, overflow_flag: %b, Cnd: %b", $signed(valE), zero_flag, sign_flag, overflow_flag, Cnd);
        
        icode = 10; //pushq
        ifun = 0; 
        valA = 64'd8; 
        valB = 64'hF; 

        #10
        $display("valE: %d, zero_flag: %b, sign_flag: %b, overflow_flag: %b, Cnd: %b", $signed(valE), zero_flag, sign_flag, overflow_flag, Cnd);
        
        icode = 11; //popq
        ifun = 0; 
        valA = 64'd9; 
        valB = 64'hF; 

        #10
        $display("valE: %d, zero_flag: %b, sign_flag: %b, overflow_flag: %b, Cnd: %b", $signed(valE), zero_flag, sign_flag, overflow_flag, Cnd);

    end
      
endmodule