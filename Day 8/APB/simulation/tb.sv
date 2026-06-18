// Include definitions using compilation wrapper orders
`include "apb_transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"

module tb;
  reg clk;
  
  apb_if vif(clk);
  
  top dut (
    .clk    (clk),
    .rst_n  (vif.rst_n),
    .paddr  (vif.paddr),
    .psel   (vif.psel),
    .penable(vif.penable),
    .pwrite (vif.pwrite),
    .pwdata (vif.pwdata),
    .prdata (vif.prdata),
    .pready (vif.pready)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    vif.rst_n = 0;
    #20 vif.rst_n = 1;
  end

  environment env;

  initial begin
    env = new(vif);
    #40;
    env.run();
    #800; 
    $display("Testbench complete. Ending simulation.");
    $finish;
  end
endmodule
