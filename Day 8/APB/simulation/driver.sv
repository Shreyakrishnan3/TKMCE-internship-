class driver;
  virtual apb_if vif;
  apb_mbx gen2drv;
  
  function new(virtual apb_if vif, apb_mbx gen2drv);
    this.vif = vif;
    this.gen2drv = gen2drv;
  endfunction
  
  task main();
    vif.paddr   <= 32'h0;
    vif.pwrite  <= 1'b0;
    vif.pwdata  <= 32'h0;
    vif.psel    <= 1'b0;
    vif.penable <= 1'b0;
    
    @(posedge vif.clk);
    while(!vif.rst_n) @(posedge vif.clk);
    
    forever begin
      apb_transaction tr;
      gen2drv.get(tr);
      
      vif.paddr   <= tr.addr;
      vif.pwrite  <= tr.write;
      vif.pwdata  <= tr.wdata;
      vif.psel    <= 1'b1;
      vif.penable <= 1'b0;
      
      @(posedge vif.clk);
      vif.penable <= 1'b1;
      
      @(posedge vif.clk);
      while (!vif.pready) @(posedge vif.clk);
      
      if (!tr.write) tr.rdata = vif.prdata;
      
      vif.psel    <= 1'b0;
      vif.penable <= 1'b0;
      vif.pwrite  <= 1'b0;
      @(posedge vif.clk); 
    end
  endtask
endclass
