

module IM_block(
  input [7:0] PC,                        
  input reset,
  output [7:0] Instruction_code);
  reg [7:0] Instruction_mem [31:0];            
  
  assign Instruction_code = Instruction_mem[PC];
  
  always@(negedge reset) 
  begin
    if(reset == 0)
    begin
      Instruction_mem[0] <= 8'h08;
      Instruction_mem[1] <= 8'h41;
      Instruction_mem[2] <= 8'h70;
      Instruction_mem[3] <= 8'h81;
      Instruction_mem[4] <= 8'h0E;
      Instruction_mem[5] <= 8'h4E;
     
    end
  end
endmodule




