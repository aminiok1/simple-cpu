module pc(output [3:0] out, input clk, start);
	reg [2:0] temp;
	assign out = {1'b0, temp};
	always @(posedge clk or posedge start)
	begin
		if(start)
		begin
			temp = 0;
		end
		else
		begin
			temp = temp + 1'b1;
		end
	end
endmodule 