--Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2017.2 (win64) Build 1909853 Thu Jun 15 18:39:09 MDT 2017
--Date        : Mon Mar 26 12:38:13 2018
--Host        : Tian running 64-bit major release  (build 9200)
--Command     : generate_target hdmi_wrapper.bd
--Design      : hdmi_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity hdmi_wrapper is
  port (
    DDR3_addr : out STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR3_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR3_cas_n : out STD_LOGIC;
    DDR3_ck_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_ck_p : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_dm : out STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR3_dq : inout STD_LOGIC_VECTOR ( 15 downto 0 );
    DDR3_dqs_n : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR3_dqs_p : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR3_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_ras_n : out STD_LOGIC;
    DDR3_reset_n : out STD_LOGIC;
    DDR3_we_n : out STD_LOGIC;
    TMDS_IN_clk_n : in STD_LOGIC;
    TMDS_IN_clk_p : in STD_LOGIC;
    TMDS_IN_data_n : in STD_LOGIC_VECTOR ( 2 downto 0 );
    TMDS_IN_data_p : in STD_LOGIC_VECTOR ( 2 downto 0 );
    TMDS_OUT_clk_n : out STD_LOGIC;
    TMDS_OUT_clk_p : out STD_LOGIC;
    TMDS_OUT_data_n : out STD_LOGIC_VECTOR ( 2 downto 0 );
    TMDS_OUT_data_p : out STD_LOGIC_VECTOR ( 2 downto 0 );
    ddc_scl_io : inout STD_LOGIC;
    ddc_sda_io : inout STD_LOGIC;
    hdmi_hpd : out STD_LOGIC_VECTOR ( 0 to 0 );
    hdmi_rx_txen : out STD_LOGIC_VECTOR ( 0 to 0 );
    ja_pin10_io : inout STD_LOGIC;
    ja_pin1_io : inout STD_LOGIC;
    ja_pin2_io : inout STD_LOGIC;
    ja_pin3_io : inout STD_LOGIC;
    ja_pin4_io : inout STD_LOGIC;
    ja_pin7_io : inout STD_LOGIC;
    ja_pin8_io : inout STD_LOGIC;
    ja_pin9_io : inout STD_LOGIC;
    reset : in STD_LOGIC;
    sys_clk_i : in STD_LOGIC;
    usb_uart_rxd : in STD_LOGIC;
    usb_uart_txd : out STD_LOGIC
  );
end hdmi_wrapper;

