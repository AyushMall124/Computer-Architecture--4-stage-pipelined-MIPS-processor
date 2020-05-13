

module ID_block(
  input [7:0] Instruction_code,
  output [1:0] Opcode,
  output [2:0] R1, 
  output [2:0] R2,
  output [5:0] Jmp_add);
  
  assign Opcode = Instruction_code[7:6];
  assign R1 = Instruction_code[5:3];
  assign R2 = Instruction_code[2:0];
  assign Jmp_add = Instruction_code[5:0];
  
endmodule

