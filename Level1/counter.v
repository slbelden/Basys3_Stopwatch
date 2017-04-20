// counter.v
// Based on count00to59.v

module counter(min,secmsd,seclsd,ten,clk,clr,en,up);
	output [3:0] min,secmsd,seclsd,ten;
	input  clk,clr,en,up;

	wire  upen,bken,mupen,mbken,minupen,minbken,lsden,msden,minen;
	
	count_to9 tenth(ten,clk,clr,en,up,upen,bken);
	count_to9 lsdig_second(seclsd,clk,clr,lsden,up,mupen,mbken);
	count_to5 msdig_second(secmsd,clk,clr,msden,up,minupen,minbken);
	count_to9 minute(min,clk,clr,minen,up, , );

	assign lsden = (clr && en) || upen || bken;
	assign msden = (clr && en) || mupen || mbken;
	assign minen = (clr && en) || minupen || minbken;
endmodule

// count_to9.v
// ctrl --> 1 - Minutes | 2 - Seconds | 3 - Tenths
module count_to9(cnt,clk,clr,en,up,upen,bken);
	output [3:0] cnt;
	output       upen, bken;
	input        clk, clr, en, up;

	reg    [3:0] cnt, ncnt;

	// Go to next count every posedge of the clock
	always @(posedge clk)
	begin
		if(en)
			if(clr)
				cnt <= 0;
			else
				cnt <= ncnt;
		else
			cnt <= cnt;
		
	end

	// Handle rollover
	always @(cnt or up)
	begin
		if(up)
			ncnt=(cnt==9) ? 0 : cnt+1;
		else
			ncnt=(cnt==0) ? 9 : cnt-1;
	end

	assign upen = (cnt==9) && up && en;
	assign bken = (cnt==0) && !up && en;
endmodule

// count_to5.v
module count_to5(cnt,clk,clr,en,up,upen,bken);
	output [3:0] cnt;
	output       upen, bken;
	input        clk, clr, en, up;

	reg    [3:0] cnt, ncnt;

	// Go to next count every posedge of the clock
	always @(posedge clk)
	begin
		if(en)
			if(clr)
				cnt <= 0;
			else
				cnt <= ncnt;
		else
			cnt <= cnt;
	end

	// Handle rollover
	always @(cnt or up)
	begin
		if(up)
			ncnt=(cnt==5) ? 0 : cnt+1;
		else
			ncnt=(cnt==0) ? 5 : cnt-1;
	end

	assign upen = (cnt==5) && up && en;
	assign bken = (cnt==0) && !up && en;
endmodule