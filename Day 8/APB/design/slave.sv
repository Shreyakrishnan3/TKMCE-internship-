module apb_slave (
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
  logic [31:0] mem [0:256];

  assign pready = 1'b1; 

  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      prdata <= 32'h0;
    end else if (psel && penable) begin
      if (pwrite)
        mem[paddr[9:2]] <= pwdata;
      else
        prdata <= mem[paddr[9:2]];
    end
  end
endmodule
