// look in pins.pcf for all the pin names on the TinyFPGA BX board
module top (
    input CLK,    // 16MHz clock
    output LED,   // User/boot LED next to power LED
    output USBPU,  // USB pull-up resistor
    inout PIN_1,
    inout PIN_2,
    inout PIN_3,
    inout PIN_4,
    inout PIN_5,
    inout PIN_6,
    inout PIN_7,
    inout PIN_8,
    inout PIN_9,
    inout PIN_10,
    inout PIN_11,
    inout PIN_12,
    inout PIN_13,
    inout PIN_14,
    inout PIN_15,
    inout PIN_16,
    inout PIN_17,
    inout PIN_18,
    inout PIN_19
);
    // drive USB pull-up resistor to '0' to disable USB
    assign USBPU = 0;

    ////////
    // make a simple blink circuit
    ////////

    // keep track of time and location in blink_pattern
    reg [25:0] blink_counter;

    // pattern that will be flashed over the LED over time
    wire [31:0] blink_pattern = 32'b101010001110111011100010101;

    // increment the blink_counter every clock
    always @(posedge CLK) begin
        blink_counter <= blink_counter + 1;
    end

    // light up the LED according to the pattern
    assign LED = blink_pattern[blink_counter[25:21]];

    ts4231 #(16_000_000,8)sensors(
      .clk(CLK),
      .rst(1'b0),
      .D_io({PIN_1,PIN_2,PIN_3,PIN_4,PIN_5,PIN_6,PIN_7,PIN_8}),
      .E_io({PIN_9,PIN_10,PIN_11,PIN_12,PIN_13,PIN_14,PIN_15,PIN_16})
    );
endmodule
