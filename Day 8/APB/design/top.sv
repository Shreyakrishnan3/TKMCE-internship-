module top (
  input  logic        clk,
  input  logic        rst_n,
  input  logic [31:0] paddr,
  input  logic        psel,
  input  logic        penable,
  input  logic        pwrite,
  input  logic [31:0] pwdata,
  output logic [31:0] prdata,
  output logic        pready
);

  apb_slave u_apb_slave (
    .clk    (clk),
    .rst_n  (rst_n),
    .paddr  (paddr),
    .psel   (psel),
    .penable(penable),
    .pwrite (pwrite),
    .pwdata (pwdata),
    .prdata (prdata),
    .pready (pready)
  );

endmodule
