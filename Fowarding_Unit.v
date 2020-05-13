module Forwarding_Unit(
  input [2:0] EX_WB_R1,ID_EX_R1,ID_EX_R2,
  input ID_EX_regwrite,
  output reg ID_Forward_control);
  
  always@(*)
  begin
    if((EX_WB_R1 == ID_EX_R2)&&(ID_EX_regwrite == 1))
      ID_Forward_control = 1;
    else if((EX_WB_R1 == ID_EX_R1)&&(ID_EX_regwrite == 1))
      ID_Forward_control = 1;
    else
      ID_Forward_control = 0;
  end
  
endmodule
