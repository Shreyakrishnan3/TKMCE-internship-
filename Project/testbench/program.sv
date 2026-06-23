program aes_program(
    aes_interface.DRIVER  drv_mp,
    aes_interface.MONITOR mon_mp
);

  test t;

  initial begin
    t = new(drv_mp, mon_mp);
    t.run();
  end

endprogram
