// (c) Copyright 1995-2018 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:user:ObjectDetection:1.0
// IP Revision: 65

(* X_CORE_INFO = "ObjectDetection_v1_0,Vivado 2017.2" *)
(* CHECK_LICENSE_TYPE = "hdmi_ObjectDetection_0_0,ObjectDetection_v1_0,{}" *)
(* CORE_GENERATION_INFO = "hdmi_ObjectDetection_0_0,ObjectDetection_v1_0,{x_ipProduct=Vivado 2017.2,x_ipVendor=xilinx.com,x_ipLibrary=user,x_ipName=ObjectDetection,x_ipVersion=1.0,x_ipCoreRevision=65,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED,C_S00_AXI_DATA_WIDTH=32,C_S00_AXI_ADDR_WIDTH=6,C_S00_AXIS_TDATA_WIDTH=32,C_M00_AXIS_TDATA_WIDTH=32,C_M00_AXIS_START_COUNT=32}" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module hdmi_ObjectDetection_0_0 (
  w_addr,
  r_addr,
  d_out,
  d_in,
  w_en,
  w_addr1,
  r_addr1,
  d_out1,
  d_in1,
  w_en1,
  reg_x,
  reg_y,
  steep,
  Sel_p,
  loop,
  x_gt,
  Sxy,
  y_step,
  Sel_y,
  x_start,
  y_start,
  x_end,
  y_end,
  start,
  updated,
  newx0,
  newx1,
  newy0,
  newy1,
  done,
  psLDA,
  nsLDA,
  swap,
  R0,
  L0,
  LN,
  LST,
  LSC,
  LI,
  LE,
  reset_xy,
  Ey,
  Ex,
  error,
  error_en,
  SER,
  x_min,
  y_min,
  x_max,
  y_max,
  x_min_f,
  x_max_f,
  y_min_f,
  y_max_f,
  detect_count,
  x,
  y,
  eol_1,
  sof_o,
  sof_out,
  ns,
  s,
  esf_ps,
  esf_ns,
  sof_ps,
  sof_ns,
  xy_ready,
  data_out,
  mode,
  is_match,
  eol_o,
  s00_axi_awaddr,
  s00_axi_awprot,
  s00_axi_awvalid,
  s00_axi_awready,
  s00_axi_wdata,
  s00_axi_wstrb,
  s00_axi_wvalid,
  s00_axi_wready,
  s00_axi_bresp,
  s00_axi_bvalid,
  s00_axi_bready,
  s00_axi_araddr,
  s00_axi_arprot,
  s00_axi_arvalid,
  s00_axi_arready,
  s00_axi_rdata,
  s00_axi_rresp,
  s00_axi_rvalid,
  s00_axi_rready,
  s00_axi_aclk,
  s00_axi_aresetn,
  s00_axis_tdata,
  s00_axis_tuser,
  s00_axis_tlast,
  s00_axis_tvalid,
  s00_axis_tready,
  s00_axis_aclk,
  s00_axis_aresetn,
  m00_axis_tdata,
  m00_axis_tuser,
  m00_axis_tlast,
  m00_axis_tvalid,
  m00_axis_tready,
  m00_axis_aclk,
  m00_axis_aresetn
);

output wire [18 : 0] w_addr;
output wire [18 : 0] r_addr;
output wire [23 : 0] d_out;
input wire [23 : 0] d_in;
output wire w_en;
output wire [18 : 0] w_addr1;
output wire [18 : 0] r_addr1;
output wire d_out1;
input wire d_in1;
output wire w_en1;
output wire [31 : 0] reg_x;
output wire [31 : 0] reg_y;
output wire steep;
output wire Sel_p;
output wire loop;
output wire x_gt;
output wire Sxy;
output wire y_step;
output wire Sel_y;
output wire [31 : 0] x_start;
output wire [31 : 0] y_start;
output wire [31 : 0] x_end;
output wire [31 : 0] y_end;
output wire start;
output wire updated;
output wire [31 : 0] newx0;
output wire [31 : 0] newx1;
output wire [31 : 0] newy0;
output wire [31 : 0] newy1;
output wire done;
output wire [4 : 0] psLDA;
output wire [4 : 0] nsLDA;
output wire swap;
output wire R0;
output wire L0;
output wire LN;
output wire LST;
output wire LSC;
output wire LI;
output wire LE;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 reset_xy RST" *)
output wire reset_xy;
output wire Ey;
output wire Ex;
output wire error;
output wire error_en;
output wire [1 : 0] SER;
output wire [31 : 0] x_min;
output wire [31 : 0] y_min;
output wire [31 : 0] x_max;
output wire [31 : 0] y_max;
output wire [31 : 0] x_min_f;
output wire [31 : 0] x_max_f;
output wire [31 : 0] y_min_f;
output wire [31 : 0] y_max_f;
output wire [5 : 0] detect_count;
output wire [31 : 0] x;
output wire [31 : 0] y;
output wire eol_1;
output wire sof_o;
output wire sof_out;
output wire [7 : 0] ns;
output wire [7 : 0] s;
output wire [2 : 0] esf_ps;
output wire [2 : 0] esf_ns;
output wire [2 : 0] sof_ps;
output wire [2 : 0] sof_ns;
output wire xy_ready;
output wire [23 : 0] data_out;
output wire [1 : 0] mode;
output wire is_match;
output wire eol_o;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWADDR" *)
input wire [5 : 0] s00_axi_awaddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWPROT" *)
input wire [2 : 0] s00_axi_awprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWVALID" *)
input wire s00_axi_awvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI AWREADY" *)
output wire s00_axi_awready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI WDATA" *)
input wire [31 : 0] s00_axi_wdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI WSTRB" *)
input wire [3 : 0] s00_axi_wstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI WVALID" *)
input wire s00_axi_wvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI WREADY" *)
output wire s00_axi_wready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI BRESP" *)
output wire [1 : 0] s00_axi_bresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI BVALID" *)
output wire s00_axi_bvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI BREADY" *)
input wire s00_axi_bready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARADDR" *)
input wire [5 : 0] s00_axi_araddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARPROT" *)
input wire [2 : 0] s00_axi_arprot;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARVALID" *)
input wire s00_axi_arvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI ARREADY" *)
output wire s00_axi_arready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RDATA" *)
output wire [31 : 0] s00_axi_rdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RRESP" *)
output wire [1 : 0] s00_axi_rresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RVALID" *)
output wire s00_axi_rvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 S00_AXI RREADY" *)
input wire s00_axi_rready;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 S00_AXI_CLK CLK, xilinx.com:signal:clock:1.0 s00_axi_aclk CLK" *)
input wire s00_axi_aclk;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 S00_AXI_RST RST, xilinx.com:signal:reset:1.0 s00_axi_aresetn RST" *)
input wire s00_axi_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S00_AXIS TDATA" *)
input wire [23 : 0] s00_axis_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S00_AXIS TUSER" *)
input wire s00_axis_tuser;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S00_AXIS TLAST" *)
input wire s00_axis_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S00_AXIS TVALID" *)
input wire s00_axis_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 S00_AXIS TREADY" *)
output wire s00_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 S00_AXIS_CLK CLK, xilinx.com:signal:clock:1.0 s00_axis_aclk CLK" *)
input wire s00_axis_aclk;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 S00_AXIS_RST RST, xilinx.com:signal:reset:1.0 s00_axis_aresetn RST" *)
input wire s00_axis_aresetn;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS TDATA" *)
output wire [23 : 0] m00_axis_tdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS TUSER" *)
output wire m00_axis_tuser;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS TLAST" *)
output wire m00_axis_tlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS TVALID" *)
output wire m00_axis_tvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 M00_AXIS TREADY" *)
input wire m00_axis_tready;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 M00_AXIS_CLK CLK, xilinx.com:signal:clock:1.0 m00_axis_aclk CLK" *)
input wire m00_axis_aclk;
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 M00_AXIS_RST RST, xilinx.com:signal:reset:1.0 m00_axis_aresetn RST" *)
input wire m00_axis_aresetn;

  ObjectDetection_v1_0 #(
    .C_S00_AXI_DATA_WIDTH(32),  // Width of S_AXI data bus
    .C_S00_AXI_ADDR_WIDTH(6),  // Width of S_AXI address bus
    .C_S00_AXIS_TDATA_WIDTH(32),  // AXI4Stream sink: Data Width
    .C_M00_AXIS_TDATA_WIDTH(32),  // Width of S_AXIS address bus. The slave accepts the read and write addresses of width C_M_AXIS_TDATA_WIDTH.
    .C_M00_AXIS_START_COUNT(32)  // Start count is the numeber of clock cycles the master will wait before initiating/issuing any transaction.
  ) inst (
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
    .error(error),
    .error_en(error_en),
    .SER(SER),
    .x_min(x_min),
    .y_min(y_min),
    .x_max(x_max),
    .y_max(y_max),
    .x_min_f(x_min_f),
    .x_max_f(x_max_f),
    .y_min_f(y_min_f),
    .y_max_f(y_max_f),
    .detect_count(detect_count),
    .x(x),
    .y(y),
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
    .eol_o(eol_o),
    .s00_axi_awaddr(s00_axi_awaddr),
    .s00_axi_awprot(s00_axi_awprot),
    .s00_axi_awvalid(s00_axi_awvalid),
    .s00_axi_awready(s00_axi_awready),
    .s00_axi_wdata(s00_axi_wdata),
    .s00_axi_wstrb(s00_axi_wstrb),
    .s00_axi_wvalid(s00_axi_wvalid),
    .s00_axi_wready(s00_axi_wready),
    .s00_axi_bresp(s00_axi_bresp),
    .s00_axi_bvalid(s00_axi_bvalid),
    .s00_axi_bready(s00_axi_bready),
    .s00_axi_araddr(s00_axi_araddr),
    .s00_axi_arprot(s00_axi_arprot),
    .s00_axi_arvalid(s00_axi_arvalid),
    .s00_axi_arready(s00_axi_arready),
    .s00_axi_rdata(s00_axi_rdata),
    .s00_axi_rresp(s00_axi_rresp),
    .s00_axi_rvalid(s00_axi_rvalid),
    .s00_axi_rready(s00_axi_rready),
    .s00_axi_aclk(s00_axi_aclk),
    .s00_axi_aresetn(s00_axi_aresetn),
    .s00_axis_tdata(s00_axis_tdata),
    .s00_axis_tuser(s00_axis_tuser),
    .s00_axis_tlast(s00_axis_tlast),
    .s00_axis_tvalid(s00_axis_tvalid),
    .s00_axis_tready(s00_axis_tready),
    .s00_axis_aclk(s00_axis_aclk),
    .s00_axis_aresetn(s00_axis_aresetn),
    .m00_axis_tdata(m00_axis_tdata),
    .m00_axis_tuser(m00_axis_tuser),
    .m00_axis_tlast(m00_axis_tlast),
    .m00_axis_tvalid(m00_axis_tvalid),
    .m00_axis_tready(m00_axis_tready),
    .m00_axis_aclk(m00_axis_aclk),
    .m00_axis_aresetn(m00_axis_aresetn)
  );
endmodule
