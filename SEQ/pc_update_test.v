module pc_update_tb; 

reg [3:0] icode; 
reg Cnd; 
reg [63:0] valC, valP, valM; 
wire [63:0] PC; 

pc_update uut(icode, Cnd, valC, valM, valP, PC); 

initial begin 
    
    $dumpfile("pc_update_tb.vcd"); 
    $dumpvars(0, pc_update_tb); 

    icode = 4'h7;
    Cnd = 1; 
    valC = 10;  
    #5

    icode = 4'h8; 
    valC = 15; 
    #5

    icode = 4'h9; 
    valM = 20; 
    #5

    icode = 4'h1; 
    valP = 25; 
    #5
    
    $finish(); 
     
end

endmodule