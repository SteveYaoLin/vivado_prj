`timescale 1ns / 1ps
module sys_top(
    input                 sys_clk     	,  //时钟信号
    input                 sys_rst_n   	,  //复位信号
    // input                 key   		,  //按键信号

    //AD转换模块的接口
    input     [13:0]       ad_porta_data    	,  //AD转换模块的数据
    input     [13:0]       ad_portb_data    	,  //AD转换模块的数据
   
    input                 ad_ofa      	,  //AD转换模块的使能信号
    output                ad_shdna      	,
    output                ad_porta_clk      	,  //AD转换模块的时钟

    //AD转换模块的接口
    input                 ad_ofb      	,  //AD转换模块的使能信号
    output                ad_shdnb      	,
    output                ad_portb_clk      	  //AD转换模块的时钟

    );

    //信号定义
    wire        clk_65m;            //100MHz时钟
    wire        clkA_65m;             //50MHz时钟
    wire        clkB_65m;             //25MHz时钟
    wire        locked;              //PLL锁定信号
    wire        rst_n;               //系统复位信号

    assign rst_n =  sys_rst_n && locked; 
    assign ad_shdna = 1'b1;
    assign ad_shdnb = 1'b1;
    // assign ad_clk =  clkB_65m; 

    //PLL模块
    clk_wiz_0 u_pll
    (
    //时钟输出
    .clk_out1(clk_65m),
    .clk_out2(clkA_65m),
    .clk_out3(clkB_65m),
    //状态和控制信号               
    .resetn(sys_rst_n), 
    .locked(locked),
    //时钟输入
    .clk_in1(sys_clk)
    );
  
    //时钟信号缓冲
    BUFG bufa (.I(clkA_65m),.O(ad_porta_clk));
    BUFG bufb (.I(clkB_65m),.O(ad_portb_clk));


endmodule
