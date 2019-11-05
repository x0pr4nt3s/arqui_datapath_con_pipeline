module Control(Instruction,RegDst,Jump,Branch,MemRead,MemtoReg,ALUOp,MemWrite,ALUSrc,RegWrite);
input [5:0] Instruction;
output reg RegDst,Jump,MemtoReg,ALUSrc,RegWrite;
output reg [1:0] ALUOp, Branch, MemRead, MemWrite;

always @(*)
begin
if(Instruction==6'b000000)//R-Type
  begin
  RegDst =1;
  Jump = 2'b00;
  Branch = 2'b00;
  MemRead = 2'b00;
  MemtoReg = 0;
  ALUOp = 2'b00;
  MemWrite = 2'b00;
  ALUSrc = 0;
  RegWrite = 1;
  end
else
  begin 
  case(Instruction)
  6'b100011: //lw
  begin
    RegDst = 0;
    Jump = 2'b00;
    Branch = 2'b00;
    MemRead = 2'b01;
    MemtoReg = 1;
    ALUOp = 2'b01;	
    MemWrite = 2'b00;
    ALUSrc = 1;
    RegWrite = 1;
  end
  6'b101011: //sw
  begin
    RegDst = 1'bx;
    Jump = 2'b00;
    Branch = 2'b00;
    MemRead = 2'b00;
    MemtoReg = 1'bx;
    ALUOp = 2'b01;
    MemWrite = 2'b01;
    ALUSrc = 1;
    RegWrite = 0;
  end

  6'b100000: //lb
  begin
    RegDst = 0;
    Jump = 2'b00;
    Branch = 2'b00;
    MemRead = 2'b10;
    MemtoReg = 1;
    ALUOp = 2'b01;	
    MemWrite = 2'b00;
    ALUSrc = 1;
    RegWrite = 1;
  end

  6'b101000: //sb
  begin
    RegDst = 1'bx;
    Jump = 2'b00;
    Branch = 2'b00;
    MemRead = 2'b00;
    MemtoReg = 1'bx;
    ALUOp = 2'b01;	
    MemWrite = 2'b10;
    ALUSrc = 1;
    RegWrite = 0;
  end

  6'b100001: //lh
  begin
    RegDst = 0;
    Jump = 2'b00;
    Branch = 2'b00;
    MemRead = 2'b11;
    MemtoReg = 1;
    ALUOp = 2'b01;
    MemWrite = 2'b00;
    ALUSrc = 1;
    RegWrite = 1;
  end

  6'b101001: //sh
  begin
    RegDst = 1'bx;
    Jump = 2'b00;
    Branch = 2'b00;
    MemRead = 2'b00;
    MemtoReg = 1'bx;
    ALUOp = 2'b01;	
    MemWrite = 2'b11;
    ALUSrc = 1;
    RegWrite = 0;
  end

  6'b001111: //lui
  begin
    RegDst = 0;
    Jump = 2'b00;
    Branch = 2'b00;
    MemRead = 2'b00;
    MemtoReg = 0;
    ALUOp = 2'b01; //REVISAR
    MemWrite = 2'b00;
    ALUSrc = 1;
    RegWrite = 1;
  end
    
  6'b001111: //andi
  begin
    RegDst = 0;
    Jump = 2'b00;
    Branch = 2'b00;
    MemRead = 2'b00;
    MemtoReg = 0;
    ALUOp = 2'b01; //REVISAR
    MemWrite = 2'b00;
    ALUSrc = 1;
    RegWrite = 1;
  end
    
  6'b001111: //ori
  begin
    RegDst = 0;
    Jump = 2'b00;
    Branch = 2'b00;
    MemRead = 2'b00;
    MemtoReg = 0;
    ALUOp = 2'b01; //REVISAR
    MemWrite = 2'b00;
    ALUSrc = 1;
    RegWrite = 1;
  end
    
  6'b000010: //jump
  begin
    RegDst = 1'bx;
    Jump = 2'b01;
    Branch = 2'b00;
    MemRead = 2'b00;
    MemtoReg = 1'bx;
    ALUOp = 2'bxx; 
    MemWrite = 2'b00;
    ALUSrc = 1'bx;
    RegWrite = 0;
  end

  6'b000011: //jal
  begin
    RegDst = 1'bx;
    Jump = 2'b10;
    Branch = 2'b00;
    MemRead = 2'b00;
    MemtoReg = 1'bx;
    ALUOp = 2'bxx;
    MemWrite = 2'b00;
    ALUSrc = 1'bx;
    RegWrite = 0;
  end

  6'b001000: //jr
  begin
    RegDst = 1'bx;
    Jump = 2'b11;
    Branch = 2'b00;
    MemRead = 2'b00;
    MemtoReg = 1'bx;
    ALUOp = 2'bxx; 
    MemWrite = 2'b00;
    ALUSrc = 1'bx;
    RegWrite = 0;
  end
  endcase
  end
end
endmodule
