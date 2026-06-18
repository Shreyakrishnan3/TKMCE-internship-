class apb_transaction;
  rand bit [31:0] addr;
  rand bit [31:0] wdata;
  rand bit        write;
  bit [31:0]      rdata;

  constraint c_addr { 
    addr[1:0] == 2'b00;       
    addr >= 32'h0000_0000;    
    addr <= 32'h0000_03FC;    
  } 
endclass

typedef mailbox #(apb_transaction) apb_mbx;
