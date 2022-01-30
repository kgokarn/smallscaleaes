`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:37:13 05/23/2020 
// Design Name: 
// Module Name:    MixColumn 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MixColumn(out_column , in_column);
output wire[15:0]out_column;
input [15:0]in_column;

// a0,a1,a2,a3 are the elements of input column
//r0,r1,r2,r3 are the elements of output column
/* MixColumn is calculated using Matrix Multiplication
r3 = [2*a3]^[3*a2]^[1*a1]^[1*a0] ; 
r2 = [1*a3]^[2*a2]^[3*a1]^[1*a0] ;
r1 = [1*a3]^[1*a2]^[2*a1]^[3*a0] ;
r0 = [3*a3]^[1*a2]^[1*a1]^[2*a0] ;
*//*
*//* 3 in binary -> 0011 = 0010 XOR 0001 
So in the above equations multiplication with 3 can be split to 
[a2*3] = [a2*2] ^ [a2*1] 
In binary multiplication by 2 means left shift by 1 bit 
*/
 
assign out_column[15:12] = galois(in_column[15:12]) ^ galois(in_column[11:8]) ^ in_column[11:8] ^in_column[7:4] ^ in_column[3:0];
assign out_column[11:8]  = in_column[15:12] ^ galois(in_column[11:8]) ^ galois(in_column[7:4]) ^ in_column[7:4] ^ in_column[3:0];
assign out_column[7:4] = in_column[15:12] ^ in_column[11:8] ^ galois(in_column[7:4]) ^ galois(in_column[3:0]) ^ in_column[3:0];
assign out_column[3:0] = galois(in_column[15:12]) ^ in_column[15:12] ^ in_column[11:8] ^ in_column[7:4] ^ galois(in_column[3:0]);

function [3:0]galois;
input [3:0]in_element;
reg [3:0]value;
begin
    if(in_element[3] == 1'b1)
        value[3:0] = 4'b0011;
    else
        value[3:0] = 4'b0000;
  galois = (value[3:0]) ^  (in_element[3:0] << 1);
end
endfunction
endmodule
