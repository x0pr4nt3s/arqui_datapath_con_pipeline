module SignExtend(a,b);
input[15:0] a;
output reg [31:0] b;
always@(*)
begin
	b = {{16{a[15]}},{a}};
end
endmodule
