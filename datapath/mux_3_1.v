module mux_forwarding(input [31:0] Reg1,input [31:0] Alu_result,input [31:0] WB_result,input [1:0] signal_forwarding,output [31:0] result);


assign result = ( signal_forwarding== 2'b00 )? Reg1  : (signal_forwarding==2'b01) ? Alu_result : WB_result;

endmodule