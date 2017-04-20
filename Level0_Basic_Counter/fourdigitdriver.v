// Takes 4 hex characters and 4 dots as input,
// and properly drives the BASYS 3 display to show all digits
// Ordered left-to-right, ABCD
// 95hz refresh rate given a 100MHz clock (full display refresh)
// 
// Stephen Belden
// 2017-04-19

module fourdigitdriver(clk, A, B, C, D, dots, seg, an, dp);
    input clk;
    input [3:0] A, B, C, D;
    input [0:3] dots;
    output reg [4:0] an;
    output [0:6] seg;
    output reg dp;
    
    reg [17:0] count = 0;
    reg [1:0] select = 0;
    reg [3:0] Hex;
    
    sevenseghexdecoder  u1(.Seg(seg[0:6]), .HexVal(Hex));
    
    always @(posedge clk)
    begin        
        if(count == 0)
        begin
            case(select)
                2'b00:
                begin
                    Hex = A;
                    an = 4'b0111;
                    if(!dots[0]) dp = 1;
                    else dp = 0;
                end
                2'b01:
                begin
                    Hex = B;
                    an = 4'b1011;
                    if(!dots[1]) dp = 1;
                    else dp = 0;
                end
                2'b10:
                begin
                    Hex = C;
                    an = 4'b1101;
                    if(!dots[2]) dp = 1;
                    else dp = 0;
                end
                2'b11:
                begin
                    Hex = D;
                    an = 4'b1110;
                    if(!dots[3]) dp = 1;
                    else dp = 0;
                end
            endcase
            select = select + 1'b1;
        end
        // Unsigned number count rolls over to 0 automatically
        count = count + 1'b1;
    end
endmodule