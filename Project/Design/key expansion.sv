module single_KeyExpansion (
    input wire clk, 
    input wire reset_n,

    input wire [31:0]  Rcon_in,         
    input wire         IN_valid,
    input wire [127:0] key,             

    output wire         OUT_valid,
    output wire [127:0] RoundKey,      // Combinational wire for the Datapath
    output reg  [127:0] NextKeyReg     // Latched register for the FSM loop
);

    reg  [31:0] RotWord;
    wire [31:0] SBOX_out;

    // Pipeline registers
    reg         IN_valid_d;
    reg [127:0] key_d;
    reg [31:0]  Rcon_d;                

    wire [31:0] temp1, temp2, temp3, temp4;

    always @(*) begin
        RotWord = {key[23 -:8], key[15 -:8], key[7 -:8], key[31 -:8]};
    end

    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin
            SBox SBox_inst(
                .clk(clk), 
                .reset(reset_n), 
                .valid_in(IN_valid), 
                .addr(RotWord[(31-i*8) -:8]), 
                .dout(SBOX_out[(31-i*8) -:8])
            );
        end
    endgenerate

    always @(posedge clk or negedge reset_n) begin 
        if (!reset_n) begin
            IN_valid_d <= 0;
            key_d      <= 128'b0;
            Rcon_d     <= 32'b0;
            NextKeyReg <= 128'b0;
        end else begin
            
            IN_valid_d <= IN_valid;
            if (IN_valid) begin
                key_d  <= key;
                Rcon_d <= Rcon_in;      
            end

            // Latch the combinational key safely for the FSM
            if (IN_valid_d) begin 
                NextKeyReg <= {temp1, temp2, temp3, temp4};
            end
            
        end
    end

    // Combinational XOR logic - Valid instantly for the Datapath
    assign temp1 = key_d[127 -:32] ^ SBOX_out ^ Rcon_d;
    assign temp2 = temp1 ^ key_d[95 -:32];
    assign temp3 = temp2 ^ key_d[63 -:32];
    assign temp4 = temp3 ^ key_d[31 -:32]; 
    
    assign RoundKey  = {temp1, temp2, temp3, temp4};
    assign OUT_valid = IN_valid_d;

endmodule
