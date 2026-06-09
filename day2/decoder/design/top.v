`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 21:27:49
// Design Name: 
// Module Name: decoder
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



module decoder(
input [1:0] b,
output reg [3:0] D
);
always @(*) begin
case (b)
2'b00: D = 4'b0001;
2'b01: D = 4'b0010;
2'b10: D = 4'b0100;
2'b11: D = 4'b1000;
default: D = 4'b0000;
endcase
end
endmodule

