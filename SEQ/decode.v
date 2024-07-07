module decode(clk, rA, rB, icode, valA, valB);
    reg [63:0] reg_files[0:14]; 
    output reg [63:0] valA, valB; 
    input [3:0] icode; 
    input [3:0] rA, rB; 
    input clk;
    
always @(*) begin 
    
    $readmemb("../SampleTestcase/reg.txt", reg_files); 

    if(icode == 4'h2)    //cmov or rrmovq
        valA <= reg_files[rA]; 
        
    else if (icode == 4'h4)     //rmmovq
    begin 
        valA <= reg_files[rA]; 
        valB <= reg_files[rB]; 
    end
    
    else if (icode == 4'h5)     //mrmovq
        valB <= reg_files[rB]; 
    
    else if(icode == 4'h6)      //OPq
    begin
        valA <= reg_files[rA]; 
        valB <= reg_files[rB]; 
    end

    else if(icode == 4'h8)      //call
        valB <= reg_files[4]; //%rsp 
    
    else if(icode == 4'h9)      //ret
    begin 
        valA <= reg_files[4]; 
        valB <= reg_files[4]; 
    end

    else if(icode == 4'hA)      //pushq
    begin
        valA <= reg_files[rA]; 
        valB <= reg_files[4]; 
    end

    else if(icode == 4'hB)      //popq
    begin 
        valA <= reg_files[4]; 
        valB <= reg_files[4]; 
    end

end

endmodule