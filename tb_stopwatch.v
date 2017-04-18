// Test bench
`include "stopwatch.v"
`timescale 1ns / 1ns

module tb_stopwatch();
	wire [6:0] tseg1,tseg2,tseg3,tseg4;
	wire [3:0] td1, td2, td3, td4;
	wire	   tdot;
	reg        tclk, ten, tup, tclr, tlap;
        
	stopwatch   dut(tclk,ten,tup,tclr,tlap,tseg1,tseg2,tseg3,tseg4,td1,td2,td3,td4,tdot);

	initial
	begin
		$dumpfile("tb.vcd");
		$dumpvars(0,tb_stopwatch);
		tclk=0; tclr=1; ten=1; tup=1;
		#20000 $finish;
	end

	always
		#10 tclk = !tclk;

	initial 
	fork
		#50 tclr=0;
		#10100 ten = 0;
		#10125 tclr = 1;
		#10175 tclr = 0;
		#10200 ten = 1;
		#10300 tclr = 1;
		#10400 tclr = 0;
		#12000 tup = 0;
		#15000 tup = 1;
	join
endmodule