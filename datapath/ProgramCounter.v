module PC(clk,entrada,salida);
input clk;
input [31:0] entrada;
output reg [31:0] salida;
reg [31:0] contador;

initial 
begin
contador = 32'h00000000;
end

always @(posedge clk)
begin
	if(contador == 32'h00000000)
	begin
		salida <= contador;
		contador <= contador + 1; 
	end
	else
	begin
		salida <= entrada;
	end
end
endmodule
