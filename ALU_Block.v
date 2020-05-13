

module Ex_block(
  input [7:0] Data_1,
  input [7:0] Data_2,
  output [7:0] outp);
  
  assign outp = Data_1 + Data_2;
  
endmodule

