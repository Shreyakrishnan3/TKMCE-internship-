`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 18:05:00
// Design Name: 
// Module Name: rca_tb
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

module RCA_tb();
reg [3:0] A_tb, B_tb;
reg cin_tb;
wire [3:0] S_tb;
wire cout_tb;

// Device Under Test (DUT) Instantiation
RCA dut(A_tb, B_tb, cin_tb, S_tb, cout_tb);

initial begin 
    A_tb = 4'b0000;
    B_tb = 4'b0000;
    cin_tb = 1'b0;
end

initial begin
#1;
 A_tb = 4'd3;
 B_tb = 4'd4;
 cin_tb = 1'b0;
#1;
 A_tb = 4'd5;
 B_tb = 4'd2;
 cin_tb = 1'b1;
#1;
 A_tb = 4'd8;
 B_tb = 4'd8;
 cin_tb = 1'b1;
#1;
 A_tb = 4'd15;
 B_tb = 4'd15;
 cin_tb = 1'b1;
end

initial begin 
    $monitor("The value of A_tb is %b (%d) The value of B_tb is %b (%d) The value of cin_tb is %b The value of S_tb is %b (%d) The value of cout_tb is %b", 
             A_tb, A_tb, B_tb, B_tb, cin_tb, S_tb, S_tb, cout_tb);
end

endmodule
