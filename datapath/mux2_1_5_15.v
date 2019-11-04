module mux2_1_5(a,b,sel,out);
input [4:0] a;
input [15:0] b;
input sel;
output [15:0] out;

assign out= (sel) ? a : b;


endmodule