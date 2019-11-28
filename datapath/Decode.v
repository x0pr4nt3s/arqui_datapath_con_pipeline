`include "Control.v"
`include "SignExtend.v"
`include "mux2_1.v"
`include "Alu_control.v"
`include "Shift_Left_Branch.v"
`include "Shift_left_Jump.v"
`include "Adder.v"

module Decode(input clk,reset,STALL,input [31:0] address_final,input [31:0] Instruction,input [31:0] READ_DATA2,input RegDst,Jump,MemtoReg,ALUsrc,RegWrite,Branch,
input [1:0] MemRead,MemWrite,input [3:0] ALUOP,output [3:0] alucontrol,output [31:0] branch_pc,output [31:0] Jump_address,output [31:0] mux_alu);


wire [31:0] sign_extended;
wire [31:0] Jump_address;
wire [31:0] shift_left_branch;



//CONTROL
Control call_Control(.clk(clk),.Instruction(Instruction[31:26]),.RegDst(RegDst),.Jump(Jump),.Branch(Branch),.MemRead(MemRead),
.MemtoReg(MemtoReg),.ALUOp(ALUOP),.MemWrite(MemWrite),.ALUSrc(ALUsrc),.RegWrite(RegWrite));//llamando al control

//SIGNEXTEND
SignExtend call_Signextend(.a(Instruction[15:0]),.b(sign_extended));

//MUX ANTES DEL ALU 
mux2_1 mux_antes_del_alu(.a(sign_extended),.b(READ_DATA2),.sel(ALUsrc),.out(mux_alu));
//ALU CONTROL
ALU_Control call_alu_control(.aluOp(ALUOP),.func(Instruction[5:0]),.out(alucontrol));

//SHIFT LEFT JUMPS
Shift_Left_Jump call_shift_jump(.imm(Instruction[25:0]),.PC(Out_PC[31:28]),.jump(Jump_address));
//SHIFT LEFT BRANCH
Shift_Left_Branch call_shift_branch(.imm(sign_extended),.branch_address(shift_left_branch));


Adder call_adder(.a(address_final),.b(shift_left_branch),.y(branch_pc));



endmodule