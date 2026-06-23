module SubBytes (
    input wire         clk, 
    input wire         reset_n,

    input wire         IN_valid,
    input wire [127:0] IN_state,

    output reg         OUT_valid,
    output wire [127:0] OUT_state
);

    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin
            SBox SBox_inst(
                .clk(clk), 
                .reset(reset_n), 
                .valid_in(IN_valid), 
                .addr(IN_state[(127-i*8) -:8]), 
                .dout(OUT_state[(127-i*8) -:8])
            );
        end
    endgenerate

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            OUT_valid <= 0;
        end else begin
            if (IN_valid)   
                OUT_valid <= 1;
            else            
                OUT_valid <= 0;
        end
    end

endmodule
