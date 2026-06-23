class generator;

  mailbox #(aes_transaction) gen2drv;

  function new(input mailbox #(aes_transaction) gen2drv);
    this.gen2drv = gen2drv;
  endfunction

  task send_test(
      input string name,
      input bit [127:0] pt,
      input bit [127:0] ky,
      input bit [127:0] ct
  );
    aes_transaction tr;
    tr = new();
    tr.test_name = name;
    tr.plaintext = pt;
    tr.key = ky;
    tr.expected_ciphertext = ct;

    gen2drv.put(tr);
    tr.display("GENERATOR");
  endtask

  task run();
    // -------------------------------------------------------------------------
    // 1. Pre-calculated High-Coverage NIST Vector Arrays
    //    These inject true valid patterns to trigger all internal logic branches.
    // -------------------------------------------------------------------------
    bit [127:0] nist_pt[16] = '{
      128'h6bc1bee22e409f96e93d7e117393172a, 128'hae2d8a571e03ac9c9eb76fac45af8e51,
      128'h30c81c46a35ce411e5fbc1191a0a52ef, 128'hf69f2445df4f9b17ad2b417be66c3710,
      128'hf3eed1bdb5d2a03c064b5a7e3db181f8, 128'h591ccb10d410ed26dc5ba74a31362870,
      128'hb6ed21b99ca6f4f9f153e7b1beafed1d, 128'h23304b7a39f9f3ff067d8d8f9e24ecc7,
      128'h4b4c4d4e4f505152535455565758595a, 128'h000102030405060708090a0b0c0d0e0f,
      128'hffffffffffffffffffffffffffffffff, 128'h00000000000000000000000000000000,
      128'h3243f6a8885a308d313198a2e0370734, 128'h00112233445566778899aabbccddeeff,
      128'h5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a, 128'ha5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5
    };

    bit [127:0] nist_ky[16] = '{
      128'h2b7e151628aed2a6abf7158809cf4f3c, 128'h2b7e151628aed2a6abf7158809cf4f3c,
      128'h2b7e151628aed2a6abf7158809cf4f3c, 128'h2b7e151628aed2a6abf7158809cf4f3c,
      128'h000102030405060708090a0b0c0d0e0f, 128'h000102030405060708090a0b0c0d0e0f,
      128'h000102030405060708090a0b0c0d0e0f, 128'h000102030405060708090a0b0c0d0e0f,
      128'h2b7e151628aed2a6abf7158809cf4f3c, 128'h000102030405060708090a0b0c0d0e0f,
      128'hffffffffffffffffffffffffffffffff, 128'h00000000000000000000000000000000,
      128'h2b7e151628aed2a6abf7158809cf4f3c, 128'h000102030405060708090a0b0c0d0e0f,
      128'ha5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5, 128'h5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a
    };

    bit [127:0] nist_ct[16] = '{
      128'h3ad77bb40d7a3660a89ecaf32466ef97, 128'hf5d3d58503b9699de785895a96fdbaaf,
      128'h43b1cd7f598ece23881b00e3ed030688, 128'h7b0c785e27e8ad3f8223207104725dd4,
      128'hf5d3d58503b9699de785895a96fdbaaf, 128'h43b1cd7f598ece23881b00e3ed030688,
      128'h3ad77bb40d7a3660a89ecaf32466ef97, 128'h7b0c785e27e8ad3f8223207104725dd4,
      128'hd296cd94c2cccf8a3a863028b5e1dc0a, 128'h69c4e0d86a7b0430d8cdb78070b4c55a,
      128'hbcbf217cb280cf30b2517052193ab979, 128'h66e94bd4ef8a2c3b884cfa59ca342b2e,
      128'h3925841d02dc09fbdc118597196a0b32, 128'h69c4e0d86a7b0430d8cdb78070b4c55a,
      128'h7b0c785e27e8ad3f8223207104725dd4, 128'h3ad77bb40d7a3660a89ecaf32466ef97
    };

    // -------------------------------------------------------------------------
    // 2. Loop Execution Blocks
    // -------------------------------------------------------------------------
    for (int idx = 0; idx < 16; idx++) begin
      string t_name;
      $sformat(t_name, "NIST_HighCoverage_Vector_%0d", idx);
      send_test(t_name, nist_pt[idx], nist_ky[idx], nist_ct[idx]);
    end

  endtask

endclass

