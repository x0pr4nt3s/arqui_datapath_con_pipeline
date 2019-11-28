module PC #(parameter WIDTH=8)(input clk,input  reset,input [WIDTH-1:0] d,output reg [WIDTH-1:0] q);//Program Counter d=next y q=actual


always @ (posedge clk, posedge reset)
if (reset==1'b1) 
q <= 0;
else
q <= d;
endmodule