class scoreboard;
  apb_mbx mon2scb;
  bit [31:0] internal_mem [bit [31:0]];
  
  function new(apb_mbx mon2scb);
    this.mon2scb = mon2scb;
  endfunction
  
  task main();
    forever begin
      apb_transaction tr;
      mon2scb.get(tr);
      if (tr.write) begin
        internal_mem[tr.addr] = tr.wdata;
        $display("[SCB] WRITE: Addr=0x%0h, Data=0x%0h", tr.addr, tr.wdata);
      end else begin
        $display("[SCB] READ : Addr=0x%0h", tr.addr);
        if (internal_mem.exists(tr.addr)) begin
          if (internal_mem[tr.addr] == tr.rdata)
            $display("[SCB] MATCH: Expected=0x%0h, Got=0x%0h (SUCCESS)\n", internal_mem[tr.addr], tr.rdata);
          else
            $error("[SCB] MISMATCH: Expected=0x%0h, Got=0x%0h (FAIL)\n", internal_mem[tr.addr], tr.rdata);
        end else begin
          $display("[SCB] WARNING: Read from uninitialized Addr=0x%0h\n", tr.addr);
        end
      end
    end
  endtask
endclass
