`timescale 1ns / 1ps

module es2(reset,comb1,comb2,enter,open,error,clk);
input reset,comb1,comb2,enter,clk;
output reg open,error;
parameter init = 0, s0 = 1, // added parameter
s1 = 2, serror = 3;
reg [1:0] state,nstate;
always @(comb1,comb2,enter,state) begin
case ( state)
    init : begin
    error <= 0;
    open<= 0;
    if(enter == 1) begin
    if(comb1==1)
    nstate<=s0;
    else if(comb1==0) 
    nstate<=serror;
    end
    else if( enter == 0) // added else if
    nstate<=init;
    
    end
    
    s0 : begin
        error <= 0 ;
        open <= 0;
        if(enter == 1) begin
        if(comb2 == 1)
        nstate <= s1;
        else if(comb2== 0)
        nstate <= serror;
        end
        else if ( enter == 0)
        nstate<=s0; // added else if
        
        end
        
     s1 : begin
        error <= 0;
        open <= 1;
        nstate<=s1; // added 
        end
      serror : begin
        error <= 1;
        open <= 0;
        nstate<=serror; // added
        end
        
     default : begin //added
     open<=1;
     error<=1;
     nstate<=init;
     end  
     endcase  
        end
 always @(posedge(clk))begin
 if(reset==1)
 state<=init;
 else 
 state<=nstate;
 end 
endmodule
