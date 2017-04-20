// Test bench
`include "counter.v"
`timescale 1ns / 1ns

module tb_counter();
	wire [3:0] tmin, tsecmsd, tseclsd, tten;
	reg        tclk, tclr, ten, tup;
        
	counter   dut(tmin,tsecmsd,tseclsd,tten,tclk,tclr,ten,tup);

	initial
	begin
		$dumpfile("tb.vcd");
		$dumpvars(0,tb_counter);
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