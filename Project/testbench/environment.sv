class environment;

  generator  gen;
  driver     drv;
  monitor    mon;
  scoreboard scb;

  mailbox #(aes_transaction) gen2drv;
  mailbox #(aes_transaction) drv2scb;
  mailbox #(aes_transaction) mon2scb;

  virtual aes_interface.DRIVER  drv_vif;
  virtual aes_interface.MONITOR mon_vif;

  function new(input virtual aes_interface.DRIVER drv_vif,
               input virtual aes_interface.MONITOR mon_vif);

    this.drv_vif = drv_vif;
    this.mon_vif = mon_vif;

    gen2drv = new();
    drv2scb = new();
    mon2scb = new();

    gen = new(gen2drv);
    drv = new(drv_vif, gen2drv, drv2scb);
    mon = new(mon_vif, mon2scb);
    scb = new(drv2scb, mon2scb);

  endfunction

  task run();

    fork
      gen.run();

      begin
        drv.reset_dut();
        drv.run();
      end

      mon.run();
      scb.run();
    join_none

  endtask

endclass
