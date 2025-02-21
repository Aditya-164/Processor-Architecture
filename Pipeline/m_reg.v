module m_reg(clk, e_stat, M_stat, e_icode, M_icode, e_cnd, M_cnd, e_valE, M_valE, e_valA, M_valA, e_dstE, M_dstE, e_dstM, M_dstM,M_bubble);

input clk,M_bubble;

input [3:0] e_icode, e_dstE, e_dstM;
input [63:0] e_valE, e_valA;
input [3:0] e_stat;
input  e_cnd;

output reg M_cnd;
output reg [3:0] M_stat, M_icode, M_dstE, M_dstM; 
output reg [63:0] M_valE, M_valA;


always@(posedge clk)
    begin
        if(!M_bubble)begin
            M_icode <= e_icode;
        end
        else
            M_icode <= 4'b1;
            
        M_stat <= e_stat;
        M_cnd <= e_cnd;
        M_valE <= e_valE;
        M_valA <= e_valA;
        M_dstE <= e_dstE;
        M_dstM <= e_dstM;
    end
    
endmodule
