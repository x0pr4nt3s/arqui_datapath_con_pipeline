module Data_Memory(clk, address, memwrite, writedata, read_data, memread);
input clk;
<<<<<<< HEAD
input [31:0] address;
input memwrite;
input memread;
input [31:0] writedata;
output [31:0] read_data;
=======
input address;
input memwrite; //control
input memread; //control
input writedata; 
output read_data;
>>>>>>> 7d6e56a00afb5e55c9f01183a52f6dc22b8341aa

reg[7:0]array[39:0];

wire clk;
wire [31:0] address;
wire [31:0] writedata;
wire [1:0] memread;
wire [1:0] memwrite;
reg [31:0] read_data;

initial
  begin
    $readmemb("array.txt", array);
  end 

always @(*) //REVISAR
begin
  if (memread == 2'b01) //lw
  begin
	read_data[31:24] <= array[address];
	read_data[23:16] <= array[address+1];
	read_data[15:8]  <= array[address+2];
	read_data[7:0]  <=  array[address+3];
  end
  if(memread == 2'b10) //lb
  begin
    	read_data[7:0] <= array[address+3];
	read_data[31:8] <= 24'hFFFFFF;
  end
  if(memread == 2'b11) //lh
  begin
    	read_data[7:0] <= array[address+3];
	read_data[15:8] <= array[address+2];
	read_data[31:16] <= 16'h0000;
  end  
end

always@(negedge clk) //REVISAR
begin
  if (memwrite == 2'b01) //sw
  begin 
	array[address] <= read_data[31:24];
	array[address+1] <= read_data[23:16];
	array[address+2] <= read_data[15:8];
	array[address+3] <= read_data[7:0];
  end
  if(memwrite == 2'b10) //sb
  begin
    	array[address+3] <= read_data[7:0];
	array[address+2] <= 8'hFF;
	array[address+1] <= 8'hFF;
	array[address] <= 8'hFF;
  end
  if(memwrite == 2'b11) //sh
  begin
    	array[address+3] <= read_data[7:0];
	array[address+2] <= read_data[15:8];
	array[address+1] <= 8'h00;
	array[address] <= 8'h00;
  end 
end
endmodule
