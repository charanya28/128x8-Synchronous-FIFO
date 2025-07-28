// Code your design here
module sync_fifo (input clk, rst_, wrtEn,  rdEn,  
                  
                  input [7:0] wrtData,
                  output full, empty,
                  output reg [7:0] rdData);
  
  reg [7:0] wrtPntr, rdPntr;
  reg [7:0] fifo_mem [127:0]; 
  assign full = {~wrtPntr[7], wrtPntr[6:0]} == {rdPntr[7:0]};
  assign empty = wrtPntr[7:0] == rdPntr[7:0];
  
  always @ (posedge clk or negedge rst_) begin 
    if (!rst_) begin 
      wrtPntr <= 8'b0; 
      end 
    else if (wrtEn && !full) begin  
      fifo_mem[wrtPntr[6:0]] <= wrtData; 
      wrtPntr <= wrtPntr + 1;
    end 
  end 
  
  always @ (posedge clk or negedge rst_) begin 
    if (!rst_) begin 
      rdPntr <= 8'b0; 
      rdData <= 8'b0; 
    end
    else if (rdEn && !empty) begin
      rdData <= fifo_mem[rdPntr[6:0]]; 
      rdPntr <= rdPntr + 1; 
    end
  end 
endmodule

