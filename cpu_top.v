
module cpu_top ( input clock , input start , input [7:0] x , output reg error, output wire[6:0] hex1, hex0) ; 
  reg [7:0] stack [0:7] ; 
  reg zeroFlag , signFlag ;
  reg [7:0] pc ; 
  reg [7:0] memory [0:255] ;
  reg [3:0] stack_pointer ; 
  reg [7:0] IR , DR  ; 
  
  wire [3:0] op;
  wire [7:0] tmp ; 
  assign tmp = memory[253] ; 
  
  assign op = IR[7:4];
  
  
  wire [7:0] result;
  assign result = memory[254] ; 
  wire clk;
  counter sample (clock, clk);
  
  
  
  always @( posedge clk ) begin
    if (start )begin
      memory[253] = 0 ;  
      memory[254] = 0 ; 
      memory[255] = x ; 
      pc = 0 ; 
      zeroFlag = 0 ; 
      signFlag = 0 ; 
      
      stack_pointer = 0 ; 
    
    memory[0] = 8'b0001_0000 ;    //push M ( x ro miare sare stack)  
    memory[1] = 8'd255 ;
    memory[2] = 8'b0000_00000 ;     // push 0 into stack ; 
    memory[3] = 8'd0 ; 
    memory[4] = 8'b0110_0000 ;    // Add them
    memory[5] = 8'b0000_0000 ;    // push adrese error
    memory[6] = 8'd33 ;
    memory[7] = 8'b0101_0000 ;    // jump if sign
    
    memory[8] = 8'b0001_0000 ;   // puch M ( x ro miare roo ) 
    memory[9] = 8'd255 ; 
    memory[10] = 8'b0000_0000 ;    // push 23 into stack 
    memory[11] = 8'd23 ; 
    memory[12] = 8'b0110_0000 ;     //add them  
    memory[13] = 8'b0010_0000 ;      //store the value of (x+23) into memory  
    memory[14] = 8'd100 ; 
    memory[15] = 8'b0001_0000 ;      //bring x+23 from memory to stack 
    memory[16] = 8'd100 ; 
    memory[17] = 8'b0001_0000 ;      //bring it again
    memory[18] = 8'd100 ; 
    memory[19] = 8'b0110_0000 ;     //add them ( => *2 ) 
    memory[20] = 8'b0000_0000 ;     //push 12 into stack 
    memory[21] = 8'd12 ; 
    memory[22] = 8'b0111_0000 ;    //Sub
    memory[23] = 8'b0000_0000 ;    // push adrese error 
    memory[24] = 8'd33 ; 
    memory[25] = 8'b0101_0000 ;    //jump if sign 
    memory[26] = 8'b0010_0000 ;    // pop  e alaki
    memory[27] = 8'd80 ; 
    memory[28] = 8'b0010_0000 ;    //store the result in memory[254]
    memory[29] = 8'd254 ;
    memory[30] = 8'b0000_0000 ;  //push adrese end
    memory[31] = 8'd 37;
    memory[32] = 8'b0011_0000 ;   // jump end 
    //error 
    memory[33] = 8'b0000_0000 ;   //push 1 into stack 
    memory[34] = 8'd1  ;
    memory[35] = 8'b0010_0000 ;   //assign error to 1 
    memory[36] = 8'd253 ;  
    
      //(x + 23 ) * 2 - 12
     //error = 0; 
    end
    else begin
      IR = memory[pc] ; 
      pc = pc + 1 ; 
      case (IR[7:4]) 
        4'd0: begin         //push C
          DR = memory[pc] ; 
          pc = pc + 1 ; 
          stack[stack_pointer] = DR ; 
          stack_pointer = stack_pointer + 1 ; 
        end
        
        4'd1: begin        // push M
          DR = memory[pc] ; 
          pc = pc +1 ; 
          stack[stack_pointer] = memory[DR] ; 
          stack_pointer = stack_pointer + 1 ; 
        end
        
        4'd2: begin       // pop M
          DR = memory[pc] ; 
          pc = pc + 1 ; 
          stack_pointer = stack_pointer -1 ; 
          memory[DR] = stack[stack_pointer] ; 
        end
        
        4'd3: begin       // JUMP
          stack_pointer = stack_pointer -1 ;
          pc = stack[stack_pointer] ; 
        end
        
        4'd4: begin       // JZ 
          if ( zeroFlag)begin 
            stack_pointer = stack_pointer -1 ; 
            pc = stack[stack_pointer] ; 
          end
        end
        
        4'd5: begin     //JS
          if ( signFlag)begin 
            stack_pointer = stack_pointer -1 ; 
            pc = stack[stack_pointer] ; 
          end
        end
        
        4'd6: begin    // ADD
          stack[stack_pointer -2 ] = stack[stack_pointer-1] + stack[stack_pointer-2] ; 
          stack_pointer = stack_pointer -1 ;
          DR = stack[stack_pointer -1 ] ;
          if ( DR == 0)
            zeroFlag = 1 ; 
          else 
            zeroFlag = 0 ;
          if ( DR[7] == 1)
            signFlag = 1 ; 
          else 
              signFlag = 0 ; 
        end
        
      4'd7: begin    // SUB
          stack[stack_pointer -2 ] = stack[stack_pointer-2] - stack[stack_pointer-1] ; 
          stack_pointer = stack_pointer -1 ;
          DR = stack[stack_pointer -1 ] ;
          if ( DR == 0)
            zeroFlag = 1 ; 
          else 
            zeroFlag = 0 ;
          if ( DR[7] == 1)
            signFlag = 1 ; 
          else 
              signFlag = 0 ; 
        end
       endcase 
       
       if (x >= 'd60)
		error = 1;
	else
		error = 0; 
    
    end
  end
  
	seven_seg a0( result[3:0], 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,temp, hex0);
	seven_seg a1( result[7:4], 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,temp2, hex1);
  
endmodule



module counter (input clk1, output reg clk2);
	reg [24:0] count = 0;
	always @(posedge clk1)
	begin 
		count = count + 1;
		if (count[24] ==1)
			clk2 = 1;
		else
			clk2 = 0;
	end

endmodule
