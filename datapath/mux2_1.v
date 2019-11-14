module mux2_1(a,b,sel,out);
input [31:0] a,b;
input sel;
output [31:0]out;

assign out = (sel==1'b1) ? a : b;

endmodule