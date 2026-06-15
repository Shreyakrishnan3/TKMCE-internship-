class fifo_base_transaction;
rand bit [7:0] data_in;
rand bit wrenb;
rand bit rdenb;

function new(input bit [7:0] data = 0);
this.data_in = data;
this.wrenb = 0;
this.rdenb = 0;
endfunction

function void display();
$display("data_in : %0d", data_in);
$display("wrenb : %0b", wrenb);
$display("rdenb : %0b", rdenb);
endfunction
endclass


class fifo_transaction extends fifo_base_transaction;
rand bit clk;
rand bit rst;
bit [7:0] data_out;
bit full;
bit empty;

constraint valid_ctrl {
!(wrenb && rdenb);
}

constraint valid_rst {
if(rst == 1) {
wrenb == 0;
rdenb == 0;
}
}

function new(input bit [7:0] data = 0, input bit rst = 0);
super.new(data);
this.rst = rst;
this.clk = 0;
this.data_out = 0;
this.full = 0;
this.empty = 1;
endfunction

function void display();
super.display();
$display("rst : %0b", rst);
$display("data_out : %0d", data_out);
$display("full : %0b", full);
$display("empty : %0b", empty);
endfunction

function void set_write(input bit [7:0] data);
this.wrenb = 1;
this.rdenb = 0;
this.data_in = data;
endfunction

function void set_read();
this.wrenb = 0;
this.rdenb = 1;
endfunction

function void set_reset();
this.rst = 1;
this.wrenb = 0;
this.rdenb = 0;
endfunction
endclass


module tb_transaction;
fifo_transaction t;

initial begin
t = new();
t.set_write(8'hAB);
t.display();

t = new();
t.set_read();
t.data_out = 8'hAB;
t.display();

t = new();
t.set_reset();
t.display();

t = new();
void'(t.randomize());
t.display();

$finish();
end
endmodule
