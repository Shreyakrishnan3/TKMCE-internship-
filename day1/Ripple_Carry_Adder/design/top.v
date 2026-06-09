`timescale 1ns / 1ps
module RCA(
    input [3:0] A,
    input [3:0] B,
    input cin,
    output [3:0] S,
    output cout
);
    // Internal carry wires connecting the stages
    wire c1, c2, c3;

    // Instantiate 4 Full Adders matching the blackboard layout
    fulladd FA1 (.a(A[0]), .b(B[0]), .cin(cin), .sum(S[0]), .carry(c1));
    fulladd FA2 (.a(A[1]), .b(B[1]), .cin(c1),  .sum(S[1]), .carry(c2));
    fulladd FA3 (.a(A[2]), .b(B[2]), .cin(c2),  .sum(S[2]), .carry(c3));
    fulladd FA4 (.a(A[3]), .b(B[3]), .cin(c3),  .sum(S[3]), .carry(cout));

endmodule
