
module Sign_Extend(
  input [5:0] in,
  output [7:0] out);
  reg [1:0] Extention;
  
  assign out = {Extention,in};
  
  always@(*)
  begin
    if(in[5] == 0)
      Extention = 2'b00;
    else
      Extention = 2'b11;
  end
endmodule
      
