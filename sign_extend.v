module sign_extend(output reg [7:0] out, input [3:0] in);
	always @(*)
	begin
		if(in[3])
			out = {4'b1111,in}; 
		else 
			out = {4'b0000,in};
	end
endmodule 