module hazard_detection(input forward_EN,input alu_src,input [4:0] src1_ID,input [4:0] src2_ID,input [4:0] dest_d_e,
input mem_to_reg_d_e,input [4:0] dest_e_m,input mem_to_reg_e_m,output hazard_detected);

wire src2_is_valid, exe_hazard, mem_hazard, hazard;

assign src2_is_valid = alu_src;//si es inmediate o no

assign exe_hazard = mem_to_reg_d_e && (src1_ID == dest_d_e || (src2_is_valid && src2_ID == dest_d_e));//si hay writeback y a la vez uno de mis sources es igual al dest anterior 
assign mem_hazard = mem_to_reg_e_m && (src1_ID == dest_e_m || (src2_is_valid && src2_ID == dest_e_m));//significa que hay raw

assign hazard = (exe_hazard || mem_hazard);//si alguno esta prendido hay dependencia 


assign hazard_detected = (forward_EN==1'b0) ? hazard : hazard;

endmodule 