module fetch_1(clk, PC, imem_error, icode, ifun, rA, rB, need_regids, need_valC, 
instr_valid, valC, valP, hlt);
    input clk;
    reg [7:0] instr_mem[0:200]; 
    reg [7:0] instr [0:10]; 
    reg [7:0] split; 
    output reg [3:0] icode, ifun, rA, rB; 
    integer i;  
    input [63:0] PC; 
    output reg imem_error, need_regids, need_valC, instr_valid;
    output reg [63:0] valC, valP;
    output reg hlt;

always @(posedge clk) begin

    $readmemb("../SampleTestcase/popq.txt", instr_mem); 

    for(i = 0; i < 10; i = i + 1) begin
        instr[i] = instr_mem[i + PC]; 
    end; 

    split = instr[0]; 
    icode = split[7:4];
    ifun = split[3:0]; 

    if(PC >= 200) 
        imem_error = 1; 
    else 
        imem_error = 0; 

    if(icode > 4'hB)
        instr_valid = 0; 
    else 
        instr_valid = 1;

    if(icode == 4'h0)  //halt
    begin
        hlt = 1;         
        need_regids = 0; 
        need_valC = 0; 
    end

    else if(icode == 4'h1)   //nop
    begin
        need_regids = 0; 
        need_valC = 0; 
    end

    else if(icode == 4'h2)   //cmov or rrmovq
    begin
        need_regids = 1; 
        need_valC = 0; 
        rA = instr[1][7:4]; 
        rB = instr[1][3:0]; 
    end
    
    else if(icode == 4'h3)   //irmovq
    begin
        need_regids = 1; 
        need_valC = 1; 
        rA = 4'hF; 
        rB = instr[1][3:0]; 
        valC = {instr[2], instr[3], instr[4], instr[5], instr[6], instr[7], instr[8], instr[9]};
    end

    else if(icode == 4'h4)    //rmmovq
    begin
        need_regids = 1; 
        need_valC = 1; 
        rA = instr[1][7:4]; 
        rB = instr[1][3:0]; 
        valC = {instr[2], instr[3], instr[4], instr[5], instr[6], instr[7], instr[8], instr[9]};
    end

    else if(icode == 4'h5)   //mrmovq
    begin
        need_regids = 1; 
        need_valC = 1; 
        rA = instr[1][7:4]; 
        rB = instr[1][3:0]; 
        valC = {instr[2], instr[3], instr[4], instr[5], instr[6], instr[7], instr[8], instr[9]};
    end

    else if(icode == 4'h6)   //opq
    begin
        need_regids = 1; 
        need_valC = 0; 
        rA = instr[1][7:4]; 
        rB = instr[1][3:0]; 
    end

    else if(icode == 4'h7)   //jXX
    begin
        need_regids = 0; 
        need_valC = 1; 
        valC = {instr[1], instr[2], instr[3], instr[4], instr[5], instr[6], instr[7], instr[8]};
    end

    else if(icode == 4'h8)   //call
    begin
        need_regids = 0; 
        need_valC = 1; 
        valC = {instr[1], instr[2], instr[3], instr[4], instr[5], instr[6], instr[7], instr[8]};
    end

    else if(icode == 4'h9)   //ret
    begin
        need_regids = 0; 
        need_valC = 0; 
    end

    else if(icode == 4'hA)   //pushq
    begin
        need_regids = 1; 
        need_valC = 0; 
        rA = instr[1][7:4]; 
        rB = 4'hF; 
    end

    else if(icode == 4'hB)   //popq
    begin
        need_regids = 1; 
        need_valC = 0; 
        rA = instr[1][7:4]; 
        rB = 4'hF; 
    end

    valP = PC + 1 + need_regids + 8 * need_valC; 

end
    
endmodule