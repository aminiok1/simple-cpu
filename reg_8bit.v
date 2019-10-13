module reg_8bit(output reg [7:0] out, input [7:0] in, input clk);
	always @(posedge clk)
	begin
		out <= in;
	end
endmodule 