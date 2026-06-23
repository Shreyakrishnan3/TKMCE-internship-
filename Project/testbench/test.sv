class test;

  environment env;

  virtual aes_interface.DRIVER  drv_vif;
  virtual aes_interface.MONITOR mon_vif;

  function new(input virtual aes_interface.DRIVER drv_vif,
               input virtual aes_interface.MONITOR mon_vif);

    this.drv_vif = drv_vif;
    this.mon_vif = mon_vif;

    env = new(drv_vif, mon_vif);

  endfunction

  task run();

    $display("========================================");
    $display("AES-128 Verification Started");
    $display("========================================");

    env.run();

    #5000;

    env.scb.report();

    $display("========================================");
    $display("AES-128 Verification Completed");
    $display("========================================");
   
    $finish;

  endtask

endclass
