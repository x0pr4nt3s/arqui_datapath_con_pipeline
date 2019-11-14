`include "Register_file.v"
module test_reg;
wire clk;
wire [4:0] readreg1, readreg2, writereg; // 2 sources y 1 destination
wire [31:0] writedata; // resultado (writeback)
wire regwrite; // input de Control
wire [31:0] read_data1, read_data2;
wire [31:0]reg_set[0:31]; // tabla de las variables

Register_File call_RF(.clk(clk),.readreg1(readreg1),.readreg2(readreg2),.writereg(writereg),.writedata(writedata),.read_data1(read_data1),.read_data2(read_data2),.regwrite(RegWrite));
initial begin
    $monitor($time,"Clock: %d , Read Data 1: %d , Read Data 2: %d",clk,read_data1,read_data2);
    #1;clk<=1;readreg1<=5'b00001;readreg2<=5'b00010;writereg<=5'b0000;writedata<=0;regwrite<=0; #10;$finish;
end


endmodule
