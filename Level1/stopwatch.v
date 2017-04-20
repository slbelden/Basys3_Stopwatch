`include "counter.v"
`include "sevensegdecoder.v"

module stopwatch(clk,en,up,reset,lap,seg1,seg2,seg3,seg4,d1,d2,d3,d4,dot);
	output [6:0] seg1, seg2, seg3, seg4;
	output [3:0] d1,d2,d3,d4; //d1 = minutes | d2d3 = seconds | d4 = tenths
	output dot;	
	input clk,en,up,reset,lap;
		
	counter count(.min(d1),.secmsd(d2),.seclsd(d3),.ten(d4),.clk(clk),
		.clr(reset),.en(en),.up(up));
		
	sevensegdecoder ssd1(.Seg(seg1),.Val(d1));
	sevensegdecoder ssd2(.Seg(seg2),.Val(d2));
	sevensegdecoder ssd3(.Seg(seg3),.Val(d3));
	sevensegdecoder ssd4(.Seg(seg4),.Val(d4));
	
endmodule