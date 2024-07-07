`timescale 1ns/1ps

module mem_tb;
reg clk;
reg write_en;
reg read_en;
reg [63:0] write_address;
reg [63:0] write_data;
wire [63:0] read_data;
wire dmem_error;

mem uut(
    .clk(clk),
    .write_en(write_en),
    .read_en(read_en),
    .write_address(write_address),
    .write_data(write_data),
    .read_data(read_data),
    .dmem_error(dmem_error)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    // Test Case 1: Write and Read
    uut.my_mem[0] = 64'h1122334455667788;
    uut.my_mem[1] = 64'hAABBCCDDEEFF0011;
    write_en = 1;
    read_en = 0;
    write_address = 1;
    write_data = 64'h9876543210ABCDEF;
    #10;
    write_en = 0;
    read_en = 1;
    write_address = 1;
    #10;
    if (read_data !== 64'h9876543210ABCDEF) begin
        $display("Test Case 1 failed: Read data mismatch");
    end else begin
        $display("Test Case 1 passed");
    end

    // Test Case 2: Write and Error (Write and Read simultaneously)
    write_en = 1;
    read_en = 1;
    write_address = 2;
    write_data = 64'h1122334455667788;
    #10;
    if (dmem_error !== 1) begin
        $display("Test Case 2 failed: Did not detect simultaneous write and read");
    end else begin
        $display("Test Case 2 passed");
    end

    // Test Case 3: Read from uninitialized memory
    write_en = 0;
    read_en = 1;
    write_address = 3;
    #10;
    if (read_data !== 64'hxxxxxxxxxxxxxxxx) begin
        $display("Test Case 3 failed: Read from uninitialized memory");
    end else begin
        $display("Test Case 3 passed");
    end
    $finish;
end

endmodule
