Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4442E1C4F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 13:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgLWMk0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Dec 2020 07:40:26 -0500
Received: from aposti.net ([89.234.176.197]:53340 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbgLWMkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 07:40:25 -0500
Date:   Wed, 23 Dec 2020 12:39:27 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 5/5] clk: Ingenic: Clean up and reformat the code.
To:     =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>
Cc:     sboyd@kernel.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        mturquette@baylibre.com, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sihui.liu@ingenic.com,
        sernia.zhou@foxmail.com
Message-Id: <RTLSLQ.76VN5F6EGEAF@crapouillou.net>
In-Reply-To: <1608565971-23895-6-git-send-email-zhouyanjie@wanyeetech.com>
References: <1608565971-23895-1-git-send-email-zhouyanjie@wanyeetech.com>
        <1608565971-23895-6-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhou,

Le lun. 21 déc. 2020 à 23:52, 周琰杰 (Zhou Yanjie) 
<zhouyanjie@wanyeetech.com> a écrit :
> 1.When the clock does not have "CGU_CLK_MUX", the 2/3/4 bits in
>   parents do not need to be filled with -1. When the clock have
>   a "CGU_CLK_MUX" has only one bit, the 3/4 bits of parents do
>   not need to be filled with -1. Clean up these unnecessary -1
>   from all the xxxx-cgu.c files.
> 2.Reformat code, add missing blank lines, remove unnecessary
>   commas and tabs, and align code.
> 
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
> 
> Notes:
>     v1->v2:
>     Remove unnecessary -1 and commas.
> 
>     v2->v3:
>     No change.
> 
>     v3->v4:
>     1.The -1 used for placeholders on the unused bits of the
>       parents in the custom clock should not be removed.
>     2.Move "JZ4780_CLK_CORE1" from the "Gate-only clocks"
>       class to the "Custom (SoC-specific)" class, because
>       it belongs to the custom clock.
> 
>  drivers/clk/ingenic/jz4725b-cgu.c |  50 +++++++-------
>  drivers/clk/ingenic/jz4740-cgu.c  |  50 +++++++-------
>  drivers/clk/ingenic/jz4770-cgu.c  |  79 +++++++++++-----------
>  drivers/clk/ingenic/jz4780-cgu.c  | 135 
> +++++++++++++++++++-------------------
>  drivers/clk/ingenic/x1000-cgu.c   | 120 
> ++++++++++++++++-----------------
>  drivers/clk/ingenic/x1830-cgu.c   | 133 
> ++++++++++++++++++-------------------
>  6 files changed, 286 insertions(+), 281 deletions(-)
> 
> diff --git a/drivers/clk/ingenic/jz4725b-cgu.c 
> b/drivers/clk/ingenic/jz4725b-cgu.c
> index 8c38e72..f41cd76 100644
> --- a/drivers/clk/ingenic/jz4725b-cgu.c
> +++ b/drivers/clk/ingenic/jz4725b-cgu.c
> @@ -17,7 +17,7 @@
> 
>  /* CGU register offsets */
>  #define CGU_REG_CPCCR		0x00
> -#define CGU_REG_LCR		0x04
> +#define CGU_REG_LCR			0x04
>  #define CGU_REG_CPPCR		0x10
>  #define CGU_REG_CLKGR		0x20
>  #define CGU_REG_OPCR		0x24
> @@ -28,7 +28,7 @@
>  #define CGU_REG_CIMCDR		0x78
> 
>  /* bits within the LCR register */
> -#define LCR_SLEEP		BIT(0)
> +#define LCR_SLEEP			BIT(0)
> 
>  static struct ingenic_cgu *cgu;
> 
> @@ -53,7 +53,7 @@ static const struct ingenic_cgu_clk_info 
> jz4725b_cgu_clocks[] = {
> 
>  	[JZ4725B_CLK_PLL] = {
>  		"pll", CGU_CLK_PLL,
> -		.parents = { JZ4725B_CLK_EXT, -1, -1, -1 },
> +		.parents = { JZ4725B_CLK_EXT },
>  		.pll = {
>  			.reg = CGU_REG_CPPCR,
>  			.rate_multiplier = 1,
> @@ -78,7 +78,7 @@ static const struct ingenic_cgu_clk_info 
> jz4725b_cgu_clocks[] = {
> 
>  	[JZ4725B_CLK_PLL_HALF] = {
>  		"pll half", CGU_CLK_DIV,
> -		.parents = { JZ4725B_CLK_PLL, -1, -1, -1 },
> +		.parents = { JZ4725B_CLK_PLL },
>  		.div = {
>  			CGU_REG_CPCCR, 21, 1, 1, -1, -1, -1,
>  			jz4725b_cgu_pll_half_div_table,
> @@ -87,7 +87,7 @@ static const struct ingenic_cgu_clk_info 
> jz4725b_cgu_clocks[] = {
> 
>  	[JZ4725B_CLK_CCLK] = {
>  		"cclk", CGU_CLK_DIV,
> -		.parents = { JZ4725B_CLK_PLL, -1, -1, -1 },
> +		.parents = { JZ4725B_CLK_PLL },
>  		.div = {
>  			CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1,
>  			jz4725b_cgu_cpccr_div_table,
> @@ -96,7 +96,7 @@ static const struct ingenic_cgu_clk_info 
> jz4725b_cgu_clocks[] = {
> 
>  	[JZ4725B_CLK_HCLK] = {
>  		"hclk", CGU_CLK_DIV,
> -		.parents = { JZ4725B_CLK_PLL, -1, -1, -1 },
> +		.parents = { JZ4725B_CLK_PLL },
>  		.div = {
>  			CGU_REG_CPCCR, 4, 1, 4, 22, -1, -1,
>  			jz4725b_cgu_cpccr_div_table,
> @@ -105,7 +105,7 @@ static const struct ingenic_cgu_clk_info 
> jz4725b_cgu_clocks[] = {
> 
>  	[JZ4725B_CLK_PCLK] = {
>  		"pclk", CGU_CLK_DIV,
> -		.parents = { JZ4725B_CLK_PLL, -1, -1, -1 },
> +		.parents = { JZ4725B_CLK_PLL },
>  		.div = {
>  			CGU_REG_CPCCR, 8, 1, 4, 22, -1, -1,
>  			jz4725b_cgu_cpccr_div_table,
> @@ -114,7 +114,7 @@ static const struct ingenic_cgu_clk_info 
> jz4725b_cgu_clocks[] = {
> 
>  	[JZ4725B_CLK_MCLK] = {
>  		"mclk", CGU_CLK_DIV,
> -		.parents = { JZ4725B_CLK_PLL, -1, -1, -1 },
> +		.parents = { JZ4725B_CLK_PLL },
>  		.div = {
>  			CGU_REG_CPCCR, 12, 1, 4, 22, -1, -1,
>  			jz4725b_cgu_cpccr_div_table,
> @@ -123,7 +123,7 @@ static const struct ingenic_cgu_clk_info 
> jz4725b_cgu_clocks[] = {
> 
>  	[JZ4725B_CLK_IPU] = {
>  		"ipu", CGU_CLK_DIV | CGU_CLK_GATE,
> -		.parents = { JZ4725B_CLK_PLL, -1, -1, -1 },
> +		.parents = { JZ4725B_CLK_PLL },
>  		.div = {
>  			CGU_REG_CPCCR, 16, 1, 4, 22, -1, -1,
>  			jz4725b_cgu_cpccr_div_table,
> @@ -133,14 +133,14 @@ static const struct ingenic_cgu_clk_info 
> jz4725b_cgu_clocks[] = {
> 
>  	[JZ4725B_CLK_LCD] = {
>  		"lcd", CGU_CLK_DIV | CGU_CLK_GATE,
> -		.parents = { JZ4725B_CLK_PLL_HALF, -1, -1, -1 },
> +		.parents = { JZ4725B_CLK_PLL_HALF },
>  		.div = { CGU_REG_LPCDR, 0, 1, 11, -1, -1, -1 },
>  		.gate = { CGU_REG_CLKGR, 9 },
>  	},
> 
>  	[JZ4725B_CLK_I2S] = {
>  		"i2s", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
> -		.parents = { JZ4725B_CLK_EXT, JZ4725B_CLK_PLL_HALF, -1, -1 },
> +		.parents = { JZ4725B_CLK_EXT, JZ4725B_CLK_PLL_HALF },
>  		.mux = { CGU_REG_CPCCR, 31, 1 },
>  		.div = { CGU_REG_I2SCDR, 0, 1, 9, -1, -1, -1 },
>  		.gate = { CGU_REG_CLKGR, 6 },
> @@ -148,7 +148,7 @@ static const struct ingenic_cgu_clk_info 
> jz4725b_cgu_clocks[] = {
> 
>  	[JZ4725B_CLK_SPI] = {
>  		"spi", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
> -		.parents = { JZ4725B_CLK_EXT, JZ4725B_CLK_PLL, -1, -1 },
> +		.parents = { JZ4725B_CLK_EXT, JZ4725B_CLK_PLL },
>  		.mux = { CGU_REG_SSICDR, 31, 1 },
>  		.div = { CGU_REG_SSICDR, 0, 1, 4, -1, -1, -1 },
>  		.gate = { CGU_REG_CLKGR, 4 },
> @@ -156,13 +156,13 @@ static const struct ingenic_cgu_clk_info 
> jz4725b_cgu_clocks[] = {
> 
>  	[JZ4725B_CLK_MMC_MUX] = {
>  		"mmc_mux", CGU_CLK_DIV,
> -		.parents = { JZ4725B_CLK_PLL_HALF, -1, -1, -1 },
> +		.parents = { JZ4725B_CLK_PLL_HALF },
>  		.div = { CGU_REG_MSCCDR, 0, 1, 5, -1, -1, -1 },
>  	},
> 
>  	[JZ4725B_CLK_UDC] = {
>  		"udc", CGU_CLK_MUX | CGU_CLK_DIV,
> -		.parents = { JZ4725B_CLK_EXT, JZ4725B_CLK_PLL_HALF, -1, -1 },
> +		.parents = { JZ4725B_CLK_EXT, JZ4725B_CLK_PLL_HALF },
>  		.mux = { CGU_REG_CPCCR, 29, 1 },
>  		.div = { CGU_REG_CPCCR, 23, 1, 6, -1, -1, -1 },
>  	},
> @@ -171,55 +171,55 @@ static const struct ingenic_cgu_clk_info 
> jz4725b_cgu_clocks[] = {
> 
>  	[JZ4725B_CLK_UART] = {
>  		"uart", CGU_CLK_GATE,
> -		.parents = { JZ4725B_CLK_EXT, -1, -1, -1 },
> +		.parents = { JZ4725B_CLK_EXT },
>  		.gate = { CGU_REG_CLKGR, 0 },
>  	},
> 
>  	[JZ4725B_CLK_DMA] = {
>  		"dma", CGU_CLK_GATE,
> -		.parents = { JZ4725B_CLK_PCLK, -1, -1, -1 },
> +		.parents = { JZ4725B_CLK_PCLK },
>  		.gate = { CGU_REG_CLKGR, 12 },
>  	},
> 
>  	[JZ4725B_CLK_ADC] = {
>  		"adc", CGU_CLK_GATE,
> -		.parents = { JZ4725B_CLK_EXT, -1, -1, -1 },
> +		.parents = { JZ4725B_CLK_EXT },
>  		.gate = { CGU_REG_CLKGR, 7 },
>  	},
> 
>  	[JZ4725B_CLK_I2C] = {
>  		"i2c", CGU_CLK_GATE,
> -		.parents = { JZ4725B_CLK_EXT, -1, -1, -1 },
> +		.parents = { JZ4725B_CLK_EXT },
>  		.gate = { CGU_REG_CLKGR, 3 },
>  	},
> 
>  	[JZ4725B_CLK_AIC] = {
>  		"aic", CGU_CLK_GATE,
> -		.parents = { JZ4725B_CLK_EXT, -1, -1, -1 },
> +		.parents = { JZ4725B_CLK_EXT },
>  		.gate = { CGU_REG_CLKGR, 5 },
>  	},
> 
>  	[JZ4725B_CLK_MMC0] = {
>  		"mmc0", CGU_CLK_GATE,
> -		.parents = { JZ4725B_CLK_MMC_MUX, -1, -1, -1 },
> +		.parents = { JZ4725B_CLK_MMC_MUX },
>  		.gate = { CGU_REG_CLKGR, 6 },
>  	},
> 
>  	[JZ4725B_CLK_MMC1] = {
>  		"mmc1", CGU_CLK_GATE,
> -		.parents = { JZ4725B_CLK_MMC_MUX, -1, -1, -1 },
> +		.parents = { JZ4725B_CLK_MMC_MUX },
>  		.gate = { CGU_REG_CLKGR, 16 },
>  	},
> 
>  	[JZ4725B_CLK_BCH] = {
>  		"bch", CGU_CLK_GATE,
> -		.parents = { JZ4725B_CLK_MCLK/* not sure */, -1, -1, -1 },
> +		.parents = { JZ4725B_CLK_MCLK/* not sure */ },
>  		.gate = { CGU_REG_CLKGR, 11 },
>  	},
> 
>  	[JZ4725B_CLK_TCU] = {
>  		"tcu", CGU_CLK_GATE,
> -		.parents = { JZ4725B_CLK_EXT/* not sure */, -1, -1, -1 },
> +		.parents = { JZ4725B_CLK_EXT/* not sure */ },
>  		.gate = { CGU_REG_CLKGR, 1 },
>  	},
> 
> @@ -233,13 +233,13 @@ static const struct ingenic_cgu_clk_info 
> jz4725b_cgu_clocks[] = {
> 
>  	[JZ4725B_CLK_RTC] = {
>  		"rtc", CGU_CLK_MUX,
> -		.parents = { JZ4725B_CLK_EXT512, JZ4725B_CLK_OSC32K, -1, -1 },
> +		.parents = { JZ4725B_CLK_EXT512, JZ4725B_CLK_OSC32K },
>  		.mux = { CGU_REG_OPCR, 2, 1},
>  	},
> 
>  	[JZ4725B_CLK_UDC_PHY] = {
>  		"udc_phy", CGU_CLK_GATE,
> -		.parents = { JZ4725B_CLK_EXT, -1, -1, -1 },
> +		.parents = { JZ4725B_CLK_EXT },
>  		.gate = { CGU_REG_OPCR, 6, true },
>  	},
>  };
> diff --git a/drivers/clk/ingenic/jz4740-cgu.c 
> b/drivers/clk/ingenic/jz4740-cgu.c
> index c0ac919..0fd3751 100644
> --- a/drivers/clk/ingenic/jz4740-cgu.c
> +++ b/drivers/clk/ingenic/jz4740-cgu.c
> @@ -18,10 +18,10 @@
> 
>  /* CGU register offsets */
>  #define CGU_REG_CPCCR		0x00
> -#define CGU_REG_LCR		0x04
> +#define CGU_REG_LCR			0x04
>  #define CGU_REG_CPPCR		0x10
>  #define CGU_REG_CLKGR		0x20
> -#define CGU_REG_SCR		0x24
> +#define CGU_REG_SCR			0x24
>  #define CGU_REG_I2SCDR		0x60
>  #define CGU_REG_LPCDR		0x64
>  #define CGU_REG_MSCCDR		0x68
> @@ -40,10 +40,10 @@
>  #define PLLCTL_ENABLE		(1 << 8)
> 
>  /* bits within the LCR register */
> -#define LCR_SLEEP		(1 << 0)
> +#define LCR_SLEEP			(1 << 0)
> 
>  /* bits within the CLKGR register */
> -#define CLKGR_UDC		(1 << 11)
> +#define CLKGR_UDC			(1 << 11)
> 
>  static struct ingenic_cgu *cgu;
> 
> @@ -68,7 +68,7 @@ static const struct ingenic_cgu_clk_info 
> jz4740_cgu_clocks[] = {
> 
>  	[JZ4740_CLK_PLL] = {
>  		"pll", CGU_CLK_PLL,
> -		.parents = { JZ4740_CLK_EXT, -1, -1, -1 },
> +		.parents = { JZ4740_CLK_EXT },
>  		.pll = {
>  			.reg = CGU_REG_CPPCR,
>  			.rate_multiplier = 1,
> @@ -93,7 +93,7 @@ static const struct ingenic_cgu_clk_info 
> jz4740_cgu_clocks[] = {
> 
>  	[JZ4740_CLK_PLL_HALF] = {
>  		"pll half", CGU_CLK_DIV,
> -		.parents = { JZ4740_CLK_PLL, -1, -1, -1 },
> +		.parents = { JZ4740_CLK_PLL },
>  		.div = {
>  			CGU_REG_CPCCR, 21, 1, 1, -1, -1, -1,
>  			jz4740_cgu_pll_half_div_table,
> @@ -102,7 +102,7 @@ static const struct ingenic_cgu_clk_info 
> jz4740_cgu_clocks[] = {
> 
>  	[JZ4740_CLK_CCLK] = {
>  		"cclk", CGU_CLK_DIV,
> -		.parents = { JZ4740_CLK_PLL, -1, -1, -1 },
> +		.parents = { JZ4740_CLK_PLL },
>  		.div = {
>  			CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1,
>  			jz4740_cgu_cpccr_div_table,
> @@ -111,7 +111,7 @@ static const struct ingenic_cgu_clk_info 
> jz4740_cgu_clocks[] = {
> 
>  	[JZ4740_CLK_HCLK] = {
>  		"hclk", CGU_CLK_DIV,
> -		.parents = { JZ4740_CLK_PLL, -1, -1, -1 },
> +		.parents = { JZ4740_CLK_PLL },
>  		.div = {
>  			CGU_REG_CPCCR, 4, 1, 4, 22, -1, -1,
>  			jz4740_cgu_cpccr_div_table,
> @@ -120,7 +120,7 @@ static const struct ingenic_cgu_clk_info 
> jz4740_cgu_clocks[] = {
> 
>  	[JZ4740_CLK_PCLK] = {
>  		"pclk", CGU_CLK_DIV,
> -		.parents = { JZ4740_CLK_PLL, -1, -1, -1 },
> +		.parents = { JZ4740_CLK_PLL },
>  		.div = {
>  			CGU_REG_CPCCR, 8, 1, 4, 22, -1, -1,
>  			jz4740_cgu_cpccr_div_table,
> @@ -129,7 +129,7 @@ static const struct ingenic_cgu_clk_info 
> jz4740_cgu_clocks[] = {
> 
>  	[JZ4740_CLK_MCLK] = {
>  		"mclk", CGU_CLK_DIV,
> -		.parents = { JZ4740_CLK_PLL, -1, -1, -1 },
> +		.parents = { JZ4740_CLK_PLL },
>  		.div = {
>  			CGU_REG_CPCCR, 12, 1, 4, 22, -1, -1,
>  			jz4740_cgu_cpccr_div_table,
> @@ -138,7 +138,7 @@ static const struct ingenic_cgu_clk_info 
> jz4740_cgu_clocks[] = {
> 
>  	[JZ4740_CLK_LCD] = {
>  		"lcd", CGU_CLK_DIV | CGU_CLK_GATE,
> -		.parents = { JZ4740_CLK_PLL_HALF, -1, -1, -1 },
> +		.parents = { JZ4740_CLK_PLL_HALF },
>  		.div = {
>  			CGU_REG_CPCCR, 16, 1, 5, 22, -1, -1,
>  			jz4740_cgu_cpccr_div_table,
> @@ -148,13 +148,13 @@ static const struct ingenic_cgu_clk_info 
> jz4740_cgu_clocks[] = {
> 
>  	[JZ4740_CLK_LCD_PCLK] = {
>  		"lcd_pclk", CGU_CLK_DIV,
> -		.parents = { JZ4740_CLK_PLL_HALF, -1, -1, -1 },
> +		.parents = { JZ4740_CLK_PLL_HALF },
>  		.div = { CGU_REG_LPCDR, 0, 1, 11, -1, -1, -1 },
>  	},
> 
>  	[JZ4740_CLK_I2S] = {
>  		"i2s", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
> -		.parents = { JZ4740_CLK_EXT, JZ4740_CLK_PLL_HALF, -1, -1 },
> +		.parents = { JZ4740_CLK_EXT, JZ4740_CLK_PLL_HALF },
>  		.mux = { CGU_REG_CPCCR, 31, 1 },
>  		.div = { CGU_REG_I2SCDR, 0, 1, 9, -1, -1, -1 },
>  		.gate = { CGU_REG_CLKGR, 6 },
> @@ -162,7 +162,7 @@ static const struct ingenic_cgu_clk_info 
> jz4740_cgu_clocks[] = {
> 
>  	[JZ4740_CLK_SPI] = {
>  		"spi", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
> -		.parents = { JZ4740_CLK_EXT, JZ4740_CLK_PLL, -1, -1 },
> +		.parents = { JZ4740_CLK_EXT, JZ4740_CLK_PLL },
>  		.mux = { CGU_REG_SSICDR, 31, 1 },
>  		.div = { CGU_REG_SSICDR, 0, 1, 4, -1, -1, -1 },
>  		.gate = { CGU_REG_CLKGR, 4 },
> @@ -170,21 +170,21 @@ static const struct ingenic_cgu_clk_info 
> jz4740_cgu_clocks[] = {
> 
>  	[JZ4740_CLK_MMC] = {
>  		"mmc", CGU_CLK_DIV | CGU_CLK_GATE,
> -		.parents = { JZ4740_CLK_PLL_HALF, -1, -1, -1 },
> +		.parents = { JZ4740_CLK_PLL_HALF },
>  		.div = { CGU_REG_MSCCDR, 0, 1, 5, -1, -1, -1 },
>  		.gate = { CGU_REG_CLKGR, 7 },
>  	},
> 
>  	[JZ4740_CLK_UHC] = {
>  		"uhc", CGU_CLK_DIV | CGU_CLK_GATE,
> -		.parents = { JZ4740_CLK_PLL_HALF, -1, -1, -1 },
> +		.parents = { JZ4740_CLK_PLL_HALF },
>  		.div = { CGU_REG_UHCCDR, 0, 1, 4, -1, -1, -1 },
>  		.gate = { CGU_REG_CLKGR, 14 },
>  	},
> 
>  	[JZ4740_CLK_UDC] = {
>  		"udc", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
> -		.parents = { JZ4740_CLK_EXT, JZ4740_CLK_PLL_HALF, -1, -1 },
> +		.parents = { JZ4740_CLK_EXT, JZ4740_CLK_PLL_HALF },
>  		.mux = { CGU_REG_CPCCR, 29, 1 },
>  		.div = { CGU_REG_CPCCR, 23, 1, 6, -1, -1, -1 },
>  		.gate = { CGU_REG_SCR, 6, true },
> @@ -194,49 +194,49 @@ static const struct ingenic_cgu_clk_info 
> jz4740_cgu_clocks[] = {
> 
>  	[JZ4740_CLK_UART0] = {
>  		"uart0", CGU_CLK_GATE,
> -		.parents = { JZ4740_CLK_EXT, -1, -1, -1 },
> +		.parents = { JZ4740_CLK_EXT },
>  		.gate = { CGU_REG_CLKGR, 0 },
>  	},
> 
>  	[JZ4740_CLK_UART1] = {
>  		"uart1", CGU_CLK_GATE,
> -		.parents = { JZ4740_CLK_EXT, -1, -1, -1 },
> +		.parents = { JZ4740_CLK_EXT },
>  		.gate = { CGU_REG_CLKGR, 15 },
>  	},
> 
>  	[JZ4740_CLK_DMA] = {
>  		"dma", CGU_CLK_GATE,
> -		.parents = { JZ4740_CLK_PCLK, -1, -1, -1 },
> +		.parents = { JZ4740_CLK_PCLK },
>  		.gate = { CGU_REG_CLKGR, 12 },
>  	},
> 
>  	[JZ4740_CLK_IPU] = {
>  		"ipu", CGU_CLK_GATE,
> -		.parents = { JZ4740_CLK_PCLK, -1, -1, -1 },
> +		.parents = { JZ4740_CLK_PCLK },
>  		.gate = { CGU_REG_CLKGR, 13 },
>  	},
> 
>  	[JZ4740_CLK_ADC] = {
>  		"adc", CGU_CLK_GATE,
> -		.parents = { JZ4740_CLK_EXT, -1, -1, -1 },
> +		.parents = { JZ4740_CLK_EXT },
>  		.gate = { CGU_REG_CLKGR, 8 },
>  	},
> 
>  	[JZ4740_CLK_I2C] = {
>  		"i2c", CGU_CLK_GATE,
> -		.parents = { JZ4740_CLK_EXT, -1, -1, -1 },
> +		.parents = { JZ4740_CLK_EXT },
>  		.gate = { CGU_REG_CLKGR, 3 },
>  	},
> 
>  	[JZ4740_CLK_AIC] = {
>  		"aic", CGU_CLK_GATE,
> -		.parents = { JZ4740_CLK_EXT, -1, -1, -1 },
> +		.parents = { JZ4740_CLK_EXT },
>  		.gate = { CGU_REG_CLKGR, 5 },
>  	},
> 
>  	[JZ4740_CLK_TCU] = {
>  		"tcu", CGU_CLK_GATE,
> -		.parents = { JZ4740_CLK_EXT, -1, -1, -1 },
> +		.parents = { JZ4740_CLK_EXT },
>  		.gate = { CGU_REG_CLKGR, 1 },
>  	},
>  };
> diff --git a/drivers/clk/ingenic/jz4770-cgu.c 
> b/drivers/clk/ingenic/jz4770-cgu.c
> index 9ea4490..a907208 100644
> --- a/drivers/clk/ingenic/jz4770-cgu.c
> +++ b/drivers/clk/ingenic/jz4770-cgu.c
> @@ -19,7 +19,7 @@
>   * CPM registers offset address definition
>   */
>  #define CGU_REG_CPCCR		0x00
> -#define CGU_REG_LCR		0x04
> +#define CGU_REG_LCR			0x04
>  #define CGU_REG_CPPCR0		0x10
>  #define CGU_REG_CLKGR0		0x20
>  #define CGU_REG_OPCR		0x24
> @@ -41,7 +41,7 @@
>  #define CGU_REG_BCHCDR		0xAC
> 
>  /* bits within the OPCR register */
> -#define OPCR_SPENDH		BIT(5)		/* UHC PHY suspend */
> +#define OPCR_SPENDH			BIT(5)		/* UHC PHY suspend */
> 
>  /* bits within the USBPCR1 register */
>  #define USBPCR1_UHC_POWER	BIT(5)		/* UHC PHY power down */
> @@ -55,6 +55,7 @@ static int jz4770_uhc_phy_enable(struct clk_hw *hw)
> 
>  	writel(readl(reg_opcr) & ~OPCR_SPENDH, reg_opcr);
>  	writel(readl(reg_usbpcr1) | USBPCR1_UHC_POWER, reg_usbpcr1);
> +
>  	return 0;
>  }
> 
> @@ -150,7 +151,7 @@ static const struct ingenic_cgu_clk_info 
> jz4770_cgu_clocks[] = {
> 
>  	[JZ4770_CLK_CCLK] = {
>  		"cclk", CGU_CLK_DIV,
> -		.parents = { JZ4770_CLK_PLL0, },
> +		.parents = { JZ4770_CLK_PLL0 },

I don't mind you removing these, but I actually tend to always put 
commas in lists. My coding style, I guess.

>  		.div = {
>  			CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1,
>  			jz4770_cgu_cpccr_div_table,
> @@ -158,7 +159,7 @@ static const struct ingenic_cgu_clk_info 
> jz4770_cgu_clocks[] = {
>  	},
>  	[JZ4770_CLK_H0CLK] = {
>  		"h0clk", CGU_CLK_DIV,
> -		.parents = { JZ4770_CLK_PLL0, },
> +		.parents = { JZ4770_CLK_PLL0 },
>  		.div = {
>  			CGU_REG_CPCCR, 4, 1, 4, 22, -1, -1,
>  			jz4770_cgu_cpccr_div_table,
> @@ -166,7 +167,7 @@ static const struct ingenic_cgu_clk_info 
> jz4770_cgu_clocks[] = {
>  	},
>  	[JZ4770_CLK_H1CLK] = {
>  		"h1clk", CGU_CLK_DIV | CGU_CLK_GATE,
> -		.parents = { JZ4770_CLK_PLL0, },
> +		.parents = { JZ4770_CLK_PLL0 },
>  		.div = {
>  			CGU_REG_CPCCR, 24, 1, 4, 22, -1, -1,
>  			jz4770_cgu_cpccr_div_table,
> @@ -175,7 +176,7 @@ static const struct ingenic_cgu_clk_info 
> jz4770_cgu_clocks[] = {
>  	},
>  	[JZ4770_CLK_H2CLK] = {
>  		"h2clk", CGU_CLK_DIV,
> -		.parents = { JZ4770_CLK_PLL0, },
> +		.parents = { JZ4770_CLK_PLL0 },
>  		.div = {
>  			CGU_REG_CPCCR, 16, 1, 4, 22, -1, -1,
>  			jz4770_cgu_cpccr_div_table,
> @@ -183,7 +184,7 @@ static const struct ingenic_cgu_clk_info 
> jz4770_cgu_clocks[] = {
>  	},
>  	[JZ4770_CLK_C1CLK] = {
>  		"c1clk", CGU_CLK_DIV | CGU_CLK_GATE,
> -		.parents = { JZ4770_CLK_PLL0, },
> +		.parents = { JZ4770_CLK_PLL0 },
>  		.div = {
>  			CGU_REG_CPCCR, 12, 1, 4, 22, -1, -1,
>  			jz4770_cgu_cpccr_div_table,
> @@ -192,7 +193,7 @@ static const struct ingenic_cgu_clk_info 
> jz4770_cgu_clocks[] = {
>  	},
>  	[JZ4770_CLK_PCLK] = {
>  		"pclk", CGU_CLK_DIV,
> -		.parents = { JZ4770_CLK_PLL0, },
> +		.parents = { JZ4770_CLK_PLL0 },
>  		.div = {
>  			CGU_REG_CPCCR, 8, 1, 4, 22, -1, -1,
>  			jz4770_cgu_cpccr_div_table,
> @@ -203,63 +204,63 @@ static const struct ingenic_cgu_clk_info 
> jz4770_cgu_clocks[] = {
> 
>  	[JZ4770_CLK_MMC0_MUX] = {
>  		"mmc0_mux", CGU_CLK_DIV | CGU_CLK_GATE | CGU_CLK_MUX,
> -		.parents = { JZ4770_CLK_PLL0, JZ4770_CLK_PLL1, },
> +		.parents = { JZ4770_CLK_PLL0, JZ4770_CLK_PLL1 },
>  		.mux = { CGU_REG_MSC0CDR, 30, 1 },
>  		.div = { CGU_REG_MSC0CDR, 0, 1, 7, -1, -1, 31 },
>  		.gate = { CGU_REG_MSC0CDR, 31 },
>  	},
>  	[JZ4770_CLK_MMC1_MUX] = {
>  		"mmc1_mux", CGU_CLK_DIV | CGU_CLK_GATE | CGU_CLK_MUX,
> -		.parents = { JZ4770_CLK_PLL0, JZ4770_CLK_PLL1, },
> +		.parents = { JZ4770_CLK_PLL0, JZ4770_CLK_PLL1 },
>  		.mux = { CGU_REG_MSC1CDR, 30, 1 },
>  		.div = { CGU_REG_MSC1CDR, 0, 1, 7, -1, -1, 31 },
>  		.gate = { CGU_REG_MSC1CDR, 31 },
>  	},
>  	[JZ4770_CLK_MMC2_MUX] = {
>  		"mmc2_mux", CGU_CLK_DIV | CGU_CLK_GATE | CGU_CLK_MUX,
> -		.parents = { JZ4770_CLK_PLL0, JZ4770_CLK_PLL1, },
> +		.parents = { JZ4770_CLK_PLL0, JZ4770_CLK_PLL1 },
>  		.mux = { CGU_REG_MSC2CDR, 30, 1 },
>  		.div = { CGU_REG_MSC2CDR, 0, 1, 7, -1, -1, 31 },
>  		.gate = { CGU_REG_MSC2CDR, 31 },
>  	},
>  	[JZ4770_CLK_CIM] = {
>  		"cim", CGU_CLK_DIV | CGU_CLK_GATE | CGU_CLK_MUX,
> -		.parents = { JZ4770_CLK_PLL0, JZ4770_CLK_PLL1, },
> +		.parents = { JZ4770_CLK_PLL0, JZ4770_CLK_PLL1 },
>  		.mux = { CGU_REG_CIMCDR, 31, 1 },
>  		.div = { CGU_REG_CIMCDR, 0, 1, 8, -1, -1, -1 },
>  		.gate = { CGU_REG_CLKGR0, 26 },
>  	},
>  	[JZ4770_CLK_UHC] = {
>  		"uhc", CGU_CLK_DIV | CGU_CLK_GATE | CGU_CLK_MUX,
> -		.parents = { JZ4770_CLK_PLL0, JZ4770_CLK_PLL1, },
> +		.parents = { JZ4770_CLK_PLL0, JZ4770_CLK_PLL1 },
>  		.mux = { CGU_REG_UHCCDR, 29, 1 },
>  		.div = { CGU_REG_UHCCDR, 0, 1, 4, -1, -1, -1 },
>  		.gate = { CGU_REG_CLKGR0, 24 },
>  	},
>  	[JZ4770_CLK_GPU] = {
>  		"gpu", CGU_CLK_DIV | CGU_CLK_GATE | CGU_CLK_MUX,
> -		.parents = { JZ4770_CLK_PLL0, JZ4770_CLK_PLL1, -1 },
> +		.parents = { JZ4770_CLK_PLL0, JZ4770_CLK_PLL1 },
>  		.mux = { CGU_REG_GPUCDR, 31, 1 },
>  		.div = { CGU_REG_GPUCDR, 0, 1, 3, -1, -1, -1 },
>  		.gate = { CGU_REG_CLKGR1, 9 },
>  	},
>  	[JZ4770_CLK_BCH] = {
>  		"bch", CGU_CLK_DIV | CGU_CLK_GATE | CGU_CLK_MUX,
> -		.parents = { JZ4770_CLK_PLL0, JZ4770_CLK_PLL1, },
> +		.parents = { JZ4770_CLK_PLL0, JZ4770_CLK_PLL1 },
>  		.mux = { CGU_REG_BCHCDR, 31, 1 },
>  		.div = { CGU_REG_BCHCDR, 0, 1, 3, -1, -1, -1 },
>  		.gate = { CGU_REG_CLKGR0, 1 },
>  	},
>  	[JZ4770_CLK_LPCLK_MUX] = {
>  		"lpclk", CGU_CLK_DIV | CGU_CLK_GATE | CGU_CLK_MUX,
> -		.parents = { JZ4770_CLK_PLL0, JZ4770_CLK_PLL1, },
> +		.parents = { JZ4770_CLK_PLL0, JZ4770_CLK_PLL1 },
>  		.mux = { CGU_REG_LPCDR, 29, 1 },
>  		.div = { CGU_REG_LPCDR, 0, 1, 11, -1, -1, -1 },
>  		.gate = { CGU_REG_CLKGR0, 28 },
>  	},
>  	[JZ4770_CLK_GPS] = {
>  		"gps", CGU_CLK_DIV | CGU_CLK_GATE | CGU_CLK_MUX,
> -		.parents = { JZ4770_CLK_PLL0, JZ4770_CLK_PLL1, },
> +		.parents = { JZ4770_CLK_PLL0, JZ4770_CLK_PLL1 },
>  		.mux = { CGU_REG_GPSCDR, 31, 1 },
>  		.div = { CGU_REG_GPSCDR, 0, 1, 4, -1, -1, -1 },
>  		.gate = { CGU_REG_CLKGR0, 22 },
> @@ -302,107 +303,107 @@ static const struct ingenic_cgu_clk_info 
> jz4770_cgu_clocks[] = {
> 
>  	[JZ4770_CLK_SSI0] = {
>  		"ssi0", CGU_CLK_GATE,
> -		.parents = { JZ4770_CLK_SSI_MUX, },
> +		.parents = { JZ4770_CLK_SSI_MUX },
>  		.gate = { CGU_REG_CLKGR0, 4 },
>  	},
>  	[JZ4770_CLK_SSI1] = {
>  		"ssi1", CGU_CLK_GATE,
> -		.parents = { JZ4770_CLK_SSI_MUX, },
> +		.parents = { JZ4770_CLK_SSI_MUX },
>  		.gate = { CGU_REG_CLKGR0, 19 },
>  	},
>  	[JZ4770_CLK_SSI2] = {
>  		"ssi2", CGU_CLK_GATE,
> -		.parents = { JZ4770_CLK_SSI_MUX, },
> +		.parents = { JZ4770_CLK_SSI_MUX },
>  		.gate = { CGU_REG_CLKGR0, 20 },
>  	},
>  	[JZ4770_CLK_PCM0] = {
>  		"pcm0", CGU_CLK_GATE,
> -		.parents = { JZ4770_CLK_PCM_MUX, },
> +		.parents = { JZ4770_CLK_PCM_MUX },
>  		.gate = { CGU_REG_CLKGR1, 8 },
>  	},
>  	[JZ4770_CLK_PCM1] = {
>  		"pcm1", CGU_CLK_GATE,
> -		.parents = { JZ4770_CLK_PCM_MUX, },
> +		.parents = { JZ4770_CLK_PCM_MUX },
>  		.gate = { CGU_REG_CLKGR1, 10 },
>  	},
>  	[JZ4770_CLK_DMA] = {
>  		"dma", CGU_CLK_GATE,
> -		.parents = { JZ4770_CLK_H2CLK, },
> +		.parents = { JZ4770_CLK_H2CLK },
>  		.gate = { CGU_REG_CLKGR0, 21 },
>  	},
>  	[JZ4770_CLK_I2C0] = {
>  		"i2c0", CGU_CLK_GATE,
> -		.parents = { JZ4770_CLK_EXT, },
> +		.parents = { JZ4770_CLK_EXT },
>  		.gate = { CGU_REG_CLKGR0, 5 },
>  	},
>  	[JZ4770_CLK_I2C1] = {
>  		"i2c1", CGU_CLK_GATE,
> -		.parents = { JZ4770_CLK_EXT, },
> +		.parents = { JZ4770_CLK_EXT },
>  		.gate = { CGU_REG_CLKGR0, 6 },
>  	},
>  	[JZ4770_CLK_I2C2] = {
>  		"i2c2", CGU_CLK_GATE,
> -		.parents = { JZ4770_CLK_EXT, },
> +		.parents = { JZ4770_CLK_EXT },
>  		.gate = { CGU_REG_CLKGR1, 15 },
>  	},
>  	[JZ4770_CLK_UART0] = {
>  		"uart0", CGU_CLK_GATE,
> -		.parents = { JZ4770_CLK_EXT, },
> +		.parents = { JZ4770_CLK_EXT },
>  		.gate = { CGU_REG_CLKGR0, 15 },
>  	},
>  	[JZ4770_CLK_UART1] = {
>  		"uart1", CGU_CLK_GATE,
> -		.parents = { JZ4770_CLK_EXT, },
> +		.parents = { JZ4770_CLK_EXT },
>  		.gate = { CGU_REG_CLKGR0, 16 },
>  	},
>  	[JZ4770_CLK_UART2] = {
>  		"uart2", CGU_CLK_GATE,
> -		.parents = { JZ4770_CLK_EXT, },
> +		.parents = { JZ4770_CLK_EXT },
>  		.gate = { CGU_REG_CLKGR0, 17 },
>  	},
>  	[JZ4770_CLK_UART3] = {
>  		"uart3", CGU_CLK_GATE,
> -		.parents = { JZ4770_CLK_EXT, },
> +		.parents = { JZ4770_CLK_EXT },
>  		.gate = { CGU_REG_CLKGR0, 18 },
>  	},
>  	[JZ4770_CLK_IPU] = {
>  		"ipu", CGU_CLK_GATE,
> -		.parents = { JZ4770_CLK_H0CLK, },
> +		.parents = { JZ4770_CLK_H0CLK },
>  		.gate = { CGU_REG_CLKGR0, 29 },
>  	},
>  	[JZ4770_CLK_ADC] = {
>  		"adc", CGU_CLK_GATE,
> -		.parents = { JZ4770_CLK_EXT, },
> +		.parents = { JZ4770_CLK_EXT },
>  		.gate = { CGU_REG_CLKGR0, 14 },
>  	},
>  	[JZ4770_CLK_AIC] = {
>  		"aic", CGU_CLK_GATE,
> -		.parents = { JZ4770_CLK_EXT, },
> +		.parents = { JZ4770_CLK_EXT },
>  		.gate = { CGU_REG_CLKGR0, 8 },
>  	},
>  	[JZ4770_CLK_AUX] = {
>  		"aux", CGU_CLK_GATE,
> -		.parents = { JZ4770_CLK_C1CLK, },
> +		.parents = { JZ4770_CLK_C1CLK },
>  		.gate = { CGU_REG_CLKGR1, 14 },
>  	},
>  	[JZ4770_CLK_VPU] = {
>  		"vpu", CGU_CLK_GATE,
> -		.parents = { JZ4770_CLK_H1CLK, },
> +		.parents = { JZ4770_CLK_H1CLK },
>  		.gate = { CGU_REG_LCR, 30, false, 150 },
>  	},
>  	[JZ4770_CLK_MMC0] = {
>  		"mmc0", CGU_CLK_GATE,
> -		.parents = { JZ4770_CLK_MMC0_MUX, },
> +		.parents = { JZ4770_CLK_MMC0_MUX },
>  		.gate = { CGU_REG_CLKGR0, 3 },
>  	},
>  	[JZ4770_CLK_MMC1] = {
>  		"mmc1", CGU_CLK_GATE,
> -		.parents = { JZ4770_CLK_MMC1_MUX, },
> +		.parents = { JZ4770_CLK_MMC1_MUX },
>  		.gate = { CGU_REG_CLKGR0, 11 },
>  	},
>  	[JZ4770_CLK_MMC2] = {
>  		"mmc2", CGU_CLK_GATE,
> -		.parents = { JZ4770_CLK_MMC2_MUX, },
> +		.parents = { JZ4770_CLK_MMC2_MUX },
>  		.gate = { CGU_REG_CLKGR0, 12 },
>  	},
>  	[JZ4770_CLK_OTG_PHY] = {
> @@ -427,7 +428,7 @@ static const struct ingenic_cgu_clk_info 
> jz4770_cgu_clocks[] = {
> 
>  	[JZ4770_CLK_RTC] = {
>  		"rtc", CGU_CLK_MUX,
> -		.parents = { JZ4770_CLK_EXT512, JZ4770_CLK_OSC32K, },
> +		.parents = { JZ4770_CLK_EXT512, JZ4770_CLK_OSC32K },
>  		.mux = { CGU_REG_OPCR, 2, 1},
>  	},
>  };
> diff --git a/drivers/clk/ingenic/jz4780-cgu.c 
> b/drivers/clk/ingenic/jz4780-cgu.c
> index dcca74e..6c6f22c 100644
> --- a/drivers/clk/ingenic/jz4780-cgu.c
> +++ b/drivers/clk/ingenic/jz4780-cgu.c
> @@ -178,6 +178,7 @@ static int jz4780_otg_phy_set_rate(struct clk_hw 
> *hw, unsigned long req_rate,
>  	writel(usbpcr1, cgu->base + CGU_REG_USBPCR1);
> 
>  	spin_unlock_irqrestore(&cgu->lock, flags);
> +
>  	return 0;
>  }
> 
> @@ -188,6 +189,7 @@ static int jz4780_otg_phy_enable(struct clk_hw 
> *hw)
> 
>  	writel(readl(reg_opcr) | OPCR_SPENDN0, reg_opcr);
>  	writel(readl(reg_usbpcr) & ~USBPCR_OTG_DISABLE & ~USBPCR_SIDDQ, 
> reg_usbpcr);
> +
>  	return 0;
>  }
> 
> @@ -215,9 +217,9 @@ static const struct clk_ops jz4780_otg_phy_ops = {
>  	.round_rate = jz4780_otg_phy_round_rate,
>  	.set_rate = jz4780_otg_phy_set_rate,
> 
> -	.enable		= jz4780_otg_phy_enable,
> -	.disable	= jz4780_otg_phy_disable,
> -	.is_enabled	= jz4780_otg_phy_is_enabled,
> +	.enable = jz4780_otg_phy_enable,
> +	.disable = jz4780_otg_phy_disable,
> +	.is_enabled = jz4780_otg_phy_is_enabled,
>  };
> 
>  static int jz4780_core1_enable(struct clk_hw *hw)
> @@ -312,35 +314,41 @@ static const struct ingenic_cgu_clk_info 
> jz4780_cgu_clocks[] = {
> 
>  	[JZ4780_CLK_APLL] = {
>  		"apll", CGU_CLK_PLL,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.pll = DEF_PLL(APLL),
>  	},
> 
>  	[JZ4780_CLK_MPLL] = {
>  		"mpll", CGU_CLK_PLL,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.pll = DEF_PLL(MPLL),
>  	},
> 
>  	[JZ4780_CLK_EPLL] = {
>  		"epll", CGU_CLK_PLL,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.pll = DEF_PLL(EPLL),
>  	},
> 
>  	[JZ4780_CLK_VPLL] = {
>  		"vpll", CGU_CLK_PLL,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.pll = DEF_PLL(VPLL),
>  	},
> 
>  #undef DEF_PLL
> 
> -	/* Custom (SoC-specific) OTG PHY */
> +	/* Custom (SoC-specific) */
> +
> +	[JZ4780_CLK_CORE1] = {
> +		"core1", CGU_CLK_CUSTOM,
> +		.parents = { JZ4780_CLK_CPU, -1, -1, -1 },
> +		.custom = { &jz4780_core1_ops },
> +	},
> 
>  	[JZ4780_CLK_OTGPHY] = {
>  		"otg_phy", CGU_CLK_CUSTOM,
> -		.parents = { -1, -1, JZ4780_CLK_EXCLK, -1 },
> +		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
>  		.custom = { &jz4780_otg_phy_ops },
>  	},
> 
> @@ -362,13 +370,13 @@ static const struct ingenic_cgu_clk_info 
> jz4780_cgu_clocks[] = {
> 
>  	[JZ4780_CLK_CPU] = {
>  		"cpu", CGU_CLK_DIV,
> -		.parents = { JZ4780_CLK_CPUMUX, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_CPUMUX },
>  		.div = { CGU_REG_CLOCKCONTROL, 0, 1, 4, 22, -1, -1 },
>  	},
> 
>  	[JZ4780_CLK_L2CACHE] = {
>  		"l2cache", CGU_CLK_DIV,
> -		.parents = { JZ4780_CLK_CPUMUX, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_CPUMUX },
>  		.div = { CGU_REG_CLOCKCONTROL, 4, 1, 4, -1, -1, -1 },
>  	},
> 
> @@ -389,13 +397,13 @@ static const struct ingenic_cgu_clk_info 
> jz4780_cgu_clocks[] = {
> 
>  	[JZ4780_CLK_AHB2] = {
>  		"ahb2", CGU_CLK_DIV,
> -		.parents = { JZ4780_CLK_AHB2PMUX, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_AHB2PMUX },
>  		.div = { CGU_REG_CLOCKCONTROL, 12, 1, 4, 20, -1, -1 },
>  	},
> 
>  	[JZ4780_CLK_PCLK] = {
>  		"pclk", CGU_CLK_DIV,
> -		.parents = { JZ4780_CLK_AHB2PMUX, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_AHB2PMUX },
>  		.div = { CGU_REG_CLOCKCONTROL, 16, 1, 4, 20, -1, -1 },
>  	},
> 
> @@ -417,14 +425,14 @@ static const struct ingenic_cgu_clk_info 
> jz4780_cgu_clocks[] = {
> 
>  	[JZ4780_CLK_I2SPLL] = {
>  		"i2s_pll", CGU_CLK_MUX | CGU_CLK_DIV,
> -		.parents = { JZ4780_CLK_SCLKA, JZ4780_CLK_EPLL, -1, -1 },
> +		.parents = { JZ4780_CLK_SCLKA, JZ4780_CLK_EPLL },
>  		.mux = { CGU_REG_I2SCDR, 30, 1 },
>  		.div = { CGU_REG_I2SCDR, 0, 1, 8, 29, 28, 27 },
>  	},
> 
>  	[JZ4780_CLK_I2S] = {
>  		"i2s", CGU_CLK_MUX,
> -		.parents = { JZ4780_CLK_EXCLK, JZ4780_CLK_I2SPLL, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK, JZ4780_CLK_I2SPLL },
>  		.mux = { CGU_REG_I2SCDR, 31, 1 },
>  	},
> 
> @@ -452,21 +460,21 @@ static const struct ingenic_cgu_clk_info 
> jz4780_cgu_clocks[] = {
> 
>  	[JZ4780_CLK_MSC0] = {
>  		"msc0", CGU_CLK_DIV | CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_MSCMUX, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_MSCMUX },
>  		.div = { CGU_REG_MSC0CDR, 0, 2, 8, 29, 28, 27 },
>  		.gate = { CGU_REG_CLKGR0, 3 },
>  	},
> 
>  	[JZ4780_CLK_MSC1] = {
>  		"msc1", CGU_CLK_DIV | CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_MSCMUX, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_MSCMUX },
>  		.div = { CGU_REG_MSC1CDR, 0, 2, 8, 29, 28, 27 },
>  		.gate = { CGU_REG_CLKGR0, 11 },
>  	},
> 
>  	[JZ4780_CLK_MSC2] = {
>  		"msc2", CGU_CLK_DIV | CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_MSCMUX, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_MSCMUX },
>  		.div = { CGU_REG_MSC2CDR, 0, 2, 8, 29, 28, 27 },
>  		.gate = { CGU_REG_CLKGR0, 12 },
>  	},
> @@ -482,20 +490,20 @@ static const struct ingenic_cgu_clk_info 
> jz4780_cgu_clocks[] = {
> 
>  	[JZ4780_CLK_SSIPLL] = {
>  		"ssi_pll", CGU_CLK_MUX | CGU_CLK_DIV,
> -		.parents = { JZ4780_CLK_SCLKA, JZ4780_CLK_MPLL, -1, -1 },
> +		.parents = { JZ4780_CLK_SCLKA, JZ4780_CLK_MPLL },
>  		.mux = { CGU_REG_SSICDR, 30, 1 },
>  		.div = { CGU_REG_SSICDR, 0, 1, 8, 29, 28, 27 },
>  	},
> 
>  	[JZ4780_CLK_SSI] = {
>  		"ssi", CGU_CLK_MUX,
> -		.parents = { JZ4780_CLK_EXCLK, JZ4780_CLK_SSIPLL, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK, JZ4780_CLK_SSIPLL },
>  		.mux = { CGU_REG_SSICDR, 31, 1 },
>  	},
> 
>  	[JZ4780_CLK_CIMMCLK] = {
>  		"cim_mclk", CGU_CLK_MUX | CGU_CLK_DIV,
> -		.parents = { JZ4780_CLK_SCLKA, JZ4780_CLK_MPLL, -1, -1 },
> +		.parents = { JZ4780_CLK_SCLKA, JZ4780_CLK_MPLL },
>  		.mux = { CGU_REG_CIMCDR, 31, 1 },
>  		.div = { CGU_REG_CIMCDR, 0, 1, 8, 30, 29, 28 },
>  	},
> @@ -510,7 +518,7 @@ static const struct ingenic_cgu_clk_info 
> jz4780_cgu_clocks[] = {
> 
>  	[JZ4780_CLK_PCM] = {
>  		"pcm", CGU_CLK_MUX | CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_EXCLK, JZ4780_CLK_PCMPLL, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK, JZ4780_CLK_PCMPLL },
>  		.mux = { CGU_REG_PCMCDR, 31, 1 },
>  		.gate = { CGU_REG_CLKGR1, 3 },
>  	},
> @@ -558,238 +566,231 @@ static const struct ingenic_cgu_clk_info 
> jz4780_cgu_clocks[] = {
> 
>  	[JZ4780_CLK_NEMC] = {
>  		"nemc", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_AHB2, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_AHB2 },
>  		.gate = { CGU_REG_CLKGR0, 0 },
>  	},
> 
>  	[JZ4780_CLK_OTG0] = {
>  		"otg0", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR0, 2 },
>  	},
> 
>  	[JZ4780_CLK_SSI0] = {
>  		"ssi0", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_SSI, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_SSI },
>  		.gate = { CGU_REG_CLKGR0, 4 },
>  	},
> 
>  	[JZ4780_CLK_SMB0] = {
>  		"smb0", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_PCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_PCLK },
>  		.gate = { CGU_REG_CLKGR0, 5 },
>  	},
> 
>  	[JZ4780_CLK_SMB1] = {
>  		"smb1", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_PCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_PCLK },
>  		.gate = { CGU_REG_CLKGR0, 6 },
>  	},
> 
>  	[JZ4780_CLK_SCC] = {
>  		"scc", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR0, 7 },
>  	},
> 
>  	[JZ4780_CLK_AIC] = {
>  		"aic", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR0, 8 },
>  	},
> 
>  	[JZ4780_CLK_TSSI0] = {
>  		"tssi0", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR0, 9 },
>  	},
> 
>  	[JZ4780_CLK_OWI] = {
>  		"owi", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR0, 10 },
>  	},
> 
>  	[JZ4780_CLK_KBC] = {
>  		"kbc", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR0, 13 },
>  	},
> 
>  	[JZ4780_CLK_SADC] = {
>  		"sadc", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR0, 14 },
>  	},
> 
>  	[JZ4780_CLK_UART0] = {
>  		"uart0", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR0, 15 },
>  	},
> 
>  	[JZ4780_CLK_UART1] = {
>  		"uart1", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR0, 16 },
>  	},
> 
>  	[JZ4780_CLK_UART2] = {
>  		"uart2", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR0, 17 },
>  	},
> 
>  	[JZ4780_CLK_UART3] = {
>  		"uart3", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR0, 18 },
>  	},
> 
>  	[JZ4780_CLK_SSI1] = {
>  		"ssi1", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_SSI, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_SSI },
>  		.gate = { CGU_REG_CLKGR0, 19 },
>  	},
> 
>  	[JZ4780_CLK_SSI2] = {
>  		"ssi2", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_SSI, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_SSI },
>  		.gate = { CGU_REG_CLKGR0, 20 },
>  	},
> 
>  	[JZ4780_CLK_PDMA] = {
>  		"pdma", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR0, 21 },
>  	},
> 
>  	[JZ4780_CLK_GPS] = {
>  		"gps", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR0, 22 },
>  	},
> 
>  	[JZ4780_CLK_MAC] = {
>  		"mac", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR0, 23 },
>  	},
> 
>  	[JZ4780_CLK_SMB2] = {
>  		"smb2", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_PCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_PCLK },
>  		.gate = { CGU_REG_CLKGR0, 24 },
>  	},
> 
>  	[JZ4780_CLK_CIM] = {
>  		"cim", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR0, 26 },
>  	},
> 
>  	[JZ4780_CLK_LCD] = {
>  		"lcd", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR0, 28 },
>  	},
> 
>  	[JZ4780_CLK_TVE] = {
>  		"tve", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_LCD, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_LCD },
>  		.gate = { CGU_REG_CLKGR0, 27 },
>  	},
> 
>  	[JZ4780_CLK_IPU] = {
>  		"ipu", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR0, 29 },
>  	},
> 
>  	[JZ4780_CLK_DDR0] = {
>  		"ddr0", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_DDR, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_DDR },
>  		.gate = { CGU_REG_CLKGR0, 30 },
>  	},
> 
>  	[JZ4780_CLK_DDR1] = {
>  		"ddr1", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_DDR, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_DDR },
>  		.gate = { CGU_REG_CLKGR0, 31 },
>  	},
> 
>  	[JZ4780_CLK_SMB3] = {
>  		"smb3", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_PCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_PCLK },
>  		.gate = { CGU_REG_CLKGR1, 0 },
>  	},
> 
>  	[JZ4780_CLK_TSSI1] = {
>  		"tssi1", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR1, 1 },
>  	},
> 
>  	[JZ4780_CLK_COMPRESS] = {
>  		"compress", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR1, 5 },
>  	},
> 
>  	[JZ4780_CLK_AIC1] = {
>  		"aic1", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR1, 6 },
>  	},
> 
>  	[JZ4780_CLK_GPVLC] = {
>  		"gpvlc", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR1, 7 },
>  	},
> 
>  	[JZ4780_CLK_OTG1] = {
>  		"otg1", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR1, 8 },
>  	},
> 
>  	[JZ4780_CLK_UART4] = {
>  		"uart4", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR1, 10 },
>  	},
> 
>  	[JZ4780_CLK_AHBMON] = {
>  		"ahb_mon", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR1, 11 },
>  	},
> 
>  	[JZ4780_CLK_SMB4] = {
>  		"smb4", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_PCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_PCLK },
>  		.gate = { CGU_REG_CLKGR1, 12 },
>  	},
> 
>  	[JZ4780_CLK_DES] = {
>  		"des", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR1, 13 },
>  	},
> 
>  	[JZ4780_CLK_X2D] = {
>  		"x2d", CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { JZ4780_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR1, 14 },
>  	},
> -
> -	[JZ4780_CLK_CORE1] = {
> -		"core1", CGU_CLK_CUSTOM,
> -		.parents = { JZ4780_CLK_CPU, -1, -1, -1 },
> -		.custom = { &jz4780_core1_ops },
> -	},
> -
>  };
> 
>  static void __init jz4780_cgu_init(struct device_node *np)
> diff --git a/drivers/clk/ingenic/x1000-cgu.c 
> b/drivers/clk/ingenic/x1000-cgu.c
> index f03dd47..8d9a1c2 100644
> --- a/drivers/clk/ingenic/x1000-cgu.c
> +++ b/drivers/clk/ingenic/x1000-cgu.c
> @@ -15,38 +15,38 @@
>  #include "pm.h"
> 
>  /* CGU register offsets */
> -#define CGU_REG_CPCCR		0x00
> -#define CGU_REG_APLL		0x10
> -#define CGU_REG_MPLL		0x14
> -#define CGU_REG_CLKGR		0x20
> -#define CGU_REG_OPCR		0x24
> -#define CGU_REG_DDRCDR		0x2c
> -#define CGU_REG_USBPCR		0x3c
> -#define CGU_REG_USBPCR1		0x48
> -#define CGU_REG_USBCDR		0x50
> -#define CGU_REG_MACCDR		0x54
> -#define CGU_REG_I2SCDR		0x60
> -#define CGU_REG_LPCDR		0x64
> -#define CGU_REG_MSC0CDR		0x68
> -#define CGU_REG_I2SCDR1		0x70
> -#define CGU_REG_SSICDR		0x74
> -#define CGU_REG_CIMCDR		0x7c
> -#define CGU_REG_PCMCDR		0x84
> -#define CGU_REG_MSC1CDR		0xa4
> -#define CGU_REG_CMP_INTR	0xb0
> -#define CGU_REG_CMP_INTRE	0xb4
> -#define CGU_REG_DRCG		0xd0
> -#define CGU_REG_CPCSR		0xd4
> -#define CGU_REG_PCMCDR1		0xe0
> -#define CGU_REG_MACPHYC		0xe8
> +#define CGU_REG_CPCCR			0x00
> +#define CGU_REG_APLL			0x10
> +#define CGU_REG_MPLL			0x14
> +#define CGU_REG_CLKGR			0x20
> +#define CGU_REG_OPCR			0x24
> +#define CGU_REG_DDRCDR			0x2c
> +#define CGU_REG_USBPCR			0x3c
> +#define CGU_REG_USBPCR1			0x48
> +#define CGU_REG_USBCDR			0x50
> +#define CGU_REG_MACCDR			0x54
> +#define CGU_REG_I2SCDR			0x60
> +#define CGU_REG_LPCDR			0x64
> +#define CGU_REG_MSC0CDR			0x68
> +#define CGU_REG_I2SCDR1			0x70
> +#define CGU_REG_SSICDR			0x74
> +#define CGU_REG_CIMCDR			0x7c
> +#define CGU_REG_PCMCDR			0x84
> +#define CGU_REG_MSC1CDR			0xa4
> +#define CGU_REG_CMP_INTR		0xb0
> +#define CGU_REG_CMP_INTRE		0xb4
> +#define CGU_REG_DRCG			0xd0
> +#define CGU_REG_CPCSR			0xd4
> +#define CGU_REG_PCMCDR1			0xe0
> +#define CGU_REG_MACPHYC			0xe8
> 
>  /* bits within the OPCR register */
> -#define OPCR_SPENDN0		BIT(7)
> -#define OPCR_SPENDN1		BIT(6)
> +#define OPCR_SPENDN0			BIT(7)
> +#define OPCR_SPENDN1			BIT(6)
> 
>  /* bits within the USBPCR register */
> -#define USBPCR_SIDDQ		BIT(21)
> -#define USBPCR_OTG_DISABLE	BIT(20)
> +#define USBPCR_SIDDQ			BIT(21)
> +#define USBPCR_OTG_DISABLE		BIT(20)
> 
>  /* bits within the USBPCR1 register */
>  #define USBPCR1_REFCLKSEL_SHIFT	26
> @@ -137,6 +137,7 @@ static int x1000_otg_phy_set_rate(struct clk_hw 
> *hw, unsigned long req_rate,
>  	writel(usbpcr1, cgu->base + CGU_REG_USBPCR1);
> 
>  	spin_unlock_irqrestore(&cgu->lock, flags);
> +
>  	return 0;
>  }
> 
> @@ -147,6 +148,7 @@ static int x1000_usb_phy_enable(struct clk_hw *hw)
> 
>  	writel(readl(reg_opcr) | OPCR_SPENDN0, reg_opcr);
>  	writel(readl(reg_usbpcr) & ~USBPCR_OTG_DISABLE & ~USBPCR_SIDDQ, 
> reg_usbpcr);
> +
>  	return 0;
>  }
> 
> @@ -174,9 +176,9 @@ static const struct clk_ops x1000_otg_phy_ops = {
>  	.round_rate = x1000_otg_phy_round_rate,
>  	.set_rate = x1000_otg_phy_set_rate,
> 
> -	.enable		= x1000_usb_phy_enable,
> -	.disable	= x1000_usb_phy_disable,
> -	.is_enabled	= x1000_usb_phy_is_enabled,
> +	.enable = x1000_usb_phy_enable,
> +	.disable = x1000_usb_phy_disable,
> +	.is_enabled = x1000_usb_phy_is_enabled,

Isn't it better aligned?

Cheers,
-Paul

>  };
> 
>  static u8 x1000_i2s_get_parent(struct clk_hw *hw)
> @@ -363,7 +365,7 @@ static const struct ingenic_cgu_clk_info 
> x1000_cgu_clocks[] = {
> 
>  	[X1000_CLK_APLL] = {
>  		"apll", CGU_CLK_PLL,
> -		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { X1000_CLK_EXCLK },
>  		.pll = {
>  			.reg = CGU_REG_APLL,
>  			.rate_multiplier = 1,
> @@ -386,7 +388,7 @@ static const struct ingenic_cgu_clk_info 
> x1000_cgu_clocks[] = {
> 
>  	[X1000_CLK_MPLL] = {
>  		"mpll", CGU_CLK_PLL,
> -		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { X1000_CLK_EXCLK },
>  		.pll = {
>  			.reg = CGU_REG_MPLL,
>  			.rate_multiplier = 1,
> @@ -411,7 +413,7 @@ static const struct ingenic_cgu_clk_info 
> x1000_cgu_clocks[] = {
> 
>  	[X1000_CLK_OTGPHY] = {
>  		"otg_phy", CGU_CLK_CUSTOM,
> -		.parents = { -1, -1, X1000_CLK_EXCLK, -1 },
> +		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
>  		.custom = { &x1000_otg_phy_ops },
>  	},
> 
> @@ -437,14 +439,14 @@ static const struct ingenic_cgu_clk_info 
> x1000_cgu_clocks[] = {
> 
>  	[X1000_CLK_CPU] = {
>  		"cpu", CGU_CLK_DIV | CGU_CLK_GATE,
> -		.parents = { X1000_CLK_CPUMUX, -1, -1, -1 },
> +		.parents = { X1000_CLK_CPUMUX },
>  		.div = { CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1 },
>  		.gate = { CGU_REG_CLKGR, 30 },
>  	},
> 
>  	[X1000_CLK_L2CACHE] = {
>  		"l2cache", CGU_CLK_DIV,
> -		.parents = { X1000_CLK_CPUMUX, -1, -1, -1 },
> +		.parents = { X1000_CLK_CPUMUX },
>  		.div = { CGU_REG_CPCCR, 4, 1, 4, 22, -1, -1 },
>  	},
> 
> @@ -463,13 +465,13 @@ static const struct ingenic_cgu_clk_info 
> x1000_cgu_clocks[] = {
> 
>  	[X1000_CLK_AHB2] = {
>  		"ahb2", CGU_CLK_DIV,
> -		.parents = { X1000_CLK_AHB2PMUX, -1, -1, -1 },
> +		.parents = { X1000_CLK_AHB2PMUX },
>  		.div = { CGU_REG_CPCCR, 12, 1, 4, 20, -1, -1 },
>  	},
> 
>  	[X1000_CLK_PCLK] = {
>  		"pclk", CGU_CLK_DIV | CGU_CLK_GATE,
> -		.parents = { X1000_CLK_AHB2PMUX, -1, -1, -1 },
> +		.parents = { X1000_CLK_AHB2PMUX },
>  		.div = { CGU_REG_CPCCR, 16, 1, 4, 20, -1, -1 },
>  		.gate = { CGU_REG_CLKGR, 28 },
>  	},
> @@ -499,20 +501,20 @@ static const struct ingenic_cgu_clk_info 
> x1000_cgu_clocks[] = {
> 
>  	[X1000_CLK_MSCMUX] = {
>  		"msc_mux", CGU_CLK_MUX,
> -		.parents = { X1000_CLK_SCLKA, X1000_CLK_MPLL},
> +		.parents = { X1000_CLK_SCLKA, X1000_CLK_MPLL },
>  		.mux = { CGU_REG_MSC0CDR, 31, 1 },
>  	},
> 
>  	[X1000_CLK_MSC0] = {
>  		"msc0", CGU_CLK_DIV | CGU_CLK_GATE,
> -		.parents = { X1000_CLK_MSCMUX, -1, -1, -1 },
> +		.parents = { X1000_CLK_MSCMUX },
>  		.div = { CGU_REG_MSC0CDR, 0, 2, 8, 29, 28, 27 },
>  		.gate = { CGU_REG_CLKGR, 4 },
>  	},
> 
>  	[X1000_CLK_MSC1] = {
>  		"msc1", CGU_CLK_DIV | CGU_CLK_GATE,
> -		.parents = { X1000_CLK_MSCMUX, -1, -1, -1 },
> +		.parents = { X1000_CLK_MSCMUX },
>  		.div = { CGU_REG_MSC1CDR, 0, 2, 8, 29, 28, 27 },
>  		.gate = { CGU_REG_CLKGR, 5 },
>  	},
> @@ -528,7 +530,7 @@ static const struct ingenic_cgu_clk_info 
> x1000_cgu_clocks[] = {
> 
>  	[X1000_CLK_SSIPLL] = {
>  		"ssi_pll", CGU_CLK_MUX | CGU_CLK_DIV,
> -		.parents = { X1000_CLK_SCLKA, X1000_CLK_MPLL, -1, -1 },
> +		.parents = { X1000_CLK_SCLKA, X1000_CLK_MPLL },
>  		.mux = { CGU_REG_SSICDR, 31, 1 },
>  		.div = { CGU_REG_SSICDR, 0, 1, 8, 29, 28, 27 },
>  	},
> @@ -541,13 +543,13 @@ static const struct ingenic_cgu_clk_info 
> x1000_cgu_clocks[] = {
> 
>  	[X1000_CLK_SSIMUX] = {
>  		"ssi_mux", CGU_CLK_MUX,
> -		.parents = { X1000_CLK_EXCLK, X1000_CLK_SSIPLL_DIV2, -1, -1 },
> +		.parents = { X1000_CLK_EXCLK, X1000_CLK_SSIPLL_DIV2 },
>  		.mux = { CGU_REG_SSICDR, 30, 1 },
>  	},
> 
>  	[X1000_CLK_CIM] = {
>  		"cim", CGU_CLK_MUX | CGU_CLK_DIV,
> -		.parents = { X1000_CLK_SCLKA, X1000_CLK_MPLL, -1, -1 },
> +		.parents = { X1000_CLK_SCLKA, X1000_CLK_MPLL },
>  		.mux = { CGU_REG_CIMCDR, 31, 1 },
>  		.div = { CGU_REG_CIMCDR, 0, 1, 8, 29, 28, 27 },
>  	},
> @@ -569,91 +571,91 @@ static const struct ingenic_cgu_clk_info 
> x1000_cgu_clocks[] = {
> 
>  	[X1000_CLK_EMC] = {
>  		"emc", CGU_CLK_GATE,
> -		.parents = { X1000_CLK_AHB2, -1, -1, -1 },
> +		.parents = { X1000_CLK_AHB2 },
>  		.gate = { CGU_REG_CLKGR, 0 },
>  	},
> 
>  	[X1000_CLK_EFUSE] = {
>  		"efuse", CGU_CLK_GATE,
> -		.parents = { X1000_CLK_AHB2, -1, -1, -1 },
> +		.parents = { X1000_CLK_AHB2 },
>  		.gate = { CGU_REG_CLKGR, 1 },
>  	},
> 
>  	[X1000_CLK_SFC] = {
>  		"sfc", CGU_CLK_GATE,
> -		.parents = { X1000_CLK_SSIPLL, -1, -1, -1 },
> +		.parents = { X1000_CLK_SSIPLL },
>  		.gate = { CGU_REG_CLKGR, 2 },
>  	},
> 
>  	[X1000_CLK_I2C0] = {
>  		"i2c0", CGU_CLK_GATE,
> -		.parents = { X1000_CLK_PCLK, -1, -1, -1 },
> +		.parents = { X1000_CLK_PCLK },
>  		.gate = { CGU_REG_CLKGR, 7 },
>  	},
> 
>  	[X1000_CLK_I2C1] = {
>  		"i2c1", CGU_CLK_GATE,
> -		.parents = { X1000_CLK_PCLK, -1, -1, -1 },
> +		.parents = { X1000_CLK_PCLK },
>  		.gate = { CGU_REG_CLKGR, 8 },
>  	},
> 
>  	[X1000_CLK_I2C2] = {
>  		"i2c2", CGU_CLK_GATE,
> -		.parents = { X1000_CLK_PCLK, -1, -1, -1 },
> +		.parents = { X1000_CLK_PCLK },
>  		.gate = { CGU_REG_CLKGR, 9 },
>  	},
> 
>  	[X1000_CLK_AIC] = {
>  		"aic", CGU_CLK_GATE,
> -		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { X1000_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR, 11 },
>  	},
> 
>  	[X1000_CLK_UART0] = {
>  		"uart0", CGU_CLK_GATE,
> -		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { X1000_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR, 14 },
>  	},
> 
>  	[X1000_CLK_UART1] = {
>  		"uart1", CGU_CLK_GATE,
> -		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { X1000_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR, 15 },
>  	},
> 
>  	[X1000_CLK_UART2] = {
>  		"uart2", CGU_CLK_GATE,
> -		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { X1000_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR, 16 },
>  	},
> 
>  	[X1000_CLK_DMIC] = {
>  		"dmic", CGU_CLK_GATE,
> -		.parents = { X1000_CLK_PCLK, -1, -1, -1 },
> +		.parents = { X1000_CLK_PCLK },
>  		.gate = { CGU_REG_CLKGR, 17 },
>  	},
> 
>  	[X1000_CLK_TCU] = {
>  		"tcu", CGU_CLK_GATE,
> -		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { X1000_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR, 18 },
>  	},
> 
>  	[X1000_CLK_SSI] = {
>  		"ssi", CGU_CLK_GATE,
> -		.parents = { X1000_CLK_SSIMUX, -1, -1, -1 },
> +		.parents = { X1000_CLK_SSIMUX },
>  		.gate = { CGU_REG_CLKGR, 19 },
>  	},
> 
>  	[X1000_CLK_OST] = {
>  		"ost", CGU_CLK_GATE,
> -		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { X1000_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR, 20 },
>  	},
> 
>  	[X1000_CLK_PDMA] = {
>  		"pdma", CGU_CLK_GATE,
> -		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { X1000_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR, 21 },
>  	},
> 
> diff --git a/drivers/clk/ingenic/x1830-cgu.c 
> b/drivers/clk/ingenic/x1830-cgu.c
> index d93cefa..bf08084 100644
> --- a/drivers/clk/ingenic/x1830-cgu.c
> +++ b/drivers/clk/ingenic/x1830-cgu.c
> @@ -15,51 +15,51 @@
>  #include "pm.h"
> 
>  /* CGU register offsets */
> -#define CGU_REG_CPCCR		0x00
> -#define CGU_REG_CPPCR		0x0c
> -#define CGU_REG_APLL		0x10
> -#define CGU_REG_MPLL		0x14
> -#define CGU_REG_CLKGR0		0x20
> -#define CGU_REG_OPCR		0x24
> -#define CGU_REG_CLKGR1		0x28
> -#define CGU_REG_DDRCDR		0x2c
> -#define CGU_REG_USBPCR		0x3c
> -#define CGU_REG_USBRDT		0x40
> -#define CGU_REG_USBVBFIL	0x44
> -#define CGU_REG_USBPCR1		0x48
> -#define CGU_REG_MACCDR		0x54
> -#define CGU_REG_EPLL		0x58
> -#define CGU_REG_I2SCDR		0x60
> -#define CGU_REG_LPCDR		0x64
> -#define CGU_REG_MSC0CDR		0x68
> -#define CGU_REG_I2SCDR1		0x70
> -#define CGU_REG_SSICDR		0x74
> -#define CGU_REG_CIMCDR		0x7c
> -#define CGU_REG_MSC1CDR		0xa4
> -#define CGU_REG_CMP_INTR	0xb0
> -#define CGU_REG_CMP_INTRE	0xb4
> -#define CGU_REG_DRCG		0xd0
> -#define CGU_REG_CPCSR		0xd4
> -#define CGU_REG_VPLL		0xe0
> -#define CGU_REG_MACPHYC		0xe8
> +#define CGU_REG_CPCCR			0x00
> +#define CGU_REG_CPPCR			0x0c
> +#define CGU_REG_APLL			0x10
> +#define CGU_REG_MPLL			0x14
> +#define CGU_REG_CLKGR0			0x20
> +#define CGU_REG_OPCR			0x24
> +#define CGU_REG_CLKGR1			0x28
> +#define CGU_REG_DDRCDR			0x2c
> +#define CGU_REG_USBPCR			0x3c
> +#define CGU_REG_USBRDT			0x40
> +#define CGU_REG_USBVBFIL		0x44
> +#define CGU_REG_USBPCR1			0x48
> +#define CGU_REG_MACCDR			0x54
> +#define CGU_REG_EPLL			0x58
> +#define CGU_REG_I2SCDR			0x60
> +#define CGU_REG_LPCDR			0x64
> +#define CGU_REG_MSC0CDR			0x68
> +#define CGU_REG_I2SCDR1			0x70
> +#define CGU_REG_SSICDR			0x74
> +#define CGU_REG_CIMCDR			0x7c
> +#define CGU_REG_MSC1CDR			0xa4
> +#define CGU_REG_CMP_INTR		0xb0
> +#define CGU_REG_CMP_INTRE		0xb4
> +#define CGU_REG_DRCG			0xd0
> +#define CGU_REG_CPCSR			0xd4
> +#define CGU_REG_VPLL			0xe0
> +#define CGU_REG_MACPHYC			0xe8
> 
>  /* bits within the OPCR register */
> -#define OPCR_GATE_USBPHYCLK	BIT(23)
> -#define OPCR_SPENDN0		BIT(7)
> -#define OPCR_SPENDN1		BIT(6)
> +#define OPCR_GATE_USBPHYCLK		BIT(23)
> +#define OPCR_SPENDN0			BIT(7)
> +#define OPCR_SPENDN1			BIT(6)
> 
>  /* bits within the USBPCR register */
> -#define USBPCR_SIDDQ		BIT(21)
> -#define USBPCR_OTG_DISABLE	BIT(20)
> +#define USBPCR_SIDDQ			BIT(21)
> +#define USBPCR_OTG_DISABLE		BIT(20)
> 
>  /* bits within the I2SCDR register */
> -#define I2SCDR_I2PCS_SHIFT	30
> -#define I2SCDR_I2PCS_MASK	(0x3 << I2SCDR_I2PCS_SHIFT)
> +#define I2SCDR_I2PCS_SHIFT		30
> +#define I2SCDR_I2PCS_MASK		(0x3 << I2SCDR_I2PCS_SHIFT)
>  #define I2SCDR_I2SDIV_M_SHIFT	20
>  #define I2SCDR_I2SDIV_M_MASK	(0x1ff << I2SCDR_I2SDIV_M_SHIFT)
>  #define I2SCDR_I2SDIV_N_SHIFT	0
>  #define I2SCDR_I2SDIV_N_MASK	(0xfffff << I2SCDR_I2SDIV_N_SHIFT)
> -#define I2SCDR_CE_I2S		BIT(29)
> +#define I2SCDR_CE_I2S			BIT(29)
> 
>  static struct ingenic_cgu *cgu;
> 
> @@ -70,6 +70,7 @@ static int x1830_usb_phy_enable(struct clk_hw *hw)
> 
>  	writel((readl(reg_opcr) | OPCR_SPENDN0) & ~OPCR_GATE_USBPHYCLK, 
> reg_opcr);
>  	writel(readl(reg_usbpcr) & ~USBPCR_OTG_DISABLE & ~USBPCR_SIDDQ, 
> reg_usbpcr);
> +
>  	return 0;
>  }
> 
> @@ -93,9 +94,9 @@ static int x1830_usb_phy_is_enabled(struct clk_hw 
> *hw)
>  }
> 
>  static const struct clk_ops x1830_otg_phy_ops = {
> -	.enable		= x1830_usb_phy_enable,
> -	.disable	= x1830_usb_phy_disable,
> -	.is_enabled	= x1830_usb_phy_is_enabled,
> +	.enable = x1830_usb_phy_enable,
> +	.disable = x1830_usb_phy_disable,
> +	.is_enabled = x1830_usb_phy_is_enabled,
>  };
> 
>  static u8 x1830_i2s_get_parent(struct clk_hw *hw)
> @@ -289,7 +290,7 @@ static const struct ingenic_cgu_clk_info 
> x1830_cgu_clocks[] = {
> 
>  	[X1830_CLK_APLL] = {
>  		"apll", CGU_CLK_PLL,
> -		.parents = { X1830_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { X1830_CLK_EXCLK },
>  		.pll = {
>  			.reg = CGU_REG_APLL,
>  			.rate_multiplier = 2,
> @@ -312,7 +313,7 @@ static const struct ingenic_cgu_clk_info 
> x1830_cgu_clocks[] = {
> 
>  	[X1830_CLK_MPLL] = {
>  		"mpll", CGU_CLK_PLL,
> -		.parents = { X1830_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { X1830_CLK_EXCLK },
>  		.pll = {
>  			.reg = CGU_REG_MPLL,
>  			.rate_multiplier = 2,
> @@ -335,7 +336,7 @@ static const struct ingenic_cgu_clk_info 
> x1830_cgu_clocks[] = {
> 
>  	[X1830_CLK_EPLL] = {
>  		"epll", CGU_CLK_PLL,
> -		.parents = { X1830_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { X1830_CLK_EXCLK },
>  		.pll = {
>  			.reg = CGU_REG_EPLL,
>  			.rate_multiplier = 2,
> @@ -358,7 +359,7 @@ static const struct ingenic_cgu_clk_info 
> x1830_cgu_clocks[] = {
> 
>  	[X1830_CLK_VPLL] = {
>  		"vpll", CGU_CLK_PLL,
> -		.parents = { X1830_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { X1830_CLK_EXCLK },
>  		.pll = {
>  			.reg = CGU_REG_VPLL,
>  			.rate_multiplier = 2,
> @@ -410,14 +411,14 @@ static const struct ingenic_cgu_clk_info 
> x1830_cgu_clocks[] = {
> 
>  	[X1830_CLK_CPU] = {
>  		"cpu", CGU_CLK_DIV | CGU_CLK_GATE,
> -		.parents = { X1830_CLK_CPUMUX, -1, -1, -1 },
> +		.parents = { X1830_CLK_CPUMUX },
>  		.div = { CGU_REG_CPCCR, 0, 1, 4, 22, -1, -1 },
>  		.gate = { CGU_REG_CLKGR1, 15 },
>  	},
> 
>  	[X1830_CLK_L2CACHE] = {
>  		"l2cache", CGU_CLK_DIV,
> -		.parents = { X1830_CLK_CPUMUX, -1, -1, -1 },
> +		.parents = { X1830_CLK_CPUMUX },
>  		.div = { CGU_REG_CPCCR, 4, 1, 4, 22, -1, -1 },
>  	},
> 
> @@ -436,13 +437,13 @@ static const struct ingenic_cgu_clk_info 
> x1830_cgu_clocks[] = {
> 
>  	[X1830_CLK_AHB2] = {
>  		"ahb2", CGU_CLK_DIV,
> -		.parents = { X1830_CLK_AHB2PMUX, -1, -1, -1 },
> +		.parents = { X1830_CLK_AHB2PMUX },
>  		.div = { CGU_REG_CPCCR, 12, 1, 4, 20, -1, -1 },
>  	},
> 
>  	[X1830_CLK_PCLK] = {
>  		"pclk", CGU_CLK_DIV | CGU_CLK_GATE,
> -		.parents = { X1830_CLK_AHB2PMUX, -1, -1, -1 },
> +		.parents = { X1830_CLK_AHB2PMUX },
>  		.div = { CGU_REG_CPCCR, 16, 1, 4, 20, -1, -1 },
>  		.gate = { CGU_REG_CLKGR1, 14 },
>  	},
> @@ -481,14 +482,14 @@ static const struct ingenic_cgu_clk_info 
> x1830_cgu_clocks[] = {
> 
>  	[X1830_CLK_MSC0] = {
>  		"msc0", CGU_CLK_DIV | CGU_CLK_GATE,
> -		.parents = { X1830_CLK_MSCMUX, -1, -1, -1 },
> +		.parents = { X1830_CLK_MSCMUX },
>  		.div = { CGU_REG_MSC0CDR, 0, 2, 8, 29, 28, 27 },
>  		.gate = { CGU_REG_CLKGR0, 4 },
>  	},
> 
>  	[X1830_CLK_MSC1] = {
>  		"msc1", CGU_CLK_DIV | CGU_CLK_GATE,
> -		.parents = { X1830_CLK_MSCMUX, -1, -1, -1 },
> +		.parents = { X1830_CLK_MSCMUX },
>  		.div = { CGU_REG_MSC1CDR, 0, 2, 8, 29, 28, 27 },
>  		.gate = { CGU_REG_CLKGR0, 5 },
>  	},
> @@ -509,7 +510,7 @@ static const struct ingenic_cgu_clk_info 
> x1830_cgu_clocks[] = {
> 
>  	[X1830_CLK_SSIMUX] = {
>  		"ssi_mux", CGU_CLK_MUX,
> -		.parents = { X1830_CLK_EXCLK, X1830_CLK_SSIPLL_DIV2, -1, -1 },
> +		.parents = { X1830_CLK_EXCLK, X1830_CLK_SSIPLL_DIV2 },
>  		.mux = { CGU_REG_SSICDR, 29, 1 },
>  	},
> 
> @@ -538,97 +539,97 @@ static const struct ingenic_cgu_clk_info 
> x1830_cgu_clocks[] = {
> 
>  	[X1830_CLK_EMC] = {
>  		"emc", CGU_CLK_GATE,
> -		.parents = { X1830_CLK_AHB2, -1, -1, -1 },
> +		.parents = { X1830_CLK_AHB2 },
>  		.gate = { CGU_REG_CLKGR0, 0 },
>  	},
> 
>  	[X1830_CLK_EFUSE] = {
>  		"efuse", CGU_CLK_GATE,
> -		.parents = { X1830_CLK_AHB2, -1, -1, -1 },
> +		.parents = { X1830_CLK_AHB2 },
>  		.gate = { CGU_REG_CLKGR0, 1 },
>  	},
> 
>  	[X1830_CLK_OTG] = {
>  		"otg", CGU_CLK_GATE,
> -		.parents = { X1830_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { X1830_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR0, 3 },
>  	},
> 
>  	[X1830_CLK_SSI0] = {
>  		"ssi0", CGU_CLK_GATE,
> -		.parents = { X1830_CLK_SSIMUX, -1, -1, -1 },
> +		.parents = { X1830_CLK_SSIMUX },
>  		.gate = { CGU_REG_CLKGR0, 6 },
>  	},
> 
>  	[X1830_CLK_SMB0] = {
>  		"smb0", CGU_CLK_GATE,
> -		.parents = { X1830_CLK_PCLK, -1, -1, -1 },
> +		.parents = { X1830_CLK_PCLK },
>  		.gate = { CGU_REG_CLKGR0, 7 },
>  	},
> 
>  	[X1830_CLK_SMB1] = {
>  		"smb1", CGU_CLK_GATE,
> -		.parents = { X1830_CLK_PCLK, -1, -1, -1 },
> +		.parents = { X1830_CLK_PCLK },
>  		.gate = { CGU_REG_CLKGR0, 8 },
>  	},
> 
>  	[X1830_CLK_SMB2] = {
>  		"smb2", CGU_CLK_GATE,
> -		.parents = { X1830_CLK_PCLK, -1, -1, -1 },
> +		.parents = { X1830_CLK_PCLK },
>  		.gate = { CGU_REG_CLKGR0, 9 },
>  	},
> 
>  	[X1830_CLK_AIC] = {
>  		"aic", CGU_CLK_GATE,
> -		.parents = { X1830_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { X1830_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR0, 11 },
>  	},
> 
>  	[X1830_CLK_DMIC] = {
>  		"dmic", CGU_CLK_GATE,
> -		.parents = { X1830_CLK_PCLK, -1, -1, -1 },
> +		.parents = { X1830_CLK_PCLK },
>  		.gate = { CGU_REG_CLKGR0, 12 },
>  	},
> 
>  	[X1830_CLK_UART0] = {
>  		"uart0", CGU_CLK_GATE,
> -		.parents = { X1830_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { X1830_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR0, 14 },
>  	},
> 
>  	[X1830_CLK_UART1] = {
>  		"uart1", CGU_CLK_GATE,
> -		.parents = { X1830_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { X1830_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR0, 15 },
>  	},
> 
>  	[X1830_CLK_SSI1] = {
>  		"ssi1", CGU_CLK_GATE,
> -		.parents = { X1830_CLK_SSIMUX, -1, -1, -1 },
> +		.parents = { X1830_CLK_SSIMUX },
>  		.gate = { CGU_REG_CLKGR0, 19 },
>  	},
> 
>  	[X1830_CLK_SFC] = {
>  		"sfc", CGU_CLK_GATE,
> -		.parents = { X1830_CLK_SSIPLL, -1, -1, -1 },
> +		.parents = { X1830_CLK_SSIPLL },
>  		.gate = { CGU_REG_CLKGR0, 20 },
>  	},
> 
>  	[X1830_CLK_PDMA] = {
>  		"pdma", CGU_CLK_GATE,
> -		.parents = { X1830_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { X1830_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR0, 21 },
>  	},
> 
>  	[X1830_CLK_TCU] = {
>  		"tcu", CGU_CLK_GATE,
> -		.parents = { X1830_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { X1830_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR0, 30 },
>  	},
> 
>  	[X1830_CLK_DTRNG] = {
>  		"dtrng", CGU_CLK_GATE,
> -		.parents = { X1830_CLK_PCLK, -1, -1, -1 },
> +		.parents = { X1830_CLK_PCLK },
>  		.gate = { CGU_REG_CLKGR1, 1 },
>  	},
> 
> @@ -640,7 +641,7 @@ static const struct ingenic_cgu_clk_info 
> x1830_cgu_clocks[] = {
> 
>  	[X1830_CLK_OST] = {
>  		"ost", CGU_CLK_GATE,
> -		.parents = { X1830_CLK_EXCLK, -1, -1, -1 },
> +		.parents = { X1830_CLK_EXCLK },
>  		.gate = { CGU_REG_CLKGR1, 11 },
>  	},
>  };
> --
> 2.7.4
> 


