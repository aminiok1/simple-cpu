module alu(output [7:0] result_im, result_re, input [7:0] a,b, input [1:0] cmd);
	wire [3:0] add_im, add_re;
	wire [7:0] mul_im, mul_re, add_im_sx, add_re_sx;
	
	add_4bit aos(add_im, add_re, a,b, cmd[0]);
	
	sign_extend sx1(add_im_sx, add_im);
	sign_extend sx2(add_re_sx, add_re);
	
	mul_4bit mul(mul_im, mul_re, a,b);
	
	assign result_im = cmd[1]?mul_im:add_im_sx;
	assign result_re = cmd[1]?mul_re:add_re_sx;
	
endmodule 