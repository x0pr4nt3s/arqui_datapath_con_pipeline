module forwarding_EXE (input [4:0] src1_d_e,input [4:0] src2_d_e,input [4:0] dest_MEM,input [4:0] dest_WB,input WB_EN_MEM, WB_EN_WB,
output reg [1:0] val1_sel, val2_sel);

always @ (*) 
begin
{val1_sel, val2_sel} <= 0;
    //PRIMER SOURCE DEL ALU
    if (WB_EN_MEM && src1_d_e == dest_MEM) val1_sel <= 2'b01;
    else if (WB_EN_WB && src1_d_e == dest_WB) val1_sel <= 2'b10;
    //SEGUNDO SOURCE DEL ALU
    if (WB_EN_MEM && src2_d_e == dest_MEM) val2_sel <= 2'b01;
    else if (WB_EN_WB && src2_d_e == dest_WB) val2_sel <= 2'b10;
  
end
endmodule 