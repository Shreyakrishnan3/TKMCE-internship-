class environment;
  generator  gen;
  driver     drv;
  monitor    mon;
  scoreboard scb;
  apb_mbx gen2drv; 
  apb_mbx mon2scb; 
  virtual apb_if vif;
  
  function new(virtual apb_if vif);
    this.vif = vif;
    gen2drv = new();
    mon2scb = new();
    gen = new(gen2drv);
    drv = new(vif, gen2drv);
    mon = new(vif, mon2scb);
    scb = new(mon2scb);
  endfunction
  
  task run();
    fork
      gen.main();
      drv.main();
      mon.main();
      scb.main();
    join_any
  endtask
endclass
