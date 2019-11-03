module ALU(A,B,Op,R);
 
input [31:0] A,B;
input [4:0] Op;
output [31:0] R;
wire [31:0] Reg1,Reg2;
reg [31:0] Reg3;
 
 
assign Reg1 = A;
assign Reg2 = B;

assign R = Reg3;
 
always @(Op or Reg1 or Reg2)
begin
case (Op)
4'b0000 : Reg3 = Reg1 + Reg2; //add
4'b0001 : Reg3 = Reg1 - Reg2; //sub
4'b0010 : Reg3 = ~Reg1; //NOT gate
4'b0100 : Reg3 = ~(Reg1 | Reg2); //NOR gate
4'b0101 : Reg3 = Reg1 & Reg2; //AND gate
4'b0110 : Reg3 = Reg1 | Reg2; //OR gate
endcase
end
 
endmodule