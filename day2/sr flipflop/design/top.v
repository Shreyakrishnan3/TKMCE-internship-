`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 12:29:29
// Design Name: 
// Module Name: sr_flipflop
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


module sr_flipflop(input s,r,rst,clk,output reg q,qbar );
always@(clk)begin
if(clk)begin
   if(rst)begin//rst is checked only if enb is high..synchronous reset
   q<=1'b0;
   qbar<=1'b1;
   end
   else if(s==0 && r==0)begin
   q<=q;
   qbar<=qbar;
   end
   else if(s==0 && r==1)begin
   q<=1'b0;
   qbar<=1'b1;
   end
   else if(s==1 && r==0)begin
   q<=1'b1;
   qbar<=1'b0;
   end
   else if(s==1 && r==1)begin
   q<='bx;
   qbar<='bx;
   end
   
   
   end
end
endmodule
