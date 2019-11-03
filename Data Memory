module Data_Memory(clk, address, memwrite, writedata, read_data, memread);
input clk;
input address;
input memwrite;
input memread;
input writedata;
output read_data;

reg[7:0]array[39:0];

wire clk;
wire memwrite;
wire memread;
wire[31:0] writedata;
wire[31:0] address;
reg[31:0] read_data;

initial
  begin
    $readmemb("datamemory.txt", array);
  end 

always @(*)
begin
  if (memread == 1'b0)
	if(memwrite == 1'b1)
	begin
	array[address] <= writedata;
	end
  else if(memread == 1'b1)
	if(memwrite == 1'b0)
	begin
	read_data <= array[address];
	end
end
endmodule
