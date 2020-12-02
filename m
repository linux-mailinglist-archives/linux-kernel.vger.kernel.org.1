Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127042CC4DD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389400AbgLBSP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:15:29 -0500
Received: from mailoutvs32.siol.net ([185.57.226.223]:43810 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389384AbgLBSP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:15:28 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 62C09522074;
        Wed,  2 Dec 2020 19:14:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1CDIGtcVqr1T; Wed,  2 Dec 2020 19:14:44 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id CD5CB522073;
        Wed,  2 Dec 2020 19:14:44 +0100 (CET)
Received: from kista.localnet (cpe1-5-97.cable.triera.net [213.161.5.97])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 3B6E0521DDC;
        Wed,  2 Dec 2020 19:14:44 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Icenowy Zheng <icenowy@aosc.xyz>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yangtao Li <frank@allwinnertech.com>,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-clk@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 4/8] clk: sunxi-ng: Add support for the Allwinner H616 R-CCU
Date:   Wed, 02 Dec 2020 19:20:56 +0100
Message-ID: <3151878.LmPXbFMbMm@kista>
In-Reply-To: <20201202135409.13683-5-andre.przywara@arm.com>
References: <20201202135409.13683-1-andre.przywara@arm.com> <20201202135409.13683-5-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 02. december 2020 ob 14:54:05 CET je Andre Przywara napisal(a):
> The clocks itself are identical to the H6 R-CCU, it's just that the H616
> has not all of them implemented (or connected).
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c | 47 +++++++++++++++++++++++++-
>  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h |  3 +-
>  2 files changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/
ccu-sun50i-h6-r.c
> index 50f8d1bc7046..119d1797f501 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
> @@ -136,6 +136,15 @@ static struct ccu_common *sun50i_h6_r_ccu_clks[] = {
>  	&w1_clk.common,
>  };
>  
> +static struct ccu_common *sun50i_h616_r_ccu_clks[] = {
> +	&r_apb1_clk.common,
> +	&r_apb2_clk.common,
> +	&r_apb1_twd_clk.common,
> +	&r_apb2_i2c_clk.common,
> +	&r_apb1_ir_clk.common,
> +	&ir_clk.common,
> +};
> +
>  static struct clk_hw_onecell_data sun50i_h6_r_hw_clks = {
>  	.hws	= {
>  		[CLK_AR100]		= &ar100_clk.common.hw,
> @@ -152,7 +161,20 @@ static struct clk_hw_onecell_data sun50i_h6_r_hw_clks = 
{
>  		[CLK_IR]		= &ir_clk.common.hw,
>  		[CLK_W1]		= &w1_clk.common.hw,
>  	},
> -	.num	= CLK_NUMBER,
> +	.num	= CLK_NUMBER_H616,

Above macro should be CLK_NUMBER_H6.

> +};
> +
> +static struct clk_hw_onecell_data sun50i_h616_r_hw_clks = {
> +	.hws	= {
> +		[CLK_R_AHB]		= &r_ahb_clk.hw,
> +		[CLK_R_APB1]		= 
&r_apb1_clk.common.hw,
> +		[CLK_R_APB2]		= 
&r_apb2_clk.common.hw,
> +		[CLK_R_APB1_TWD]	= &r_apb1_twd_clk.common.hw,

Do we know if TWD exists? I tested I2C and IR. What is your source for these 
clocks?

Best regards,
Jernej

> +		[CLK_R_APB2_I2C]	= &r_apb2_i2c_clk.common.hw,
> +		[CLK_R_APB1_IR]		= 
&r_apb1_ir_clk.common.hw,
> +		[CLK_IR]		= &ir_clk.common.hw,
> +	},
> +	.num	= CLK_NUMBER_H616,
>  };
>  
>  static struct ccu_reset_map sun50i_h6_r_ccu_resets[] = {
> @@ -165,6 +187,12 @@ static struct ccu_reset_map sun50i_h6_r_ccu_resets[] = 
{
>  	[RST_R_APB1_W1]		=  { 0x1ec, BIT(16) },
>  };
>  
> +static struct ccu_reset_map sun50i_h616_r_ccu_resets[] = {
> +	[RST_R_APB1_TWD]	=  { 0x12c, BIT(16) },
> +	[RST_R_APB2_I2C]	=  { 0x19c, BIT(16) },
> +	[RST_R_APB1_IR]		=  { 0x1cc, BIT(16) },
> +};
> +
>  static const struct sunxi_ccu_desc sun50i_h6_r_ccu_desc = {
>  	.ccu_clks	= sun50i_h6_r_ccu_clks,
>  	.num_ccu_clks	= ARRAY_SIZE(sun50i_h6_r_ccu_clks),
> @@ -175,6 +203,16 @@ static const struct sunxi_ccu_desc sun50i_h6_r_ccu_desc 
= {
>  	.num_resets	= ARRAY_SIZE(sun50i_h6_r_ccu_resets),
>  };
>  
> +static const struct sunxi_ccu_desc sun50i_h616_r_ccu_desc = {
> +	.ccu_clks	= sun50i_h616_r_ccu_clks,
> +	.num_ccu_clks	= ARRAY_SIZE(sun50i_h616_r_ccu_clks),
> +
> +	.hw_clks	= &sun50i_h616_r_hw_clks,
> +
> +	.resets		= sun50i_h616_r_ccu_resets,
> +	.num_resets	= ARRAY_SIZE(sun50i_h616_r_ccu_resets),
> +};
> +
>  static void __init sunxi_r_ccu_init(struct device_node *node,
>  				    const struct sunxi_ccu_desc 
*desc)
>  {
> @@ -195,3 +233,10 @@ static void __init sun50i_h6_r_ccu_setup(struct 
device_node *node)
>  }
>  CLK_OF_DECLARE(sun50i_h6_r_ccu, "allwinner,sun50i-h6-r-ccu",
>  	       sun50i_h6_r_ccu_setup);
> +
> +static void __init sun50i_h616_r_ccu_setup(struct device_node *node)
> +{
> +	sunxi_r_ccu_init(node, &sun50i_h616_r_ccu_desc);
> +}
> +CLK_OF_DECLARE(sun50i_h616_r_ccu, "allwinner,sun50i-h616-r-ccu",
> +	       sun50i_h616_r_ccu_setup);
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h b/drivers/clk/sunxi-ng/
ccu-sun50i-h6-r.h
> index 782117dc0b28..128302696ca1 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
> @@ -14,6 +14,7 @@
>  
>  #define CLK_R_APB2	3
>  
> -#define CLK_NUMBER	(CLK_W1 + 1)
> +#define CLK_NUMBER_H6	(CLK_W1 + 1)
> +#define CLK_NUMBER_H616	(CLK_IR + 1)
>  
>  #endif /* _CCU_SUN50I_H6_R_H */
> -- 
> 2.17.5
> 
> 


