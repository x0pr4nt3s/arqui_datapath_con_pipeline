module mux2_1(a,b,sel,out);
input [31:0] a,b;
input sel;
output out;

assign out= (sel) ? a : b;


endmodule