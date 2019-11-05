module InstructionMemory(clk,pc,out);
input clk;
input [31:0] pc;
output reg [31:0] out;
reg [7:0] IM [0:7];
initial begin
  $readmemb("instrucciones.txt",instrucciones);
end
always@(pc)
begin
out <= {IM[pc],IM[pc+1],IM[pc+2],IM[pc+3]};
end 
endmodule
