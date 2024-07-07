`include "ALU/alu/alu_64.v"

module execute(clk, icode, ifun, valA, valB, valC, valE, Cnd, zero_flag, sign_flag, 
    overflow_flag); 
    input clk;
    input [3:0] icode, ifun; 
    input [63:0] valA, valB, valC; 
    output [63:0] valE; 
    reg [63:0] aluA, aluB; 
    reg [3:0] aluFun; 
    output reg sign_flag, zero_flag; 
    output reg overflow_flag;
    output reg Cnd; 
    reg set_cc; 
    reg cc_mem[2:0]; 
    wire of; 
    
    alu_64 alu_64_1(
        .A(aluA), 
        .B(aluB), 
        .Control(aluFun), 
        .Sum(valE), 
        .Overflow(of) 
    );
    
initial 
begin 
    $readmemb("cc_mem.txt", cc_mem, 0, 2); 
    zero_flag = cc_mem[0]; 
    sign_flag = cc_mem[1]; 
    overflow_flag = cc_mem[2]; 
end

always @(*) begin
    
    set_cc = 0; 

    //aluA

    if(icode == 4'h6 || icode == 4'h2)      //opq or rrmovq
        aluA = valA; 
    
    else if(icode == 4'h8 || icode == 4'hA)     //call or pushq
        aluA = -8; 
    
    else if(icode == 4'h9 || icode == 4'hB)     //ret or popq
        aluA = 8; 
    
    else if(icode == 4'h3 || icode == 4'h4 || icode == 4'h5)    //irmovq or rmmovq or mrmovq
        aluA = valC; 
    
    //aluB

    if(icode == 4'h4 || icode == 4'h5 || icode == 4'h6 || icode == 4'h8
        || icode == 4'hA || icode == 4'h9 || icode == 4'hB)  // rmmovq, mrmovq
                                                            //opq, call, pushq, 
                                                            //ret, popq
        aluB = valB; 
    
    else if(icode == 4'h2 || icode == 4'h3)         //rrmovq, irmovq
        aluB = 0; 
    
    //aluFun
    
    if(icode == 4'h6) //opq
        aluFun = ifun; 
    else
        aluFun = 0; //add
    
    //set_cc

    if(icode == 4'h6)    //opq
        set_cc = 1; 
    
    //valE

    if(valE < 0)
        sign_flag = 1;  
    else if(valE == 0) 
        zero_flag = 1; 

    //Cnd

    if(icode == 4'h2 || icode == 4'h7) 
    begin 
        if(ifun == 4'h0)        //rrmovq
            Cnd = 1;

        else if(ifun == 4'h1)   //cmovle
            Cnd = ((sign_flag ^ overflow_flag) | zero_flag); 

        else if(ifun == 4'h2)   //cmovl
            Cnd = sign_flag ^ overflow_flag; 
        
        else if(ifun == 4'h3)   //cmove
            Cnd = zero_flag; 
        
        else if(ifun == 4'h4)    //cmovne
            Cnd = ~zero_flag;
        
        else if(ifun == 4'h5)    //cmovge
            Cnd = (~sign_flag ^ overflow_flag); 
        
        else if(ifun == 4'h6)     //cmovg
            Cnd = ((~sign_flag ^ overflow_flag) & ~zero_flag); 
    end
    
end

always @(valE) begin
    if(set_cc) begin 
        if($signed(valE) < 0)
            sign_flag = 1; 
        else 
            sign_flag = 0; 
        
        if(valE == 0)
            zero_flag = 1;
        else 
            zero_flag = 0;
            
        overflow_flag = of;
       
        cc_mem[0] = zero_flag; 
        cc_mem[1] = sign_flag; 
        cc_mem[2] = overflow_flag;
         
        $writememb("cc_mem.txt", cc_mem, 0, 2); 
    end
end

endmodule