//Small Scale AES

module SmallAES(ciphertext, plaintext, masterkey);
 input [63:0]plaintext;
 input [63:0]masterkey;
 output [63:0]ciphertext;
 
 //Key schedule Instantiation
 wire [63:0] key1, key2, key3, key4, key5, key6, key7, key8, key9, key10;
 wire [63:0] int_cipher1, int_cipher2, int_cipher3, int_cipher4, int_cipher5, int_cipher6, int_cipher7, int_cipher8, int_cipher9;
 wire [63:0] round_keys;
 
 assign round_keys = masterkey ^ plaintext;
 
 Key_Schedule K1(key1, masterkey, 4'h1);
 Key_Schedule K2(key2, key1, 4'h2);
 Key_Schedule K3(key3, key2, 4'h3);
 Key_Schedule K4(key4, key3, 4'h4);
 Key_Schedule K5(key5, key4, 4'h5);
 Key_Schedule K6(key6, key5, 4'h6);
 Key_Schedule K7(key7, key6, 4'h7);
 Key_Schedule K8(key8, key7, 4'h8);
 Key_Schedule K9(key9, key8, 4'h9);
 Key_Schedule K10(key10, key9, 4'hA);



//round instantiations

RoundModule R1(int_cipher1, round_keys, key1, 4'h1);
RoundModule R2(int_cipher2, int_cipher1, key2, 4'h2);
RoundModule R3(int_cipher3, int_cipher2, key3, 4'h3);
RoundModule R4(int_cipher4, int_cipher3, key4, 4'h4);
RoundModule R5(int_cipher5, int_cipher4, key5, 4'h5);
RoundModule R6(int_cipher6, int_cipher5, key6, 4'h6);
RoundModule R7(int_cipher7, int_cipher6, key7, 4'h7);
RoundModule R8(int_cipher8, int_cipher7, key8, 4'h8);
RoundModule R9(int_cipher9, int_cipher8, key9, 4'h9);
RoundModule R10(int_cipher10, int_cipher9, key10, 4'hA);
endmodule