`timescale 1ns / 1ps

module sys_top_tb;

  // Inputs
  reg sys_clk;
  reg sys_rst_n;
  reg [13:0] ad_porta_data;
  reg [13:0] ad_portb_data;
  reg ad_ofa;
  reg ad_ofb;

  // Outputs
  wire ad_shdna;
  wire ad_shdnb;
  wire ad_porta_clk;
  wire ad_portb_clk;

  // Instantiate the sys_top module
  sys_top uut (
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .ad_porta_data(ad_porta_data),
    .ad_portb_data(ad_portb_data),
    .ad_ofa(ad_ofa),
    .ad_ofb(ad_ofb),
    .ad_shdna(ad_shdna),
    .ad_shdnb(ad_shdnb),
    .ad_porta_clk(ad_porta_clk),
    .ad_portb_clk(ad_portb_clk)
  );

  // Clock generation
  reg clk_50m;
  reg clk_65mA;
  reg clk_65mB;
  reg once;
  
  initial begin
    sys_clk = 0;
    clk_50m = 0;
    clk_65mA = 0;
    clk_65mB = 0;
    sys_rst_n = 0;
    ad_porta_data = 0;
    ad_portb_data = 0;
    ad_ofa = 0;
    ad_ofb = 0;
    once = 0;
    
    #100;
    sys_rst_n = 1;  // De-assert reset after 100ns
  end

  // Generate 50M clock
  always #10 sys_clk = ~sys_clk;  // 50M clock -> period = 20ns (T/2 = 10ns)

  // Generate 65M clocks for ADC
  always #7.692 clk_65mA = ~clk_65mA;  // 65M clock A -> period = 15.38ns (T/2 = 7.692ns)
  always #7.692 clk_65mB = ~clk_65mB;  // 65M clock B -> period = 15.38ns (T/2 = 7.692ns)

  // Stimulus for ADC data
  always begin
    #30;
    ad_portb_data = $random % (1 << 14);  // Random 14-bit data for portb
    ad_ofb = ~ad_ofb;  // Toggle enable signal
  end

  // Generate sine wave signal based on 65M clock (13 clock cycles per period)
  real sine_wave_real;
  integer i;
  reg [13:0] sine_wave;
  real amplitude = 14'h1FFF;  // 幅值

  initial begin
    for (i = 0; i < 130; i = i + 1) begin  // Generate 10 sine wave cycles for demonstration
      @(posedge clk_65mA);
      sine_wave_real = 14'h2000 + amplitude * $sin(2 * 3.14159 * i / 13);  // 正弦波生成公式
      sine_wave = sine_wave_real;  // 将实数转换为14位信号
      ad_porta_data = sine_wave;  // 将正弦波信号传递给ad_porta_data
        if (i == 129) begin
            i=0;
            once = 1;
        end
    if (!once) begin
        $display("Sine wave value at time %0t: %0d", $time, sine_wave);
    end
      
    end
  end

endmodule
