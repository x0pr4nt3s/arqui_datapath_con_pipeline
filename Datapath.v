module DATAPATH(clk, address_final, resultado_de_alu);
input clk;


/*
output wire [31:0] address_final, resultado_de_alu;
wire [31:0] Out_PC, In_PC, PC_4, I_PC, S_E_S_L,PC_final;

wire RegDst,Jump,MemtoReg,ALUsrc,RegWrite;
wire [1:0] Branch, ALUOP, MemRead, MemWrite;

wire [31:0] Instruction;

wire [31:0] R1, R2, sign_extended, RF_to_ALU, ALU_out;
wire [3:0] ctrl_to_ALU;

wire ZERO, ZERO_to_MUX;

wire [31:0] DM_out, DM_to_RF;

wire [4:0] mux_to_RF;

wire [31:0] Jump_address;

wire [31:0] PC_final_Jump;
*/

//CONEXIONES

//module PC(clk,entrada,salida);
PC call_PC(.clk(clk),.entrada(PC_final_Jump),.salida(Out_PC));

//module InstructionMemory(clk,pc,out);
InstructionMemory call_InstructionMemory(.clk(clk),.pc(Out_PC),.out(Instruction));

//module Control(inA,RegDst,Jump,Branch,MemRead,MemtoReg,ALUOP,MemWrite,ALUsrc,RegWrite);
Control call_Control(.inA(Instruction[31:26]),.RegDst(RegDst),.Jump(Jump),.Branch(Branch),.MemRead(MemRead),.MemtoReg(MemtoReg),.ALUOP(ALUOP),.MemWrite(MemWrite),.ALUsrc(ALUsrc),.RegWrite(RegWrite));

//module MUX_reg_file(inA,inB,outA,control);
MUX_reg_file call_MUX_RF(.inA(Instruction[20:16]),.inB(Instruction[15:11]),.outA(mux_to_RF),.control(RegDst));

//module rfile(clk, rd1, rd2, wd1, write, read1, read2, regwrite);
rfile call_RF(.clk(clk),.rd1(Instruction[25:21]),.rd2(Instruction[20:16]),.wd1(mux_to_RF),.write(DM_to_RF),.read1(R1),.read2(R2),.regwrite(RegWrite));

//module Signextend(inA,outA);
Signextend call_Signextend(.inA(Instruction[15:0]),.outA(sign_extended));

//module mux_to_alu(ReadData2, Inmediatte, control, out);
mux_to_alu call_mux_to_ALU(.ReadData2(R2),.Inmediatte(sign_extended),.control(ALUsrc),.out(RF_to_ALU));

//module ALU_control(aluOp,func,out);
ALU_control call_ALU_control(.aluOp(ALUOP),.func(Instruction[5:0]),.out(ctrl_to_ALU));

//module ALU(entr1,entr2,ctrl,ovrflw,rslt,zero);
ALU call_ALU(.entr1(R1),.entr2(RF_to_ALU),.ctrl(ctrl_to_ALU),.rslt(ALU_out),.zero(ZERO));

//module add_pc(pc,pc_add);
add_pc call_add_pc(.pc(Out_PC),.pc_add(PC_4));

//module shift_jump(Instr_inm, PC, jump);
shift_jump call_shift_jump(.Instr_inm(Instruction[25:0]),.PC(PC_4[31:28]),.jump(Jump_address));

//module shift_branch(inmediatte,branch_address);
shift_branch call_shift_branch(.inmediatte(sign_extended),.branch_address(S_E_S_L));

//module ALU_ADD_Branch(pc,shift_left,outA);
ALU_ADD_Branch call_ALU_ADD_BRANCH(.pc(PC_4),.shift_left(S_E_S_L),.outA(I_PC));

//module Branch(Branch,zero,mux);
Branch call_Branch(.Branch(Branch),.zero(ZERO),.mux(ZERO_to_MUX));

//module mux_branch(PC,Branch,Zero,result);
mux_branch call_mux_branch(.PC(PC_4),.Branch(I_PC),.Zero(ZERO_to_MUX),.result(PC_final));

//module mux_jump(PC,Address,Jump,result);
mux_jump call_mux_jump(.PC(PC_final),.Address(Jump_address),.Jump(Jump),.result(PC_final_Jump));

//module data_memory(adres, clk, inMemRead, inMemWrite, inWriteReg, outReadReg);
data_memory call_D_M(.adres(ALU_out),.clk(clk),.inMemRead(MemRead),.inMemWrite(MemWrite),.inWriteReg(R2),.outReadReg(DM_out));

//module mux_from_data_mem(ReadData,ALUresult,control,write);
mux_from_data_mem call_mux_DM(.ReadData(DM_out),.ALUresult(ALU_out),.control(MemtoReg),.write(DM_to_RF));

assign resultado_de_alu = ALU_out;
assign address_final = PC_final_Jump;

endmodule
