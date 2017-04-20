// toplevel_Lab04.v for EE 2390 Spring 2016 Lab #4
`timescale 1ns / 1ps
module toplevel_Lab04(seg, an, clk, dp);
    output [0:6] seg;
    output [3:0] an;
    output [0:0] dp;
    input clk;
    
    integer count = 0;
    
    reg [3:0] A = 4'h0;
    reg [3:0] B = 4'h0;
    reg [3:0] C = 4'h0;
    reg [3:0] D = 4'h0;
    reg [0:3] dots = 4'b1010;
    
    always @(posedge clk)
    begin
        count = count + 1;
        
        if(count >= 10000000)
        begin
            if(D == 9)
            begin
                D = 0;
                if(C == 9)
                begin
                    C = 0;
                    if(B == 5)
                    begin
                        B = 0;
                        if(A == 9)
                        begin
                            A = 0;
                        end
                        else A = A + 1;
                    end
                    else B = B + 1;
                end
                else C = C + 1;
            end
            else D = D + 1;
            count = 0;
        end
    end

    fourdigitdriver(clk, A, B, C, D, dots, seg, an, dp);

endmodule
