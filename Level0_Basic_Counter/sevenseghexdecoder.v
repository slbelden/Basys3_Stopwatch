// sevenseghexdecoder.v
// For EE 2390 Spring 2017 Lab #4
// 2017-02-28
//
// Template from Cameron H. G. Wright and Jerry C. Hamann
// Modified by Stephen Belden

`timescale 1ns / 1ps
module sevenseghexdecoder (Seg, HexVal);
	output [0:6] Seg;
	input [3:0] HexVal;
	reg [0:6] Seg;
	// Signal correspondence is as follows:
	// Display Segment: a b c d e f g (all active low: 0--on , 1--off)
	// Seg output bit: 0 1 2 3 4 5 6
	// HexVal [3:0] has MSb at bit 3, LSb at bit 0
	always @(HexVal) // Do this whenever HexVal changes
	begin
		case (HexVal)
			4'h0: Seg = 7'b000_0001; // 0
			4'h1: Seg = 7'b100_1111; // 1
			4'h2: Seg = 7'b001_0010; // 2
			4'h3: Seg = 7'b000_0110; // 3
			4'h4: Seg = 7'b100_1100; // 4
			4'h5: Seg = 7'b010_0100; // 5
			4'h6: Seg = 7'b010_0000; // 6
			4'h7: Seg = 7'b000_1111; // 7
			4'h8: Seg = 7'b000_0000; // 8
			4'h9: Seg = 7'b000_0100; // 9
			4'hA: Seg = 7'b000_1000; // A
			4'hB: Seg = 7'b110_0000; // B
			4'hC: Seg = 7'b011_0001; // C
			4'hD: Seg = 7'b100_0010; // D
			4'hE: Seg = 7'b011_0000; // E
			4'hF: Seg = 7'b011_1000; // F
			default: Seg = 7'b111_1111; // default to all off
		endcase
	end
endmodule