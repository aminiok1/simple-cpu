
module seven_seg( input [3:0] a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,S , output [3:0] out , output [6:0] HEX) ;

wire [15:0] sel ; 
wire [15:0] final ; 

assign sel[0] = ~S[0] & ~S[1] & ~S[2] & ~S[3] ; 
assign sel[1] = S[0] & ~S[1] & ~S[2] & ~S[3] ; 
assign sel[2] = ~S[0] & S[1] & ~S[2] & ~S[3] ; 
assign sel[3] = S[0] & S[1] & ~S[2] & ~S[3] ; 
assign sel[4] = ~S[0] & ~S[1] & S[2] & ~S[3] ; 
assign sel[5] = S[0] & ~S[1] & S[2] & ~S[3] ; 
assign sel[6] = ~S[0] & S[1] & S[2] & ~S[3] ; 
assign sel[7] = S[0] & S[1] & S[2] & ~S[3] ; 
assign sel[8] = ~S[0] & ~S[1] & ~S[2] & S[3] ; 
assign sel[9] = S[0] & ~S[1] & ~S[2] & S[3] ; 
assign sel[10] = ~S[0] & S[1] & ~S[2] & S[3] ; 
assign sel[11] = S[0] & S[1] & ~S[2] & S[3] ; 
assign sel[12] = ~S[0] & ~S[1] & S[2] & S[3] ; 
assign sel[13] = S[0] & ~S[1] & S[2] & S[3] ; 
assign sel[14] = ~S[0] & S[1] & S[2] & S[3] ; 
assign sel[15] = S[0] & S[1] & S[2] & S[3] ;

assign out = sel[0] ? a0 : 4'bz ; 
assign out = sel[1] ? a1 : 4'bz ; 
assign out = sel[2] ? a2 : 4'bz ; 
assign out = sel[3] ? a3 : 4'bz ; 
assign out = sel[4] ? a4 : 4'bz ; 
assign out = sel[5] ? a5 : 4'bz ; 
assign out = sel[6] ? a6 : 4'bz ; 
assign out = sel[7] ? a7 : 4'bz ; 
assign out = sel[8] ? a8 : 4'bz ; 
assign out = sel[9] ? a9 : 4'bz ; 
assign out = sel[10] ? a10 : 4'bz ; 
assign out = sel[11] ? a11 : 4'bz ; 
assign out = sel[12] ? a12 : 4'bz ; 
assign out = sel[13] ? a13 : 4'bz ; 
assign out = sel[14] ? a14 : 4'bz ; 
assign out = sel[15] ? a15 : 4'bz ; 

assign final[0] = ~out[0] & ~out[1] & ~out[2] & ~out[3] ; 
assign final[1] = out[0] & ~out[1] & ~out[2] & ~out[3] ; 
assign final[2] = ~out[0] & out[1] & ~out[2] & ~out[3] ; 
assign final[3] = out[0] & out[1] & ~out[2] & ~out[3] ; 
assign final[4] = ~out[0] & ~out[1] & out[2] & ~out[3] ; 
assign final[5] = out[0] & ~out[1] & out[2] & ~out[3] ; 
assign final[6] = ~out[0] & out[1] & out[2] & ~out[3] ; 
assign final[7] = out[0] & out[1] & out[2] & ~out[3] ; 
assign final[8] = ~out[0] & ~out[1] & ~out[2] & out[3] ; 
assign final[9] = out[0] & ~out[1] & ~out[2] & out[3] ; 
assign final[10] = ~out[0] & out[1] & ~out[2] & out[3] ; 
assign final[11] = out[0] & out[1] & ~out[2] & out[3] ; 
assign final[12] = ~out[0] & ~out[1] & out[2] & out[3] ; 
assign final[13] = out[0] & ~out[1] & out[2] & out[3] ; 
assign final[14] = ~out[0] & out[1] & out[2] & out[3] ; 
assign final[15] = out[0] & out[1] & out[2] & out[3] ;


assign HEX[0] = final[1] | final[4] | final[11] | final[13] ; 
assign HEX[1] =  final[5] | final[6] | final[11] | final[12] | final[14] | final[15] ;
assign HEX[2] =  final[2] | final[12] | final[14] | final[15] ;
assign HEX[3] =  final[1] | final[4] | final[7] | final[10] | final[15]  ;
assign HEX[4] =  final[1] | final[3] | final[4] | final[5] | final[7] | final[9] ;
assign HEX[5] =  final[1] | final[2] | final[3] | final[7] | final[13] ;
assign HEX[6] =  final[0] | final[1] | final[7] | final[12] ;






endmodule


