
`timescale 1 ns / 1 ps

	module ObjectDetection_v1_0_S00_AXI #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line

		// Width of S_AXI data bus
		parameter integer C_S_AXI_DATA_WIDTH	= 32,
		// Width of S_AXI address bus
		parameter integer C_S_AXI_ADDR_WIDTH	= 6
	)
	(
		// Users to add ports here
        input wire [23:0] pixel_in,
        input wire pixel_clk,
        input wire sof,
        input wire eol,
        input wire valid,
        output reg [23:0] pixel_out,
        output reg [18:0] w_addr,
        output reg [18:0] r_addr,
        output reg [23:0] d_out,
        input wire [23:0] d_in,
        output reg w_en,
        
        output reg [18:0] w_addr1,
        output reg [18:0] r_addr1,
        output reg  d_out1,
        input wire  d_in1,
        output reg w_en1,
        output reg [31:0] reg_x, 
        output reg [31:0] reg_y,
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
        output [1:0]SER,
        output reg [31:0] x_min,
        output reg [31:0] y_min,
        output reg [31:0] x_max,
        output reg [31:0] y_max,
        output reg [31:0] x,
        output reg [31:0] y,
        output reg eol_1,
        output sof_o,
        output reg sof_out,
        output reg [7:0]ns,
        output reg [7:0]s,
        output reg [2:0] esf_ps,
        output reg [2:0] esf_ns,
        output reg [2:0] sof_ps,
        output reg [2:0] sof_ns,
        output reg xy_ready,
        output wire [23:0] data_out,
        output reg [1:0] mode,
        output reg is_match,
        output reg [31:0]x_min_f,
        output reg [31:0]x_max_f,
        output reg [31:0]y_min_f,
        output reg [31:0]y_max_f,
        output reg [5:0] detect_count,
        
        
        
		// User ports ends
		// Do not modify the ports beyond this line

		// Global Clock Signal
		input wire  S_AXI_ACLK,
		// Global Reset Signal. This Signal is Active LOW
		input wire  S_AXI_ARESETN,
		// Write address (issued by master, acceped by Slave)
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR,
		// Write channel Protection type. This signal indicates the
    		// privilege and security level of the transaction, and whether
    		// the transaction is a data access or an instruction access.
		input wire [2 : 0] S_AXI_AWPROT,
		// Write address valid. This signal indicates that the master signaling
    		// valid write address and control information.
		input wire  S_AXI_AWVALID,
		// Write address ready. This signal indicates that the slave is ready
    		// to accept an address and associated control signals.
		output wire  S_AXI_AWREADY,
		// Write data (issued by master, acceped by Slave) 
		input wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA,
		// Write strobes. This signal indicates which byte lanes hold
    		// valid data. There is one write strobe bit for each eight
    		// bits of the write data bus.    
		input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,
		// Write valid. This signal indicates that valid write
    		// data and strobes are available.
		input wire  S_AXI_WVALID,
		// Write ready. This signal indicates that the slave
    		// can accept the write data.
		output wire  S_AXI_WREADY,
		// Write response. This signal indicates the status
    		// of the write transaction.
		output wire [1 : 0] S_AXI_BRESP,
		// Write response valid. This signal indicates that the channel
    		// is signaling a valid write response.
		output wire  S_AXI_BVALID,
		// Response ready. This signal indicates that the master
    		// can accept a write response.
		input wire  S_AXI_BREADY,
		// Read address (issued by master, acceped by Slave)
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR,
		// Protection type. This signal indicates the privilege
    		// and security level of the transaction, and whether the
    		// transaction is a data access or an instruction access.
		input wire [2 : 0] S_AXI_ARPROT,
		// Read address valid. This signal indicates that the channel
    		// is signaling valid read address and control information.
		input wire  S_AXI_ARVALID,
		// Read address ready. This signal indicates that the slave is
    		// ready to accept an address and associated control signals.
		output wire  S_AXI_ARREADY,
		// Read data (issued by slave)
		output wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA,
		// Read response. This signal indicates the status of the
    		// read transfer.
		output wire [1 : 0] S_AXI_RRESP,
		// Read valid. This signal indicates that the channel is
    		// signaling the required read data.
		output wire  S_AXI_RVALID,
		// Read ready. This signal indicates that the master can
    		// accept the read data and response information.
		input wire  S_AXI_RREADY
	);

	// AXI4LITE signals
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_awaddr;
	reg  	axi_awready;
	reg  	axi_wready;
	reg [1 : 0] 	axi_bresp;
	reg  	axi_bvalid;
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_araddr;
	reg  	axi_arready;
	reg [C_S_AXI_DATA_WIDTH-1 : 0] 	axi_rdata;
	reg [1 : 0] 	axi_rresp;
	reg  	axi_rvalid;

	// Example-specific design signals
	// local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
	// ADDR_LSB is used for addressing 32/64 bit registers/memories
	// ADDR_LSB = 2 for 32 bits (n downto 2)
	// ADDR_LSB = 3 for 64 bits (n downto 3)
	localparam integer ADDR_LSB = (C_S_AXI_DATA_WIDTH/32) + 1;
	localparam integer OPT_MEM_ADDR_BITS = 3;
	//----------------------------------------------
	//-- Signals for user logic register space example
	//------------------------------------------------
	//-- Number of Slave Registers 10
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg0;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg1;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg2;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg3;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg4;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg5;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg6;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg7;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg8;
	reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg9;
	wire	 slv_reg_rden;
	wire	 slv_reg_wren;
	reg [C_S_AXI_DATA_WIDTH-1:0]	 reg_data_out;
	integer	 byte_index;
	reg	 aw_en;

	// I/O Connections assignments

	assign S_AXI_AWREADY	= axi_awready;
	assign S_AXI_WREADY	= axi_wready;
	assign S_AXI_BRESP	= axi_bresp;
	assign S_AXI_BVALID	= axi_bvalid;
	assign S_AXI_ARREADY	= axi_arready;
	assign S_AXI_RDATA	= axi_rdata;
	assign S_AXI_RRESP	= axi_rresp;
	assign S_AXI_RVALID	= axi_rvalid;
	assign sof_o = sof;
	assign data_out = pixel_in;
	// Implement axi_awready generation
	// axi_awready is asserted for one S_AXI_ACLK clock cycle when both
	// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_awready is
	// de-asserted when reset is low.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awready <= 1'b0;
	      aw_en <= 1'b1;
	    end 
	  else
	    begin    
	      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en)
	        begin
	          // slave is ready to accept write address when 
	          // there is a valid write address and write data
	          // on the write address and data bus. This design 
	          // expects no outstanding transactions. 
	          axi_awready <= 1'b1;
	          aw_en <= 1'b0;
	        end
	        else if (S_AXI_BREADY && axi_bvalid)
	            begin
	              aw_en <= 1'b1;
	              axi_awready <= 1'b0;
	            end
	      else           
	        begin
	          axi_awready <= 1'b0;
	        end
	    end 
	end       

	// Implement axi_awaddr latching
	// This process is used to latch the address when both 
	// S_AXI_AWVALID and S_AXI_WVALID are valid. 

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awaddr <= 0;
	    end 
	  else
	    begin    
	      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en)
	        begin
	          // Write Address latching 
	          axi_awaddr <= S_AXI_AWADDR;
	        end
	    end 
	end       

	// Implement axi_wready generation
	// axi_wready is asserted for one S_AXI_ACLK clock cycle when both
	// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_wready is 
	// de-asserted when reset is low. 

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_wready <= 1'b0;
	    end 
	  else
	    begin    
	      if (~axi_wready && S_AXI_WVALID && S_AXI_AWVALID && aw_en )
	        begin
	          // slave is ready to accept write data when 
	          // there is a valid write address and write data
	          // on the write address and data bus. This design 
	          // expects no outstanding transactions. 
	          axi_wready <= 1'b1;
	        end
	      else
	        begin
	          axi_wready <= 1'b0;
	        end
	    end 
	end       

	// Implement memory mapped register select and write logic generation
	// The write data is accepted and written to memory mapped registers when
	// axi_awready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted. Write strobes are used to
	// select byte enables of slave registers while writing.
	// These registers are cleared when reset (active low) is applied.
	// Slave register write enable is asserted when valid address and data are available
	// and the slave is ready to accept the write address and write data.
	assign slv_reg_wren = axi_wready && S_AXI_WVALID && axi_awready && S_AXI_AWVALID;

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      slv_reg0 <= 0;
	      slv_reg1 <= 0;
	      slv_reg2 <= 0;
	      slv_reg3 <= 0;
	      slv_reg4 <= 0;
	      slv_reg5 <= 0;
	      slv_reg6 <= 0;
	      slv_reg7 <= 0;
	      slv_reg8 <= 0;
	      slv_reg9 <= 0;
	    end 
	  else begin
	    if (slv_reg_wren)
	      begin
	        case ( axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
	          4'h0:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 0
	                slv_reg0[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          4'h1:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 1
	                slv_reg1[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          4'h2:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 2
	                slv_reg2[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          4'h3:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 3
	                slv_reg3[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          4'h4:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 4
	                slv_reg4[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          4'h5:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 5
	                slv_reg5[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          4'h6:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 6
	                slv_reg6[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          4'h7:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 7
	                slv_reg7[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          4'h8:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 8
	                slv_reg8[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          4'h9:
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 9
	                slv_reg9[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	          default : begin
	                      slv_reg0 <= slv_reg0;
	                      slv_reg1 <= slv_reg1;
	                      slv_reg2 <= slv_reg2;
	                      slv_reg3 <= slv_reg3;
	                      slv_reg4 <= slv_reg4;
	                      slv_reg5 <= slv_reg5;
	                      slv_reg6 <= slv_reg6;
	                      slv_reg7 <= slv_reg7;
	                      slv_reg8 <= slv_reg8;
	                      slv_reg9 <= slv_reg9;
	                    end
	        endcase
	      end
	  end
	end    
	

	// Implement write response logic generation
	// The write response and response valid signals are asserted by the slave 
	// when axi_wready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted.  
	// This marks the acceptance of address and indicates the status of 
	// write transaction.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_bvalid  <= 0;
	      axi_bresp   <= 2'b0;
	    end 
	  else
	    begin    
	      if (axi_awready && S_AXI_AWVALID && ~axi_bvalid && axi_wready && S_AXI_WVALID)
	        begin
	          // indicates a valid write response is available
	          axi_bvalid <= 1'b1;
	          axi_bresp  <= 2'b0; // 'OKAY' response 
	        end                   // work error responses in future
	      else
	        begin
	          if (S_AXI_BREADY && axi_bvalid) 
	            //check if bready is asserted while bvalid is high) 
	            //(there is a possibility that bready is always asserted high)   
	            begin
	              axi_bvalid <= 1'b0; 
	            end  
	        end
	    end
	end   

	// Implement axi_arready generation
	// axi_arready is asserted for one S_AXI_ACLK clock cycle when
	// S_AXI_ARVALID is asserted. axi_awready is 
	// de-asserted when reset (active low) is asserted. 
	// The read address is also latched when S_AXI_ARVALID is 
	// asserted. axi_araddr is reset to zero on reset assertion.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_arready <= 1'b0;
	      axi_araddr  <= 32'b0;
	    end 
	  else
	    begin    
	      if (~axi_arready && S_AXI_ARVALID)
	        begin
	          // indicates that the slave has acceped the valid read address
	          axi_arready <= 1'b1;
	          // Read address latching
	          axi_araddr  <= S_AXI_ARADDR;
	        end
	      else
	        begin
	          axi_arready <= 1'b0;
	        end
	    end 
	end       

	// Implement axi_arvalid generation
	// axi_rvalid is asserted for one S_AXI_ACLK clock cycle when both 
	// S_AXI_ARVALID and axi_arready are asserted. The slave registers 
	// data are available on the axi_rdata bus at this instance. The 
	// assertion of axi_rvalid marks the validity of read data on the 
	// bus and axi_rresp indicates the status of read transaction.axi_rvalid 
	// is deasserted on reset (active low). axi_rresp and axi_rdata are 
	// cleared to zero on reset (active low).  
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rvalid <= 0;
	      axi_rresp  <= 0;
	    end 
	  else
	    begin    
	      if (axi_arready && S_AXI_ARVALID && ~axi_rvalid)
	        begin
	          // Valid read data is available at the read data bus
	          axi_rvalid <= 1'b1;
	          axi_rresp  <= 2'b0; // 'OKAY' response
	        end   
	      else if (axi_rvalid && S_AXI_RREADY)
	        begin
	          // Read data is accepted by the master
	          axi_rvalid <= 1'b0;
	        end                
	    end
	end    

	// Implement memory mapped register select and read logic generation
	// Slave register read enable is asserted when valid address is available
	// and the slave is ready to accept the read address.
	assign slv_reg_rden = axi_arready & S_AXI_ARVALID & ~axi_rvalid;
	always @(*)
	begin
	      // Address decoding for reading registers
	      case ( axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
	        4'h0   : reg_data_out <= slv_reg0;
	        4'h1   : reg_data_out <= slv_reg1;
	        4'h2   : reg_data_out <= slv_reg2;
	        4'h3   : reg_data_out <= slv_reg3;
	        4'h4   : reg_data_out <= slv_reg4;
	        4'h5   : reg_data_out <= slv_reg5;
	        4'h6   : reg_data_out <= done;
	        4'h7   : reg_data_out <= (x_min_f + x_max_f) >> 1;
	        4'h8   : reg_data_out <= (y_min_f + y_max_f) >> 1;
	        4'h9   : reg_data_out <= xy_ready;
	        default : reg_data_out <= 0;
	      endcase
	end

	// Output register or memory read data
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rdata  <= 0;
	    end 
	  else
	    begin    
	      // When there is a valid read address (S_AXI_ARVALID) with 
	      // acceptance of read address by the slave (axi_arready), 
	      // output the read dada 
	      if (slv_reg_rden)
	        begin
	          axi_rdata <= reg_data_out;     // register read data
	        end   
	    end
	end    
	
	//Custom IP to get center point
    wire [7:0] r;
    wire [7:0] g;
    wire [7:0] b;
//reg [9:0] x;
    //reg [9:0] y;  
    //reg is_match;  // 1 if pixel matches user-defined limits
    /*reg [18:0] w_addr;
    reg [18:0] r_addr;
    reg [23:0] d_out;
    wire [23:0] d_in_ext;
    reg w_en;*/
    //reg [1:0] mode;
    //reg [18:0] counter;
    //initial counter = 0;
    initial x_min = 640;
    initial y_min = 480;    
    initial x_max = 0;
    initial y_max = 0;
    
    assign r = pixel_in[23:16];
    assign b = pixel_in[15:8];
    assign g = pixel_in[7:0];
    
    
    //reg [2:0] esf_ps;
    //reg [2:0] esf_ns;
    //reg eol_1;
            
    parameter ESF_RESET  = 3'b001,
              ESF_HIGH = 3'b010,
              ESF_LOW = 3'b100;
             
        // present state logic 
                     
    always@(posedge pixel_clk)
    begin
            if ( S_AXI_ARESETN == 1'b0 )
                esf_ps <= ESF_RESET; 
            else
                esf_ps <= esf_ns;
        end
        
        // next state logic
        always@(*)
        begin
           case(esf_ps)
            ESF_RESET:
            begin
                 if(eol)
                     esf_ns = ESF_HIGH;
                 else
                     esf_ns = ESF_RESET;
            end
            ESF_HIGH:
            begin
                 if(eol)
                     esf_ns = ESF_LOW;
                 else
                     esf_ns = ESF_RESET;  
            end
            ESF_LOW:
            begin
                 if(eol)
                     esf_ns = ESF_LOW;
                 else
                     esf_ns = ESF_RESET;
            end       
            default:
                 esf_ns = ESF_RESET;
            endcase
        end
        
        // logic for eol in current state
        always@(posedge pixel_clk)
        begin
           case(esf_ps)
           ESF_RESET:
           begin
                eol_1 = 1'b0;
           end
           ESF_HIGH:
           begin
                eol_1= 1'b1;
           end
           ESF_LOW:
           begin
                eol_1 = 1'b0;
           end   
           default:
           begin
               eol_1 = 1'b0;
           end
           endcase
        end
        
        // ================= end of esf (eol stabilizing fsm) =================
   
         //reg [2:0] sof_ps;
         //reg [2:0] sof_ns;
         //reg sof_out;
                     
         parameter SOF_RESET  = 3'b001,
                   SOF_HIGH = 3'b010,
                   SOF_LOW = 3'b100;
                  
             // present state logic 
                       
         always@(posedge pixel_clk)
         begin
                 if ( S_AXI_ARESETN == 1'b0 )
                     sof_ps <= SOF_RESET; 
                 else
                     sof_ps <= sof_ns;
             end
             
             // next state logic
             always@(*)
             begin
                case(sof_ps)
                 SOF_RESET:
                 begin
                      if(sof)
                          sof_ns = SOF_HIGH;
                      else
                          sof_ns = SOF_RESET;
                 end
                 SOF_HIGH:
                 begin
                      if(sof)
                          sof_ns = SOF_LOW;
                      else
                          sof_ns = SOF_RESET;  
                 end
                 SOF_LOW:
                 begin
                      if(sof)
                          sof_ns = SOF_LOW;
                      else
                          sof_ns = SOF_RESET;
                 end       
                 default:
                      sof_ns = SOF_RESET;
                 endcase
             end
             
             // logic for sof in current state
             always@(posedge pixel_clk)
             begin
                case(sof_ps)
                SOF_RESET:
                begin
                     sof_out = 1'b0;
                end
                SOF_HIGH:
                begin
                     sof_out = 1'b1;
                end
                SOF_LOW:
                begin
                     sof_out = 1'b0;
                end   
                default:
                begin
                    sof_out = 1'b0;
                end
                endcase
             end              
        
        //logic for x-y location
        always@(posedge pixel_clk)
        begin
            if ( S_AXI_ARESETN == 1'b0 )
            begin
                x <= 0;
                y <= 0;
            end
            else
            begin        
                if (sof_out) // || y == (height - 1) )
                begin
                    x <= 0;
                    y <= 0;
                end
                else
                begin
                    if (eol_1) // (x == (width - 1))
                    begin
                        x <= 0;
                        y <= y + 1;
                    end
                    else if (valid & !eol_1)
                    begin
                        x <= x + 1;
                    end  
                end
            end
        end

//pixel is matching limits comb logic
         reg [23:0] delay1;
         reg [23:0] delay2;
         
         always@ (posedge pixel_clk)
         begin
         delay1 <= pixel_in;
         delay2 <= delay1;         
         end
         
         //wire [23:0] pix_dif_g;
         //wire [23:0] pix_dif_b;
         //wire [23:0] pix_dif_r;
         //assign pix_dif_g = (g > d_in[7:0]) ? (g - d_in[7:0]) : (d_in[7:0] - g);
         //assign pix_dif_b = (b > d_in[15:8]) ? (b - d_in[15:8]) : (d_in[15:8] - b);
         //assign pix_dif_r = (r > d_in[23:16]) ? (r - d_in[23:16]) : (d_in[23:16] - r);

         always@(*)
         begin             
             if((delay1[7:0] >= (d_in[7:0] + 20) &&  delay1[15:8] >= (d_in[15:8] + 20) && delay1[23:16] >= (d_in[23:16] + 20)) && x < 640 && y < 480)
                 is_match = 1'b1;
             else
                 is_match = 1'b0;
        end                      
        //reg[7:0] s;
          //reg [7:0] ns;
        
        
        parameter RESET  = 8'b0000001,
                      REF = 8'b00000010,
                      WAIT = 8'b00000100,
                      NEW_RESET = 8'b00001000,
                      NOTHING = 8'b00010000,
                      first_DETECTING = 8'b00100000,
                      second_DETECTING = 8'b01000000,
                      //third_DETECTING = 8'b01000000,
                      //DONE_LINE = 6'b001000,
                      //NOT_DONE = 6'b010000,
                      DONE = 8'b10000000;
                      //DONE_WAIT = 9'b100000000; 
                      
            //present state logic          
            always@(posedge pixel_clk)
            begin
                if ( S_AXI_ARESETN == 1'b0 )
                    s <= RESET; 
                else
                    s <= ns;
            end
                          
            
            //next state logic
            always@(*)
            begin
               case(s)
               RESET:
               begin
                     if (sof_out)
                       ns = REF;
                     else ns = RESET;
               end
               REF:
               begin
                  if (sof_out)
                        ns = WAIT;
                  else ns= REF;
               end
               WAIT:
               begin
                  if (sof_out)
                     ns = NEW_RESET;
                  else ns = WAIT;
               end
               NEW_RESET:
               begin
                  if(is_match)
                     ns = first_DETECTING;
                  else
                     ns = NOTHING;
               end
               NOTHING:
               begin
                    if(sof_out)
                        ns = DONE;
                    else if (is_match)
                        ns = first_DETECTING;
                    else
                        ns = NOTHING;
                                                  
               end
               first_DETECTING:
               begin
                    if(sof_out)
                        ns = DONE;
                    else if(eol_1)
                        ns = NOTHING;
                    else if (is_match && valid)
                        ns = second_DETECTING;
                    else if (is_match)
                        ns = first_DETECTING;
                    else
                        ns = NOTHING;                           
               end 
               second_DETECTING:
               begin
                    if(sof_out)
                        ns = DONE;
                    else if(eol_1)
                        ns = NOTHING;
                    else if (is_match)
                        ns = second_DETECTING;
                    else
                        ns = first_DETECTING;                           
               end  
               
               /*third_DETECTING:
               begin
                    if(sof_out)
                        ns = DONE;
                    else if(eol)
                        ns = NOTHING;
                    //else if (!is_match)
                        //ns = DONE_LINE;
                    else if (is_match)
                        ns = third_DETECTING;
                    else
                        ns = second_DETECTING;                           
               end */                                           
               DONE:
               begin
                   ns = NEW_RESET;
               end    
               default:
                    ns = RESET;
               endcase
            end
            
            //logic in current state
            always@(posedge pixel_clk)
            begin
               case(s)
               RESET:
               begin     
                    x_min <= 640;
                    y_min <= 480;    
                    x_max <= 0;
                    y_max <= 0;
                    x_min_f <= 0;
                    y_min_f <= 0;    
                    x_max_f <= 0;
                    y_max_f <= 0;
                    
                    xy_ready <= 0;
                    mode <= 2;
               end
               
               REF:
               begin
                  mode <= 0;  
               end
               WAIT:
               begin
                  mode <= 1;
               end
               NEW_RESET:
               begin
               x_min <= 640;
               y_min <= 480;    
               x_max <= 0;
               y_max <= 0;

               detect_count <= 0;
               xy_ready <= 0;
               mode <= 2;              
               end
               NOTHING:
               begin
                detect_count <= 0;   
               end
               first_DETECTING:
               begin
                detect_count <= 0;                           
               end
               second_DETECTING:
               begin
               if(detect_count > 30)
               begin
               if ( (x-20) < x_min && x < 620 && y < 460 && x > 30)
                   x_min <= x - 20;
                   
               if (y < y_min && y < 460 && x < 620 && x > 30)
                   y_min <= y;
               
               if(x > x_max && x < 620 && y < 460 && x > 30)
                   x_max <= x;
               
               if(y > y_max && y < 460 && x < 620 && x > 30)
                   y_max <= y;  
               end  
               else
               begin 
                detect_count <= detect_count + 1;
               end                                                                   
               end  
               DONE:
               begin
                   xy_ready <= 1; 
                   x_min_f <= x_min;
                   x_max_f <= x_max;
                   y_min_f <= y_min;
                   y_max_f <= y_max;
               end
               default:
               begin

               end
               endcase
            end
            
            always @(*)
            begin
                    r_addr = x + (y<<7) + (y<<9) ;
            end
            
             always @(posedge pixel_clk)
             begin
                 if (mode == 0 && x < 640 && y < 480)
                 begin                       
                     w_addr <= x + (y<<7) + (y<<9);
                     d_out <= pixel_in;
                     w_en <= 1'b1;
                 end
                 else if (mode == 1 && x < 640 && y < 480)
                 begin                    
                    // d_out[23:16] <= (d_in[23:16] + pixel_in[23:16]) >> 1;
                    // d_out[15:8] <= (d_in[15:8] + pixel_in[15:8]) >> 1;
                    // d_out[7:0] <= (d_in[7:0] + pixel_in[7:0]) >> 1;
                    // w_addr <= x + y*640;
                    // w_en <= 1'b1;
                    //w_addr <= x + (y<<7) + (y<<9);
                    //d_out <= pixel_in;
                    w_en <= 1'b0;                          
                 end
                 else 
                 begin
                     w_en <= 1'b0;
                 end               
             end
             
             /*always @(posedge pixel_clk)
             begin
             if (sof)
                counter <= 0;
             else
                counter <= counter + 1;
             end*/
	//Custom IP to get center point end
	

	// Add user logic here

    assign x_start=slv_reg0;
    assign y_start=slv_reg1;
    assign x_end=slv_reg2;
    assign y_end=slv_reg3;    
    assign start=slv_reg4;
    assign updated=slv_reg5;
    //assign color=slv_reg4[23:0];

    //reg occupied[0:639][0:399];
    /*reg [31:0]x;
    reg [31:0]y;
    reg eol_1;
     always@(posedge pixel_clk)
       begin
           if ( S_AXI_ARESETN == 1'b0 )
           begin
               x <= 0;
               y <= 0;
           end
           else
           begin        
               if (sof) // || y == (height - 1) )
               begin
                   x <= 0;
                   y <= 0;
               end
               else
               begin
                   if (eol_1) // (x == (width - 1))
                   begin
                       x <= 0;
                       y <= y + 1;
                   end
                   else if (valid & !eol)
                   begin
                       x <= x + 1;
                   end  
               end
           end
       end*/
    
        /*always@(*)
       begin   
           // if streamed in pixel is in area where face1 is located
           if (x >= 0 && x <= 639 && y >= 0 && y <= 479)
           begin
               w_addr = x + y * 640;
               d_out = pixel_in;
               w_en = 1'b1;
           end
           else
           begin
               w_addr = 1'b0;
               d_out = 0;
               w_en = 1'b0;
           end
       end
       reg [23:0] pixel_value;
       // face2 data to face1 location output always block and face1 data to face2 location output always block
       always@(*)
       begin
           if (x >= 0 && x <= 639 && y >= 0 && y <= 479)
           begin
               // if streamed in pixel is in area wher face1 is located
               r_addr = x + y * 640;
               pixel_value = d_in;
           end
           else
           begin
               r_addr = 0;
               pixel_value = 24'b111111111111111111111111;
           end
       end*/
       
       // ==================drawline algorithm=========================
       wire [31:0]plot_x;
       wire [31:0]plot_y;
       
        drawlines d(
       .clk(pixel_clk),
       .reset(S_AXI_ARESETN),
       .start(start),
       .y0(y_start),
       .y1(y_end),
       .x0(x_start),
       .x1(x_end),
       .plot(),
       .done_plot(done),
       .plot_x(plot_x),
       .plot_y(plot_y),
       .updated(updated),
        .steep(steep),
        .Sel_p(Sel_p),
        .loop(loop),
        .x_gt(x_gt),
        .Sxy(Sxy),
        .y_step(y_step),
        .Sel_y(Sel_y),
        .newx0(newx0),
        .newx1(newx1),
        .newy0(newy0),
        .newy1(newy1),
        .ps(psLDA),
        .ns(nsLDA),
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
        .SER(SER)
       );
       
       always@(posedge pixel_clk) begin
           reg_x<=plot_x;
           reg_y<=plot_y;
       end
       
        reg [18:0] waddr_reg;
        always@(posedge pixel_clk) begin
             waddr_reg <=  reg_x + reg_y * 640;
        end
       always@(*)
              begin   
                  // if streamed in pixel is in area where face1 is located
                  if (start)
                  begin
                      w_addr1 = waddr_reg;
                      d_out1 = 1'b1;
                      w_en1 = 1'b1;
                  end
                  else
                  begin
                      w_addr1 = 1'b0;
                      d_out1 = 0;
                      w_en1 = 1'b0;
                  end
              end
              
              // face2 data to face1 location output always block and face1 data to face2 location output always block
              always@(*)
              begin
                  if (x >= 0 && x <= 639 && y >= 0 && y <= 479)
                  begin
                      // if streamed in pixel is in area wher face1 is located
                      r_addr1 = x + y * 640;
                      pixel_out = d_in1?0:24'b111111111111111111111111;
                  end
                  else
                  begin
                      r_addr1 = 0;
                      pixel_out = 24'b111111111111111111111111;
                  end
              end
       /*integer k;
       integer j;
       
           always@(posedge pixel_clk) begin
           if(!S_AXI_ARESETN) begin
               for(k=0; k<640; k=k+1) begin
                   for(j=0;j<480;j=j+1) begin
                       occupied[k][j] <= 0;
                   end
               end
           end
           else if (done)
               occupied[plot_x][plot_y] <= 1'b1;
           end*/
       //==================end drawline algorothm========================
    
        // ================ eol (eol internal) stabilizing fsm ===================
       // reducing external eol to go high for one clock
       /*reg [2:0] esf_ps;
       reg [2:0] esf_ns;
       reg eol;
       
       parameter ESF_RESET  = 3'b001,
                 ESF_HIGH = 3'b010,
                 ESF_LOW = 3'b100;
            
       // present state logic          
       always@(posedge pixel_clk)
       begin
           if ( S_AXI_ARESETN == 1'b0 )
               esf_ps <= ESF_RESET; 
           else
               esf_ps <= esf_ns;
       end
       
       // next state logic
       always@(*)
       begin
          case(esf_ps)
           ESF_RESET:
           begin
                if(eol)
                    esf_ns = ESF_HIGH;
                else
                    esf_ns = ESF_RESET;
           end
           ESF_HIGH:
           begin
                if(eol)
                    esf_ns = ESF_LOW;
                else
                    esf_ns = ESF_RESET;  
           end
           ESF_LOW:
           begin
                if(eol)
                    esf_ns = ESF_LOW;
                else
                    esf_ns = ESF_RESET;
           end       
           default:
                esf_ns = ESF_RESET;
           endcase
       end
       
       // logic for eol in current state
       always@(*)
       begin
          case(esf_ps)
          ESF_RESET:
          begin
               eol_1 = 1'b0;
          end
          ESF_HIGH:
          begin
               eol_1 = 1'b1;
          end
          ESF_LOW:
          begin
               eol_1 = 1'b0;
          end   
          default:
          begin
              eol_1 = 1'b0;
          end
          endcase
       end*/
       
       // ================= end of esf (eol stabilizing fsm) =================
	// User logic ends

	endmodule
