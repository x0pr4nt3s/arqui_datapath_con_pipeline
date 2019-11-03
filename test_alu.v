// fpga4student.com: FPGA projects, Verilog projects, VHDL projects
// Verilog project: Verilog code for ALU
// by FPGA4STUDENT
`include "Alu.v"
 `timescale 1ns / 1ps  

module tb_alu;
//Inputs
 reg[7:0] A,B;
 reg[3:0] ALU_Sel;

//Outputs
 wire[7:0] ALU_Out;
 wire CarryOut;
 // Verilog code for ALU
 integer i;
 alu test_unit(
            A,B,  // ALU 8-bit Inputs                 
            ALU_Sel,// ALU Selection
            ALU_Out, // ALU 8-bit Output
            CarryOut // Carry Out Flag
     );
    initial begin
    // hold reset state for 100 ns.
      A = 2'h0A;
      B = 2'h02;
      ALU_Sel = 2'h0;
      
      for (i=0;i<=15;i=i+1)
      begin
       ALU_Sel = ALU_Sel + 2'h01;
       #10;
      end;
      
      A = 2'hF6;
      B = 2'h0A;
      
    end
endmodule