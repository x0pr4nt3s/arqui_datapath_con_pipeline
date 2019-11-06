`include "Datapath.v"
module testbench;
reg clk;
reg reset;

DATAPATH test(.clk(clk),.reset(reset));

always 
begin
	#1clk=~clk;
end
initial begin
	$dumpfile("imb.vcd");
	$dumpvars;
	$monitor($time, "Clock = %h",clk);
	reset<=1;
	clk<=1;
	#10;reset<=0;
	#11;reset<=0;
	#35;$finish;

end





endmodule