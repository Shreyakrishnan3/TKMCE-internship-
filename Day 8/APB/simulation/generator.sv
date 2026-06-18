class generator;
  apb_mbx gen2drv; 
  int num_pairs = 10; 

  function new(apb_mbx gen2drv);
    this.gen2drv = gen2drv;
  endfunction

  task main();
    repeat(num_pairs) begin
      apb_transaction tr_write = new();
      apb_transaction tr_read  = new();
      
      if (!tr_write.randomize() with { write == 1'b1; }) 
        $fatal(1, "Randomization failed");
      gen2drv.put(tr_write);
      
      if (!tr_read.randomize() with { write == 1'b0; }) 
        $fatal(1, "Randomization failed");
      tr_read.addr = tr_write.addr; 
      gen2drv.put(tr_read);
    end
  endtask
endclass
