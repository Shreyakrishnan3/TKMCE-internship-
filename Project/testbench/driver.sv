class driver;

  virtual aes_interface.DRIVER vif;
  mailbox #(aes_transaction) gen2drv;
  mailbox #(aes_transaction) drv2scb;

  function new(input virtual aes_interface.DRIVER vif,
               input mailbox #(aes_transaction) gen2drv,
               input mailbox #(aes_transaction) drv2scb);
    this.vif     = vif;
    this.gen2drv = gen2drv;
    this.drv2scb = drv2scb;
  endfunction

  task reset_dut();

    vif.drv_cb.reset_n  <= 1'b0;
    vif.drv_cb.IN_valid <= 1'b0;
    vif.drv_cb.IN_state <= 128'b0;
    vif.drv_cb.key      <= 128'b0;

    repeat(5) @(vif.drv_cb);

    vif.drv_cb.reset_n <= 1'b1;

    repeat(2) @(vif.drv_cb);

    $display("[DRIVER] Reset completed");

  endtask

  task run();

    aes_transaction tr;

    forever begin
      gen2drv.get(tr);

      @(vif.drv_cb);

      tr.start_time = $time;

      vif.drv_cb.IN_state <= tr.plaintext;
      vif.drv_cb.key      <= tr.key;
      vif.drv_cb.IN_valid <= 1'b1;

      @(vif.drv_cb);

      vif.drv_cb.IN_valid <= 1'b0;
      vif.drv_cb.IN_state <= 128'b0;
      vif.drv_cb.key      <= 128'b0;

      drv2scb.put(tr);

      $display("[DRIVER] Transaction driven");
      tr.display("DRIVER");

      wait(vif.drv_cb.OUT_valid == 1'b1);

      repeat(2) @(vif.drv_cb);
    end

  endtask

endclass
