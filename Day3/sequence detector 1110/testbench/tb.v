`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 11:48:24
// Design Name: 
// Module Name: sd_1110_tb
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




module sd_1110_tb();

reg clk_tb, rst_tb, din_tb;
wire detected_tb;

// Instantiate the design
sd_1110 dut(clk_tb, rst_tb, din_tb, detected_tb);

// Initialize all inputs to 0 at t=0
initial begin
    {clk_tb, rst_tb, din_tb} = 0;
end

// Clock generator: 10ns total period (5ns low, 5ns high)
always #5 clk_tb = ~clk_tb;

// Stimulus block
initial begin
    rst_tb = 1;   // Assert reset
    #10;          // Hold for 10ns
    rst_tb = 0;   // Release reset
    #10;
    din_tb = 1;   // First bit: 1
    #10;
    din_tb = 1;   // Second bit: 1 (Fixed comment from 0 to 1)
    #10;
    din_tb = 1;   // Third bit: 1
    #10;
    din_tb = 0;   // Fourth bit: 0 (Sequence 1110 complete - Fixed comment from 1010 to 1110)
    
    #10;          // CRITICAL: Wait 10ns so the clk edge can sample the final 0
    $finish;      // CRITICAL: Cleanly stops the simulation
end

endmodule



