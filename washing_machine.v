`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2025 03:15:17 PM
// Design Name: 
// Module Name: washing_machine
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


module washing_machine(
//input mstart,
input start,clk,rst,

input [1:0]mode,
output reg[8*8:0]state,
output reg out



);
reg mrst,reset_switch;

reg [2:0]ns,ps,count;


parameter idle =3'b000;
parameter soaking=3'b001;
parameter washing =3'b010;
parameter rinse   =3'b011;
parameter resoak =3'b100;
parameter rerinse= 3'b101;
parameter  alarm   = 3'b110;
/*

always@(mstart)
mrst=1;
always@(rst or mrst)
begin

reset_switch= rst^mrst;
end
*/
always@(posedge clk or posedge rst)
begin
if(rst) begin
  ps<=idle;
  count<=0;
  state<="idle";
  end
else begin


ps<=ns;
count=count+1;

end

end

always@(ps,count)

begin
case(ps)
            
   idle: begin
                if(start==1 && (mode==2'b00 || mode==2'b01) )
                   begin
                   ns=soaking;
                   state="soaking";
                   out=0; 
                   end
               else if(start==1 && mode==3'b10)
                 begin
                  ns=rerinse;
                  state ="rinse";
                  out=0;
                 end
              
                  else if(start==1 && mode==3'b11)
                 begin
                  ns=resoak;
                  state ="soaking";
                  out=0;
                  
                 end
                  else begin
                  ns=idle;
                  out=0;
                  state="idle";
                  end
                
        end
 soaking: begin
       
               if(start==1 && (mode==2'b00||mode==2'b01))
                begin
                ns=washing;
                out=0;
                state="washing";
                end
                else
                 begin 
                 ns=soaking;
                 state="soaking";
                 out=0;
                end
              
          end 
            
 washing: begin
                 if (start==1 && (mode==0||mode==1) )   
                 begin
                  ns=rinse;
                  out=0;
                  state ="rinse";
                 end
                else begin
                 ns=washing;
                 out=0;
                 state="washing";
                end        
         end
  
  rinse: begin
            if(start==1&&(mode==0))
            begin
            ns=resoak;
            out=0;
            state="resoak";
            end
            else if(start==1 && mode==1)
           begin
           ns=idle;
           out=1;
         //  mrst= ~mrst;
           state="idle";
           end
           else  begin
            ns = rinse;
            out =0;
            state="rinse";         
            end
 
         end  
 resoak :begin
            if(start==1&&(mode==0))
               begin
               ns=rerinse;
               out=0;
               state="rerinse";
               end            
             else if (start==1 && mode==3) 
               begin
               ns=rerinse;
               out=0;
               state="rinse";
               end 
              else begin
                ns= resoak;
                out=0;
                state="resoak";
                end
 
 
 
         end 
 rerinse:  begin
            if(start==1&&(mode==0||mode==2||mode==3))
            begin  
             ns=idle;
         //    mrst=~mrst;
             out=1;
         
             state="idle";
            end
            else begin
            ns=rerinse;
            out=0;
              if(mode==0)
                state="rerinse";
              if(mode==2||mode==3)
                state="rinse";
             end
          end        
         



endcase 

end
endmodule
