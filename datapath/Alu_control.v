module ALU_control(aluOp,func,out);
input wire [1:0] aluOp;
input wire [5:0] func;
output reg [3:0] out;

always @(func or aluOp)
begin
case (aluOp)     
	2'b00: //R type
	case (func)
    6'b100000: out <= 4'b0000; //ADD
	6'b100010: out <= 4'b0001; //SUB
    6'b100100: out <= 4'b0010; //AND
	6'b100111: out <= 4'b0011; //NOR	
    6'b100101: out <= 4'b0100; //OR
	6'b101010: out <= 4'b0101; //SLT
	//6'h08: out <= 4'b0010; //ADD for JR
	endcase  
    2'b01: //I Type
	case (func)
	6'b001000: out <= 4'b0000; //ADDI    
	6'b001001: out <= 4'b0001; //SUBI,como no exite le pondre 9
	6'b100100: out <= 4'b0010; //ANDI
	6'b001101: out <= 4'b0100; //ORI
	6'b001010: out <= 4'b0101; //SLTI
	6'b000100: out <= 4'b0110;//BEQ
    6'b000101: out = 4'b0111; //BNEQ
	6'b000000: out <= 4'b0000; //BGEZ,branch si es mayor o igual que 0
    endcase
   endcase
 end

endmodule
