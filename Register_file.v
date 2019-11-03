module Register_File(clk, readreg1, readreg2, writereg, writedata, read_data1, read_data2, regwrite);

input clk;

input [4:0] readreg1, readreg2, writereg; // 2 sources y 1 destination

input [31:0] writedata; // resultado (writeback)

input regwrite; // input de Control

output reg [31:0] read_data1, read_data2;

reg [31:0]reg_set[0:31]; // tabla de las variables

initial begin
$readmemb("register_set.txt", reg_set);
end

//se lee en posedge
always @(*) 
begin
    read_data1 <= reg_set[readreg1];
    read_data2 <= reg_set[readreg2];
end

//se escribe en negedge
always @(negedge clk) 
begin
  if(regwrite == 1'b1)
  begin
  reg_set[writereg] <= writedata;
  end
end					

endmodule
