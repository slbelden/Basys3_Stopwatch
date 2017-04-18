// sevensegdecoder.v
// Based off of sevenseghexdecoder.v from lab 4 

`timescale 1ns / 1ps 

module sevensegdecoder(Seg,Val); 
	output 	[0:6] Seg; 
	input 	[3:0] Val; 
	reg 	[0:6] Seg; 
	
	always @(Val)  
	begin 	
		case(Val) // 0 = On | 1 = Off
			4'h0: Seg = 7'b000_0001; 
			4'h1: Seg = 7'b100_1111; //      0
			4'h2: Seg = 7'b001_0010; //     ---
			4'h3: Seg = 7'b000_0110; // 5  |   |  1
			4'h4: Seg = 7'b100_1100; //     -6-
			4'h5: Seg = 7'b010_0100; // 4  |   |  2
			4'h6: Seg = 7'b010_0000; //     ---
			4'h7: Seg = 7'b000_1111; //      3
			4'h8: Seg = 7'b000_0000;
			4'h9: Seg = 7'b000_0100;
			default: Seg = 7'b000_0000;
		endcase
	end
endmodule