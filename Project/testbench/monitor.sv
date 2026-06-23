class monitor;

  virtual aes_interface.MONITOR vif;
  mailbox #(aes_transaction) mon2scb;

  function new(input virtual aes_interface.MONITOR vif,
               input mailbox #(aes_transaction) mon2scb);

    this.vif = vif;
    this.mon2scb = mon2scb;

  endfunction

  task run();

    aes_transaction tr;

    forever begin

      @(vif.mon_cb);

      if(vif.mon_cb.OUT_valid == 1'b1)
      begin
        tr = new();

        tr.actual_ciphertext = vif.mon_cb.OUT_state;
        tr.end_time = $time;

        mon2scb.put(tr);

        $display("[MONITOR] OUT_valid detected");
        $display("[MONITOR] Actual Ciphertext = %032h",
                 tr.actual_ciphertext);
      end

    end

  endtask

endclass
