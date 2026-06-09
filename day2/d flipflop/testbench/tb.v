`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 13:36:41
// Design Name: 
// Module Name: D_flipflop_tb
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


module D_flipflop_tb();
reg d_tb,clk_tb;
wire q_tb;
integer m;
D_flipflop dut(d_tb,clk_tb,q_tb);
initial begin
{d_tb,clk_tb}=0;
end
initial begin
$monitor("The value of q_tb is %b",q_tb);
for(m=0;m<4;m=m+1)begin
#1;
{d_tb,clk_tb}=m;
end
end
endmodule
