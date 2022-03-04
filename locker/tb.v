`timescale 1ns / 1ps


module tb();
reg resets,comb1s,comb2s,enters,clks;
wire opens,errors;

 es2 CompToTest(resets,comb1s,comb2s,enters,opens,errors,clks);
 
 always begin
clks <= 0;
#5 clks <= 1;
#5;
end

 initial begin
 resets <= 1 ;
#10 resets<= 0;comb1s<=1;enters <= 1;
#10 comb1s<= 0;enters<=0;
#10 comb2s<= 1;enters<=1;
#10 comb2s<= 0;enters <= 0;
#10 resets<=1;
#10 resets<= 0;comb1s<=1;enters <= 1;
#10 comb1s<= 0;enters<=0;
#10 comb2s<= 0;enters<=1;
#10 comb2s<= 0;enters <= 0;
#10 resets<=1;
#10 resets<= 0;comb1s<=0;enters <= 1;
#10 comb1s<= 0;enters<=0;
#10 comb2s<= 1;enters<=1;
#10 comb2s<= 0;enters <= 0;
#10 resets<=1;
end 
endmodule
