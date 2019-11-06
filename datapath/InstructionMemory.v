module InstructionMemory(clk,pc,out);
input clk;
input [31:0] pc;
output reg [31:0] out;
reg [32:0] instrucciones [7:0];
integer i;
initial begin
$readmemb("instrucciones.txt",instrucciones);
end
always@(posedge clk)
begin
  out <= instrucciones[pc];
end

initial begin
    $display("Dato instruction:");
    /*
    for (i=0;i<3;i=i+1)
        $display("%d:%b",i,instrucciones[i]);
    */
end
endmodule
