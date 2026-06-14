`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2026 21:46:48
// Design Name: 
// Module Name: fifo_if
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


interface fifo_if;
logic clk;
logic rst_n;
logic wr_en;
logic rd_en;
logic [7:0] data_in;
logic [7:0] data_out;
logic full;
logic empty;
endinterface

module fifo_tb();
fifo_if fif();
fifo dut (
.clk(fif.clk),
.rst_n(fif.rst_n),
.wr_en(fif.wr_en),
.rd_en(fif.rd_en),
.data_in(fif.data_in),
.data_out(fif.data_out),
.full(fif.full),
.empty(fif.empty)
);
always #5 fif.clk = ~fif.clk;
initial begin
fif.clk = 0;
fif.rst_n = 0;
fif.wr_en = 0;
fif.rd_en = 0;
fif.data_in = 0;
#15;
fif.rst_n = 1;
#10;
fif.wr_en = 1;
fif.data_in = 8'hAA;
#10;
fif.data_in = 8'hBB;
#10;
fif.data_in = 8'hCC;
#10;
fif.wr_en = 0;
#10;
fif.rd_en = 1;
#10;
#10;
#10;
fif.rd_en = 0;
#20;
$finish();
end
initial begin
$monitor("Time=%0t rst_n=%b wr=%b rd=%b din=%h dout=%h full=%b empty=%b", 
$time, fif.rst_n, fif.wr_en, fif.rd_en, fif.data_in, fif.data_out, fif.full, fif.empty);
end
endmodule

module fifo (
input clk,
input rst_n,
input wr_en,
input rd_en,
input [7:0] data_in,
output reg [7:0] data_out,
output full,
output empty
);
reg [7:0] mem [7:0];
reg [2:0] wptr;
reg [2:0] rptr;
reg [3:0] count;
assign full = (count == 8);
assign empty = (count == 0);
always @(posedge clk or negedge rst_n) begin
if (!rst_n) begin
wptr <= 0;
rptr <= 0;
count <= 0;
data_out <= 0;
end else begin
if (wr_en && !full) begin
mem[wptr] <= data_in;
wptr <= wptr + 1;
end
if (rd_en && !empty) begin
data_out <= mem[rptr];
rptr <= rptr + 1;
end
if ((wr_en && !full) && !(rd_en && !empty)) begin
count <= count + 1;
end else if (!(wr_en && !full) && (rd_en && !empty)) begin
count <= count - 1;
end
end
end
endmodule
