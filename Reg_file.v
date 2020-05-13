

module Reg_File(
  input [2:0] Reg1,
  input [2:0] Reg2,
  input [2:0] Write_reg,   
  input [7:0] Data_Write,
  input RegWr_control,
  input reset,
  output reg [7:0] Data_Reg1,
  output reg [7:0] Data_Reg2
  );
  
  reg [7:0] Reg_mem [7:0];    
  
  always@(negedge reset)
  begin
    if(reset == 0)
    begin
      Reg_mem[0] = 0;
      Reg_mem[1] = 1;
      Reg_mem[2] = 2;
      Reg_mem[3] = 3;
      Reg_mem[4] = 4;
      Reg_mem[5] = 5;
      Reg_mem[6] = 6;
      Reg_mem[7] = 7;
    end
  end
  
  always@(*)                          
  begin      
    Data_Reg1 <= Reg_mem[Reg1];
    Data_Reg2 <= Reg_mem[Reg2];  //for sequential execution
                                       
    if(RegWr_control == 1)
      Reg_mem[Write_reg] <= Data_Write;
  end
endmodule  

