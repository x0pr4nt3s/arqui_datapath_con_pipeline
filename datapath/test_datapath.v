`include "Datapath.v"

module testbench;
reg clk;
reg reset;

DATAPATH test(.clk(clk),.reset(reset));

initial 
 begin
	clk = 1'b0;
#5	begin
	clk = 1'b1;
	end
#5	begin
	clk = 0;
	end
#5 	begin
	clk = 1;
	end
#5	begin
	clk = 1;
	end
#5	begin 
	clk = 0; 
	end
#5	begin
	clk = 1;
	end
#5	begin 
	clk = 0; 
	end
#5	begin
	clk = 1;
	end
end

initial
	$monitor($time, "Clock = %h",clk);
endmodule
