module F_D (input clk,input rst,input STALL,input [31:0] PCIn,input [31:0] instructionIn,output reg [31:0] PC,output reg [31:0] instruction);

always @ (posedge clk) begin
  if (rst)
  begin
    PC <= 0;
    instruction <= 0;
  end
  else 
  begin
    if (STALL)
    begin
    //no pasa nada 
    end
    else 
    begin
      instruction <= instructionIn;
      PC <= PCIn;
    end
  end
end 
endmodule