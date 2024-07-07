module f_reg(clk,F_stall,F_pc, predPC, F_predPC,F_stat,f_stat);

input clk,F_stall;
input [63:0] predPC ,F_pc;
input [3:0] F_stat;

output reg [3:0] f_stat;
output reg [63:0] F_predPC;


always @(posedge clk)
    begin
        f_stat <= F_stat;
        if(!F_stall)
        begin
            F_predPC <= predPC;
        end
        else
        begin
            F_predPC <= F_pc;
        end
    end
endmodule