package dfu_pkg;


// DFU
localparam GET_VENDOR            = 8'hC0;
localparam VENDOR_CODE           = 8'h01;   //自定义
localparam GET_DESCRIPTOR_SET    = 8'h07;

localparam DFU_DETACH            = 8'h00;
localparam DFU_DNLOAD            = 8'h01;
localparam DFU_GETSTATUS         = 8'h03;
localparam DFU_CLRSTATUS         = 8'h04;

// DFU States (bState)
localparam APP_STATE_IDLE          = 8'd1; // appIDLE               APP状态 空闲
localparam DFU_STATE_IDLE          = 8'd2; // dfuIDLE               DFU状态 空闲
localparam DFU_STATE_DNLOAD_SYNC   = 8'd3; // dfuDNLOAD-SYNC        接收到数据包，等待主机GETSTATUS命令
localparam DFU_STATE_DNBUSY        = 8'd4; // dfuDNBUSY             接收到数据包，正在下载到flash中 
localparam DFU_STATE_DNLOAD_IDLE   = 8'd5; // dfuDNLOAD-IDLE        flash等待新的数据包
localparam DFU_STATE_MANIFEST_SYNC = 8'd6; // dfuMANIFEST-SYNC      文件完全传输，等待主机GETSTATUS命令
localparam DFU_STATE_MANIFEST      = 8'd7; // dfuMANIFEST           收尾工作，CDC/解密等操作




localparam int MSOS20_PROP_NAME_CHARS = 20;
localparam [MSOS20_PROP_NAME_CHARS*8-1:0] MSOS20_PROP_NAME = "DeviceInterfaceGUIDs";



//============================================== USB OS APP 2.0 des =============================================
localparam logic [7:0] APP_INTF_NUM = 8'h03;

localparam int MSOS20_GUID_CHARS = 38;
localparam [MSOS20_GUID_CHARS*8-1:0]      APP_MSOS20_GUID  = "{48153129-649C-4B67-AF78-A6FCF9FD3C71}";

localparam int APP_LEN_OS20_DES = 170;
typedef logic [7:0] os20_app_des_array_t [APP_LEN_OS20_DES];

localparam os20_app_des_array_t OS20_APP_DES_TEMPLATE = '{
  8'h0A, 8'h00,                                       // Set Header wLength = 10
  8'h00, 8'h00,                                       // MS_OS_20_SET_HEADER_DESCRIPTOR
  8'h00, 8'h00, 8'h03, 8'h06,                         // Windows 8.1 or later
  8'hAA, 8'h00,                                       // wDescriptorSetTotalLength
//--- Function Subset Header (8 Bytes)
  8'h08, 8'h00,                                       // wLength = 8
  8'h02, 8'h00,                                       // MS_OS_20_SUBSET_HEADER_FUNCTION
  APP_INTF_NUM, 8'h00,                                // bFirstInterface = DFU接口号, bReserved
  8'hA0, 8'h00,                                       // wSubsetLength = 174 - 8 = 166 (0xA6)
//--- WCID20 compatible ID descriptor
  8'h14, 8'h00,                                       // Compatible ID wLength = 20
  8'h03, 8'h00,                                       // MS_OS_20_FEATURE_COMPATIBLE_ID
//--- WINUSB 
  "W", "I", "N", "U", "S", "B",                       /* cCID_8 */
  8'h00, 8'h00, 8'h00, 8'h00, 8'h00,  8'h00, 8'h00, 8'h00, 8'h00, 8'h00,   /* cSubCID_8 */
//--- WCID20 registry property descriptor
  8'h84, 8'h00,                                       // Registry Property wLength = 132
  8'h04, 8'h00,                                       // MS_OS_20_FEATURE_REG_PROPERTY
  8'h07, 8'h00,                                       // REG_MULTI_SZ
// --- DeviceInterfaceGUIDs 
  8'h2A, 8'h00,                                       // PropertyName length = 42
  8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
  8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
  8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
  8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
  8'h00, 8'h00, //Null
// --- MSOS20_GUID 
  8'h50, 8'h00,                                       // PropertyData length = 80
  8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
  8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
  8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
  8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
  8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
  8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
  8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
  8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
  8'h00, 8'h00 //Null
};

