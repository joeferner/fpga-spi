`timescale 1ns / 1ps

module SPI_slave_tb;
  reg clk;
  reg sck;
  reg mosi;
  wire miso;
  reg ssel;
  wire byteReceived;
  wire[7:0] receivedData;
  reg[7:0] expectedData;
  
  SPI_slave spi_slave(clk, sck, mosi, miso, ssel, byteReceived, receivedData);
  
  initial
  begin
    sck = 1'b0;
    mosi = 1'b0;
    ssel = 1'b1;
  
    #10 ssel = 1'b0;

    expectedData = 8'b11111111;
    #10 mosi = 1'b1; #10 sck = 1'b0; #10 sck = 1'b1; // bit 0
    #10 mosi = 1'b1; #10 sck = 1'b0; #10 sck = 1'b1; // bit 1
    #10 mosi = 1'b1; #10 sck = 1'b0; #10 sck = 1'b1; // bit 2
    #10 mosi = 1'b1; #10 sck = 1'b0; #10 sck = 1'b1; // bit 3
    #10 mosi = 1'b1; #10 sck = 1'b0; #10 sck = 1'b1; // bit 4
    #10 mosi = 1'b1; #10 sck = 1'b0; #10 sck = 1'b1; // bit 5
    #10 mosi = 1'b1; #10 sck = 1'b0; #10 sck = 1'b1; // bit 6
    #10 mosi = 1'b1; #10 sck = 1'b0; #10 sck = 1'b1; // bit 7
    #10

    expectedData = 8'b00000000;
    #10 mosi = 1'b0; #10 sck = 1'b0; #10 sck = 1'b1; // bit 0
    #10 mosi = 1'b0; #10 sck = 1'b0; #10 sck = 1'b1; // bit 1
    #10 mosi = 1'b0; #10 sck = 1'b0; #10 sck = 1'b1; // bit 2
    #10 mosi = 1'b0; #10 sck = 1'b0; #10 sck = 1'b1; // bit 3
    #10 mosi = 1'b0; #10 sck = 1'b0; #10 sck = 1'b1; // bit 4
    #10 mosi = 1'b0; #10 sck = 1'b0; #10 sck = 1'b1; // bit 5
    #10 mosi = 1'b0; #10 sck = 1'b0; #10 sck = 1'b1; // bit 6
    #10 mosi = 1'b0; #10 sck = 1'b0; #10 sck = 1'b1; // bit 7
    
    #100 $finish;
  end

  always @(*) begin
    if(byteReceived == 1)
      $display("assertEquals(receivedData,%b,%b)", receivedData, expectedData);
  end
  
  always
  begin
    clk = 1'b0;
    forever
      #1 clk = ~clk; 
  end
endmodule
