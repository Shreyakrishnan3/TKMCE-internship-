`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 11:42:25
// Design Name: 
// Module Name: sd_1110
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




module sd_1110(input clk,rst,din,output reg detected);
parameter idle=2'b00;
parameter s1=2'b01;
parameter s2=2'b10;
parameter s3=2'b11;
reg [1:0] ps,ns;

always@(posedge clk)
begin
if(rst)begin
ps<=idle;
end
else 
ps<=ns;
end

always@(*)begin
//  Default value prevents  latch synthesis error
detected = 0;
case(ps)
idle:begin
if(din==0)
ns=idle;
else
ns=s1;
end
s1:begin
if(din==0)
ns=idle;
else 
ns=s2;
end
s2:begin
if(din==0)
ns=idle;
else
ns=s3;
end
s3:begin
if(din==0)begin
//   overlapping allows the next bit to start a new stream
ns=idle;
detected=1;
end
else begin
ns=s3;
end
end
default: ns=idle;
endcase
end

endmodule

