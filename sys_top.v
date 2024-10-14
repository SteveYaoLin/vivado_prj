`timescale 1ns / 1ps
module sys_top(
    input                 sys_clk     	,  //�?荤粺鏃堕�?
    input                 sys_rst_n   	,  //�?荤粺澶嶄綅锛屼綆鐢靛钩鏈夋晥
    // input                 key   		,  //鎸�?�敭key0    

    //AD鑺墖鎺ュ彛
    input     [13:0]       ad_data    	,  //AD杈撳叆鏁版嵁
    //�?℃嫙杈撳叆鐢靛帇瓒呭�?閲忕▼鏍囧織(鏈璇曢獙鏈敤锟�??)
    input                 ad_porta_otr      	,  //0:鍦ㄩ噺绋�?寖锟�?? 1:瓒呭�?閲忕�?
    output                ada_porta_clk      	,  //AD椹卞姩鏃堕挓,锟�?澶ф敮锟�?32Mhz鏃堕�? 

        //�?℃嫙杈撳叆鐢靛帇瓒呭�?閲忕▼鏍囧織(鏈璇曢獙鏈敤锟�??)
    input                 ad_portb_otr      	,  //0:鍦ㄩ噺绋�?寖锟�?? 1:瓒呭�?閲忕�?
    output                ada_portb_clk      	  //AD椹卞姩鏃堕挓,锟�?澶ф敮锟�?32Mhz鏃堕�? 
    

    );

    //NET define    
    wire        clk_65m;            //100m鏃堕�?
    wire        clkA_65m;             //50m鏃堕�?
    wire        clkB_65m;             //25m鏃堕�? 
    //wire        clkB_65m_deg;         //鐩镐綅鍋忕Щ鍚庣殑25m鏃堕�? 
    wire        locked;              //pll杈撳�?绋冲畾淇″彿
    wire        rst_n;               //澶嶄綅淇″彿锛屼綆鐢靛钩鏈�?�晥
    //寰呮椂閽熼攣瀹氬悗浜х敓缁撴潫澶嶄綅淇″彿
    assign rst_n =  sys_rst_n && locked; 
    //灏唒ll浜х敓锟�?25m鏃堕挓璧�?粰ad鐨勯┍鍔ㄦ�?�锟�??
    assign ad_clk =  clkB_65m; 

    //渚�??寲pll�?″潡	
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
  
  BUFG bufa (.I(clk_65m),.O(ada_porta_clk));
  BUFG bufb (.I(clkA_65m),.O(ada_portb_clk));


endmodule