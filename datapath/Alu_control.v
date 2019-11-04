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
    endcase
   endcase
 end

endmodule
