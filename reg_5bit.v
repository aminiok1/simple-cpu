module reg_5bit(output reg [4:0] ins, input [4:0] data, input clk);
	always @(posedge clk)
	begin
		ins <= data;
	end
endmodule 