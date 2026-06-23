module LastRound (
    input wire clk, 
    input wire reset_n,

    input wire         IN_valid,
    input wire [127:0] IN_state,
    input wire [127:0] RoundKey,

    output wire         OUT_valid,
    output wire [127:0] OUT_state
);

    wire SubBytes2AddRoundKey_valid;
    wire [127:0] SubBytes2ShiftRows_state, ShiftRows2AddRoundKey_state;


    SubBytes SubBytes_inst(
        .clk(clk), 
        .reset_n(reset_n),
        .IN_valid(IN_valid),
        .IN_state(IN_state),
        .OUT_valid(SubBytes2AddRoundKey_valid),
        .OUT_state(SubBytes2ShiftRows_state)
    );

    ShiftRows ShiftRows_inst(
        .IN_state(SubBytes2ShiftRows_state),
        .OUT_state(ShiftRows2AddRoundKey_state)
    );

    AddRoundKey AddRoundKey_inst(
        .clk(clk), 
        .reset_n(reset_n),
        .IN_valid(SubBytes2AddRoundKey_valid),
        .IN_state(ShiftRows2AddRoundKey_state),
        .RoundKey(RoundKey),
        .OUT_valid(OUT_valid),
        .OUT_state(OUT_state)
    );

endmodule
