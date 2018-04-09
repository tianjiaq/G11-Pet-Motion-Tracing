
`timescale 1 ns / 1 ps

	module ObjectDetection_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 6,

		// Parameters of Axi Slave Bus Interface S00_AXIS
		parameter integer C_S00_AXIS_TDATA_WIDTH	= 32,

		// Parameters of Axi Master Bus Interface M00_AXIS
		parameter integer C_M00_AXIS_TDATA_WIDTH	= 32,
		parameter integer C_M00_AXIS_START_COUNT	= 32
	)
	(
		// Users to add ports here
        output wire [18:0] w_addr,
        output wire [18:0] r_addr,
        output wire [23:0] d_out,
        input wire [23:0] d_in,
        output wire w_en,
        
        output wire [18:0] w_addr1,
        output wire [18:0] r_addr1,
        output wire  d_out1,
        input wire  d_in1,
        output wire w_en1,
        output wire [31:0] reg_x,
        output wire [31:0] reg_y,
        output steep,
        output Sel_p,
        output loop,
        output x_gt,
        output Sxy,
        output y_step,
        output Sel_y,
        output wire [31:0]x_start,
        output wire [31:0]y_start,
        output wire [31:0]x_end,
        output wire [31:0]y_end,
        output start,
        output updated,
        output wire [31:0]newx0,
        output wire [31:0]newx1,
        output wire [31:0]newy0,
        output wire [31:0]newy1,
        output wire done,
        output wire [4:0] psLDA,
        output wire [4:0] nsLDA,
        output wire swap,
        output R0, 
        output L0, 
        output LN, 
        output LST,
        output LSC,
        output LI,
        output LE,
        output reset_xy,
        output Ey,
        output Ex,
        output error , 
        output error_en,
        output [1:0] SER,
        output wire [31:0] x_min,
        output wire [31:0] y_min,
        output wire [31:0] x_max,
        output wire [31:0] y_max,
        output wire [31:0]x_min_f,
        output wire [31:0]x_max_f,
        output wire [31:0]y_min_f,
        output wire [31:0]y_max_f,
        output wire [5:0] detect_count,                
        
                output wire [31:0] x,
                output wire [31:0] y,
                //output wire [18:0] counter,
                output wire eol_1,
                output wire sof_o,
                output wire sof_out,
                output wire [7:0]ns,
                output wire [7:0]s,
                output wire [2:0] esf_ps,
                output wire [2:0] esf_ns,
                output wire [2:0] sof_ps,
                output wire [2:0] sof_ns,
                output wire xy_ready,
                output wire [23:0] data_out,
                output wire [1:0] mode,
                output wire is_match,
                output wire eol_o,
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXI
		input wire  s00_axi_aclk,
		input wire  s00_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
		input wire [2 : 0] s00_axi_awprot,
		input wire  s00_axi_awvalid,
		output wire  s00_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
		input wire  s00_axi_wvalid,
		output wire  s00_axi_wready,
		output wire [1 : 0] s00_axi_bresp,
		output wire  s00_axi_bvalid,
		input wire  s00_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
		input wire [2 : 0] s00_axi_arprot,
		input wire  s00_axi_arvalid,
		output wire  s00_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
		output wire [1 : 0] s00_axi_rresp,
		output wire  s00_axi_rvalid,
		input wire  s00_axi_rready,

		// Ports of Axi Slave Bus Interface S00_AXIS
		input wire  s00_axis_aclk,
		input wire  s00_axis_aresetn,
		output wire  s00_axis_tready,
		input wire [24-1 : 0] s00_axis_tdata,
		input wire  s00_axis_tuser,
		input wire  s00_axis_tlast,
		input wire  s00_axis_tvalid,

		// Ports of Axi Master Bus Interface M00_AXIS
		input wire  m00_axis_aclk,
		input wire  m00_axis_aresetn,
		output wire  m00_axis_tvalid,
		output wire [24-1 : 0] m00_axis_tdata,
		output wire m00_axis_tuser,
		output wire  m00_axis_tlast,
		input wire  m00_axis_tready
		//output wire [23:0] data_pixel_out
	);
	
	assign m00_axis_tvalid=s00_axis_tvalid;
	//assign m00_axis_tdata=s00_axis_tdata;
	//assign m00_axis_tdata=d_in;
	assign m00_axis_tuser=s00_axis_tuser;
	assign m00_axis_tlast=s00_axis_tlast;
	assign s00_axis_tready=m00_axis_tready;
	assign eol_o = s00_axis_tlast;
	//wire [23:0]dumb;
	
// Instantiation of Axi Bus Interface S00_AXI
	ObjectDetection_v1_0_S00_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) ObjectDetection_v1_0_S00_AXI_inst (
	    .pixel_in(s00_axis_tdata),
	    .pixel_out(m00_axis_tdata),
	    .eol(s00_axis_tlast),
	    .sof(s00_axis_tuser),
	    .valid(s00_axis_tvalid),
	    .pixel_clk(s00_axis_aclk),
	    .w_addr(w_addr),
        .r_addr(r_addr),
        .d_out(d_out),
        .d_in(d_in),
        .w_en(w_en),
        .w_addr1(w_addr1),
        .r_addr1(r_addr1),
        .d_out1(d_out1),
        .d_in1(d_in1),
        .w_en1(w_en1),
        .reg_x(reg_x),
        .reg_y(reg_y),
        .steep(steep),
       .Sel_p(Sel_p),
       .loop(loop),
       .x_gt(x_gt),
       .Sxy(Sxy),
       .y_step(y_step),
       .Sel_y(Sel_y),
       .x_start(x_start),
       .y_start(y_start),
       .x_end(x_end),
       .y_end(y_end),
       .start(start),
       .updated(updated),
       .newx0(newx0),
       .newx1(newx1),
       .newy0(newy0),
       .newy1(newy1),
       .done(done),
       .psLDA(psLDA),
       .nsLDA(nsLDA),
       .swap(swap),
       .R0(R0), 
       .L0(L0), 
       .LN(LN), 
       .LST(LST),
       .LSC(LSC),
       .LI(LI),
       .LE(LE),
       .reset_xy(reset_xy),
       .Ey(Ey),
       .Ex(Ex),
       .error(error) , 
       .error_en(error_en),
       .SER(SER),
       .x_min(x_min),
       .y_min(y_min),
       .x_max(x_max),
       .y_max(y_max),
       .x(x),
       .y(y),
       //.counter(counter),
       .eol_1(eol_1),
       .sof_o(sof_o),
       .sof_out(sof_out),
       .ns(ns),
       .s(s),
       .esf_ps(esf_ps),
       .esf_ns(esf_ns),
       .sof_ps(sof_ps),
       .sof_ns(sof_ns),
       .xy_ready(xy_ready),
       .data_out(data_out),
       .mode(mode),
       .is_match(is_match),
       .x_min_f(x_min_f),
       .x_max_f(x_max_f),
       .y_min_f(y_min_f),
       .y_max_f(y_max_f),
       .detect_count(detect_count),
               
		.S_AXI_ACLK(s00_axi_aclk),
		.S_AXI_ARESETN(s00_axi_aresetn),
		.S_AXI_AWADDR(s00_axi_awaddr),
		.S_AXI_AWPROT(s00_axi_awprot),
		.S_AXI_AWVALID(s00_axi_awvalid),
		.S_AXI_AWREADY(s00_axi_awready),
		.S_AXI_WDATA(s00_axi_wdata),
		.S_AXI_WSTRB(s00_axi_wstrb),
		.S_AXI_WVALID(s00_axi_wvalid),
		.S_AXI_WREADY(s00_axi_wready),
		.S_AXI_BRESP(s00_axi_bresp),
		.S_AXI_BVALID(s00_axi_bvalid),
		.S_AXI_BREADY(s00_axi_bready),
		.S_AXI_ARADDR(s00_axi_araddr),
		.S_AXI_ARPROT(s00_axi_arprot),
		.S_AXI_ARVALID(s00_axi_arvalid),
		.S_AXI_ARREADY(s00_axi_arready),
		.S_AXI_RDATA(s00_axi_rdata),
		.S_AXI_RRESP(s00_axi_rresp),
		.S_AXI_RVALID(s00_axi_rvalid),
		.S_AXI_RREADY(s00_axi_rready)
	);

// Instantiation of Axi Bus Interface S00_AXIS
	/*ObjectDetection_v1_0_S00_AXIS # ( 
		.C_S_AXIS_TDATA_WIDTH(C_S00_AXIS_TDATA_WIDTH)
	) ObjectDetection_v1_0_S00_AXIS_inst (
		.S_AXIS_ACLK(s00_axis_aclk),
		.S_AXIS_ARESETN(s00_axis_aresetn),
		.S_AXIS_TREADY(s00_axis_tready),
		.S_AXIS_TDATA(s00_axis_tdata),
		.S_AXIS_TSTRB(s00_axis_tstrb),
		.S_AXIS_TLAST(s00_axis_tlast),
		.S_AXIS_TVALID(s00_axis_tvalid)
	);

// Instantiation of Axi Bus Interface M00_AXIS
	ObjectDetection_v1_0_M00_AXIS # ( 
		.C_M_AXIS_TDATA_WIDTH(C_M00_AXIS_TDATA_WIDTH),
		.C_M_START_COUNT(C_M00_AXIS_START_COUNT)
	) ObjectDetection_v1_0_M00_AXIS_inst (
		.M_AXIS_ACLK(m00_axis_aclk),
		.M_AXIS_ARESETN(m00_axis_aresetn),
		.M_AXIS_TVALID(m00_axis_tvalid),
		.M_AXIS_TDATA(m00_axis_tdata),
		.M_AXIS_TSTRB(m00_axis_tstrb),
		.M_AXIS_TLAST(m00_axis_tlast),
		.M_AXIS_TREADY(m00_axis_tready)
	);*/

	// Add user logic here

	// User logic ends

	endmodule
