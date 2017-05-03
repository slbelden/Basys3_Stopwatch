// Counts up or down from 0 to 10 minutes,
// with precision of 1/10th second
// Based on count00to59.v
//
// Shaya Wolf
// 2017-04-26

module counter(min,secmsd,seclsd,ten,tick,clr,en,up);
	output [3:0] min,secmsd,seclsd,ten;
	input  tick,clr,en,up;

	wire  upen,bken,mupen,mbken,minupen,minbken,lsden,msden,minen;

	count_to9 tenth(ten,tick,clr,en,up,upen,bken);
	count_to9 lsdig_second(seclsd,tick,clr,lsden,up,mupen,mbken);
	count_to5 msdig_second(secmsd,tick,clr,msden,up,minupen,minbken);
	count_to9 minute(min,tick,clr,minen,up, , );

	assign lsden = (clr && en) || upen || bken;
	assign msden = (clr && en) || mupen || mbken;
	assign minen = (clr && en) || minupen || minbken;
endmodule

// count_to9.v
// ctrl --> 1 - Minutes | 2 - Seconds | 3 - Tenths
module count_to9(cnt,tick,clr,en,up,upen,bken);
	output reg [3:0] cnt;
	output       upen, bken;
	input        tick, clr, en, up;

	reg    [3:0] ncnt = 4'b0000;

	// Go to next count every posedge of the clock
	always @(posedge tick)
	begin
		if(en)
			cnt <= ncnt;
		else
			cnt <= cnt;
        if(clr)
            cnt <= 0;
	end

	// Handle rollover
	always @(cnt or up)
	begin
		if(up)
			ncnt=(cnt==9) ? 0 : cnt+4'b0001;
		else
			ncnt=(cnt==0) ? 9 : cnt-4'b0001;
	end

	assign upen = (cnt==9) && up && en;
	assign bken = (cnt==0) && !up && en;
endmodule

// count_to5.v
module count_to5(cnt,tick,clr,en,up,upen,bken);
	output reg [3:0] cnt;
	output       upen, bken;
	input        tick, clr, en, up;

	reg    [3:0] ncnt = 4'b0000;

	// Go to next count every posedge of the clock
	always @(posedge tick)
	begin
		if(en)
            cnt <= ncnt;
        else
            cnt <= cnt;
        if(clr)
            cnt <= 0;
	end

	// Handle rollover
	always @(cnt or up)
	begin
		if(up)
			ncnt=(cnt==5) ? 0 : cnt+4'b0001;
		else
			ncnt=(cnt==0) ? 5 : cnt-4'b0001;
	end

	assign upen = (cnt==5) && up && en;
	assign bken = (cnt==0) && !up && en;
endmodule
