Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CCF2CC95D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 23:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgLBWKg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Dec 2020 17:10:36 -0500
Received: from aposti.net ([89.234.176.197]:36194 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgLBWKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 17:10:35 -0500
Date:   Wed, 02 Dec 2020 22:09:39 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 4/4] clk: Ingenic: Fill unused bits in parents and
 reformat code.
To:     =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>
Cc:     sboyd@kernel.org, robh+dt@kernel.org, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Message-Id: <38GQKQ.Q3V9QMBZFBRU3@crapouillou.net>
In-Reply-To: <20201125172618.112707-5-zhouyanjie@wanyeetech.com>
References: <20201125172618.112707-1-zhouyanjie@wanyeetech.com>
        <20201125172618.112707-5-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhou,

Le jeu. 26 nov. 2020 à 1:26, 周琰杰 (Zhou Yanjie) 
<zhouyanjie@wanyeetech.com> a écrit :
> 1.Fill unused bits in parents in jz4780-cgu.c, x1000-cgu.c,
>   and x1830-cgu.c, these bits should be filled with -1.
> 2.Reformat code, add missing blank lines, remove unnecessary
>   tabs, and align code.
> 
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
>  drivers/clk/ingenic/jz4780-cgu.c | 12 +++---
>  drivers/clk/ingenic/x1000-cgu.c  | 20 +++++-----
>  drivers/clk/ingenic/x1830-cgu.c  | 83 
> ++++++++++++++++++++--------------------
>  3 files changed, 60 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/clk/ingenic/jz4780-cgu.c 
> b/drivers/clk/ingenic/jz4780-cgu.c
> index dcca74e..1b61eaa 100644
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
> @@ -544,13 +546,13 @@ static const struct ingenic_cgu_clk_info 
> jz4780_cgu_clocks[] = {
> 
>  	[JZ4780_CLK_EXCLK_DIV512] = {
>  		"exclk_div512", CGU_CLK_FIXDIV,
> -		.parents = { JZ4780_CLK_EXCLK },
> +		.parents = { JZ4780_CLK_EXCLK, -1, -1, -1 },

These -1 are not really needed since the clock doesn't have CGU_CLK_MUX.

>  		.fixdiv = { 512 },
>  	},
> 
>  	[JZ4780_CLK_RTC] = {
>  		"rtc_ercs", CGU_CLK_MUX | CGU_CLK_GATE,
> -		.parents = { JZ4780_CLK_EXCLK_DIV512, JZ4780_CLK_RTCLK },
> +		.parents = { JZ4780_CLK_EXCLK_DIV512, JZ4780_CLK_RTCLK, -1, -1 },
>  		.mux = { CGU_REG_OPCR, 2, 1},

This clock has CGU_CLK_MUX, but only one bit to change the setting, so 
only two parents possible; so again these -1 are not really needed.

Cheers,
-Paul

>  	},
> 
> diff --git a/drivers/clk/ingenic/x1000-cgu.c 
> b/drivers/clk/ingenic/x1000-cgu.c
> index d340bcd..fe2e274 100644
> --- a/drivers/clk/ingenic/x1000-cgu.c
> +++ b/drivers/clk/ingenic/x1000-cgu.c
> @@ -126,6 +126,7 @@ static int x1000_otg_phy_set_rate(struct clk_hw 
> *hw, unsigned long req_rate,
>  	writel(usbpcr1, cgu->base + CGU_REG_USBPCR1);
> 
>  	spin_unlock_irqrestore(&cgu->lock, flags);
> +
>  	return 0;
>  }
> 
> @@ -136,6 +137,7 @@ static int x1000_usb_phy_enable(struct clk_hw *hw)
> 
>  	writel(readl(reg_opcr) | OPCR_SPENDN0, reg_opcr);
>  	writel(readl(reg_usbpcr) & ~USBPCR_OTG_DISABLE & ~USBPCR_SIDDQ, 
> reg_usbpcr);
> +
>  	return 0;
>  }
> 
> @@ -163,9 +165,9 @@ static const struct clk_ops x1000_otg_phy_ops = {
>  	.round_rate = x1000_otg_phy_round_rate,
>  	.set_rate = x1000_otg_phy_set_rate,
> 
> -	.enable		= x1000_usb_phy_enable,
> -	.disable	= x1000_usb_phy_disable,
> -	.is_enabled	= x1000_usb_phy_is_enabled,
> +	.enable = x1000_usb_phy_enable,
> +	.disable = x1000_usb_phy_disable,
> +	.is_enabled = x1000_usb_phy_is_enabled,
>  };
> 
>  static const s8 pll_od_encoding[8] = {
> @@ -298,7 +300,7 @@ static const struct ingenic_cgu_clk_info 
> x1000_cgu_clocks[] = {
> 
>  	[X1000_CLK_MAC] = {
>  		"mac", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
> -		.parents = { X1000_CLK_SCLKA, X1000_CLK_MPLL },
> +		.parents = { X1000_CLK_SCLKA, X1000_CLK_MPLL, -1, -1 },
>  		.mux = { CGU_REG_MACCDR, 31, 1 },
>  		.div = { CGU_REG_MACCDR, 0, 1, 8, 29, 28, 27 },
>  		.gate = { CGU_REG_CLKGR, 25 },
> @@ -306,7 +308,7 @@ static const struct ingenic_cgu_clk_info 
> x1000_cgu_clocks[] = {
> 
>  	[X1000_CLK_LCD] = {
>  		"lcd", CGU_CLK_MUX | CGU_CLK_DIV | CGU_CLK_GATE,
> -		.parents = { X1000_CLK_SCLKA, X1000_CLK_MPLL },
> +		.parents = { X1000_CLK_SCLKA, X1000_CLK_MPLL, -1, -1 },
>  		.mux = { CGU_REG_LPCDR, 31, 1 },
>  		.div = { CGU_REG_LPCDR, 0, 1, 8, 28, 27, 26 },
>  		.gate = { CGU_REG_CLKGR, 23 },
> @@ -314,7 +316,7 @@ static const struct ingenic_cgu_clk_info 
> x1000_cgu_clocks[] = {
> 
>  	[X1000_CLK_MSCMUX] = {
>  		"msc_mux", CGU_CLK_MUX,
> -		.parents = { X1000_CLK_SCLKA, X1000_CLK_MPLL},
> +		.parents = { X1000_CLK_SCLKA, X1000_CLK_MPLL, -1, -1 },
>  		.mux = { CGU_REG_MSC0CDR, 31, 1 },
>  	},
> 
> @@ -350,7 +352,7 @@ static const struct ingenic_cgu_clk_info 
> x1000_cgu_clocks[] = {
> 
>  	[X1000_CLK_SSIPLL_DIV2] = {
>  		"ssi_pll_div2", CGU_CLK_FIXDIV,
> -		.parents = { X1000_CLK_SSIPLL },
> +		.parents = { X1000_CLK_SSIPLL, -1, -1, -1 },
>  		.fixdiv = { 2 },
>  	},
> 
> @@ -369,13 +371,13 @@ static const struct ingenic_cgu_clk_info 
> x1000_cgu_clocks[] = {
> 
>  	[X1000_CLK_EXCLK_DIV512] = {
>  		"exclk_div512", CGU_CLK_FIXDIV,
> -		.parents = { X1000_CLK_EXCLK },
> +		.parents = { X1000_CLK_EXCLK, -1, -1, -1 },
>  		.fixdiv = { 512 },
>  	},
> 
>  	[X1000_CLK_RTC] = {
>  		"rtc_ercs", CGU_CLK_MUX | CGU_CLK_GATE,
> -		.parents = { X1000_CLK_EXCLK_DIV512, X1000_CLK_RTCLK },
> +		.parents = { X1000_CLK_EXCLK_DIV512, X1000_CLK_RTCLK, -1, -1 },
>  		.mux = { CGU_REG_OPCR, 2, 1},
>  		.gate = { CGU_REG_CLKGR, 27 },
>  	},
> diff --git a/drivers/clk/ingenic/x1830-cgu.c 
> b/drivers/clk/ingenic/x1830-cgu.c
> index e76e82c..4d6cca5 100644
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
> @@ -486,7 +487,7 @@ static const struct ingenic_cgu_clk_info 
> x1830_cgu_clocks[] = {
> 
>  	[X1830_CLK_SSIPLL_DIV2] = {
>  		"ssi_pll_div2", CGU_CLK_FIXDIV,
> -		.parents = { X1830_CLK_SSIPLL },
> +		.parents = { X1830_CLK_SSIPLL, -1, -1, -1 },
>  		.fixdiv = { 2 },
>  	},
> 
> @@ -506,13 +507,13 @@ static const struct ingenic_cgu_clk_info 
> x1830_cgu_clocks[] = {
> 
>  	[X1830_CLK_EXCLK_DIV512] = {
>  		"exclk_div512", CGU_CLK_FIXDIV,
> -		.parents = { X1830_CLK_EXCLK },
> +		.parents = { X1830_CLK_EXCLK, -1, -1, -1 },
>  		.fixdiv = { 512 },
>  	},
> 
>  	[X1830_CLK_RTC] = {
>  		"rtc_ercs", CGU_CLK_MUX | CGU_CLK_GATE,
> -		.parents = { X1830_CLK_EXCLK_DIV512, X1830_CLK_RTCLK },
> +		.parents = { X1830_CLK_EXCLK_DIV512, X1830_CLK_RTCLK, -1, -1 },
>  		.mux = { CGU_REG_OPCR, 2, 1},
>  		.gate = { CGU_REG_CLKGR0, 29 },
>  	},
> --
> 2.7.4
> 


