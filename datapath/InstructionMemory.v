module InstructionMemory(pc,out);//solo recibe 
input [31:0] pc;
output reg [31:0] out;
reg [31:0] instrucciones [0:7];//son 8 filas con 32 columnas
integer i;
initial begin
$readmemb("instrucciones.txt",instrucciones);
end
always@(*)
begin
  out <= instrucciones[pc];
end

initial begin
    $display("Dato instruction:");
    for (i=0;i<8;i=i+1)
      $display("%d :%b",i,instrucciones[i]);
end
endmodule
