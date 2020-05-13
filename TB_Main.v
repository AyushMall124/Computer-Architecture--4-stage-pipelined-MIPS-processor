module testb_main;
  reg clk,reset;
  
  Processor main(clk,reset);
  
  initial begin
  clk = 1'b0;
  repeat(100)
  #10 clk = ~clk;
  #10 $finish;
  end
  
  initial begin
  reset = 1'b1;
  #5 reset = 1'b0;
  #10 reset = 1'b1;
  end
  
endmodule

