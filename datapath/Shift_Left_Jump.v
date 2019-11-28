module Shift_Left_Jump(imm, PC, jump);
input[25:0] imm;
input[3:0] PC;
output reg[31:0] jump;
reg [1:0] shift;

initial begin
shift = 2'b00;
end

always@(*)
begin
  jump = {{PC},{imm},{shift}};  
end

endmodule
