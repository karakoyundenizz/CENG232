`timescale 1ns / 1ps
module lab3_2(
    input [4:0] money,
    input CLK,
    input [1:0] selectedArea,
    input plugAvailability,
    output reg [5:0] moneyLeft,
    output reg [5:0] seatLeft,
    output reg seatUnavailable,
    output reg insufficientFund,
    output reg notExactFund,
    output reg invalidPlugSeat,
    output reg plugSeatUnavailable,
    output reg seatReady
);

// Define codes for different seating areas
parameter Area_Loud = 2'b00, Area_Quiet = 2'b01, Area_Individual = 2'b11;

// Define fees for each seating area
parameter Fee_Loud = 10, Fee_Quiet = 20, Fee_Individual = 30;

// Define available seats for each area
reg [4:0] Seats_Loud = 15;
reg [4:0] Seats_Quiet_WithPlug = 10;
reg [4:0] Seats_Quiet_WithoutPlug = 15;
reg [4:0] Seats_Individual = 20;

initial begin
    moneyLeft <= money;
    notExactFund <= 0;
    plugSeatUnavailable <= 0;
    seatReady <= 0;
    seatUnavailable <= 0;
    insufficientFund <= 0;
    invalidPlugSeat <= 0;
    seatReady <= 0;
end

always @(posedge CLK) begin
    moneyLeft <= money;
    notExactFund <= 0;
    plugSeatUnavailable <= 0;
    seatReady <= 0;
    seatUnavailable <= 0;
    insufficientFund <= 0;
    invalidPlugSeat <= 0;
    seatReady <= 0;
    
    
    // Process for Loud Area
    if (selectedArea == Area_Loud) begin
        if (Seats_Loud > 0) begin
            if (plugAvailability == 1'b0) begin
                if (money >= Fee_Loud) begin
                    seatReady <= 1;
                    Seats_Loud = Seats_Loud - 1;
                    moneyLeft <= money - Fee_Loud;
                    seatLeft <= Seats_Loud;
                end
                else begin
                    insufficientFund <= 1;
                    seatLeft <= Seats_Loud;
                end
            end
            else begin
                invalidPlugSeat <= 1;
                seatLeft <= Seats_Loud;
            end
        end
        else begin
            seatUnavailable <= 1;
            seatLeft <= Seats_Loud;
        end
    end

    // Process for Quiet Area
    else if (selectedArea == Area_Quiet) begin
        // Seats with plug
        if (plugAvailability == 1'b1) begin
            if (Seats_Quiet_WithPlug > 0 && money >= Fee_Quiet) begin
                moneyLeft <= money - Fee_Quiet;
                seatReady <= 1;
                Seats_Quiet_WithPlug = Seats_Quiet_WithPlug - 1;
                seatLeft <= Seats_Quiet_WithPlug;
            end
            else if (Seats_Quiet_WithoutPlug > 0) begin
                plugSeatUnavailable <= 1;
                seatLeft <= Seats_Quiet_WithPlug;
            end
            else begin
                seatUnavailable <= 1;
                seatLeft <= Seats_Quiet_WithPlug;
            end
        end
        // Seats without plug
        else if (plugAvailability == 1'b0) begin
            if (Seats_Quiet_WithoutPlug > 0 && money >= Fee_Quiet) begin
                moneyLeft <= money - Fee_Quiet;
                Seats_Quiet_WithoutPlug = Seats_Quiet_WithoutPlug - 1;
                seatReady <= 1;
                seatLeft <= Seats_Quiet_WithoutPlug;
            end
            else begin
                insufficientFund <= 1;
                seatLeft <= Seats_Quiet_WithoutPlug;
            end
        end
    end

    // Process for Individual Area
    else if (selectedArea == Area_Individual) begin
        if (Seats_Individual > 0) begin
            if (money == Fee_Individual) begin
                seatReady <= 1;
                Seats_Individual = Seats_Individual - 1;
                moneyLeft <= money - Fee_Individual;
                seatLeft <= Seats_Individual;
            end
            else begin
                notExactFund <= 1;
                seatLeft <= Seats_Individual;
            end
        end
        else begin
            seatUnavailable <= 1;
            seatLeft <= Seats_Individual;
        end
    end
end

endmodule
