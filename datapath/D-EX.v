module D_EX(input clk,rst,input [4:0] src_1,input [4:0] src_2,input [4:0] dest_in,input [31:0] Reg1_in,
input [31:0] Reg2_in,input [31:0] out_mux_reg_2_o_imm_in,input Branch_in,
input Jump_in,
input MemtoReg_in,input [1:0] MemRead_in,input [1:0] MemWrite_in,
input [3:0] alu_control_out_in,input [31:0] Jump_address_in,
input [31:0] shift_left_branch_in,output reg [4:0] src_1_out,output reg [4:0] src_2_out,output reg [4:0] dest_out,
output reg [31:0] Reg1_out,output reg [31:0] Reg2_out,
output reg [31:0] out_mux_reg_2_o_imm_out,output reg Branch_out,
output reg Jump_out,
output reg MemtoReg_out,output reg [1:0] MemRead_out,
output reg [1:0] MemWrite_out,
output reg [3:0] alu_control_out_out,output reg [31:0] Jump_address_out,
output reg [31:0] shift_left_branch_out);


always @(posedge clk)
begin
    if (rst) 
        begin
        src_1_out<=0;
        src_2_out<=0;        
        Reg1_out<=0;
        Reg2_out<=0;
        dest_out<=0;
        out_mux_reg_2_o_imm_out<=0;
        Branch_out<=0;
        Jump_out<=0;
        MemtoReg_out<=0;
        MemRead_out<=0;
        MemWrite_out<=0;
        alu_control_out_out<=0;
        Jump_address_out<=0;
        shift_left_branch_out<=0;
        end
    else
        begin
        src_1_out<=src_1;
        src_2_out<=src_2;
        Reg1_out<=Reg1_in;
        Reg2_out<=Reg2_in;
        dest_out<=dest_in;
        out_mux_reg_2_o_imm_out<=alu_control_out_in;
        Branch_out<=Branch_in;
        Jump_out<=Jump_in;
        MemtoReg_out<=MemtoReg_in;
        MemRead_out<=MemRead_in;
        MemWrite_out<=MemWrite_in;
        alu_control_out_out<=alu_control_out_in;
        Jump_address_out<=Jump_address_in;
        shift_left_branch_out<=shift_left_branch_in;
        end
end
endmodule