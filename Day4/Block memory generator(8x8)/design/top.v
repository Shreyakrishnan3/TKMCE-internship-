`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.06.2026 20:02:18
// Design Name: 
// Module Name: block_memory_generator
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




module block_memory_generator(
input clk,rst,we,ce,
input [2:0] addr,
input [7:0] din,
output reg [7:0] dout
);
reg [7:0] ram_block[7:0];
integer i;

always@(posedge clk)begin
if(rst)begin
dout<=0;
for(i=0;i<8;i=i+1)
ram_block[i]<=0;
end
else if(ce)begin
if(we)begin
ram_block[addr]<=din;
end
else begin
dout<=ram_block[addr];
end
end
end
endmodule
