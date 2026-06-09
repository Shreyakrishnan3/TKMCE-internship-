`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 18:35:47
// Design Name: 
// Module Name: BCD
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

    // Stage 1: First 4-bit addition using RCA
    RCA rca1(
        .A(A), 
        .B(B), 
        .cin(cin), 
        .S(S1), 
        .cout(cout1)
    );

    // Stage 2: Detection logic (Checks if Stage 1 sum is > 9)
    and (w1, S1[3], S1[2]);      
    and (w2, S1[3], S1[1]);       
    or  (cout_bcd, cout1, w1, w2); 

    // Stage 3: Generate the correction vector (Creates 4'b0110 when cout_bcd is active)
    assign correction[3] = 1'b0;
    assign correction[2] = cout_bcd;
    assign correction[1] = cout_bcd;
    assign correction[0] = 1'b0;

    // Stage 4: Second 4-bit addition to apply the correction factor
    RCA rca2(
        .A(S1), 
        .B(correction), 
        .cin(1'b0), 
        .S(sum_bcd), 
        .cout(cout2)
    );

endmodule


