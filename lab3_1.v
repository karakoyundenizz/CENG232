module ac_flip_flop (
    input A, C, clk,
    output reg Q
);


reg Qprev;
initial Q = 1;
// Always block to define the behavior of the flip-flop
always @(posedge clk) begin
    Qprev = Q;
    if (A == 0 && C == 0)
        Q <= 1;            // Set to 1
    else if (A == 0 && C == 1)
        Q <= ~Q;           // Complement
    else if (A == 1 && C == 0)
        Q <= Qprev;            // Reset to 0
    else if (A == 1 && C == 1)
        Q <= 1;            // Set to 1
end


endmodule

module ic1406 (
    input A0, A1, A2, clk,
    output Q0, Q1, Z
);


wire A_input_1, C_input_1, A_input_2, C_input_2;

assign A_input_1 = ~((A0 ^ A1) | ~A2);
assign C_input_1 = A0 & A1;


assign A_input_2 = A0 & A1;
assign C_input_2 = (~A0 | ~A1) & ~A2;


ac_flip_flop ff1 (.A(A_input_1), .C(C_input_1), .clk(clk), .Q(Q0));
ac_flip_flop ff2 (.A(A_input_2), .C(C_input_2), .clk(clk), .Q(Q1));


assign Z= Q0 ^ Q1;


endmodule