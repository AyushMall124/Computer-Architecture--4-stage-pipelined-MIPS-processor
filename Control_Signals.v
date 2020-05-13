

module Control_Unit(
  input [1:0] Opcode,
 
  output reg Reg_write,
  output reg Out_control,
  output reg Pc_jmp_select);
  

  always@(*)
  
  begin
  
    case(Opcode)
    2'b00: begin
           Reg_write = 1;
           Out_control = 1;
           Pc_jmp_select = 0;
           end          
    2'b01: begin
           Reg_write = 1;
           Out_control = 0;
           Pc_jmp_select = 0;
           end          
    2'b11: begin
           Reg_write = 0;
           Out_control = 0;
           Pc_jmp_select = 1;
           end          
     default:begin                          
             Reg_write= 0;
             Out_control= 0;
             Pc_jmp_select = 0;
             end
    endcase
              
  end          

  
endmodule

