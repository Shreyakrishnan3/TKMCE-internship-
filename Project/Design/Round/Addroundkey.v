module AddRoundKey (
    input wire         clk, 
    input wire         reset_n,

    input wire         IN_valid,
    input wire [127:0] IN_state,
    input wire [127:0] RoundKey,

    output reg         OUT_valid,
    output reg [127:0] OUT_state
);

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin 
            OUT_valid <= 0;
            OUT_state <= 128'b0;
        end else begin
            if (IN_valid) begin 
                OUT_valid <= 1;
                OUT_state <= IN_state ^ RoundKey;
            end else begin
                OUT_valid <= 0;
                OUT_state <= 128'b0;
            end 
        end
    end

endmodule
