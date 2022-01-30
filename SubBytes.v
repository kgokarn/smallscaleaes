`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/30/2020 12:30:32 PM
// Design Name: 
// Module Name: SubBytes
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


module SubBytes(b_out,a_in);
output wire[3:0]b_out;
input [3:0]a_in;

wire [3:0] c [0:15] ; 

 
assign {c[0],c[1],c[2],c[3] , c[4] , c[5] , c[6], c[7] , c[8], c[9], c[10], c[11], c[12], c[13], c[14], c[15]} =   {  4'b0110,
                    4'b1011,
                    4'b0101,
                    4'b0100,
                    4'b0010,
                    4'b1110,
                    4'b0111,
                    4'b1010,
                    4'b1001,
                    4'b1101,
                    4'b1111,
                    4'b1100,
                    4'b0011,
                    4'b0001,
                    4'b0000,
                    4'b1000 };
assign b_out = c[a_in];                    
endmodule
