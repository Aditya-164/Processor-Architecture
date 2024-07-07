module mem(
    input clk,
    input write_en,
    input read_en,
    input [63:0] write_address,
    input [63:0] write_data,
    output reg [63:0] read_data,
    output reg dmem_error
);

reg [63:0] my_mem [0:16383];

    always @(posedge clk) begin
        if (write_en && !read_en) begin
            my_mem[write_address]<=write_data;
        end 
        
        else if (!write_en && read_en) begin
            read_data<=my_mem[write_address];
        end 

        else if (write_en && read_en || write_address > 16384 || write_address < 0) begin
            dmem_error<=1;
        end
    end
endmodule
