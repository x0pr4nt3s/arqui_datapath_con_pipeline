module ALU(entr1,entr2,alu_ctrl,alu_result,zero);
//entradas al alu
input [31:0] entr1, entr2;
//orden de la instruccion 
input [3:0] alu_ctrl;

output reg zero;
initial begin
zero = 1'b0;
end

output reg [31:0] alu_result;
/*
ISA-1:
add,addi,sub,and,andi,nor,ori,or,slti,slt.
ISA-2:

*/

always@(*)
begin
  case(alu_ctrl) 
    //ADD
    4'b0000:
	    alu_result= entr1+entr2;
    //SUB
    4'b0001: 
	    alu_result = entr1 - entr2;
    //AND
    4'b0010: 
	    alu_result = entr1 & entr2;
    //NOR
    4'b0011: 
        alu_result = ~(entr1 | entr2);
    //OR
    4'b0100:
        alu_result = entr1 | entr2;
    //SLT
    4'b0101:
    begin 
    if(entr1>entr2)
        alu_result = 1'b1;
    else
        alu_result = 1'b0;
    end
    //BEQ
    4'b0110: 
    begin
	  if(entr1==entr2)
        zero = 1'b1;
    else 
        zero = 1'b0;
    end
    //BNQ
    4'b0111:
    begin
	  if(entr1==entr2)
      zero = 1'b0;
    else 
      zero = 1'b1;
    end
    //BGEZ
<<<<<<< HEAD
=======
    4'b1111:
    begin
	  if(entr1>=0)
	      zero =1'b1;
	  else
	      zero = 1'b0;
    end
	  
>>>>>>> 3f8b62543df797dfc90440184ade070011aa131a
  endcase
end
endmodule