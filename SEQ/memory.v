`timescale 1ns/1ps
module memory(clk,icode,valE,valP,valA,valB,valM,data);

  input clk;
  input [3:0] icode;
  input [63:0] valE,valP;
  input [63:0] valA,valB;

  output reg [63:0] valM;
  output reg [63:0] data;

  reg [63:0] Memory[0:1023];

  always@(*)
  begin
    //rmmovq
    if(icode==4'b0100)
    begin
      Memory[valE]<=valA;
    end
    //mrmovq
    if(icode==4'b0101) 
    begin
      valM<=Memory[valE];
    end
    //call
    if(icode==4'b1000) 
    begin
      Memory[valE]<=valP;
    end
    //ret
    if(icode==4'b1001) 
    begin
      valM<=Memory[valA];
    end
    //pushq
    if(icode==4'b1010) 
    begin
      Memory[valE]<=valA;
    end
    //popq
    if(icode==4'b1011) 
    begin
      valM<=Memory[valE];
    end
    data<=Memory[valE];
  end
endmodule
