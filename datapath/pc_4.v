module adder_pc(pc,pc_add);
input [31:0] pc;
output reg [31:0] pc_add;
always @(*)
begin
  pc_add <= pc + 4;
end
endmodule

