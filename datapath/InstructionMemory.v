module InstructionMemory(pc,out);//solo recibe 
input [31:0] pc;
output reg [31:0] out;
reg [7:0] instrucciones [0:91];//son 8 filas con 32 columnas
integer i;
initial begin
$readmemb("instrucciones.txt",instrucciones);
end
always@(*)
begin
  out <= {instrucciones[pc],instrucciones[pc+1],instrucciones[pc+2],instrucciones[pc+3]};
end
endmodule
