`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 21:33:37
// Design Name: 
// Module Name: decoder_tb
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



module decoder_tb();
reg [1:0] b_tb;
wire [3:0] D_tb;
decoder dut(
.b(b_tb),
.D(D_tb)
);
initial begin
b_tb = 2'b00;
#10;
b_tb = 2'b01;
#10;
b_tb = 2'b10;
#10;
b_tb = 2'b11;
#10;
end
endmodule
