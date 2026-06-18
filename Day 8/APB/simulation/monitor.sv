class monitor;
  virtual apb_if vif;
  apb_mbx mon2scb;
  
  function new(virtual apb_if vif, mailbox #(apb_transaction) mon2scb);
    this.vif = vif;
    this.mon2scb = mon2scb;
  endfunction
  
  task main();
    forever begin
      @(posedge vif.clk);
      #1; 
      if (vif.psel && vif.penable && vif.pready) begin
        apb_transaction tr = new();
        tr.addr  = vif.paddr;
        tr.write = vif.pwrite;
        if (vif.pwrite) begin
          tr.wdata = vif.pwdata;
        end else begin
          @(posedge vif.clk);
          #1;
          tr.rdata = vif.prdata;
        end
        mon2scb.put(tr);
      end
    end
  endtask
endclass
