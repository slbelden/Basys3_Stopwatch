// directleddriver.v for EE 2390 Spring 2016 Lab #4
`timescale 1ns / 1ps
module directleddriver(led,sw);
    output  led;
    input   sw;
    assign  led=sw;
endmodule
