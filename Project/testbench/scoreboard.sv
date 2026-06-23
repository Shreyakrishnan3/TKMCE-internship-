class scoreboard;

  mailbox #(aes_transaction) drv2scb;
  mailbox #(aes_transaction) mon2scb;

  int pass_count;
  int fail_count;

  function new(
      input mailbox #(aes_transaction) drv2scb,
      input mailbox #(aes_transaction) mon2scb
  );

    this.drv2scb = drv2scb;
    this.mon2scb = mon2scb;

  endfunction

  task run();

    aes_transaction exp_tr;
    aes_transaction act_tr;

    forever begin

      drv2scb.get(exp_tr);
      mon2scb.get(act_tr);

      act_tr.end_time = $time;

      $display("========================================");
      $display("TEST NAME : %s", exp_tr.test_name);
      $display("PLAINTEXT : %032h", exp_tr.plaintext);
      $display("KEY       : %032h", exp_tr.key);
      $display("EXPECTED  : %032h", exp_tr.expected_ciphertext);
      $display("ACTUAL    : %032h", act_tr.actual_ciphertext);

      if(exp_tr.expected_ciphertext == act_tr.actual_ciphertext)
      begin
        pass_count++;

        $display("[SCOREBOARD] TEST PASSED");

        $display("LATENCY = %0t ns",
                 act_tr.end_time - exp_tr.start_time);
      end
      else
      begin
        fail_count++;

        $display("[SCOREBOARD] TEST FAILED");

        $display("LATENCY = %0t ns",
                 act_tr.end_time - exp_tr.start_time);
      end

      $display("========================================");

    end

  endtask

  function void report();

    $display("========================================");
    $display("FINAL SCOREBOARD REPORT");
    $display("PASS COUNT = %0d", pass_count);
    $display("FAIL COUNT = %0d", fail_count);
    $display("========================================");

  endfunction

endclass
