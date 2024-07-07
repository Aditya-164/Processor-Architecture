module write_back(clk, Cnd, icode, valE, valM, rA, rB); 
    input clk;
    reg [63:0] reg_files[0:14]; 
    input [3:0] icode; 
    input [63:0] valE, valM; 
    input Cnd;
    input [3:0] rA, rB; 

always @(negedge clk)  //negedge clock 
begin
    
    $readmemb("../SampleTestcase/reg.txt", reg_files); 

    if(icode == 4'h2 && Cnd == 1'b1)    //cmov
        reg_files[rB] = valE; 
    
    else if(icode == 4'h3)      //irmovq
        reg_files[rB] = valE; 
    
    else if(icode == 4'h5)      //mrmovq
        reg_files[rA] = valM; 
    
    else if(icode == 4'h6)      //OPq
        reg_files[rB] = valE; 
    
    else if(icode == 4'h8)      //call
        reg_files[4] = valE;
    
    else if(icode == 4'h9)      //ret 
        reg_files[4] = valE;
    
    else if(icode == 4'hA)      //pushq
        reg_files[4] = valE;
    
    else if(icode == 4'hB)      //popq
    begin 
        reg_files[4] = valE; 
        reg_files[rA] = valM; 
    end
    
    $writememb("../SampleTestcase/reg.txt", reg_files); 

end

endmodule