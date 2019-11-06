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
input reset;
wire [31:0] address_final;//funca
input clk;//funca
wire [31:0] pc_final;//pc_final=es la direccion a la que va a apuntar el program counter
//Out_PC=salida del program counter 
wire [31:0] Out_PC, PC_4;
wire RegDst,Jump,MemtoReg,ALUsrc,RegWrite;//del Control 
wire [1:0] ALUOP, MemRead, MemWrite;//del Control
wire [31:0] Instruction;
wire [31:0] RD1, RD2, sign_extended, RF_to_ALU, ALU_out;//los primeros dos son las salidas del register file,el segundo es sign extend
wire [31:0] mux_alu;//es el mux antes del alu
wire [3:0] ctrl_to_ALU;//es el opcode para el alu
wire ZERO, ZERO_to_MUX;//este es para el and del branch
wire [31:0] DM_out,DM_mux;//La salida del data memory
wire [31:0] shift_left_branch;
wire [4:0] mux_to_RF;//sirve
wire [31:0] Jump_address;//shift left jump
wire [31:0] PC_final_Jump;//no sirve 
wire [31:0] mux_from_data_mem;
wire [31:0] branch_pc;//sirve carajo
wire [31:0] mux_branch_out;//mux del branch
wire Branch;//del control
wire [31:0] mux_jump_out; //la salida del mux del jump
//llamo al program counter
PC call_PC(.clk(clk),.entrada(address_final),.salida(Out_PC));
//llama al instruction memory 
InstructionMemory call_IM(.clk(clck),.pc(Out_PC),.out(Instruction));
//llama al Control 
Control call_Control(.clk(clk),.Instruction(Instruction[31:26]),.RegDst(RegDst),.Jump(Jump),.Branch(Branch),.MemRead(MemRead),.MemtoReg(MemtoReg),.ALUOp(ALUOP),.MemWrite(MemWrite),.ALUSrc(ALUsrc),.RegWrite(RegWrite));
//llama al mux2_1_5bits()
mux2_1_5 call_mux2_1_5bits(.a(Instruction[20:16]),.b(Instruction[15:11]),.sel(RegDst),.out(mux_to_RF));
//llama al register file
Register_File call_RF(.clk(clk),.readreg1(Instruction[25:21]),.readreg2(Instruction[20:16]),.writereg(mux_to_RF),.writedata(mux_from_data_mem),.read_data1(RD1),.read_data2(RD2),.regwrite(RegWrite));
//llama al SignExtend
SignExtend call_Signextend(.a(Instruction[15:0]),.b(sign_extended));
//llama al mux que esta antes del alu 
mux2_1 mux_de_32(.a(RD2),.b(sign_extended),.sel(ALUSrc),.out(mux_alu));
//llama al alu control
ALU_Control call_alu_control(.aluOp(ALUOP),.func(Instruction[5:0]),.out(ctrl_to_ALU));
//llama al Alu
ALU call_ALU(.entr1(RD1),.entr2(mux_alu),.alu_ctrl(ctrl_to_ALU),.alu_result(ALU_out),.zero(ZERO));
//llama al Shift left jump
Shift_Left_Jump call_shift_jump(.imm(Instruction[25:0]),.PC(PC_4[31:28]),.jump(Jump_address));
//llama al Shift left Branch 
Shift_Left_Branch call_shift_branch(.imm(sign_extended),.branch_address(shift_left_branch));//el sign_extend es el unsigned que sale del sign_extend
//llamas al adder 
Adder call_adder(.a(PC_4),.b(shift_left_branch),.y(branch_pc));
//and del branch
And call_and(.a(Branch),.b(ZERO),.out(ZERO_to_MUX)); 
//mux del branch
mux2_1 call_mux2_1_branch(.a(PC_4),.b(branch_pc),.sel(ZERO_to_MUX),.out(mux_branch_out));
//mux del jump 
mux2_1 call_mux_jump(.a(Jump_address),.b(mux_branch_out),.sel(Jump),.out(mux_jump_out));
//llama al data memory
Data_Memory call_data_memory(.clk(clk),.address(ALU_out),.memwrite(MemWrite),.writedata(RD2),.read_data(DM_out),.memread(MemRead));
//llama al mux del data memory
mux2_1 call_mux_data_memory(.a(DM_out),.b(ALU_out),.sel(MemtoReg),.out(DM_mux));

adder_pc call_adder_pc(.pc(Out_PC),.pc_add(address_final));

always @ (posedge clk)
begin
#2;$display("%d,%d,%d,%d,%d,%d,%d", address_final, Instruction,RD1,RD2, DM_mux, ALUsrc, ALUOP);
end

endmodule

