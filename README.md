# simple-cpu
Verilog implementation of a simple stack-based CPU. The CPU has 8 registers each 8 bits wide. It also has a 256x8 bits memory. The last 8 rows of the memory are for the memory-mapped I/O(switches and leds).

The supported instructoins are:

<pre>
opcode |    instr |  op  |	instruction

0000   |    PUSHC |  C   |   pushes 8 bits constant C into the stack

0001   |    PUSH  |  M   |   reads the value from address M and pushes it into the stack

0010   |    POP   |  M   |   pops the value from the stack and writes it to address M

0011   |    JUMP  |  -   |   pops the address from the stack and writes it to PC

0100   |    JZ    |  -   |   if flag z is 1, pops the address from the stack and writes it to PC

0101   |    JS    |  -   |   if flag s is 1, pops the address from the stack and writes it to PC

0110   |    ADD   |  -   |   pops two values from the stack, adds them, and pushes the result back into the stack

0111   |    SUB	  |  -   |   pops two values from the stack, subtracts the second value from the first one, and pushes the result back into the stack
</pre>

The CPU has two flags: z(zero) and s(sign) which change during ADD and SUB instructions. All the computations are signed and done in two's complement.

The initialized memory in cpu.v is a simple program which takes an input from user(switch) X and calculates Y:

							Y = ((X + 23) * 2) - 12

The result Y is outputted to the seven segment display.
