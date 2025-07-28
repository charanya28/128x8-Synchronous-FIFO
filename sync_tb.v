// Code your testbench here
// or browse Examples
module sync_tb(); 
  reg clk = 0; 
  reg rst_, wrtEn, rdEn; 
  reg [7:0] wrtData; 
  wire full; 
  wire empty; 
  wire [7:0] rdData; 
  
  sync_fifo u1 (.clk(clk), 
                .rst_(rst_), 
                .wrtEn(wrtEn),
                .rdEn(rdEn),
                .wrtData(wrtData), 
                .full(full), 
                .empty(empty),
                .rdData(rdData));
  
  always 
    clk = #5 ~clk; 
  
  integer i; 
  integer j; 
  
  initial begin 
    $dumpfile("sync_fifo.vcd"); 
    $dumpvars(1, sync_tb);
    rst_ = 0; #10; 
    rst_ = 1; 
    wrtEn = 1;
    for (i = 0 ; i <= 127; i = i + 1) begin
      if (!full)
      #15 wrtData = i + 1;
    end
    wrtEn = 0; 
    for (j = 0; j <= 127; j = j + 1) begin
      if (!empty)
        #15 rdEn = 1; 
      else 
        rdEn = 0;
    end 
     /*reg [6:0] read_count = 0;

always @(posedge clk) begin
  if (rst_ && !empty && read_count < 128) begin
    rdEn <= 1;
    read_count <= read_count + 1;
  end else begin
    rdEn <= 0;
  end
end
 */
    $finish; 
  end 
  
endmodule 