function automatic os20_app_des_array_t build_app_os20_des();
    os20_app_des_array_t rom = OS20_APP_DES_TEMPLATE; 
    int i;
// --- DeviceInterfaceGUIDs 
    for (i = 0; i < MSOS20_PROP_NAME_CHARS; i++) begin
        rom[46 + i*2]     = MSOS20_PROP_NAME[(MSOS20_PROP_NAME_CHARS - 1 - i)*8 +: 8];
        rom[46 + i*2 + 1] = 8'h00; 
    end
// --- MSOS20_GUID 
    for (i = 0; i < MSOS20_GUID_CHARS; i++) begin
        rom[90 + i*2]     = APP_MSOS20_GUID[(MSOS20_GUID_CHARS - 1 - i)*8 +: 8];
        rom[90 + i*2 + 1] = 8'h00; 
    end
    return rom;
endfunction

//============================================== USB OS APP 2.0 des =============================================




//============================================== USB OS DFU 2.0 des =============================================
localparam logic [7:0] DFU_INTF_NUM = 8'h00;
localparam [MSOS20_GUID_CHARS*8-1:0]      DFU_MSOS20_GUID   = "{F5436908-F3FD-36FC-8730-89531CBFEA14}";

localparam int DFU_LEN_OS20_DES = 168;
typedef logic [7:0] os20_dfu_des_array_t [DFU_LEN_OS20_DES];
localparam os20_dfu_des_array_t OS20_DFU_DES_TEMPLATE = '{
  8'h0A, 8'h00,                                       // Set Header wLength = 10
  8'h00, 8'h00,                                       // MS_OS_20_SET_HEADER_DESCRIPTOR
  8'h00, 8'h00, 8'h03, 8'h06,                         // Windows 8.1 or later
  8'hA8, 8'h00,                                       // wDescriptorSetTotalLength
//--- WCID20 compatible ID descriptor
  8'h14, 8'h00,                                       // Compatible ID wLength = 20
  8'h03, 8'h00,                                       // MS_OS_20_FEATURE_COMPATIBLE_ID
//--- WINUSB 
  "W", "I", "N", "U", "S", "B",                       /* cCID_8 */
  8'h00, 8'h00, 8'h00, 8'h00, 8'h00,  8'h00, 8'h00, 8'h00, 8'h00, 8'h00,   /* cSubCID_8 */
//--- WCID20 registry property descriptor
  8'h84, 8'h00,                                       // Registry Property wLength = 132
  8'h04, 8'h00,                                       // MS_OS_20_FEATURE_REG_PROPERTY
  8'h07, 8'h00,                                       // REG_MULTI_SZ
// --- DeviceInterfaceGUIDs 
  8'h2A, 8'h00,                                       // PropertyName length = 42
  8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
  8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
  8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
  8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
  8'h00, 8'h00, //Null
// --- MSOS20_GUID 
  8'h50, 8'h00,                                       // PropertyData length = 80
  8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
  8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
  8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
  8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
  8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
  8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
  8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
  8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00,
  8'h00, 8'h00, //Null

  8'h06, 8'h00, 
  8'h08, 8'h00, 8'h01, 8'h00

};

function automatic os20_dfu_des_array_t build_dfu_os20_des();
    os20_dfu_des_array_t rom = OS20_DFU_DES_TEMPLATE; 
    int i;
// --- DeviceInterfaceGUIDs 
    for (i = 0; i < MSOS20_PROP_NAME_CHARS; i++) begin
        rom[38 + i*2]     = MSOS20_PROP_NAME[(MSOS20_PROP_NAME_CHARS - 1 - i)*8 +: 8];
        rom[38 + i*2 + 1] = 8'h00; 
    end
// --- MSOS20_GUID 
    for (i = 0; i < MSOS20_GUID_CHARS; i++) begin
        rom[82 + i*2]     = DFU_MSOS20_GUID[(MSOS20_GUID_CHARS - 1 - i)*8 +: 8];
        rom[82 + i*2 + 1] = 8'h00; 
    end
    return rom;
endfunction

//============================================== USB OS DFU 2.0 des =============================================


endpackage