package audio_pkg;
    localparam bit [31:0] SAMPLE_RATE_32    = 32'h00007D00;
    localparam bit [31:0] SAMPLE_RATE_44_1  = 32'h0000AC44;
    localparam bit [31:0] SAMPLE_RATE_48    = 32'h0000BB80;
    localparam bit [31:0] SAMPLE_RATE_64    = 32'h0000FA00;
    localparam bit [31:0] SAMPLE_RATE_88_2  = 32'h00015888;
    localparam bit [31:0] SAMPLE_RATE_96    = 32'h00017700;
    localparam bit [31:0] SAMPLE_RATE_128   = 32'h0001F400;
    localparam bit [31:0] SAMPLE_RATE_176_4 = 32'h0002B110;
    localparam bit [31:0] SAMPLE_RATE_192   = 32'h0002EE00;
    localparam bit [31:0] SAMPLE_RATE_352_8 = 32'h00056220;
    localparam bit [31:0] SAMPLE_RATE_384   = 32'h0005DC00;
    localparam bit [31:0] SAMPLE_RATE_705_6 = 32'h000AC440;
    localparam bit [31:0] SAMPLE_RATE_768   = 32'h000BB800;

    localparam bit [7:0]  DOP_PACKET_CODE0      = 8'h05 ;
    localparam bit [7:0]  DOP_PACKET_CODE1      = 8'hFA ;


//===============================================================================
// ============================================================================
// UAC Local Params
// ============================================================================
//==========================bmRequestType============================
localparam  GET_STAND_INTF         = 8'h81;
localparam  SET_STAND_INTF         = 8'h01;
localparam  GET_CLASS_INTF         = 8'hA1;
localparam  SET_CLASS_INTF         = 8'h21;
localparam  GET_CLASS_EP           = 8'hA2;
localparam  SET_CLASS_EP           = 8'h22;

localparam  SET_CUR                = 8'h01;
localparam  GET_CUR                = 8'h81;

//============================bRequest==================================
    //UAC1.1
localparam  SET_MIN                = 8'h02;
localparam  GET_MIN                = 8'h82;
localparam  SET_MAX                = 8'h03;
localparam  GET_MAX                = 8'h83;
localparam  SET_RES                = 8'h04;
localparam  GET_RES                = 8'h84;
    //UAC2.0
localparam  CUR                    = 8'h01;
localparam  RANGE                  = 8'h02;


//============================wValue====================================
localparam  CS_SAM_FREQ_CONTROL         = 8'h01;
localparam  CS_CLOCK_VALID_CONTROL      = 8'h02;
localparam  FU_MUTE_CONTROL             = 8'h01;
localparam  FU_VOLUME_CONTROL           = 8'h02;
localparam  CX_CLOCK_SELECTOR_CONTROL   = 8'h01;
localparam  AS_VAL_ALT_SETTINGS_CONTROL = 8'h02;

localparam  CN0                      = 8'h00;
localparam  CN1                      = 8'h01;
localparam  CN2                      = 8'h02;



// UAC 2.0 采样率配置
localparam int NUM_FREQS = 12;
localparam int LEN_FREQS = 12 * NUM_FREQS + 2 ;
localparam logic [31:0] SUPPORTED_FREQS [NUM_FREQS] = '{
    SAMPLE_RATE_44_1,  SAMPLE_RATE_48, 
    SAMPLE_RATE_64,    SAMPLE_RATE_88_2,  SAMPLE_RATE_96, 
    SAMPLE_RATE_128,   SAMPLE_RATE_176_4, SAMPLE_RATE_192, 
    SAMPLE_RATE_352_8, SAMPLE_RATE_384,   SAMPLE_RATE_705_6, 
    SAMPLE_RATE_768
};


localparam  VOLUME_NUM               = 16'h0001;
localparam  VOLUME_FS_MIN            = 16'hD200;
localparam  VOLUME_FS_MAX            = 16'h0000;
localparam  VOLUME_FS_RES            = 16'h0300;

localparam  VOLUME_HS_MAX            = 16'h0000;
localparam  VOLUME_HS_MIN            = 16'hC080;
localparam  VOLUME_HS_RES            = 16'h0080;









endpackage