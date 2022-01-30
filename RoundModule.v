`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:37:21 06/11/2020 
// Design Name: 
// Module Name:    Round 
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
module RoundModule(out_round,in_previous_round,key_round, round_number);
output wire[63:0]out_round;                         // Output from this round which is input to next round
input [63:0]in_previous_round;                      // Input to this round which is the output of the previous round
input [63:0]key_round; 
input [3:0]round_number;                             // key schedule - current round

wire [63:0]subbyte_value; 									 // Intermediate SubByte value
wire [63:0]shift_left_value;								 // Intermediate Left shift value
wire [63:0]mix_column_value;                        // Intermediate Mix Column output value

/* 
	SubByte Operation Intermediate Value  
*/                      

SubBytes sub_1(subbyte_value[3:0],in_previous_round[3:0]);
SubBytes sub_2(subbyte_value[7:4],in_previous_round[7:4]);
SubBytes sub_3(subbyte_value[11:8],in_previous_round[11:8]);
SubBytes sub_4(subbyte_value[15:12],in_previous_round[15:12]);

SubBytes sub_5(subbyte_value[19:16],in_previous_round[19:16]);
SubBytes sub_6(subbyte_value[23:20],in_previous_round[23:20]);
SubBytes sub_7(subbyte_value[27:24],in_previous_round[27:24]);
SubBytes sub_8(subbyte_value[31:28],in_previous_round[31:28]);

SubBytes sub_9(subbyte_value[35:32],in_previous_round[35:32]);
SubBytes sub_10(subbyte_value[39:36],in_previous_round[39:36]);
SubBytes sub_11(subbyte_value[43:40],in_previous_round[43:40]);
SubBytes sub_12(subbyte_value[47:44],in_previous_round[47:44]);

SubBytes sub_13(subbyte_value[51:48],in_previous_round[51:48]);
SubBytes sub_14(subbyte_value[55:52],in_previous_round[55:52]);
SubBytes sub_15(subbyte_value[59:56],in_previous_round[59:56]);
SubBytes sub_16(subbyte_value[63:60],in_previous_round[63:60]);

/*
	Shift Left operation 
*/

assign shift_left_value[3:0] = subbyte_value[19:16];
assign shift_left_value[7:4] = subbyte_value[39:36];
assign shift_left_value[11:8] = subbyte_value[59:56];
assign shift_left_value[15:12] = subbyte_value[15:12];

assign shift_left_value[19:16] = subbyte_value[35:32];
assign shift_left_value[23:20] = subbyte_value[55:52];
assign shift_left_value[27:24] = subbyte_value[11:8];
assign shift_left_value[31:28] = subbyte_value[31:28];

assign shift_left_value[35:32] = subbyte_value[51:48];
assign shift_left_value[39:36] = subbyte_value[7:4];
assign shift_left_value[43:40] = subbyte_value[27:24];
assign shift_left_value[47:44] = subbyte_value[47:44];

assign shift_left_value[51:48] = subbyte_value[3:0];
assign shift_left_value[55:52] = subbyte_value[23:20];
assign shift_left_value[59:56] = subbyte_value[43:40];
assign shift_left_value[63:60] = subbyte_value[63:60];

/*
	MixColumn Operation
*/
MixColumn mix_column1(mix_column_value[15:0],shift_left_value[15:0]);
MixColumn mix_column2(mix_column_value[31:16],shift_left_value[31:16]);
MixColumn mix_column3(mix_column_value[47:32],shift_left_value[47:32]);
MixColumn mix_column4(mix_column_value[63:48],shift_left_value[63:48]);

assign out_round = (round_number == 4'hA)? shift_left_value ^ key_round : mix_column_value ^ key_round;

endmodule
