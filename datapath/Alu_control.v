module ALU_Control(aluOp,func,out);
input wire [3:0] aluOp;
input wire [5:0] func;
output reg [3:0] out;

always @(*)
begin
case (aluOp)
	4'b0000: //R type
	begin
	case (func)
	6'b100000: out <= 4'b0000; //ADD
	6'b100010: out <= 4'b0001; //SUB
    6'b100100: out <= 4'b0010; //AND
	6'b100111: out <= 4'b0011; //NOR
    6'b100101: out <= 4'b0100; //OR
	6'b101010: out <= 4'b0101; //SLT
	endcase  
    end
	
		
    4'b0100: // I-type (addi, load y store)
	out <= 4'b0000; //ADD
    4'b1010: // I-type (subi)
	out <= 4'b0001; //SUB
	4'b0010: // I-type (slti)
	out <= 4'b0101; // SLT
	4'b1100: // I-type (andi)
	out <= 4'b0010; // AND
	4'b1110: // I-type (ori)
	out <= 4'b0100; // OR
	4'b1111: // I-type (bgez)
	out <= 4'b1111;
	4'b0101: // I-type (beq)
	out <= 4'b0110;
	4'b0111: // I-type (bneq)
	out <= 4'b0111;
	

endcase
end

endmodule