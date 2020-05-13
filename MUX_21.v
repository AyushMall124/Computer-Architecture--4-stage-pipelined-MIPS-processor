
module MUX_21(
  input [7:0] input1,input2,
  input select,
  output reg [7:0] outp);
  
  always@(*)
  begin
    if(select == 1)
      outp = input2;
    else
      outp = input1;        
  end
endmodule
