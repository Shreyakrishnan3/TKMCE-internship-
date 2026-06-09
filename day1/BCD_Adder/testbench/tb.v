`timescale 1ns / 1ps

module BCD_tb();
reg [3:0] A_tb, B_tb;
reg cin_tb;
wire [3:0] S_tb;
wire cout_tb;

BCD dut(A_tb, B_tb, cin_tb, S_tb, cout_tb);

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
 B_tb = 4'd6;
 cin_tb = 1'b0;
#1;
 A_tb = 4'd8;
 B_tb = 4'd7;
 cin_tb = 1'b1;
#1;
 A_tb = 4'd9;
 B_tb = 4'd9;
 cin_tb = 1'b1;
end

initial begin 
    $monitor("The value of A_tb is %b (%d) The value of B_tb is %b (%d) The value of cin_tb is %b The value of S_tb is %b (%d) The value of cout_tb is %b", 
             A_tb, A_tb, B_tb, B_tb, cin_tb, S_tb, S_tb, cout_tb);
end

endmodule
