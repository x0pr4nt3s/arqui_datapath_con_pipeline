`include "pc_4.v"
`include "Adder.v"
`include "Alu.v"
`include "Alu_control.v"
`include "and.v"
`include "Control.v"
`include "Data_Memory.v"
`include "InstructionMemory.v"
`include "mux_2_1_5bits.v"
`include "mux2_1.v"
`include "ProgramCounter.v"
`include "Register_file.v"
`include "Shift_left_Branch.v"
`include "Shift_left_Jump.v"
`include "SignExtend.v"
`include "F-D.v"
`include "D-EX.v"
`include "EX-MEM.v"
`include "Hazard_Unit.v"
`include "forwarding.v"
`include "mux_3_1.v"

module DATAPATH_CON_PIPELINE(clk,reset);
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

//DECODE -EXECUTE
wire [4:0] dest_d_e;
wire [31:0] reg1_d_e;
wire [31:0] reg2_d_e;
wire [31:0] mux_reg2_imm_d_e;
wire branch_d_e;
wire jump_d_e;
wire MemtoReg_d_e;
wire [1:0] MemRead_d_e;
wire [1:0] MemWrite_d_e;
wire [3:0] alucontrol_d_e;
wire [31:0] Jump_address_d_e;
wire [31:0] shift_left_branch_d_e;
//EX-MEM
wire [4:0] dest_e_m;
input MemtoReg_e_m;
input [1:0] MemWrite_e_m,MemRead_e_m;
//hazards
wire STALL;//acordarse que tengo que ponerle un valor
//F-D
wire [31:0] PC_F_D,inst_F_D;
wire [4:0] src_1_f_d,src_2_f_d;
//forwarding
wire forward_EN;
wire [1:0] val1,val2;
//f
wire hazard_detected;
wire [31:0] val_1_mux_forw,val_2_mux_forw;
//



//FETCH
PC #(32)call_pc(.clk(clk),.reset(reset),.d(address_final),.q(Out_PC));

InstructionMemory call_IM(.pc(Out_PC),.out(Instruction));

adder_pc call_adder_pc(.pc(Out_PC),.pc_add(address_final));

//FETCH-DECODE

F_D call_F_D(.clk(clk),.rst(reset),.STALL(hazard_detected),.PCIn(address_final),.instructionIn(Instruction),.PC(PC_F_D),.instruction(inst_F_D));


//REGISTER FILE
Register_File call_RF(.clk(clk),.readreg1(Instruction[25:21]),.readreg2(Instruction[20:16]),
.writereg(writereg),.writedata(writedata),.read_data1(read_data1),.read_data2(read_data2),.regwrite(RegWrite));
//primero llamamos al RF para sacar los datos 

hazard_detection call_hazard(.forward_EN(forward_EN),.alu_src(ALUsrc),.src1_ID(inst_F_D[25:21]),.src2_ID(inst_F_D[20:16]),.dest_d_e(dest_d_e),
.mem_to_reg_d_e(mem_to_reg_d_e),.dest_e_m(dest_e_m),.mem_to_reg_e_m(mem_to_reg_e_m),.hazard_detected(hazard_detected));

//DECODE

Control call_Control(.clk(clk),.hazard_detected(hazard_detected),.Instruction(inst_F_D[31:26]),.RegDst(RegDst),.Jump(Jump),.Branch(Branch),.MemRead(MemRead),
.MemtoReg(MemtoReg),.ALUOp(ALUOP),.MemWrite(MemWrite),.ALUSrc(ALUsrc),.RegWrite(RegWrite));//llamando al control

mux2_1_5 call_mux2_1_5bits(.a(inst_F_D[20:16]),.b(inst_F_D[15:11]),.sel(RegDst),.out(writereg));

SignExtend call_Signextend(.a(inst_F_D[15:0]),.b(sign_extended));

mux2_1 mux_antes_del_alu(.a(sign_extended),.b(read_data2),.sel(ALUsrc),.out(mux_alu));

ALU_Control call_alu_control(.aluOp(ALUOP),.func(inst_F_D[5:0]),.out(alucontrol));

Shift_Left_Jump call_shift_jump(.imm(inst_F_D[25:0]),.PC(Out_PC[31:28]),.jump(Jump_address));

Shift_Left_Branch call_shift_branch(.imm(sign_extended),.branch_address(shift_left_branch));//el sign_extend es el unsigned que sale del sign_extend


// DECODE - EXECUTION
D_EX ID_IE(.clk(clk),.rst(reset),.src_1(inst_F_D[25:21]),.src_2(inst_F_D[20:16]),.dest_in(inst_F_D[15:11]),
.Reg1_in(read_data1),.Reg2_in(read_data2),
.out_mux_reg_2_o_imm_in(mux_alu),.Branch_in(Branch),
.Jump_in(Jump),.MemtoReg_in(MemtoReg),
.MemRead_in(MemRead),.MemWrite_in(MemWrite),
.alu_control_out_in(alucontrol),.Jump_address_in(Jump_address),
.shift_left_branch_in(shift_left_branch),.src_1_out(src_1_f_d),.src_2_out(src_2_f_d),.dest_out(dest_d_e),
.Reg1_out(reg1_d_e),.Reg2_out(reg2_d_e),
.out_mux_reg_2_o_imm_out(mux_reg2_imm_d_e),.Branch_out(branch_d_e),
.Jump_out(jump_d_e),.MemtoReg_out(MemtoReg_d_e),.MemRead_out(MemRead_d_e),
.MemWrite_out(MemWrite_d_e),.alu_control_out_out(alucontrol_d_e),
.Jump_address_out(Jump_address_d_e),
.shift_left_branch_out(shift_left_branch_d_e));



//FORWARDNIG 
forwarding_EXE call_forwarding(.src1_d_e(inst_F_D[25:21]),.src2_d_e(inst_F_D[20:16]),
.dest_MEM(dest_d_e),.dest_WB(dest_e_m),.WB_EN_MEM(mem_to_reg_d_e),.WB_EN_WB(mem_to_reg_e_m),.val1_sel(val1),.val2_sel(val2));


//MUXES DE FORWARDING


mux_forwarding call_3_forwarding_1(.Reg1(reg1_d_e),.Alu_result(alu_result),.WB_result(DM_mux),.signal_forwarding(val1),.result(val_1_mux_forw));

mux_forwarding call_3_forwarding_2(.Reg1(reg2_d_e),.Alu_result(alu_result),.WB_result(DM_mux),.signal_forwarding(val2),.result(val_2_mux_forw));

//EXECUTE 
ALU call_ALU(.entr1(val_1_mux_forw),.entr2(val_2_mux_forw),.alu_ctrl(alucontrol_d_e),.alu_result(alu_result),.zero(zero));

Adder call_adder(.a(address_final),.b(shift_left_branch),.y(branch_pc));

And call_and(.a(branch_d_e),.b(zero),.out(zero_to_mux));//Corre perfecto

mux2_1 call_mux2_1_branch(.a(address_final),.b(branch_pc),.sel(zero_to_mux),.out(mux_branch_out));


//EX-MEM
EX_MEM call_ex_mem(.clk(clk),.rst(reset),.dest(dest_d_e),.memwrite(MemWrite_d_e),.memtoreg(MemtoReg_d_e),.memread(MemRead_d_e),
.dest_out(dest_e_m),.memwrite_out(MemWrite_e_m),.memread_out(MemRead_e_m),.memtoreg_out(MemtoReg_e_m));

//MEMORY
Data_Memory call_data_memory(.clk(clk),.address(alu_result),.memwrite(MemWrite_e_m),.writedata(read_data2),.read_data(DM_out),.memread(MemRead_e_m));

//WRITEBACK
mux2_1 call_mux_data_memory(.a(DM_out),.b(alu_result),.sel(MemtoReg_d_e),.out(DM_mux));


always @ (posedge clk)  
begin
#2;$display("%b,%b",dest_d_e,dest_e_m);
end


endmodule

