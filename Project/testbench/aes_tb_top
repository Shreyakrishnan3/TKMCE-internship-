`include "aes_interface.sv"
`include "aes_transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "test.sv"
`include "program.sv"

module aes_tb_top;

  logic clk;

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  aes_interface intf(clk);

  AES_128Core DUT (
    .clk       (clk),
    .reset_n   (intf.reset_n),
    .IN_valid  (intf.IN_valid),
    .IN_state  (intf.IN_state),
    .key       (intf.key),
    .OUT_valid (intf.OUT_valid),
    .OUT_state (intf.OUT_state)
  );

  aes_assertions ASSERTIONS (
    .clk       (clk),
    .reset_n   (intf.reset_n),
    .OUT_valid (intf.OUT_valid),
    .OUT_state (intf.OUT_state)
  );

  aes_coverage COVERAGE (
    .clk       (clk),
    .reset_n   (intf.reset_n),
    .IN_valid  (intf.IN_valid),
    .IN_state  (intf.IN_state),
    .key       (intf.key),
    .OUT_valid (intf.OUT_valid)
  );

  aes_program prog (
    .drv_mp (intf.DRIVER),
    .mon_mp (intf.MONITOR)
  );

endmodule
