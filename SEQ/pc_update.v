module pc_update(clk, icode, Cnd, valC, valM, valP, updated_PC); 
    input clk;
    input [3:0] icode; 
    input Cnd; 
    input [63:0] valC, valP, valM; 
    output reg [63:0] updated_PC; 
    
always @(*) begin

    if(icode == 4'h7 && Cnd == 1)   //jXX
        updated_PC = valC; 

    else if(icode == 4'h8)      //call
        updated_PC = valC; 

    else if(icode == 4'h9)      //ret
        updated_PC = valM; 

    else 
        updated_PC = valP; 

end

endmodule