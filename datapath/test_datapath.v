`include "Datapath.v"
module testbench;
reg clk;
reg reset;

DATAPATH test(.clk(clk),.reset(reset));

always 
begin
	clk=1'b1;
	#1;clk=1'b0;
	#1;clk=1'b0;
end
initial
	$monitor($time, "Clock = %h",clk);


always @(posedge clk) 
begin
#30;
$finish;
end

endmodule