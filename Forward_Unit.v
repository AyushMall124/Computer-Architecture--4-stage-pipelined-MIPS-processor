module Forwarding_Unit(
  input [2:0] EX_WB_R1,ID_EX_R1,
  input ID_EX_RegWrite,
  output reg forward_control);
  
  always@(*)
  begin
    if((EX_WB_R1 == ID_EX_R1)&&(ID_EX_RegWrite == 1))
      forward_control = 1;
    else
      forward_control = 0;
  end
  
endmodule

