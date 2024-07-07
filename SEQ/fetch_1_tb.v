module fetch_1_tb; 

reg [63:0] PC;
wire imem_error, need_regids, need_valC, instr_valid; 
wire [63:0] valC, valP; 
wire [3:0] icode, ifun, rA, rB; 

fetch_1 uut(PC, imem_error, icode, ifun, rA, rB, need_regids, need_valC, 
instr_valid, valC, valP); 

initial begin
    $dumpfile("fetch_test.vcd"); 
    $dumpvars(0, fetch_1_tb); 
    PC = 32'b0; 
    #5
    $finish(); 
end
endmodule