`include"pc_4.v"
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
module DATAPATH(clk,reset);
input clk;//funca
input reset;
//PROGRAM COUNTER:
wire [31:0] address_final;//funca 
wire [31:0] Out_PC;//Out_PC=salida del program counter
//INSTRUCTION MEMORY:
wire [31:0] Instruction;//la instruccion
//CONTROL:
wire RegDst,Jump,MemtoReg,ALUsrc,RegWrite,Branch;//del Control 
wire [1:0] MemRead, MemWrite;//del Control
wire [3:0] ALUOP;
//REGISTER FILE:
wire [4:0] writereg;
wire [4:0] readreg1,readreg2;
wire [31:0] read_data1,read_data2;
//SIGN EXTEND:
wire [31:0] sign_extended;
//ALU CONTROL:
wire [3:0] alucontrol;
//ALU
wire [31:0] mux_alu;
wire [31:0] alu_result;
wire zero;//verifica si es branch
//shift jump
wire [31:0] Jump_address;
//shift Branch 
wire [31:0] shift_left_branch;
wire [31:0] branch_pc;
wire [31:0] mux_branch_out;
wire [31:0] mux_jum_out;
//DATA MEMORY:
wire [31:0] writedata;
wire zero_to_mux;
wire [31:0] DM_out;
wire [31:0] DM_mux;

//
wire [31:0] nuevo;


//NOTA LOS JUMPS ESTAN POR ARREGLAR





//FETCH:
PC #(32)call_pc(.clk(clk),.reset(reset),.d(address_final),.q(Out_PC));
InstructionMemory call_IM(.pc(Out_PC),.out(Instruction));

adder_pc call_adder_pc(.pc(Out_PC),.pc_add(address_final));
//DECODE:
Control call_Control(.clk(clk),.Instruction(Instruction[31:26]),.RegDst(RegDst),.Jump(Jump),.Branch(Branch),.MemRead(MemRead),
.MemtoReg(MemtoReg),.ALUOp(ALUOP),.MemWrite(MemWrite),.ALUSrc(ALUsrc),.RegWrite(RegWrite));//llamando al control
mux2_1_5 call_mux2_1_5bits(.a(Instruction[20:16]),.b(Instruction[15:11]),.sel(RegDst),.out(writereg));
Register_File call_RF(.clk(clk),.readreg1(Instruction[25:21]),.readreg2(Instruction[20:16]),.writereg(writereg),.writedata(writedata),.read_data1(read_data1),.read_data2(read_data2),.regwrite(RegWrite));
SignExtend call_Signextend(.a(Instruction[15:0]),.b(sign_extended));
mux2_1 mux_antes_del_alu(.a(sign_extended),.b(read_data2),.sel(ALUsrc),.out(mux_alu));
ALU_Control call_alu_control(.aluOp(ALUOP),.func(Instruction[5:0]),.out(alucontrol));

Shift_Left_Jump call_shift_jump(.imm(Instruction[25:0]),.PC(Out_PC[31:28]),.jump(Jump_address));

Shift_Left_Branch call_shift_branch(.imm(sign_extended),.branch_address(shift_left_branch));//el sign_extend es el unsigned que sale del sign_extend
//EXECUTE   
ALU call_ALU(.entr1(read_data1),.entr2(mux_alu),.alu_ctrl(alucontrol),.alu_result(alu_result),.zero(zero));
Adder call_adder(.a(address_final),.b(shift_left_branch),.y(branch_pc));
And call_and(.a(Branch),.b(zero),.out(zero_to_mux));//Corre perfecto

mux2_1 call_mux2_1_branch(.a(address_final),.b(branch_pc),.sel(zero_to_mux),.out(mux_branch_out));
//falta el mux del

//

mux2_1 call_mux2_1_jump(.a(Jump_address),.b(mux_branch_out),.sel(Jump),.out(nuevo));
//MEMORY
Data_Memory call_data_memory(.clk(clk),.address(alu_result),.memwrite(MemWrite),.writedata(read_data2),.read_data(DM_out),.memread(MemRead));

//WRITEBACK
mux2_1 call_mux_data_memory(.a(DM_out),.b(alu_result),.sel(MemtoReg),.out(DM_mux));


always @ (posedge clk)  
begin
#2;$display("%d,%b,%b,%b,%b,%b,%d,%b",Out_PC,Instruction,read_data1,mux_alu,zero,zero_to_mux,branch_pc,nuevo);
end

endmodule

