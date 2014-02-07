
module SPI_driver(clk, sck, mosi, miso, ssel, leds);
  input wire clk;
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
  
  SPI_slave spi_slave(clk, sck, mosi, miso, ssel, byteReceived, receivedData, dataNeeded, dataToSend);

  always @(posedge clk) begin
    if(byteReceived)
      receivedDataBuffer = receivedData;
  end
  
  always @(posedge clk) begin
    if(dataNeeded)
      dataToSend = receivedDataBuffer;
  end
  
  assign leds = receivedDataBuffer;
  
endmodule