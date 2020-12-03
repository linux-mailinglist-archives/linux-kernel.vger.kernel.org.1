Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD3A2CD44C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 12:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388715AbgLCLId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 06:08:33 -0500
Received: from foss.arm.com ([217.140.110.172]:37316 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387757AbgLCLIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 06:08:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAB52113E;
        Thu,  3 Dec 2020 03:07:46 -0800 (PST)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 185AA3F66B;
        Thu,  3 Dec 2020 03:07:29 -0800 (PST)
Subject: Re: [PATCH 4/8] clk: sunxi-ng: Add support for the Allwinner H616
 R-CCU
To:     Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Icenowy Zheng <icenowy@aosc.xyz>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yangtao Li <frank@allwinnertech.com>,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-clk@vger.kernel.org
References: <20201202135409.13683-1-andre.przywara@arm.com>
 <20201202135409.13683-5-andre.przywara@arm.com>
 <422A0729-7E7C-4ABF-BEAB-21772FDD0CE3@aosc.io>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <94f2b2db-cffd-06d5-f660-eed07b5cafe6@arm.com>
Date:   Thu, 3 Dec 2020 11:07:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <422A0729-7E7C-4ABF-BEAB-21772FDD0CE3@aosc.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2020 14:31, Icenowy Zheng wrote:

Hi,

> 于 2020年12月2日 GMT+08:00 下午9:54:05, Andre Przywara <andre.przywara@arm.com> 写到:
>> The clocks itself are identical to the H6 R-CCU, it's just that the
>> H616
>> has not all of them implemented (or connected).
> 
> For selective clocks, try to follow the practice of V3(s) driver?

Not sure what you mean, isn't that what I do? Having a separate
sunxi_ccu_desc for each SoC and referencing separate structs? At least
that's what I see in ccu-sun8i-v3s.c.

What am I missing?

Cheers,
Andre

>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>> drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c | 47 +++++++++++++++++++++++++-
>> drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h |  3 +-
>> 2 files changed, 48 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
>> b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
>> index 50f8d1bc7046..119d1797f501 100644
>> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
>> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
>> @@ -136,6 +136,15 @@ static struct ccu_common *sun50i_h6_r_ccu_clks[] =
>> {
>> 	&w1_clk.common,
>> };
>>
>> +static struct ccu_common *sun50i_h616_r_ccu_clks[] = {
>> +	&r_apb1_clk.common,
>> +	&r_apb2_clk.common,
>> +	&r_apb1_twd_clk.common,
>> +	&r_apb2_i2c_clk.common,
>> +	&r_apb1_ir_clk.common,
>> +	&ir_clk.common,
>> +};
>> +
>> static struct clk_hw_onecell_data sun50i_h6_r_hw_clks = {
>> 	.hws	= {
>> 		[CLK_AR100]		= &ar100_clk.common.hw,
>> @@ -152,7 +161,20 @@ static struct clk_hw_onecell_data
>> sun50i_h6_r_hw_clks = {
>> 		[CLK_IR]		= &ir_clk.common.hw,
>> 		[CLK_W1]		= &w1_clk.common.hw,
>> 	},
>> -	.num	= CLK_NUMBER,
>> +	.num	= CLK_NUMBER_H616,
>> +};
>> +
>> +static struct clk_hw_onecell_data sun50i_h616_r_hw_clks = {
>> +	.hws	= {
>> +		[CLK_R_AHB]		= &r_ahb_clk.hw,
>> +		[CLK_R_APB1]		= &r_apb1_clk.common.hw,
>> +		[CLK_R_APB2]		= &r_apb2_clk.common.hw,
>> +		[CLK_R_APB1_TWD]	= &r_apb1_twd_clk.common.hw,
>> +		[CLK_R_APB2_I2C]	= &r_apb2_i2c_clk.common.hw,
>> +		[CLK_R_APB1_IR]		= &r_apb1_ir_clk.common.hw,
>> +		[CLK_IR]		= &ir_clk.common.hw,
>> +	},
>> +	.num	= CLK_NUMBER_H616,
>> };
>>
>> static struct ccu_reset_map sun50i_h6_r_ccu_resets[] = {
>> @@ -165,6 +187,12 @@ static struct ccu_reset_map
>> sun50i_h6_r_ccu_resets[] = {
>> 	[RST_R_APB1_W1]		=  { 0x1ec, BIT(16) },
>> };
>>
>> +static struct ccu_reset_map sun50i_h616_r_ccu_resets[] = {
>> +	[RST_R_APB1_TWD]	=  { 0x12c, BIT(16) },
>> +	[RST_R_APB2_I2C]	=  { 0x19c, BIT(16) },
>> +	[RST_R_APB1_IR]		=  { 0x1cc, BIT(16) },
>> +};
>> +
>> static const struct sunxi_ccu_desc sun50i_h6_r_ccu_desc = {
>> 	.ccu_clks	= sun50i_h6_r_ccu_clks,
>> 	.num_ccu_clks	= ARRAY_SIZE(sun50i_h6_r_ccu_clks),
>> @@ -175,6 +203,16 @@ static const struct sunxi_ccu_desc
>> sun50i_h6_r_ccu_desc = {
>> 	.num_resets	= ARRAY_SIZE(sun50i_h6_r_ccu_resets),
>> };
>>
>> +static const struct sunxi_ccu_desc sun50i_h616_r_ccu_desc = {
>> +	.ccu_clks	= sun50i_h616_r_ccu_clks,
>> +	.num_ccu_clks	= ARRAY_SIZE(sun50i_h616_r_ccu_clks),
>> +
>> +	.hw_clks	= &sun50i_h616_r_hw_clks,
>> +
>> +	.resets		= sun50i_h616_r_ccu_resets,
>> +	.num_resets	= ARRAY_SIZE(sun50i_h616_r_ccu_resets),
>> +};
>> +
>> static void __init sunxi_r_ccu_init(struct device_node *node,
>> 				    const struct sunxi_ccu_desc *desc)
>> {
>> @@ -195,3 +233,10 @@ static void __init sun50i_h6_r_ccu_setup(struct
>> device_node *node)
>> }
>> CLK_OF_DECLARE(sun50i_h6_r_ccu, "allwinner,sun50i-h6-r-ccu",
>> 	       sun50i_h6_r_ccu_setup);
>> +
>> +static void __init sun50i_h616_r_ccu_setup(struct device_node *node)
>> +{
>> +	sunxi_r_ccu_init(node, &sun50i_h616_r_ccu_desc);
>> +}
>> +CLK_OF_DECLARE(sun50i_h616_r_ccu, "allwinner,sun50i-h616-r-ccu",
>> +	       sun50i_h616_r_ccu_setup);
>> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
>> b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
>> index 782117dc0b28..128302696ca1 100644
>> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
>> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
>> @@ -14,6 +14,7 @@
>>
>> #define CLK_R_APB2	3
>>
>> -#define CLK_NUMBER	(CLK_W1 + 1)
>> +#define CLK_NUMBER_H6	(CLK_W1 + 1)
>> +#define CLK_NUMBER_H616	(CLK_IR + 1)
>>
>> #endif /* _CCU_SUN50I_H6_R_H */