architecture STRUCTURE of hdmi_wrapper is
  component hdmi is
  port (
    DDC_scl_i : in STD_LOGIC;
    DDC_scl_o : out STD_LOGIC;
    DDC_scl_t : out STD_LOGIC;
    DDC_sda_i : in STD_LOGIC;
    DDC_sda_o : out STD_LOGIC;
    DDC_sda_t : out STD_LOGIC;
    DDR3_dq : inout STD_LOGIC_VECTOR ( 15 downto 0 );
    DDR3_dqs_p : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR3_dqs_n : inout STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR3_addr : out STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR3_ba : out STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR3_ras_n : out STD_LOGIC;
    DDR3_cas_n : out STD_LOGIC;
    DDR3_we_n : out STD_LOGIC;
    DDR3_reset_n : out STD_LOGIC;
    DDR3_ck_p : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_ck_n : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_cke : out STD_LOGIC_VECTOR ( 0 to 0 );
    DDR3_dm : out STD_LOGIC_VECTOR ( 1 downto 0 );
    DDR3_odt : out STD_LOGIC_VECTOR ( 0 to 0 );
    TMDS_IN_clk_p : in STD_LOGIC;
    TMDS_IN_clk_n : in STD_LOGIC;
    TMDS_IN_data_p : in STD_LOGIC_VECTOR ( 2 downto 0 );
    TMDS_IN_data_n : in STD_LOGIC_VECTOR ( 2 downto 0 );
    TMDS_OUT_clk_p : out STD_LOGIC;
    TMDS_OUT_clk_n : out STD_LOGIC;
    TMDS_OUT_data_p : out STD_LOGIC_VECTOR ( 2 downto 0 );
    TMDS_OUT_data_n : out STD_LOGIC_VECTOR ( 2 downto 0 );
    usb_uart_rxd : in STD_LOGIC;
    usb_uart_txd : out STD_LOGIC;
    ja_pin1_o : out STD_LOGIC;
    ja_pin7_i : in STD_LOGIC;
    ja_pin2_o : out STD_LOGIC;
    ja_pin8_i : in STD_LOGIC;
    ja_pin3_o : out STD_LOGIC;
    ja_pin9_i : in STD_LOGIC;
    ja_pin10_o : out STD_LOGIC;
    ja_pin4_o : out STD_LOGIC;
    ja_pin3_i : in STD_LOGIC;
    ja_pin4_i : in STD_LOGIC;
    ja_pin1_i : in STD_LOGIC;
    ja_pin2_i : in STD_LOGIC;
    ja_pin10_t : out STD_LOGIC;
    ja_pin8_t : out STD_LOGIC;
    ja_pin9_t : out STD_LOGIC;
    ja_pin4_t : out STD_LOGIC;
    ja_pin9_o : out STD_LOGIC;
    ja_pin10_i : in STD_LOGIC;
    ja_pin7_t : out STD_LOGIC;
    ja_pin1_t : out STD_LOGIC;
    ja_pin2_t : out STD_LOGIC;
    ja_pin7_o : out STD_LOGIC;
    ja_pin3_t : out STD_LOGIC;
    ja_pin8_o : out STD_LOGIC;
    hdmi_hpd : out STD_LOGIC_VECTOR ( 0 to 0 );
    reset : in STD_LOGIC;
    sys_clk_i : in STD_LOGIC;
    hdmi_rx_txen : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  end component hdmi;
  component IOBUF is
  port (
    I : in STD_LOGIC;
    O : out STD_LOGIC;
    T : in STD_LOGIC;
    IO : inout STD_LOGIC
  );
  end component IOBUF;
  signal ddc_scl_i : STD_LOGIC;
  signal ddc_scl_o : STD_LOGIC;
  signal ddc_scl_t : STD_LOGIC;
  signal ddc_sda_i : STD_LOGIC;
  signal ddc_sda_o : STD_LOGIC;
  signal ddc_sda_t : STD_LOGIC;
  signal ja_pin10_i : STD_LOGIC;
  signal ja_pin10_o : STD_LOGIC;
  signal ja_pin10_t : STD_LOGIC;
  signal ja_pin1_i : STD_LOGIC;
  signal ja_pin1_o : STD_LOGIC;
  signal ja_pin1_t : STD_LOGIC;
  signal ja_pin2_i : STD_LOGIC;
  signal ja_pin2_o : STD_LOGIC;
  signal ja_pin2_t : STD_LOGIC;
  signal ja_pin3_i : STD_LOGIC;
  signal ja_pin3_o : STD_LOGIC;
  signal ja_pin3_t : STD_LOGIC;
  signal ja_pin4_i : STD_LOGIC;
  signal ja_pin4_o : STD_LOGIC;
  signal ja_pin4_t : STD_LOGIC;
  signal ja_pin7_i : STD_LOGIC;
  signal ja_pin7_o : STD_LOGIC;
  signal ja_pin7_t : STD_LOGIC;
  signal ja_pin8_i : STD_LOGIC;
  signal ja_pin8_o : STD_LOGIC;
  signal ja_pin8_t : STD_LOGIC;
  signal ja_pin9_i : STD_LOGIC;
  signal ja_pin9_o : STD_LOGIC;
  signal ja_pin9_t : STD_LOGIC;
begin
ddc_scl_iobuf: component IOBUF
     port map (
      I => ddc_scl_o,
      IO => ddc_scl_io,
      O => ddc_scl_i,
      T => ddc_scl_t
    );
ddc_sda_iobuf: component IOBUF
     port map (
      I => ddc_sda_o,
      IO => ddc_sda_io,
      O => ddc_sda_i,
      T => ddc_sda_t
    );
hdmi_i: component hdmi
     port map (
      DDC_scl_i => ddc_scl_i,
      DDC_scl_o => ddc_scl_o,
      DDC_scl_t => ddc_scl_t,
      DDC_sda_i => ddc_sda_i,
      DDC_sda_o => ddc_sda_o,
      DDC_sda_t => ddc_sda_t,
      DDR3_addr(14 downto 0) => DDR3_addr(14 downto 0),
      DDR3_ba(2 downto 0) => DDR3_ba(2 downto 0),
      DDR3_cas_n => DDR3_cas_n,
      DDR3_ck_n(0) => DDR3_ck_n(0),
      DDR3_ck_p(0) => DDR3_ck_p(0),
      DDR3_cke(0) => DDR3_cke(0),
      DDR3_dm(1 downto 0) => DDR3_dm(1 downto 0),
      DDR3_dq(15 downto 0) => DDR3_dq(15 downto 0),
      DDR3_dqs_n(1 downto 0) => DDR3_dqs_n(1 downto 0),
      DDR3_dqs_p(1 downto 0) => DDR3_dqs_p(1 downto 0),
      DDR3_odt(0) => DDR3_odt(0),
      DDR3_ras_n => DDR3_ras_n,
      DDR3_reset_n => DDR3_reset_n,
      DDR3_we_n => DDR3_we_n,
      TMDS_IN_clk_n => TMDS_IN_clk_n,
      TMDS_IN_clk_p => TMDS_IN_clk_p,
      TMDS_IN_data_n(2 downto 0) => TMDS_IN_data_n(2 downto 0),
      TMDS_IN_data_p(2 downto 0) => TMDS_IN_data_p(2 downto 0),
      TMDS_OUT_clk_n => TMDS_OUT_clk_n,
      TMDS_OUT_clk_p => TMDS_OUT_clk_p,
      TMDS_OUT_data_n(2 downto 0) => TMDS_OUT_data_n(2 downto 0),
      TMDS_OUT_data_p(2 downto 0) => TMDS_OUT_data_p(2 downto 0),
      hdmi_hpd(0) => hdmi_hpd(0),
      hdmi_rx_txen(0) => hdmi_rx_txen(0),
      ja_pin10_i => ja_pin10_i,
      ja_pin10_o => ja_pin10_o,
      ja_pin10_t => ja_pin10_t,
      ja_pin1_i => ja_pin1_i,
      ja_pin1_o => ja_pin1_o,
      ja_pin1_t => ja_pin1_t,
      ja_pin2_i => ja_pin2_i,
      ja_pin2_o => ja_pin2_o,
      ja_pin2_t => ja_pin2_t,
      ja_pin3_i => ja_pin3_i,
      ja_pin3_o => ja_pin3_o,
      ja_pin3_t => ja_pin3_t,
      ja_pin4_i => ja_pin4_i,
      ja_pin4_o => ja_pin4_o,
      ja_pin4_t => ja_pin4_t,
      ja_pin7_i => ja_pin7_i,
      ja_pin7_o => ja_pin7_o,
      ja_pin7_t => ja_pin7_t,
      ja_pin8_i => ja_pin8_i,
      ja_pin8_o => ja_pin8_o,
      ja_pin8_t => ja_pin8_t,
      ja_pin9_i => ja_pin9_i,
      ja_pin9_o => ja_pin9_o,
      ja_pin9_t => ja_pin9_t,
      reset => reset,
      sys_clk_i => sys_clk_i,
      usb_uart_rxd => usb_uart_rxd,
      usb_uart_txd => usb_uart_txd
    );
ja_pin10_iobuf: component IOBUF
     port map (
      I => ja_pin10_o,
      IO => ja_pin10_io,
      O => ja_pin10_i,
      T => ja_pin10_t
    );
ja_pin1_iobuf: component IOBUF
     port map (
      I => ja_pin1_o,
      IO => ja_pin1_io,
      O => ja_pin1_i,
      T => ja_pin1_t
    );
ja_pin2_iobuf: component IOBUF
     port map (
      I => ja_pin2_o,
      IO => ja_pin2_io,
      O => ja_pin2_i,
      T => ja_pin2_t
    );
ja_pin3_iobuf: component IOBUF
     port map (
      I => ja_pin3_o,
      IO => ja_pin3_io,
      O => ja_pin3_i,
      T => ja_pin3_t
    );
ja_pin4_iobuf: component IOBUF
     port map (
      I => ja_pin4_o,
      IO => ja_pin4_io,
      O => ja_pin4_i,
      T => ja_pin4_t
    );
ja_pin7_iobuf: component IOBUF
     port map (
      I => ja_pin7_o,
      IO => ja_pin7_io,
      O => ja_pin7_i,
      T => ja_pin7_t
    );
ja_pin8_iobuf: component IOBUF
     port map (
      I => ja_pin8_o,
      IO => ja_pin8_io,
      O => ja_pin8_i,
      T => ja_pin8_t
    );
ja_pin9_iobuf: component IOBUF
     port map (
      I => ja_pin9_o,
      IO => ja_pin9_io,
      O => ja_pin9_i,
      T => ja_pin9_t
    );
end STRUCTURE;
