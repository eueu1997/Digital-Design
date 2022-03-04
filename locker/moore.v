`timescale 1ns / 1ps

module moore(reset,comb2,comb2,enter,open,error,clk);
input reset,comb2,comb2,enter,clk;
output open,error;
reg open,error;
reg [1:0] state,nstate;
always @(comb1,comb2,enter,state) begin
case ( state)
    "00" : begin
    error <= 0;
    open<= 0;
    if(enter == 1) begin
    if(comb1==1)
    nstate<="01";
    else if(comb1==0) 
    nstate<="11";
    end 
    end
    
    "01" : begin
        error <= 0 ;
        open <= 0;
        if(enter == 1) begin
        if(comb2 == 1)
        nstate <= "10";
        else if(comb2== 0)
        nstate <= "11";
        end
        end
        
     "10" : begin
        error <= 0;
        open <= 1;
        end
      "11" : begin
        error <= 1;
        open <= 0;
        end
        endcase  
        end
endmodule
