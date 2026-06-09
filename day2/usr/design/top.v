`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 14:49:36
// Design Name: 
// Module Name: usr
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


module usr(input clk,rst,sin,input [3:0]p_in,input shift,load,enb,[1:0]mod,output reg sout,output reg [3:0]p_out);
reg[3:0]temp;
always@(posedge clk)begin
if(shift)begin
if(load)begin
case(mod)
2'b00:begin
        if (rst) begin
            temp <= 4'b0000;
            sout <= 1'b0;
        end
        else if (enb == 0) begin
            // Shift left-to-right (same as your SIPO)
            temp <= temp >> 1'b1;
            temp[3] <= sin;
        end
        else if (enb == 1) begin
            // Output the last bit in the shift chain (LSB)
            sout <= temp[0];
            end
        end
    

2'b01:begin 
if(rst)begin
temp<=4'b0000;
end
else if(enb==0)begin
temp<=temp>>1'b1;
temp[3]<=sin;
end
else if(enb==1)begin
p_out<=temp;
end
end
2'b10: begin
        if (rst) begin
            temp <= 4'b0000;
            sout <= 1'b0;
        end
        else if (enb == 1) begin
            // Parallel load data into internal buffer
            temp <= p_in;
        end
        else if (enb == 0) begin
            // Shift data out serially (LSB comes out first)
            sout <= temp[0];
            temp <= temp >> 1'b1;
        end
        end
    
    2'b11:begin
        if (rst) begin
            temp <= 4'b0000;
            p_out <= 4'b0000;
        end
        else if (enb == 1) begin
            // Parallel load input
            temp <= p_in;
        end
        else if (enb == 0) begin
            // Transfer stored data to parallel output
            p_out <= temp;
           
            end
        


        end
        endcase
    end
    end
    end
endmodule

