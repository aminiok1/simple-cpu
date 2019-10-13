module data_path(output [7:0] result_im, result_re, input clk, start, input [7:0] in1, in2);
	
	wire [3:0] r_addr;
	wire [4:0] inst;
	wire [4:0] r1_out;
	wire [7:0] a;
	wire [7:0] b;
	wire [3:0] w_addr;
	
	assign w_addr = {1'b1, r1_out[4:2]};
	
	pc p(r_addr, clk, start);
	mem_id M(inst, start, clk, {result_re, result_im}, w_addr, r_addr);
	reg_5bit r1(r1_out, inst, clk);
	reg_8bit r2(a, in1, clk);
	reg_8bit r3(b, in2, clk);
	alu al(result_im, result_re, a,b, r1_out[1:0]);
	
endmodule 