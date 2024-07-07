`include "fetch_1.v"
`include "decode.v"
`include "execute_2.v"
`include "memory.v"
`include "write_back.v"
`include "pc_update.v"

module seq; 
    reg clk; 
    reg stat [0:2];     
    reg [63:0] PC; 
    
    wire [3:0] icode, ifun, rA, rB; 
    wire [63:0] valA, valB, valC, valP, valE, valM, updated_PC;
    wire instr_valid, imem_error, Cnd, sign_flag, zero_flag, overflow_flag; 
    wire hlt; 
    
    fetch_1 fetch_1_1(
        .clk(clk), 
        .PC(PC), 
        .imem_error(imem_error), 
        .icode(icode), 
        .ifun(ifun), 
        .rA(rA), 
        .rB(rB), 
        .need_regids(need_regids), 
        .need_valC(need_valC), 
        .instr_valid(instr_valid), 
        .valC(valC), 
        .valP(valP), 
        .hlt(hlt)
    ); 

    decode decode_1(
        .clk(clk),  
        .rA(rA), 
        .rB(rB), 
        .icode(icode), 
        .valA(valA), 
        .valB(valB)
    );

    execute execute_1(
        .clk(clk), 
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

    memory memory_1(
        .clk(clk), 
        .icode(icode), 
        .valE(valE), 
        .valP(valP), 
        .valA(valA), 
        .valB(valB), 
        .valM(valM), 
        .data(data)
    ); 

    write_back write_back_1(
        .clk(clk), 
        .Cnd(Cnd), 
        .icode(icode),
        .valE(valE), 
        .valM(valM), 
        .rA(rA), 
        .rB(rB)
    ); 

    pc_update pc_update_1(
        .clk(clk), 
        .icode(icode), 
        .Cnd(Cnd), 
        .valC(valC), 
        .valM(valM), 
        .valP(valP), 
        .updated_PC(updated_PC)
    );
    
    always #5 clk = ~clk; 
    
    initial begin 
        $dumpfile("seq.vcd"); 
        $dumpvars(0, seq); 

        stat[0] = 1; 
        stat[1] = 0; 
        stat[2] = 0; 

        clk = 0; 
        PC = 64'd0; 

        $monitor("PC: %0d, icode = %0d, ifun = %0h, rA = %0h, rB = %0h, valA = %0d, valB = %0d, valC = %0d, valE = %0d, valM = %0d, Cnd = %0b, hlt = %0b, data = %0d", PC, icode, ifun, rA, rB, valA, valB, valC, 
        valE, valM, Cnd, hlt, data);
    end
        
    always @(*)
    begin 
        PC = updated_PC; 
    end

    always @(*) 
    begin 
        if(hlt)
        begin 
            stat[2] = hlt; 
            stat[1] = 1'b0; 
            stat[0] = 1'b0; 
        end

        else if(instr_valid)
        begin 
            stat[1] = instr_valid; 
            stat[2] = 1'b0; 
            stat[0] = 1'b0; 
        end

        else
        begin 
            stat[0] = 1'b1; 
            stat[1] = 1'b0; 
            stat[2] = 1'b0; 
        end

        if(stat[2] == 1'b1) 
            $finish(); 
    end
    
endmodule