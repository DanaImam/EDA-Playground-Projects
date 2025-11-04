`ifndef DIV_BY_3_TOP
`define DIV_BY_3_TOP

`include "div_by_3_env.sv"

program div_by_3_top (div_by_3_if intf);
  
  div_by_3_env div_by_3_env_ins;
  
  
  initial begin
    div_by_3_env_ins =new(intf);
    div_by_3_env_ins.run();
  end
  
endprogram

`endif
