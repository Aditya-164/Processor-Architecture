`timescale 1ns / 1ps

module write_back_tb;

    // Inputs
    reg clk;
    reg Cnd;
    reg [3:0] icode;
    reg [63:0] valE;
    reg [63:0] valM;
    reg [3:0] rA;
    reg [3:0] rB;

    write_back uut (
        .clk(clk),
        .Cnd(Cnd),
        .icode(icode),
        .valE(valE),
        .valM(valM),
        .rA(rA),
        .rB(rB)
    );

    // Generate clock
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        Cnd = 0;
        icode = 0;
        valE = 0;
        valM = 0;
        rA = 0;
        rB = 0;

        // Wait for global reset
        #100;

        // Test Case 1: cmov (conditionally move if Cnd is true)
        icode = 4'h2;
        Cnd = 1'b1;
        valE = 64'hCAFEBABEDEADBEEF;
        rB = 4'h4;
        #10;

        // Test Case 2: irmovq
        icode = 4'h3;
        valE = 64'h123456789ABCDEF0;
        rB = 4'h1;
        #10;

        // Test Case 3: mrmovq
        icode = 4'h5;
        valM = 64'hFEDCBA9876543210;
        rA = 4'h2;
        #10;

        // Test Case 4: OPq
        icode = 4'h6;
        valE = 64'hAABBCCDDEEFF0011;
        rB = 4'h3;
        #10;

        // Test Case 5: call
        icode = 4'h8;
        valE = 64'hDEADDEADDEADDEAD;
        #10;

        // Test Case 6: ret
        icode = 4'h9;
        valE = 64'hBEEFBEEFBEEFBEEF;
        #10;

        // Test Case 7: pushq
        icode = 4'hA;
        valE = 64'h1122334455667788;
        #10;

        // Test Case 8: popq
        icode = 4'hB;
        valE = 64'h8877665544332211;
        valM = 64'hFACEFACEFACEFACE;
        rA = 4'h5;
        #10;

        // End simulation
        #10 $finish;
    end

endmodule