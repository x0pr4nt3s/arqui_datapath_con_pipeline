module Control(clk,hazard_detected,Instruction,RegDst,Jump,Branch,MemRead,MemtoReg,ALUOp,MemWrite,ALUSrc,RegWrite);
input clk,hazard_detected;
input [5:0] Instruction;
output reg RegDst,Branch,Jump,MemtoReg,ALUSrc,RegWrite;
output reg [1:0] MemRead, MemWrite;
output reg [3:0] ALUOp;

always @(*)
begin
if(hazard_detected)
begin
  //nada
end
else if(Instruction==6'b000000)//R-Type
  begin
  RegDst =1'b1;
  Jump = 1'b0;
  Branch = 1'b0;
  MemRead = 2'b00;
  MemtoReg = 1'b0;
  ALUOp = 4'b0000;
  MemWrite = 2'b00;
  ALUSrc = 1'b0;
  RegWrite = 1'b1;
  end
else if(Instruction==6'b100011)//lw
  begin
    RegDst = 1'b1;
    Jump = 1'b0;
    Branch = 1'b0;
    MemRead = 2'b01;
    MemtoReg = 1'b1;
    ALUOp = 4'b0100;	
    MemWrite = 2'b00;
    ALUSrc = 1'b1;
    RegWrite = 1'b1;
  end
else if(Instruction==6'b101011)//sw
  begin
    RegDst = 1'bx;
    Jump = 1'b0;
    Branch = 1'b0;
    MemRead = 2'b00;
    MemtoReg = 1'bx;
    ALUOp = 4'b0100;
    MemWrite = 2'b01;
    ALUSrc = 1'b1;
    RegWrite = 1'b0;
  end
else if(Instruction==6'b100000)//lb
  begin
    RegDst = 1'b1;
    Jump = 1'b0;
    Branch = 1'b0;
    MemRead = 2'b10;
    MemtoReg = 1'b1;
    ALUOp = 4'b0100;	
    MemWrite = 2'b00;
    ALUSrc = 1'b1;
    RegWrite = 1'b1;
  end
else if(Instruction==6'b101000)//sb
  begin
    RegDst = 1'bx;
    Jump = 1'b0;
    Branch = 1'b0;
    MemRead = 2'b00;
    MemtoReg = 1'bx;
    ALUOp = 4'b0100;	
    MemWrite = 2'b10;
    ALUSrc = 1'b1;
    RegWrite = 1'b0;
  end
else if(Instruction==6'b100001)//lh
  begin
    RegDst = 1'b1;
    Jump = 1'b0;
    Branch = 1'b0;
    MemRead = 2'b11;
    MemtoReg = 1'b1;
    ALUOp = 4'b0100;
    MemWrite = 2'b00;
    ALUSrc = 1'b1;
    RegWrite = 1'b1;
  end
else if(Instruction==6'b101001)//sh
  begin
    RegDst = 1'bx;
    Jump = 1'b0;   
    Branch = 1'b0;
    MemRead = 2'b00;
    MemtoReg = 1'bx;
    ALUOp = 4'b0100;	
    MemWrite = 2'b11;
    ALUSrc = 1'b1;
    RegWrite = 1'b0;
  end
  else if(Instruction==6'b001010)//slti
  begin
    RegDst = 1'b0;
    Jump = 1'b0;
    Branch = 1'b0;
    MemRead = 2'b00;
    MemtoReg = 1'b0;
    ALUOp = 4'b0010; 
    MemWrite = 2'b00;
    ALUSrc = 1'b1;
    RegWrite = 1'b1;
  end
else if(Instruction==6'b001111)//lui
  begin
    RegDst = 1'b0;
    Jump = 1'b0;
    Branch = 1'b0;
    MemRead = 2'b00;
    MemtoReg = 1'b0;
    ALUOp = 4'b0001; //REVISAR
    MemWrite = 2'b00;
    ALUSrc = 1'b1;
    RegWrite = 1'b1;
  end
else if(Instruction==6'b001000)//addi
  begin 
    RegDst = 1'b0;
    Jump = 1'b0;
    Branch = 1'b0;
    MemRead = 2'b00;
    MemtoReg = 1'b0;
    ALUOp = 4'b0100; //REVISAR
    MemWrite = 2'b00;
    ALUSrc = 1'b1;
    RegWrite = 1'b1;
  end
else if(Instruction==6'b001100)//andi
  begin
    RegDst = 1'b0;
    Jump = 1'b0;
    Branch = 1'b0;
    MemRead = 2'b00;
    MemtoReg = 1'b0;
    ALUOp = 4'b1100;
    MemWrite = 2'b00;
    ALUSrc = 1'b1;
    RegWrite = 1'b1;
  end
else if(Instruction==6'b001101)//ori    
  begin
    RegDst = 1'b0;
    Jump = 1'b0;
    Branch = 1'b0;
    MemRead = 2'b00;
    MemtoReg = 1'b0;
    ALUOp = 4'b1110;
    MemWrite = 2'b00;
    ALUSrc = 1'b1;
    RegWrite = 1'b1;
  end
else if(Instruction==6'b001000)//andi    
  begin
    RegDst = 1'b0;
    Jump = 1'b0;
    Branch = 1'b0;
    MemRead = 2'b00;
    MemtoReg = 1'b0;
    ALUOp = 4'b0100;
    MemWrite = 2'b00;
    ALUSrc = 1'b1;
    RegWrite = 1'b1;
  end
else if(Instruction==6'b000100)//beq
  begin
    RegDst = 1'b0;
    Jump = 1'b0;
    Branch = 1'b1;
    MemRead = 2'b00;
    MemtoReg = 1'b0;
    ALUOp = 4'b0101; 
    MemWrite = 2'b00;
    ALUSrc = 1'b1;
    RegWrite = 1'b1;
  end
else if(Instruction==6'b000101)//bneq
  begin
    RegDst = 1'b0;
    Jump = 1'b0;
    Branch = 1'b1;
    MemRead = 2'b00;
    MemtoReg = 1'b0;
    ALUOp = 4'b0111;
    MemWrite = 2'b00;
    ALUSrc = 1'b1;
    RegWrite = 1'b1;
  end
else if(Instruction==6'b000111)//bgez
  begin
    RegDst = 1'b0;
    Jump = 1'b0;
    Branch = 1'b1;
    MemRead = 2'b00;
    MemtoReg = 1'b0;
    ALUOp = 4'b1111;
    MemWrite = 2'b00;
    ALUSrc = 1'b1;
    RegWrite = 1'b1;
  end  
else if(Instruction==6'b000010)//jump
  begin
    RegDst = 1'bx;
    Jump = 1'b1;
    Branch = 1'b0;
    MemRead = 2'b00;
    MemtoReg = 1'bx;
    ALUOp = 4'bxxxx; 
    MemWrite = 2'b00;
    ALUSrc = 1'bx;
    RegWrite = 1'b0;
  end
else if(Instruction==6'b000011)//jal
  begin
    RegDst = 1'bx;
    Jump = 1'b1;
    Branch = 1'b0;
    MemRead = 2'b00;
    MemtoReg = 1'bx;
    ALUOp = 4'bxxxx;
    MemWrite = 2'b00;
    ALUSrc = 1'bx;
    RegWrite = 1'b0;
  end
else if(Instruction==6'b011000)//jr
  begin
    RegDst = 1'bx;
    Jump = 1'b1;
    Branch = 1'b0;
    MemRead = 2'b00;
    MemtoReg = 1'bx;
    ALUOp = 4'bxxxx; 
    MemWrite = 2'b00;
    ALUSrc = 1'bx;
    RegWrite = 1'b0;
  end
end
endmodule