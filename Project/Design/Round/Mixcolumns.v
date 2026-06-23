module MixColumns (
    input wire [127:0] IN_state,
    output reg [127:0] OUT_state
);

    // Only MultiplyByTwo (xtime) is needed now!
    function [7:0] MultiplyByTwo(input [7:0] x);
        begin 
            if(x[7] == 1) MultiplyByTwo = ((x << 1) ^ 8'h1b);
            else MultiplyByTwo = x << 1; 
        end     
    endfunction

    integer i, j;

    reg [7:0] S[0:3][0:3];
    reg [7:0] S_new[0:3][0:3];
    
    // Intermediate variables for mathematical optimization
    reg [7:0] T, U, V, W, X;

    always @(*) begin
        // 1. Map 128-bit vector to 4x4 column-major matrix
        for (i = 0; i < 4; i = i+1) begin
            for (j = 0; j < 4; j = j+1) begin
                S[i][j] = IN_state[(8*(3-i)+32*(3-j)+7) -: 8];
            end
        end
        
        // 2. Algebraically Optimized Matrix Multiplication
        for (j = 0; j < 4; j = j+1) begin
            // Calculate the shared terms for this column (The "Magic Base")
            T = S[0][j] ^ S[1][j] ^ S[2][j] ^ S[3][j];
            
            // Calculate adjacent XORs
            U = S[0][j] ^ S[1][j];
            V = S[1][j] ^ S[2][j];
            W = S[2][j] ^ S[3][j];
            X = S[3][j] ^ S[0][j];
            
            // Calculate the new column bytes using the shared terms
            S_new[0][j] = S[0][j] ^ T ^ MultiplyByTwo(U);
            S_new[1][j] = S[1][j] ^ T ^ MultiplyByTwo(V);
            S_new[2][j] = S[2][j] ^ T ^ MultiplyByTwo(W);
            S_new[3][j] = S[3][j] ^ T ^ MultiplyByTwo(X);
        end

        // 3. Flatten 4x4 matrix back to 128-bit vector
        OUT_state = {S_new[0][0], S_new[1][0], S_new[2][0], S_new[3][0], 
                     S_new[0][1], S_new[1][1], S_new[2][1], S_new[3][1], 
                     S_new[0][2], S_new[1][2], S_new[2][2], S_new[3][2], 
                     S_new[0][3], S_new[1][3], S_new[2][3], S_new[3][3]};

    end 

endmodule
