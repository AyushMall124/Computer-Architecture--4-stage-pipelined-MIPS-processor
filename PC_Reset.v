
module PC_Reset(
  input clk,reset,
  input [7:0] PC_in,
  output reg [7:0] PC_out);
  
  always@(posedge clk or negedge reset)
  begin
    if(reset == 0)
      PC_out <= 0;
    else
      PC_out <= PC_in;
  end
endmodule 
