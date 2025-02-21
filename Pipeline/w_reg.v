module w_reg(clk, m_stat, W_stat, m_icode, W_icode, m_valE, W_valE, m_valM, W_valM, m_dstE, m_dstM, W_dstE, W_dstM,W_stall);


input clk,W_stall;
input [63:0] m_valE, m_valM;
input [3:0] m_stat, m_icode, m_dstE, m_dstM;


output reg [63:0] W_valE, W_valM;
output reg [3:0] W_stat, W_icode, W_dstE, W_dstM;
output reg m_cnd;



always @(posedge clk)
    begin
        if(!W_stall)begin
            W_stat <= m_stat;
            W_icode <= m_icode;
            W_valE <= m_valE;
            W_valM <= m_valM;
            W_dstE <= m_dstE; 
            W_dstM <= m_dstM;
        end
    end

endmodule