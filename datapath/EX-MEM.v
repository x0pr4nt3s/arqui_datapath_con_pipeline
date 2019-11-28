module EX_MEM(input clk,input rst,input [4:0] dest,input [1:0] memwrite,input memtoreg,input [1:0] memread,
output reg [4:0] dest_out,output reg [1:0] memwrite_out,output reg [1:0] memread_out,output reg memtoreg_out);

always @(posedge clk)
begin
if (rst) begin
    dest_out<=0;
    memwrite_out<=0;
    memread_out<=0;
    memtoreg_out<=0;
end
else
begin
    dest_out<=dest;
    memwrite_out<=memwrite;
    memread_out<=memread;
    memtoreg_out<=memtoreg;
end
    
end

endmodule