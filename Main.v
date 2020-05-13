module Processor(
  input clk, reset);
  
  //Variable declarations
  wire [7:0] IF_PC_in,IF_PC_out,IF_PC_next;
  
  wire [7:0] IF_Instruction_code;
  
  reg [7:0] IF_ID_PC_next, IF_ID_Instruction_code;


  
  wire [7:0] ID_Instruction_code,ID_jmp_address;
  wire [1:0] ID_Opcode;
  wire [2:0] ID_R1,ID_R2;
  wire [5:0] ID_address;
  wire ID_regwrite,ID_Out_select,ID_PC_select,EX_Forward_control;
  wire [7:0] ID_Read_data_R1,ID_Read_data_R2,ID_PC_Jump_address,ID_PC_next;
  
  reg [7:0] ID_EX_Read_data_R1, ID_EX_Read_data_R2;
  reg [2:0] ID_EX_R1,ID_EX_R2;
  reg ID_EX_regwrite,ID_EX_Out_select;

  wire [7:0] EX_Read_data_R1,EX_Read_data_R2,EX_added_data,EX_final_data;
  wire [2:0] EX_R1,EX_R2;
  wire EX_regwrite,EX_Out_select;
  
  wire [7:0] EX_Write_data;
  
  reg [7:0] EX_WB_Write_data;
  reg [2:0] EX_WB_R1;
  reg EX_WB_regwrite;
  
  wire [2:0] WB_R1;
  wire WB_regwrite;
  wire [7:0] WB_Write_data;
  
//IF stage : Mux, PC_counter, IM

  //first two letters denotig which stage that signal is coming from 
 PC_Reset PC(clk,reset,IF_PC_in,IF_PC_out);
 MUX_21 M1(IF_PC_out,ID_PC_Jump_address,ID_PC_select,IF_PC_next);
 Ex_block Pc_inc(1,IF_PC_next,IF_PC_in);
 IM_block IM1(IF_PC_next,reset,IF_Instruction_code);

  
//IF-ID Reg 
 // IF/ID Register
  always@(posedge clk or negedge reset)
  begin
    if(reset == 0)
    begin
      IF_ID_PC_next = 0;
      IF_ID_Instruction_code = 0;
    end
    else
    begin
      IF_ID_PC_next = IF_PC_in;
      IF_ID_Instruction_code = IF_Instruction_code;
           
    end
  end


 //ID stage : Decoder, Control Unit, Control Hazard
  assign ID_Instruction_code = IF_ID_Instruction_code;
  assign ID_PC_next = IF_ID_PC_next;

  ID_block ID(ID_Instruction_code,ID_Opcode,ID_R1,ID_R2,ID_address);
  
  Control_Unit CU(ID_Opcode,ID_regwrite,ID_Out_select,ID_PC_select);
  
  Reg_File RF(ID_R1,ID_R2,WB_R1,WB_Write_data,WB_regwrite,reset,ID_Read_data_R1,ID_Read_data_R2);   
  
  Sign_Extend S1(ID_address,ID_jmp_address);
    
  Ex_block addJump(ID_PC_next,ID_jmp_address,ID_PC_Jump_address);  

   // ID/EX Register
  always@(posedge clk or negedge reset)
  begin
    if(reset ==0)
    begin
      ID_EX_R1 = 0;
      ID_EX_R2 = 0;
      ID_EX_Read_data_R1 = 0;
      ID_EX_Read_data_R2 = 0;
      ID_EX_regwrite = 0;
      ID_EX_Out_select = 0;
    
    end
    else
    begin
      ID_EX_R1 = ID_R1;
      ID_EX_R2 = ID_R2;
      ID_EX_Read_data_R1 = ID_Read_data_R1;
      ID_EX_Read_data_R2 = ID_Read_data_R2;
      ID_EX_regwrite = ID_regwrite;
      ID_EX_Out_select = ID_Out_select;
      
    
    end
  end


  //Ex_block : ALU, Forwarding unit

  assign EX_Read_data_R1 = ID_EX_Read_data_R1;
  assign EX_Read_data_R2 = ID_EX_Read_data_R2;
  assign EX_regwrite = ID_EX_regwrite;
  assign EX_Out_select = ID_EX_Out_select;
  assign EX_R1 = ID_EX_R1;
  assign EX_R2 = ID_EX_R2;


Forwarding_Unit FU(EX_WB_R1,ID_EX_R1,ID_EX_R2,ID_EX_regwrite,EX_Forward_control);
  
  MUX_21 muxFWD(EX_Read_data_R1,WB_Write_data,EX_Forward_control,EX_final_data);
  
  Ex_block EX(EX_final_data,EX_Read_data_R2,EX_Added_data);
  
  MUX_21 mux2(EX_added_data,EX_Read_data_R2,EX_Out_select,EX_Write_data);



   // EX/WB Register
  always@(posedge clk or negedge reset)
  begin
    if(reset == 0)
    begin
      EX_WB_Write_data = 0;
      EX_WB_regwrite = 0;
      EX_WB_R1 = 0;
    end
    else
    begin
      EX_WB_Write_data = EX_Write_data;
      EX_WB_regwrite = EX_regwrite;
      EX_WB_R1 = EX_R1;
    end
  end
  
  
  // WB Stage
  assign WB_Write_data = EX_WB_Write_data;
  assign WB_regwrite = EX_WB_regwrite;
  assign WB_R1 = EX_WB_R1;




  endmodule
  




  

  
 	


