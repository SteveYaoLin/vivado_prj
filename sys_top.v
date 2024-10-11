`timescale 1ns / 1ps
module sys_top(
    input                 sys_clk     	,  //系统时钟
    input                 sys_rst_n   	,  //系统复位，低电平有效
    // input                 key   		,  //按键key0    
    //DA芯片接口
    // output                da_clk      	,  //DA驱动时钟,最大支持125Mhz时钟
    // output    [7:0]       da_data     	,  //输出给DA的数据
    //AD芯片接口
    input     [13:0]       ad_data    	,  //AD输入数据
    //模拟输入电压超出量程标志(本次试验未用到)
    input                 ad_porta_otr      	,  //0:在量程范围 1:超出量程
    output                ada_porta_clk      	,  //AD驱动时钟,最大支持32Mhz时钟 

        //模拟输入电压超出量程标志(本次试验未用到)
    input                 ad_portb_otr      	,  //0:在量程范围 1:超出量程
    output                ada_portb_clk      	,  //AD驱动时钟,最大支持32Mhz时钟 
    
    // output                lcd_de		,  //LCD 数据使能信号
    // output                lcd_hs		,  //LCD 行同步信号
    // output                lcd_vs		,  //LCD 场同步信号
    // output                lcd_clk		,  //LCD 像素时钟
    // inout     [23:0]   	  lcd_rgb		,  //LCD RGB888颜色数据
    // output                lcd_rst		,  //LCD 复位,低电平有效 
    // output                lcd_bl           //LCD 背光控制信号
    );

    //NET define    
    wire        clk_100m;            //100m时钟
    wire        clk_50m;             //50m时钟
    wire        clk_25m;             //25m时钟 
    wire        clk_25m_deg;         //相位偏移后的25m时钟 
    wire        locked;              //pll输出稳定信号
    wire        rst_n;               //复位信号，低电平有效
    //待时钟锁定后产生结束复位信号
    assign rst_n =  sys_rst_n && locked; 
    //将pll产生的25m时钟赋给ad的驱动时钟
    assign ad_clk =  clk_25m; 

    //例化pll模块	
    pll u_pll(
    .clk_out1(clk_100m),    
    .clk_out2(clk_50m),  
    .clk_out3(clk_25m),     
    .clk_out4(clk_25m_deg),     
    // Status and control signals
    .resetn(sys_rst_n), 
    .locked(locked),      
   // Clock in ports
    .clk_in1(sys_clk)     
    );   

endmodule