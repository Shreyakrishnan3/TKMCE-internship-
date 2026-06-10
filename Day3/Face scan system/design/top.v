`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 21:03:36
// Design Name: 
// Module Name: top_system
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




// =================================================================
// 1. TOP MODULE (Connects to your existing FIFO file)
// =================================================================
module top_system (
input clk,
input rst,
input wren,          
input start_read,    
input [7:0] sin,     
output [7:0] dout,   
output rden,         
output full,         
output empty
);

wire [7:0] face_to_fifo;
wire [7:0] fifo_to_out;

face u_face (
.clk(clk),
.sin(sin),
.sout(face_to_fifo)
);

fifo u_fifo (
.clk(clk),
.rst(rst),
.wren(wren),
.rden(rden),
.data_in(face_to_fifo),
.data_out(fifo_to_out),
.full(full),
.empty(empty)
);

out_mod u_out_mod (
.clk(clk),
.rst(rst),
.start_read(start_read),
.empty(empty),
.din(fifo_to_out),
.rden(rden),
.dout(dout)
);

endmodule



// 2. MOD OUT WITH INTERNAL FSM (Using parameters)

module out_mod (
input clk,
input rst,
input start_read,
input empty,
input [7:0] din,
output reg rden,
output reg [7:0] dout
);


parameter IDLE = 2'b00;
parameter DELAY_CYCLES = 2'b01;
parameter READ_DATA = 2'b10;

reg [1:0] current_state, next_state;
reg [1:0] delay_count;

// Sequential State and Counter Register
always @(posedge clk) begin
if (rst) begin
current_state <= IDLE;
delay_count <= 2'b00;
dout <= 8'h00;
end else begin
current_state <= next_state;

if (current_state == DELAY_CYCLES) begin
delay_count <= delay_count + 1;
end else if (current_state == IDLE) begin
delay_count <= 2'b00;
end

if (current_state == READ_DATA && !empty) begin
dout <= din;
end
end
end

// Next State Combinational Logic
always @(*) begin
next_state = current_state;
case (current_state)
IDLE: begin
if (start_read)
next_state = DELAY_CYCLES;
end

DELAY_CYCLES: begin
if (delay_count == 2'b01)
next_state = READ_DATA;
end

READ_DATA: begin
if (empty)
next_state = IDLE;
end

default: next_state = IDLE;
endcase
end

// Output Control Combinational Logic
always @(*) begin
rden = 1'b0;
case (current_state)
IDLE, DELAY_CYCLES: begin
rden = 1'b0; 
end
READ_DATA: begin
rden = !empty; 
end
endcase
end

endmodule



// 3. FACE SCAN STUB MODULE

module face (
input clk,
input [7:0] sin,
output reg [7:0] sout
);
always @(posedge clk) begin
sout <= sin; 
end
endmodule


