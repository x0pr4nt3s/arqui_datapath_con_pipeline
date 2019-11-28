`include "ProgramCounter.v"
`include "InstructionMemory.v"
`include "pc_4.v"

module Fetch(input clk,input reset,input STALL,input [31:0] PC,output [31:0] address_final,output [31:0] Instruction_out);//Stall
//PROGRAM COUNTER:
//funca 
wire [31:0] Out_PC;//Out_PC=salida del program counter
//INSTRUCTION MEMORY:
//////////////////////////////////

//PROGRAM COUNTER
PC #(32)call_pc(.clk(clk),.reset(reset),.STALL(STALL),.d(PC),.q(Out_PC));

//INSTRUCTION MEMORY
InstructionMemory call_IM(.pc(Out_PC),.out(Instruction_out));

//PROGRAM COUNTER
adder_pc call_adder_pc(.pc(Out_PC),.pc_add(address_final));


//
endmodule
