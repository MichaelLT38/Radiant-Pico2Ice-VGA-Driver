
module test_hvsync_top(CLK, reset, hsync, vsync, rgb);

  input CLK;
  input reset;
  output hsync, vsync;
  output [11:0] rgb;
  wire display_on;
  wire [9:0] hpos;
  wire [9:0] vpos; 
  
	
	
  
  wire clk;
  HSOSC
#(
  .CLKHF_DIV ()
) myosc (
  .CLKHFPU (1'b1),  // I
  .CLKHFEN (1'b1),  // I
  .CLKHF   (clk)   // O
);



  wire my_clk;
  my_pll_79to25 my_pll_inst (
    .ref_clk_i (clk),
    .rst_n_i (1'b1),
    .outcore_o (),
    .outglobal_o (my_clk)
  );
  
  assign clk_chk = my_clk;

  hvsync_generator hvsync_gen(
    .clk(my_clk),  // CLK for TB, my_clk
    .reset(1'b0),
    .hsync(hsync),
    .vsync(vsync),
    .display_on(display_on),
    .hpos(hpos),
    .vpos(vpos)
  );

  wire r = display_on && (((hpos&7)==0) || ((vpos&7)==0));
  wire g = display_on && vpos[4];
  wire b = display_on && hpos[4];
  assign rgb = {b,b,b,b,g,g,g,g,r,r,r,r};

endmodule