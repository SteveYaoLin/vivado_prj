`timescale 1ns / 1ps
module sys_top(
    input                 sys_clk     	,  //ʱ���ź�
    input                 sys_rst_n   	,  //��λ�ź�
    // input                 key   		,  //�����ź�

    //ADת��ģ��Ľӿ�
    input     [13:0]       ad_porta_data    	,  //ADת��ģ�������
    input     [13:0]       ad_portb_data    	,  //ADת��ģ�������
   
    input                 ad_ofa      	,  //ADת��ģ���ʹ���ź�
    output                ad_shdna      	,
    output                ad_porta_clk      	,  //ADת��ģ���ʱ��

    //ADת��ģ��Ľӿ�
    input                 ad_ofb      	,  //ADת��ģ���ʹ���ź�
    output                ad_shdnb      	,
    output                ad_portb_clk      	  //ADת��ģ���ʱ��

    );

    //�źŶ���
    wire        clk_65m;            //100MHzʱ��
    wire        clkA_65m;             //50MHzʱ��
    wire        clkB_65m;             //25MHzʱ��
    wire        locked;              //PLL�����ź�
    wire        rst_n;               //ϵͳ��λ�ź�

    assign rst_n =  sys_rst_n && locked; 
    assign ad_shdna = 1'b1;
    assign ad_shdnb = 1'b1;
    // assign ad_clk =  clkB_65m; 

    //PLLģ��
    clk_wiz_0 u_pll
    (
    //ʱ�����
    .clk_out1(clk_65m),
    .clk_out2(clkA_65m),
    .clk_out3(clkB_65m),
    //״̬�Ϳ����ź�               
    .resetn(sys_rst_n), 
    .locked(locked),
    //ʱ������
    .clk_in1(sys_clk)
    );
  
    //ʱ���źŻ���
    BUFG bufa (.I(clkA_65m),.O(ad_porta_clk));
    BUFG bufb (.I(clkB_65m),.O(ad_portb_clk));


endmodule
