module mem_id(output reg [4:0] ins, input start, clk, input [15:0] data, input [3:0] w_addr, r_addr);
	
	reg [15:0] M [15:0];
	
	always @(posedge clk or posedge start)
	begin
		if(start)
		begin
			M[0] = 16'd1;
			M[1] = 16'd6;
			M[2] = 16'd4;
			M[3] = 16'd1;
			M[4] = 16'd4;
			M[5] = 16'd6;
			M[6] = 16'd1;
			M[7] = 16'd6;
		end
		else
		begin
			ins = M[r_addr][4:0];
			M[w_addr] = data;
		end
	end
endmodule 