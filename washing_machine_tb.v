`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/25/2025 03:01:43 PM
// Design Name: 
// Module Name: washing_machine_tb
// Project Name: 
// Target Devices:
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module washing_machine_tb();
reg start,rst,clk;
reg [1:0]mode;
wire [8*8:0]state;
wire out;

 washing_machine m1 ( start,clk,rst,mode,state,out);
 
 initial begin
 $monitor("%s",state);
 clk=0;
 rst=1;
 mode=0;
 #3 start =1;rst=0;
 #2 mode=0;
 #25 ;
 rst=1;#1
 rst=0;
 mode=1;
 #16
 rst=1; 
 mode=2;
 #1
 rst=0;
 #10
 rst=1;
 mode=3;
 #1
 rst=0;
 #20
 
 
 $finish;
 
 
 
 
 
 
 
 
 end
 initial forever #2 clk=~clk; 

endmodule
