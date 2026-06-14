`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2026 21:07:47
// Design Name: 
// Module Name: BCD_if
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


// 1. Define the Interface for the BCD module
interface bcd_if;
logic [3:0] A;
logic [3:0] B;
logic cin;
logic [3:0] sum_bcd;
logic cout_bcd;
endinterface

module BCD_tb();
bcd_if bif();
BCD dut(
.A(bif.A),
.B(bif.B),
.cin(bif.cin),
.sum_bcd(bif.sum_bcd),
.cout_bcd(bif.cout_bcd)
);
initial begin 
bif.A = 4'b0000;
bif.B = 4'b0000;
bif.cin = 1'b0;
end
initial begin
#1;
bif.A = 4'd3;
bif.B = 4'd4;
bif.cin = 1'b0;
#1;
bif.A = 4'd5;
bif.B = 4'd6;
bif.cin = 1'b0;
#1;
bif.A = 4'd8;
bif.B = 4'd7;
bif.cin = 1'b1;
#1;
bif.A = 4'd9;
bif.B = 4'd9;
bif.cin = 1'b1;
#1;
$finish();
end
initial begin 
$monitor("A=%d, B=%d, cin=%b -> S=%d, cout=%b", bif.A, bif.B, bif.cin, bif.sum_bcd, bif.cout_bcd);
end
endmodule

module BCD(
input [3:0] A,
input [3:0] B,
input cin,
output [3:0] sum_bcd,
output cout_bcd
);
wire [3:0] S1;
wire cout1;
wire w1, w2;
wire [3:0] correction;
wire cout2;
RCA rca1(
.A(A), 
.B(B), 
.cin(cin), 
.S(S1), 
.cout(cout1)
);
and (w1, S1[3], S1[2]);
and (w2, S1[3], S1[1]);
or (cout_bcd, cout1, w1, w2);
assign correction[3] = 1'b0;
assign correction[2] = cout_bcd;
assign correction[1] = cout_bcd;
assign correction[0] = 1'b0;
RCA rca2(
.A(S1), 
.B(correction), 
.cin(1'b0), 
.S(sum_bcd), 
.cout(cout2)
);
endmodule

module RCA(
input [3:0] A,
input [3:0] B,
input cin,
output [3:0] S,
output cout
);
wire c1, c2, c3;
fulladd FA1 (.a(A[0]), .b(B[0]), .cin(cin), .sum(S[0]), .carry(c1));
fulladd FA2 (.a(A[1]), .b(B[1]), .cin(c1), .sum(S[1]), .carry(c2));
fulladd FA3 (.a(A[2]), .b(B[2]), .cin(c2), .sum(S[2]), .carry(c3));
fulladd FA4 (.a(A[3]), .b(B[3]), .cin(c3), .sum(S[3]), .carry(cout));
endmodule

module fulladd(
input a,
input b,
input cin,
output sum,
output carry
);
assign sum = a ^ b ^ cin;
assign carry = (a & b) | (b & cin) | (cin & a);
endmodule

