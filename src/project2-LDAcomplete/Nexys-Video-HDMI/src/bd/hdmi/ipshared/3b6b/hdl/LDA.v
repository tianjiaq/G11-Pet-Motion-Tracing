`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/20/2018 04:54:46 PM
// Design Name: 
// Module Name: LDA
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module LDA(clk, reset, start,plot,LST,LSC,Sxy,LI,LE,reset_xy,SER,Ey,Ex,Sel_p,steep,x_gt,loop,y_step,error,Sel_y,done,error_en,updated,ps, ns,swap);
  input clk,reset,start,steep,x_gt,error,loop, y_step;
  
  output plot,LST,LSC,LI,LE,reset_xy,Ex,Ey,done,error_en;
  output reg Sel_y, Sel_p, Sxy, swap;
  output reg [1:0] SER;
  input updated;
  
  localparam [4:0] s0=5'd0, s1=5'd1, s2=5'd2, s3=5'd3, s4=5'd4, s5=5'd5,
                   s6=5'd6, s7=5'd7, s8=5'd8, s9=5'd9, s10=5'd10, s11=5'd11,
						 s12=5'd12, s13=5'd13, s14=5'd14,s15=5'd15;
  
  output reg [4:0] ps,ns;
  
  always@(*)
    begin
	  case(ps)
	    s0: if(start) ns <= s1;
		     else ns <= s0;
		 s1: ns <= s2;
		 s2: if(steep) ns <= s3;
		     else ns <= s4;
		 //s14: ns<= s3;
		 s3: ns <= s4;
		 s4: ns <= s5;
		 //s14: ns <= s5;
		 s5: if(x_gt) ns <= s6;
		     else ns <= s7;
		 //s15: ns <= s6;
		 s6: ns <= s7;
		 s7: ns <= s8;
		 s8: ns <= s9;
		 s9: if(loop) ns <= s10;
		     else ns <= s11;
		 s10: if(error) ns <= s12;
		      else ns <= s13;
		 s11: if(updated) ns <= s0;
		      else ns<=s11;
		 s12: ns <= s13;
		 s13: ns <= s9;
	    default: ns <= 5'bxxxx;
	  endcase 
	 end
	
	/*reg [31:0] old_x0=0;
	reg [31:0] old_x1=0;
	reg [31:0] old_y0=0;
	reg [31:0] old_y1=0;
	
	always@(posedge clk) begin
	   old_x0<=x0;
	   old_x1<=x1;
	   old_y0<=y0;
	   old_y1<=y1;
	end*/
	
	 always@(posedge clk, negedge reset)
    begin
	   if(~reset) ps <= s0;
		else ps <= ns;
	 end
	 
	 always@(posedge clk)
	 begin
	   if(ps==s2 && steep==1) begin
		  Sxy = 0;
          //swap = 1;
		  end
		else if(ps==s5 && x_gt==1) begin
		  Sxy = 1;
		  //swap = 1;
		end
		else begin
		  Sxy = Sxy;
		  //swap = 0;
        end		  
	 end
	 
	 always@(posedge clk)
	 begin
	   if(ps==s8)
		  SER = 2'b00;
		else if(ps==s9)
		  SER = 2'b10;
		else if(ps==s12)
		  SER = 2'b01;
		else
		  SER = SER;
	 end
	 
	 always@(posedge clk)
	 begin
	   if(ps==s8 && y_step==1)
		  Sel_y=0;
		else if(ps==s8 && y_step==0)
		  Sel_y=1;
		else
		  Sel_y = Sel_y;
	 end
	 
	 always@(posedge clk)
	 begin
	   if(steep==1 && ps==s9)
		  Sel_p = 1;
		else if (steep==0 && ps==s9)
		  Sel_p = 0;
		else
		  Sel_p = Sel_p;
	 end
	 
	 assign reset_xy = (ps==s0);
	 assign LST = (ps==s1);
	 assign LI = (ps==s3)|(ps==s6);
	 assign LSC = (ps==s4);
	 assign LE = (ps==s7);
	 assign plot = (ps==s10);
	 assign Ex = (ps==s13);
	 assign Ey = (ps==s12);
	 assign done = (ps==s11);
	 assign error_en = (ps==s8)|(ps==s9)|(ps==s12);

endmodule

module LDA_datapath(clk,LST,LSC,LI,LE,reset_xy,Ex,Ey,Sel_p,y_step,Sel_y,Sxy,SER,oldx0,oldy0,oldx1,oldy1,steep, x_gt, loop,plot_x, plot_y, error_sel, error_en,x0,x1,y0,y1,swap);
  input clk,LST,LSC,LI,LE,reset_xy,Ex,Ey,Sel_p,Sel_y, Sxy, error_en;
  input [1:0] SER;
  input [31:0] oldy0,oldy1;
  input [31:0] oldx0,oldx1;
  input swap;

  output steep, x_gt, loop, y_step, error_sel;
  output reg [31:0] plot_x;
  output reg [31:0] plot_y;
  output [31:0] x0,x1,y0,y1;
  
  wire [31:0] deltay,y;
  wire [31:0] x,deltax;
  wire signed [31:0] error;
  
  get_steep steep_fun(.x0(x0), .y0(y0), .x1(x1), .y1(y1), .clk(clk), .enable(LST), .steep(steep));
  
  x0_gt_x1 compare_x(.clk(clk), .en(LSC), .a(x0), .b(x1), .out(x_gt));
  
  xy_select xy_selection(.clk(clk), .LI(LI),.swap(swap), .reset(reset_xy), .sel_xy(Sxy), .oldx0(oldx0), .oldx1(oldx1),
                         .oldy0(oldy0), .oldy1(oldy1), .x0(x0), .x1(x1), .y0(y0), .y1(y1));
  
  delta_x delx(.clk(clk), .a(x1), .b(x0), .en(LE), .c(deltax));
  
  delta_y dely(.clk(clk), .a(y0), .b(y1), .en(LE), .c(deltay));
  
  error_select error_get(.clk(clk), .sel(SER), .x(deltax), .y(deltay), .error(error), .enable(error_en));
  
  x_add x_loop(.reset(LE), .enable(Ex), .clk(clk), .xold(x0), .x(x));
  
  get_y y_loop(.clk(clk), .reset(LE), .sel(Sel_y), .enable(Ey), .yold(y0), .y(y));
  
  x_compare x_comp(.a(x), .b(x1), .c(loop));
  
  y_compare y_comp(.a(y0), .b(y1), .c(y_step));
  
  always@(posedge clk) begin
        if(Sel_p) begin
            plot_x<=y;
            plot_y<=x;
        end
        else begin
            plot_x<=x;
            plot_y<=y;
        end
  end
  error_compare error_comp(.error(error), .out(error_sel));

endmodule


 module get_steep(x0,y0,x1,y1,clk,enable,steep);
  input [31:0] y0,y1;
  input [31:0] x0,x1;
  input clk,enable;
  output reg steep;
  
  reg [31:0] comp_y;
  reg [31:0] comp_x;
    
  always@(*)
  begin
    if(y0>y1)
	   comp_y = y0-y1;
	 else
	   comp_y = y1-y0;
  end
  
  always@(*)
  begin
    if(x0>x1)
	   comp_x = x0-x1;
	 else
	   comp_x = x1-x0;
  end
  
  always@(posedge clk)
  begin
    if(enable)
	   begin
		  if(comp_y > comp_x)
		    steep = 1;
		  else
		    steep = 0;
		end
	 else
	   steep = steep;
  end
	 
endmodule 

module x0_gt_x1(clk,en,a,b,out);
  input clk,en;
  input [31:0] a,b;
  output reg out;
  
  always@(posedge clk)
  begin
    if(en)
	   begin
		  if(a > b)
		    out = 1;
		  else 
		    out = 0;
		end
	 else
	   out = out;
  end

endmodule

module xy_select(clk,LI,swap,reset,sel_xy,oldx0,oldx1,oldy0,oldy1,x0,x1,y0,y1);
  input clk, LI, reset;
  input sel_xy,swap;
  input [31:0] oldy0,oldy1;
  input [31:0] oldx0,oldx1;
  
  output  reg [31:0] y0,y1;
  output  reg [31:0] x0,x1;
  
  //assign x0=newx0;
 //assign x1=newx1;
  //assign y0=newy0;
  //assign y1=newy1;
  
  reg [31:0] newy0,newy1;
  reg [31:0] newx0,newx1;
  
always@(*) begin
              if(!sel_xy) begin
                  newx0=y0;
                  newx1=y1;
                  newy0=x0;
                  newy1=x1;
              end
              else begin
                  newx0=x1;
                  newx1=x0;
                  newy0=y1;
                  newy1=y0;
              end
         end
always@(posedge clk) begin
    if(reset) begin
        x0 = oldx0;
        x1 = oldx1;
        y0 = oldy0;
        y1 = oldy1;
    end
    else if(LI) begin
        x0 = newx0;
        x1 = newx1;
        y0 = newy0;
        y1 = newy1;
    end    
    else begin
        x0 = x0;
        x1 = x1;
        y0 = y0;
        y1 = y1;
    end
end
  /*always@(posedge clk)
  begin
    if(reset)
	   begin
		  x0 = oldx0;
		  y0 = oldy0;
		  x1 = oldx1;
		  y1 = oldy1;
		end
	 else if(LI)
	   begin
		  x0 = newx0;
		  y0 = newy0;
		  x1 = newx1;
		  y1 = newy1;
		end
	 else
	   x0 = x0;
		y0 = y0;
		x1 = x1;
		y1 = y1;
  end*/

endmodule

module delta_x(clk,a,b,en,c);
  input [31:0] a,b;
  input clk;
  input en;
  output reg [31:0] c;
  
  always@(posedge clk)
    if(en)
	   c = a-b;
	 else
	   c = c;
endmodule

module delta_y(clk,a,b,en,c);
  input[31:0] a,b;
  input clk;
  input en;
  output reg [31:0] c;
  
  always@(posedge clk)
  begin
    if(en)
	 begin
	   if(b>a)
		  c = b-a;
		else
	     c = a-b;	
	 end
	 else
	   c = c;
  end
endmodule

module error_select(clk, enable, sel, x,y, error);
  input [1:0] sel;
  input clk, enable;
  input [31:0] y;
  input [31:0] x;
  output reg signed [31:0] error;
  
  reg signed [31:0] first, second, third;
  
  always@(*)
  begin
    first = -(x >> 1);
	 second = error - x;
	 third = error + y;
  end
  
  always@(posedge clk)
  begin
    if(enable)
	 begin
	   if(sel==2'b00) error = first;
		else if(sel==2'b01) error = second;
		else if (sel==2'b10) error = third;
	 end
	 else
	   error=error;
  end
  
  //error_mux error_sel(.clken(enable), .clock(clk), .data0x(first), .data1x(second), .data2x(third), .sel(sel), .result(error));
  //xy_mux error_sel(first,second,third,sel,error);
  
endmodule

module x_add(reset, enable, clk, xold, x);
  input reset, enable, clk;
  input [31:0] xold;
  output reg [31:0] x;
  
  always@(posedge clk)
  begin
    if(reset)
	   x = xold;
	 else if(enable)
	   x = x+1;
	 else
	   x = x;
  end

endmodule

module get_y(clk,reset,sel, enable, yold, y);
  input reset,enable,sel,clk;
  input [31:0] yold;
  output reg [31:0] y;
  
  reg signed [31:0] y_step;
  
  always@(*)
  begin
    if(sel)
	   y_step = -1;
	 else
	   y_step = 1;
  end
  
  always@(posedge clk)
  begin
    if(reset)
	   y = yold;
	 else if(enable)
	   y = y+y_step;
	 else
	   y = y;
  end
  
  
endmodule

module x_compare(a,b,c);
  input [31:0] a,b;
  output reg c;
  
  always@(*)
  begin
    if(a <= b)
	   c = 1;
	 else
	   c = 0;
  end
endmodule

module y_compare(a,b,c);
  input [31:0] a,b;
  output reg c;
  
  always@(*)
  begin
    if(a < b)
	   c = 1;
	 else
	   c = 0;
  end
endmodule

module error_compare(error,out);
  input signed [31:0] error;
  output reg out;
  
  always@(*)
  begin
    if(error > 0)
	   out = 1;
	 else
	   out = 0;
  end
  
endmodule







module drawlines(
			clk,
			reset,
			start,
			y0,
			y1,
			x0,
			x1,
			plot,
			done_plot,
			plot_x,
			plot_y,
			updated,
			steep,
			Sel_p,
			loop,
			x_gt,
			Sxy,
			y_step,
			Sel_y,
			newx0,
			newx1,
			newy0,
			newy1,
			ns,
			ps,
			swap,R0, L0, LN, LST,LSC,LI,LE,reset_xy,Ey,Ex,error , error_en, SER
			);
	
	
	input clk,reset,start;
   input [31:0] y0,y1;
   input [31:0] x0,x1;
	
	output plot,done_plot; 
	output [31:0] plot_x;
    output [31:0] plot_y;
    input updated;
    output steep,Sel_p,loop,x_gt,Sxy,y_step,Sel_y;
    output [31:0] newy0,newy1;
    output [31:0] newx0,newx1;
    output [4:0]ns,ps;
   
	output R0, L0, LN, LST,LSC,LI,LE,reset_xy,Ey,Ex,error , error_en;
	output [1:0] SER;
	output swap;



	
	LDA LDA_FSMD(.clk(clk), .reset(reset), .start(start), .plot(plot), .LST(LST), .LSC(LSC), .Sxy(Sxy)
	             ,.LI(LI), .LE(LE), .reset_xy(reset_xy), .SER(SER),.Ey(Ey),.Ex(Ex), .Sel_p(Sel_p)
					 ,.steep(steep), .x_gt(x_gt), .loop(loop), .y_step(y_step), .error(error), .Sel_y(Sel_y), .done(done_plot)
					 ,.error_en(error_en),.updated(updated),.ps(ps),.ns(ns),.swap(swap));	 
		 
	LDA_datapath LDA_element(.clk(clk),.LST(LST),.LSC(LSC),.LI(LI),.LE(LE),.reset_xy(reset_xy),.Ex(Ex),.Ey(Ey),.Sel_p(Sel_p)
	                         ,.y_step(y_step),.Sel_y(Sel_y),.Sxy(Sxy),.SER(SER),.oldx0(x0),.oldy0(y0),.oldx1(x1),.oldy1(y1)
					             ,.steep(steep), .x_gt(x_gt), .loop(loop), .plot_x(plot_x), .plot_y(plot_y), .error_sel(error)
									 ,.error_en(error_en),.x0(newx0),.x1(newx1),.y0(newy0),.y1(newy1),.swap(swap));
									 
endmodule
