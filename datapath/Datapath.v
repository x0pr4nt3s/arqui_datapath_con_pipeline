`include"Adder.v"
`include"Alu.v"
`include"Alu_control.v"
`include"and.v"
`include"Control.v"
`include"Data_Memory.v"
`include"InstructionMemory.v"
`include"mux_2_1_5bits.v"
`include"mux2_1.v"
`include"ProgramCounter.v"
`include"Register_file.v"
`include"Shift_left_Branch.v"
`include"Shift_left_Jump.v"
`include"SignExtend.v"
module DATAPATH(clk);
wire [31:0] address_final;//funca
input clk;//funca
wire [31:0] pc_final;//pc_final=es la direccion a la que va a apuntar el program counter
//Out_PC=salida del program counter 
wire [31:0] Out_PC, In_PC, PC_4, I_PC, S_E_S_L,PC_final;
wire RegDst,Jump,MemtoReg,ALUsrc,RegWrite;//del Control 
wire [1:0] Branch, ALUOP, MemRead, MemWrite;//del Control
wire [31:0] Instruction;
wire [31:0] RD1, RD2, sign_extended, RF_to_ALU, ALU_out;//los primeros dos son las salidas del register file,el segundo es sign extend
wire [31:0] mux_alu;//es el mux antes del alu
wire [3:0] ctrl_to_ALU;//es el opcode para el alu
wire ZERO, ZERO_to_MUX;
wire [31:0] DM_out, DM_to_RF;
wire [4:0] mux_to_RF;
wire [31:0] Jump_address;
wire [31:0] PC_final_Jump;
wire [31:0] mux_from_data_mem;


//llamo al program counter
PC call_PC(.clk(clk),.entrada(address_final),.salida(Out_PC));
//llama al instruction memory 
InstructionMemory call_IM(.clk(clck),.pc(Out_PC),.out(Instruction));
//llama al Control 
Control call_Control(.Instruction(Instruction[31:26]),.RegDst(RegDst),.Jump(Jump),.Branch(Branch),.MemRead(MemRead),.MemtoReg(MemtoReg),.ALUOp(ALUOP),.MemWrite(MemWrite),.ALUSrc(ALUsrc),.RegWrite(RegWrite));
//llama al mux2_1_5bits()
mux2_1_5 call_mux2_1_5bits(.a(Instruction[20:16]),.b(Instruction[15:11]),.sel(RegDst),.out(mux_to_RF));
//llama al register file
Register_File call_RF(.clk(clk),.readreg1(Instruction[25:21]),.readreg2(Instruction[20:16]),.writereg(mux_to_RF),.writedata(mux_from_data_mem),.read_data1(RD1),.read_data2(RD2),.regwrite(RegWrite));
//llama al SignExtend
SignExtend call_Signextend(.a(Instruction[15:0]),.b(sign_extended));
//llama al mux que esta antes del alu 
mux2_1 mux_de_32(.a(RD2),.b(sign_extended),.sel(ALUSrc),.out(mux_alu));
//llama al alu control
ALU_control call_alu_control(.aluOp(ALUOP),.func(Instruction[5:0]),.out(ctrl_to_ALU));
//


endmodule
/*
//CONEXIONES
//module PC(clk,entrada,salida);
PC call_PC(.clk(clk),.entrada(PC_final),.salida(Out_PC));
//module InstructionMemory(clk,pc,out);
InstructionMemory call_InstructionMemory(.clk(clk),.pc(Out_PC),.out(Instruction));
//module Control(Instruction,RegDst,Jump,Branch,MemRead,MemtoReg,ALUOp,MemWrite,ALUsrc,RegWrite);
Control call_Control(.Instruction(Instruction[31:26]),.RegDst(RegDst),.Jump(Jump),.Branch(Branch),.MemRead(MemRead),.MemtoReg(MemtoReg),.ALUOp(ALUOP),.MemWrite(MemWrite),.ALUSrc(ALUsrc),.RegWrite(RegWrite));
//module mux2_1_5(a,b,sel,out); MUX PARA EL REGISTER FILE
mux2_1_5 call_MUX_RF(.a(Instruction[20:16]),.b(Instruction[15:11]),.sel(mux_to_RF),.out(RegDst));
//module Register_File(clk, rd1, rd2, wd1, write, read1, read2, regwrite);
Register_File call_RF(.clk(clk),.readreg1(Instruction[25:21]),.readreg2(Instruction[20:16]),.writereg(DM_to_RF),.writedata(mux_to_RF),.read_data1(R1),.read_data2(R2),.regwrite(RegWrite));
//module Signextend(inA,outA);
SignExtend call_Signextend(.a(Instruction[15:0]),.b(sign_extended));
//module mux2_1(ReadData2, Inmediatte, control, out);Decide cual pasa el inmediato o el register source
mux2_1 call_mux_to_ALU(.a(R2),.b(sign_extended),.sel(ALUsrc),.out(RF_to_ALU));
//module ALU_control(aluOp,func,out);//Decide que opcode tomar mediante la direccion 
ALU_control call_ALU_control(.aluOp(ALUOP),.func(Instruction[5:0]),.out(ctrl_to_ALU));
//module ALU(entr1,entr2,ctrl,ovrflw,rslt,zero);//decide que operacion hacer
ALU call_ALU(.entr1(R1),.entr2(RF_to_ALU),.ctrl(ctrl_to_ALU),.rslt(ALU_out),.zero(ZERO));
//module adder_pc(pc,pc_add);
//adder_pc call_add_pc(.pc(Out_PC),.pc_add(PC_4);

//module shift_jump(Instr_inm, PC, jump);
Shift_Left_Jump call_shift_jump(.Instr_inm(Instruction[25:0]),.PC(PC_4[31:28]),.jump(Jump_address));

//module shift_branch(inmediatte,branch_address);
Shift_Left_Branch call_shift_branch(.inmediatte(sign_extended),.branch_address(S_E_S_L));
/*
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
*/
//assign resultado_de_alu = ALU_out;
//assign address_final = PC_final_Jump;


