`ifndef DIV_BY_3_REF_MODEL
`define DIV_BY_3_REF_MODEL

`include "div_by_3_seq_item.sv"

class div_by_3_ref_model;

  mailbox 			mon_rf_mb;
  mailbox 			rf_sc_mb;
  div_by_3_seq_item seq_item_in,seq_item_exp;

  logic [1:0] temp ;
  bit divl_exp;

  function new (mailbox mon_rf_mb, mailbox rf_sc_mb);
    this.mon_rf_mb=mon_rf_mb;
    this.rf_sc_mb=rf_sc_mb;    
  endfunction

  function void ref_model();
    if (mon_rf_mb.num()>0) begin
      mon_rf_mb.try_get (seq_item_in);
      seq_item_exp = new();

      if (seq_item_in.res_n ===0 ) begin
        temp[1:0] = 0;
      end  //rst
      else begin
        if (temp === 0 && seq_item_in.bit_number ===0) begin
          divl_exp =1;
          temp =0;
        end
        else if (temp === 0 && seq_item_in.bit_number) begin
          temp [1:0] = {temp[0],seq_item_in.bit_number};
          divl_exp =0;
        end
        else if (temp === 1 && seq_item_in.bit_number ===0) begin
          divl_exp =0;
          temp [1:0] = {temp[0],seq_item_in.bit_number};
        end
        else if (temp === 1 && seq_item_in.bit_number) begin
          temp [1:0] = {temp[0],seq_item_in.bit_number};
          divl_exp =1;
        end
        else if (temp === 2 && seq_item_in.bit_number ===0) begin
          divl_exp =0;
          temp [1:0] = 1;
        end
        else if (temp === 2 && seq_item_in.bit_number) begin
          temp [1:0] = 2;
          divl_exp =0;
        end
        
      end//rst

      seq_item_exp.divl=divl_exp;

      $display (" Time = %t : res_n = %b  bit_number=%b  temp=%b   divl_exp= %b",$time,seq_item_in.res_n,seq_item_in.bit_number,temp,divl_exp);
      rf_sc_mb.try_put (seq_item_exp);


    end//if

  endfunction
endclass

`endif
