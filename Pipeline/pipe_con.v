module ctrl_lgc(clk,W_stat,e_Cnd,m_stat,E_dstM,d_srcB,d_srcA,D_icode,E_icode);

input clk;

input [3:0] D_icode, E_icode, M_icode;
input [3:0] W_stat, m_stat;
input [3:0] d_srcB ,d_srcA;
input [3:0] E_dstM;

input e_Cnd;

output reg set_cc;
output reg E_bubble,M_bubble,D_bubble;
output reg W_stall ,D_stall, F_stall;



endmodule