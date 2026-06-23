module AES_128Core (
    input wire clk,                 
    input wire reset_n,             

    input wire         IN_valid,    
    input wire [127:0] IN_state,    
    input wire [127:0] key,         

    output reg         OUT_valid,   
    output reg [127:0] OUT_state    
);

    // FSM States
    localparam IDLE       = 2'b00;
    localparam ROUNDS_1_9 = 2'b01;
    localparam ROUND_10   = 2'b10;

    reg [1:0] current_state;
    reg [3:0] round_cnt;

    // Internal loop registers
    reg [127:0] current_data;
    reg [127:0] current_key;
    reg         round_trigger;

    // Wires from instantiated modules
    wire [127:0] round_out_data, last_round_out_data;
    wire         round_out_valid, last_round_out_valid, key_out_valid;
    wire [31:0]  dynamic_rcon;
    
    // Split key domains
    wire [127:0] combinational_round_key;
    wire [127:0] next_key_out;

    // --------------------------------------------------------
    // Instantiations 
    // --------------------------------------------------------
    
    Rcon_LUT Rcon_inst(
        .round_cnt(round_cnt),
        .rcon_out(dynamic_rcon)
    );

    single_KeyExpansion KeyExp_inst(
        .clk(clk), 
        .reset_n(reset_n),
        .Rcon_in(dynamic_rcon),     
        .IN_valid(round_trigger),
        .key(current_key),
        .OUT_valid(key_out_valid),
        .RoundKey(combinational_round_key), // <--- Feeds instant math datapath
        .NextKeyReg(next_key_out)           // <--- Feeds clocked FSM register
    );

    Round Round_inst(
        .clk(clk), 
        .reset_n(reset_n),
        .IN_valid(round_trigger),
        .IN_state(current_data),
        .RoundKey(combinational_round_key), // <--- Receives instant math key
        .OUT_valid(round_out_valid),
        .OUT_state(round_out_data)
    );

    LastRound LastRound_inst(
        .clk(clk), 
        .reset_n(reset_n),
        .IN_valid(round_trigger),
        .IN_state(current_data),
        .RoundKey(combinational_round_key), // <--- Receives instant math key
        .OUT_valid(last_round_out_valid),
        .OUT_state(last_round_out_data)
    );

    // --------------------------------------------------------
    // FSM Sequential Logic 
    // --------------------------------------------------------
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            current_state <= IDLE;
            round_cnt     <= 4'd0;
            current_data  <= 128'b0;
            current_key   <= 128'b0;
            round_trigger <= 1'b0;
            OUT_valid     <= 1'b0;
            OUT_state     <= 128'b0;
        end else begin
            case (current_state)
                IDLE: begin
                    OUT_valid <= 1'b0;
                    if (IN_valid) begin
                        current_data  <= IN_state ^ key; 
                        current_key   <= key;
                        round_cnt     <= 4'd1;         
                        round_trigger <= 1'b1;         
                        current_state <= ROUNDS_1_9;
                    end
                end

                ROUNDS_1_9: begin
                    round_trigger <= 1'b0; 
                    
                    if (round_out_valid) begin
                        current_data <= round_out_data;
                        current_key  <= next_key_out; // Safely grabs the latched FSM key
                        round_cnt    <= round_cnt + 1;
                        
                        if (round_cnt == 4'd9) begin
                            current_state <= ROUND_10; 
                        end
                        round_trigger <= 1'b1; 
                    end
                end

                ROUND_10: begin
                    round_trigger <= 1'b0;
                    
                    if (last_round_out_valid) begin
                        OUT_valid <= 1'b1;
                        OUT_state <= last_round_out_data;
                        current_state <= IDLE; 
                    end
                end
                
                default: current_state <= IDLE;
            endcase
        end
    end

endmodule
