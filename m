Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0592CD40A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 11:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388970AbgLCKyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 05:54:15 -0500
Received: from foss.arm.com ([217.140.110.172]:36950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388781AbgLCKyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 05:54:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D53A2113E;
        Thu,  3 Dec 2020 02:53:27 -0800 (PST)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D25003F66B;
        Thu,  3 Dec 2020 02:53:25 -0800 (PST)
Subject: Re: [PATCH 4/8] clk: sunxi-ng: Add support for the Allwinner H616
 R-CCU
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@siol.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
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
 <20201202135409.13683-5-andre.przywara@arm.com> <3151878.LmPXbFMbMm@kista>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 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
 i4aIXCH3Wv6K
Organization: ARM Ltd.
Message-ID: <dc3747ce-5f9a-b76d-30bd-42cd1a106056@arm.com>
Date:   Thu, 3 Dec 2020 10:52:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <3151878.LmPXbFMbMm@kista>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2020 18:20, Jernej Škrabec wrote:

Hi,

> Dne sreda, 02. december 2020 ob 14:54:05 CET je Andre Przywara napisal(a):
>> The clocks itself are identical to the H6 R-CCU, it's just that the H616
>> has not all of them implemented (or connected).
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c | 47 +++++++++++++++++++++++++-
>>  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h |  3 +-
>>  2 files changed, 48 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
>> index 50f8d1bc7046..119d1797f501 100644
>> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
>> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
>> @@ -136,6 +136,15 @@ static struct ccu_common *sun50i_h6_r_ccu_clks[] = {
>>  	&w1_clk.common,
>>  };
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
>>  static struct clk_hw_onecell_data sun50i_h6_r_hw_clks = {
>>  	.hws	= {
>>  		[CLK_AR100]		= &ar100_clk.common.hw,
>> @@ -152,7 +161,20 @@ static struct clk_hw_onecell_data sun50i_h6_r_hw_clks = {
>>  		[CLK_IR]		= &ir_clk.common.hw,
>>  		[CLK_W1]		= &w1_clk.common.hw,
>>  	},
>> -	.num	= CLK_NUMBER,
>> +	.num	= CLK_NUMBER_H616,
> 
> Above macro should be CLK_NUMBER_H6.

Ouch, well spotted!

>> +};
>> +
>> +static struct clk_hw_onecell_data sun50i_h616_r_hw_clks = {
>> +	.hws	= {
>> +		[CLK_R_AHB]		= &r_ahb_clk.hw,
>> +		[CLK_R_APB1]		= &r_apb1_clk.common.hw,
>> +		[CLK_R_APB2]		= &r_apb2_clk.common.hw,
>> +		[CLK_R_APB1_TWD]	= &r_apb1_twd_clk.common.hw,
> 
> Do we know if TWD exists? I tested I2C and IR. What is your source for these 
> clocks?

I poked around in this area, writing all Fs into those clock registers
and checked which stuck. There are actually even more clocks still
around there, though not all of the H6 (no PWM, for instance).

For TWD: it's mentioned in the manual, the clock register is there and
can be written to. The normal watchdog registers do not appear to work
at 0x7020800 (they are RAZ/WI), but there is a counter at 0x7020820,
which increments as long as those TWD clock gates are open. It stops
when the clock bits are cleared.
So that tells me that this clock is there and is working.
I didn't have time yet to check the other (former) peripherals from that
area.

Cheers,
Andre

> 
> Best regards,
> Jernej
> 
>> +		[CLK_R_APB2_I2C]	= &r_apb2_i2c_clk.common.hw,
>> +		[CLK_R_APB1_IR]		= &r_apb1_ir_clk.common.hw,
>> +		[CLK_IR]		= &ir_clk.common.hw,
>> +	},
>> +	.num	= CLK_NUMBER_H616,
>>  };
>>  
>>  static struct ccu_reset_map sun50i_h6_r_ccu_resets[] = {
>> @@ -165,6 +187,12 @@ static struct ccu_reset_map sun50i_h6_r_ccu_resets[] = {
>>  	[RST_R_APB1_W1]		=  { 0x1ec, BIT(16) },
>>  };
>>  
>> +static struct ccu_reset_map sun50i_h616_r_ccu_resets[] = {
>> +	[RST_R_APB1_TWD]	=  { 0x12c, BIT(16) },
>> +	[RST_R_APB2_I2C]	=  { 0x19c, BIT(16) },
>> +	[RST_R_APB1_IR]		=  { 0x1cc, BIT(16) },
>> +};
>> +
>>  static const struct sunxi_ccu_desc sun50i_h6_r_ccu_desc = {
>>  	.ccu_clks	= sun50i_h6_r_ccu_clks,
>>  	.num_ccu_clks	= ARRAY_SIZE(sun50i_h6_r_ccu_clks),
>> @@ -175,6 +203,16 @@ static const struct sunxi_ccu_desc sun50i_h6_r_ccu_desc = {
>>  	.num_resets	= ARRAY_SIZE(sun50i_h6_r_ccu_resets),
>>  };
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
>>  static void __init sunxi_r_ccu_init(struct device_node *node,
>>  				    const struct sunxi_ccu_desc *desc)
>>  {
>> @@ -195,3 +233,10 @@ static void __init sun50i_h6_r_ccu_setup(struct device_node *node)
>>  }
>>  CLK_OF_DECLARE(sun50i_h6_r_ccu, "allwinner,sun50i-h6-r-ccu",
>>  	       sun50i_h6_r_ccu_setup);
>> +
>> +static void __init sun50i_h616_r_ccu_setup(struct device_node *node)
>> +{
>> +	sunxi_r_ccu_init(node, &sun50i_h616_r_ccu_desc);
>> +}
>> +CLK_OF_DECLARE(sun50i_h616_r_ccu, "allwinner,sun50i-h616-r-ccu",
>> +	       sun50i_h616_r_ccu_setup);
>> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
>> index 782117dc0b28..128302696ca1 100644
>> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
>> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h
>> @@ -14,6 +14,7 @@
>>  
>>  #define CLK_R_APB2	3
>>  
>> -#define CLK_NUMBER	(CLK_W1 + 1)
>> +#define CLK_NUMBER_H6	(CLK_W1 + 1)
>> +#define CLK_NUMBER_H616	(CLK_IR + 1)
>>  
>>  #endif /* _CCU_SUN50I_H6_R_H */
>> -- 
>> 2.17.5
>>
>>
