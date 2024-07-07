`timescale 1ns/1ps

module memory_tb;

  reg clk;
  reg [3:0] icode;
  reg [63:0] valE, valP, valA, valB;
  wire [63:0] valM, data;

  // Instantiate memory module
  memory dut (
    .clk(clk),
    .icode(icode),
    .valE(valE),
    .valP(valP),
    .valA(valA),
    .valB(valB),
    .valM(valM),
    .data(data)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Testbench stimulus
  initial begin
    clk = 0;
    icode = 4'b0100; // rmmovq
    valE = 8'd10;
    valA = 64'h1234567890ABCDEF;
    #10;
    if (dut.Memory[valE] !== valA)
    $display("Test case 1 failed: rmmovq. Expected: %h, Got: %h", valA, dut.Memory[valE]);
    else
    $display("Test case 1 passed: rmmovq");

    icode = 4'b0101; // mrmovq
    valE = 8'd10;
    dut.Memory[valE] = 64'h9876543210FEDCBA;
    #10;
    if (valM !== dut.Memory[valE]) $display("Test case 2 failed: mrmovq");
    else $display("Test case 2 passed: mrmovq");

    icode = 4'b1000; // call
    valE = 8'd10;
    valP = 64'hAAAAAAAAAAAAAAAA;
    #10;
    if (dut.Memory[valE] !== valP) $display("Test case 3 failed: call");
    else $display("Test case 3 passed: call");

    icode = 4'b1001; // ret
    valA = 8'd10;
    dut.Memory[valA] = 64'hBBBBBBBBBBBBBBBB;
    #10;
    if (valM !== dut.Memory[valA]) $display("Test case 4 failed: ret");
    else $display("Test case 4 passed: ret");

    icode = 4'b1010; // pushq
    valE = 8'd10;
    valA = 64'hCCCCCCCCCCCCCCCC;
    #10;
    if (dut.Memory[valE] !== valA) $display("Test case 5 failed: pushq");
    else $display("Test case 5 passed: pushq");

    icode = 4'b1011; // popq
    valE = 8'd10;
    dut.Memory[valE] = 64'hDDDDDDDDDDDDDDDD;
    #10;
    if (valM !== dut.Memory[valE]) $display("Test case 6 failed: popq");
    else $display("Test case 6 passed: popq");

    $finish;
  end

endmodule
