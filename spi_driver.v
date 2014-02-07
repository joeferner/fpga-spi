`timescale 1ns / 1ps

module SPI_driver(CLK_3_33_MHZ, sck, mosi, miso, ssel, leds);
  input wire CLK_3_33_MHZ;
  input wire sck;
  input wire mosi;
  output wire miso;
  input wire ssel;
  output wire[7:0] leds;
  
  wire byteReceived;
  wire[7:0] receivedData;
  wire dataNeeded;
  reg[7:0] dataToSend;
  reg[7:0] receivedDataBuffer;
  
  SPI_slave spi_slave(CLK_3_33_MHZ, sck, mosi, miso, ssel, byteReceived, receivedData, dataNeeded, dataToSend);

  always @(posedge CLK_3_33_MHZ) begin
    if(byteReceived)
      receivedDataBuffer <= receivedData;
  end
  
  always @(posedge CLK_3_33_MHZ) begin
    if(dataNeeded)
      dataToSend <= receivedDataBuffer;
  end
  
  assign leds = receivedDataBuffer;
    
endmodule