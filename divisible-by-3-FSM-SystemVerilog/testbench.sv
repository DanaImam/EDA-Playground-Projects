// Code your testbench here
// or browse Examples

`include "div_by_3_if.sv"
`include "div_by_3_top.sv"

module div_by_3_tb;

  // port decleration
  logic clock = 0 ;
  //---------------------------------------
    //CLK GEN
  initial begin
   forever   begin 
     #10 ;
     clock = ~ clock;
   end
  end
  //---------------------------------------
  
  //Interface creation
  div_by_3_if intf (clock);

  //---------------------------------------

  // DUT Connection
  div_by_3 div_by_3_ins (.clk   		(clock 		),
                         .res_n 		(intf.res_n		),
                         .bit_number    (intf.bit_number),
                         .divl     		(intf.divl		)
                        );
  //---------------------------------------

  // Program connection
  div_by_3_top div_by_3_top_ins (intf);
  //---------------------------------------

  initial begin
    #800;
    $finish;
  end
  //---------------------------------------

  // Dump wave
  initial begin
    $dumpfile("dump2.vcd"); 
    $dumpvars;
  end//Dump wave
  //---------------------------------------

endmodule //div_by_3_tb
