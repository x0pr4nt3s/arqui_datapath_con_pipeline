module InstructionMemory(clk,pc,out);
input clk;
input [31:0] pc;
output reg [31:0] out;
  reg [7:0] instrucciones [0:59];
initial begin
<<<<<<< HEAD
$readmemb("instrucciones.txt",IM);
=======
  $readmemb("instrucciones.txt",instrucciones);
>>>>>>> 1867ac5da96caffc16f8be3736c997940f9e4747
end
always@(pc)
begin
  out <= {instrucciones[pc],instrucciones[pc+1],instrucciones[pc+2],instrucciones[pc+3]};
end 
endmodule
