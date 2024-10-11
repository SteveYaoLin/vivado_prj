`timescale 1ns / 1ps
module sys_top(
    input                 sys_clk     	,  //绯荤粺鏃堕挓
    input                 sys_rst_n   	,  //绯荤粺澶嶄綅锛屼綆鐢靛钩鏈夋晥
    // input                 key   		,  //鎸夐敭key0    
    //DA鑺墖鎺ュ彛
    // output                da_clk      	,  //DA椹卞姩鏃堕挓,锟�?澶ф敮锟�?125Mhz鏃堕挓
    // output    [7:0]       da_data     	,  //杈撳嚭缁橠A鐨勬暟锟�?
    //AD鑺墖鎺ュ彛
    input     [13:0]       ad_data    	,  //AD杈撳叆鏁版嵁
    //妯℃嫙杈撳叆鐢靛帇瓒呭嚭閲忕▼鏍囧織(鏈璇曢獙鏈敤锟�?)
    input                 ad_porta_otr      	,  //0:鍦ㄩ噺绋嬭寖锟�? 1:瓒呭嚭閲忕▼
    output                ada_porta_clk      	,  //AD椹卞姩鏃堕挓,锟�?澶ф敮锟�?32Mhz鏃堕挓 

        //妯℃嫙杈撳叆鐢靛帇瓒呭嚭閲忕▼鏍囧織(鏈璇曢獙鏈敤锟�?)
    input                 ad_portb_otr      	,  //0:鍦ㄩ噺绋嬭寖锟�? 1:瓒呭嚭閲忕▼
    output                ada_portb_clk      	  //AD椹卞姩鏃堕挓,锟�?澶ф敮锟�?32Mhz鏃堕挓 
    
    // output                lcd_de		,  //LCD 鏁版嵁浣胯兘淇″彿
    // output                lcd_hs		,  //LCD 琛屽悓姝ヤ俊锟�?
    // output                lcd_vs		,  //LCD 鍦哄悓姝ヤ俊锟�?
    // output                lcd_clk		,  //LCD 鍍忕礌鏃堕挓
    // inout     [23:0]   	  lcd_rgb		,  //LCD RGB888棰滆壊鏁版嵁
    // output                lcd_rst		,  //LCD 澶嶄綅,浣庣數骞虫湁锟�? 
    // output                lcd_bl           //LCD 鑳屽厜鎺у埗淇″彿
    );

    //NET define    
    wire        clk_65m;            //100m鏃堕挓
    wire        clkA_65m;             //50m鏃堕挓
    wire        clkB_65m;             //25m鏃堕挓 
    //wire        clkB_65m_deg;         //鐩镐綅鍋忕Щ鍚庣殑25m鏃堕挓 
    wire        locked;              //pll杈撳嚭绋冲畾淇″彿
    wire        rst_n;               //澶嶄綅淇″彿锛屼綆鐢靛钩鏈夋晥
    //寰呮椂閽熼攣瀹氬悗浜х敓缁撴潫澶嶄綅淇″彿
    assign rst_n =  sys_rst_n && locked; 
    //灏唒ll浜х敓锟�?25m鏃堕挓璧嬬粰ad鐨勯┍鍔ㄦ椂锟�?
    assign ad_clk =  clkB_65m; 

    //渚嬪寲pll妯″潡	
      clk_wiz_0 u_pll
  (
  // Clock out ports  
  .clk_out1(clk_65m),
  .clk_out2(clkA_65m),
  .clk_out3(clkB_65m),
  // Status and control signals               
  .resetn(sys_rst_n), 
  .locked(locked),
 // Clock in ports
  .clk_in1(sys_clk)
  );
  
//    pll u_pll(
//    .clk_out1(clk_65m),    
//    .clk_out2(clkA_65m),  
//    .clk_out3(clkB_65m),     
//    .clk_out4(clkB_65m_deg),     
//    // Status and control signals
//    .resetn(sys_rst_n), 
//    .locked(locked),      
//   // Clock in ports
//    .clk_in1(sys_clk)     
//    );   

endmodule