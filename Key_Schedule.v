`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/29/2020 09:53:53 PM
// Design Name: 
// Module Name: Key_Schedule
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


module Key_Schedule(current_round_key,previous_round_key,current_round);
input [63:0]previous_round_key;
input [3:0]current_round;
output wire [63:0]current_round_key;
wire [15:0]subbyte_value;
wire [15:0]intermediate_input;

/*
    sub_byte[15:0] = SubBytes(previous_round_key[15:0])
*/

SubBytes sub_1(subbyte_value[3:0],previous_round_key[3:0]);
SubBytes sub_2(subbyte_value[7:4],previous_round_key[7:4]);
SubBytes sub_3(subbyte_value[11:8],previous_round_key[11:8]);
SubBytes sub_4(subbyte_value[15:12],previous_round_key[15:12]);

/* 
     __             ___       __            ___
    | sub_byte[3:0]   |      | round_constant |
    | sub_byte[07:04] |   +  |       0        |   
    | sub_byte[11:08] |      |       0        |     = intermediate input value
    | sub_byte[15:12] |      |       0        |
    |__             __|      |__            __|
*/

assign intermediate_input[3:0] = xor_value(subbyte_value[3:0],round_constant(current_round));
assign intermediate_input[15:4] = subbyte_value[15:4];


assign current_round_key[63:60] = xor_value(intermediate_input[3:0],previous_round_key[63:60]);
assign current_round_key[59:56] = xor_value(intermediate_input[7:4],previous_round_key[59:56]);
assign current_round_key[55:52] = xor_value(intermediate_input[11:8],previous_round_key[55:52]);
assign current_round_key[51:48] = xor_value(intermediate_input[15:12],previous_round_key[51:48]);


assign current_round_key[47:44] = xor_value(previous_round_key[47:44],current_round_key[63:60]);
assign current_round_key[43:40] = xor_value(previous_round_key[43:40],current_round_key[59:56]);
assign current_round_key[39:36] = xor_value(previous_round_key[39:36],current_round_key[55:52]);
assign current_round_key[35:32] = xor_value(previous_round_key[35:32],current_round_key[51:48]);

assign current_round_key[31:28] = xor_value(previous_round_key[31:28],current_round_key[47:44]);
assign current_round_key[27:24] = xor_value(previous_round_key[27:24],current_round_key[43:40]);
assign current_round_key[23:20] = xor_value(previous_round_key[23:20],current_round_key[39:36]);
assign current_round_key[19:16] = xor_value(previous_round_key[19:16],current_round_key[35:32]);

assign current_round_key[15:12] = xor_value(previous_round_key[15:12],current_round_key[31:28]);
assign current_round_key[11:8] = xor_value(previous_round_key[11:8],current_round_key[27:24]);
assign current_round_key[7:4] = xor_value(previous_round_key[7:4],current_round_key[23:20]);
assign current_round_key[3:0] = xor_value(previous_round_key[3:0],current_round_key[19:16]);

/*
Calculation of XOR value of two 4 bit inputs
*/

function [3:0]xor_value;
input [3:0]value_1;
input [3:0]value_2;
xor_value = value_1 ^ value_2;
endfunction

/*
Calculation of round constant value based on current round (X**4 = X + 1)
*/
function [3:0]round_constant;
input [3:0]current_round;
reg [3:0]value;
begin
    case(current_round)
        4'b0001 : value = 4'b0001;
        4'b0010 : value = 4'b0010;
        4'b0011 : value = 4'b0100;
        4'b0100 : value = 4'b1000; 
        4'b0101 : value = 4'b0011;
        4'b0110 : value = 4'b0110;
        4'b0111 : value = 4'b1100;
        4'b1000 : value = 4'b1011;
        4'b1001 : value = 4'b0101;
        4'b1010 : value = 4'b1010;
        default: $display("Not a valid round number"); 
    endcase
round_constant = value;
end
endfunction

endmodule
