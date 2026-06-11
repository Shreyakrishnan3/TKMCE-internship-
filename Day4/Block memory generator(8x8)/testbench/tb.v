`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.06.2026 20:05:16
// Design Name: 
// Module Name: block_memory_generator_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////




module block_memory_generator_tb();
reg clk_tb, rst_tb, we_tb, ce_tb;
reg [2:0] addr_tb;
reg [7:0] din_tb;
wire [7:0] dout_tb;

block_memory_generator dut(clk_tb, rst_tb, we_tb, ce_tb, addr_tb, din_tb, dout_tb);

initial begin
{clk_tb, rst_tb, we_tb, ce_tb, addr_tb, din_tb} = 0;
end

always #5 clk_tb = ~clk_tb;

initial begin
rst_tb = 1;
#10;
rst_tb = 0;
ce_tb = 1;
#10;
addr_tb = 0; din_tb = 165; we_tb = 1; #10; // 165 is 8'hA5
addr_tb = 4; din_tb = 91;  we_tb = 1; #10; // 91 is 8'h5B
addr_tb = 7; din_tb = 255; we_tb = 1; #10; // 255 is 8'hFF
we_tb = 0;
addr_tb = 0; #10;
addr_tb = 4; #10;
addr_tb = 7; #10;
ce_tb = 0;
addr_tb = 0; #10;
$finish;
end
endmodule
