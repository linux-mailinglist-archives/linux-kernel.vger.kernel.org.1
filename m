Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC642CCA4C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 00:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgLBXH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 18:07:56 -0500
Received: from foss.arm.com ([217.140.110.172]:53456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbgLBXH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 18:07:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D54A711FB;
        Wed,  2 Dec 2020 15:07:09 -0800 (PST)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C93523F718;
        Wed,  2 Dec 2020 15:07:07 -0800 (PST)
Subject: Re: [PATCH 5/8] clk: sunxi-ng: Add support for the Allwinner H616 CCU
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@siol.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yangtao Li <frank@allwinnertech.com>,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-clk@vger.kernel.org,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
References: <20201202135409.13683-1-andre.przywara@arm.com>
 <20201202135409.13683-6-andre.przywara@arm.com> <3799948.NgY8yFQIOr@kista>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 xsFNBFNPCKMBEAC+6GVcuP9ri8r+gg2fHZDedOmFRZPtcrMMF2Cx6KrTUT0YEISsqPoJTKld
 tPfEG0KnRL9CWvftyHseWTnU2Gi7hKNwhRkC0oBL5Er2hhNpoi8x4VcsxQ6bHG5/dA7ctvL6
 kYvKAZw4X2Y3GTbAZIOLf+leNPiF9175S8pvqMPi0qu67RWZD5H/uT/TfLpvmmOlRzNiXMBm
 kGvewkBpL3R2clHquv7pB6KLoY3uvjFhZfEedqSqTwBVu/JVZZO7tvYCJPfyY5JG9+BjPmr+
 REe2gS6w/4DJ4D8oMWKoY3r6ZpHx3YS2hWZFUYiCYovPxfj5+bOr78sg3JleEd0OB0yYtzTT
 esiNlQpCo0oOevwHR+jUiaZevM4xCyt23L2G+euzdRsUZcK/M6qYf41Dy6Afqa+PxgMEiDto
 ITEH3Dv+zfzwdeqCuNU0VOGrQZs/vrKOUmU/QDlYL7G8OIg5Ekheq4N+Ay+3EYCROXkstQnf
 YYxRn5F1oeVeqoh1LgGH7YN9H9LeIajwBD8OgiZDVsmb67DdF6EQtklH0ycBcVodG1zTCfqM
 AavYMfhldNMBg4vaLh0cJ/3ZXZNIyDlV372GmxSJJiidxDm7E1PkgdfCnHk+pD8YeITmSNyb
 7qeU08Hqqh4ui8SSeUp7+yie9zBhJB5vVBJoO5D0MikZAODIDwARAQABzS1BbmRyZSBQcnp5
 d2FyYSAoQVJNKSA8YW5kcmUucHJ6eXdhcmFAYXJtLmNvbT7CwXsEEwECACUCGwMGCwkIBwMC
 BhUIAgkKCwQWAgMBAh4BAheABQJTWSV8AhkBAAoJEAL1yD+ydue63REP/1tPqTo/f6StS00g
 NTUpjgVqxgsPWYWwSLkgkaUZn2z9Edv86BLpqTY8OBQZ19EUwfNehcnvR+Olw+7wxNnatyxo
 D2FG0paTia1SjxaJ8Nx3e85jy6l7N2AQrTCFCtFN9lp8Pc0LVBpSbjmP+Peh5Mi7gtCBNkpz
 KShEaJE25a/+rnIrIXzJHrsbC2GwcssAF3bd03iU41J1gMTalB6HCtQUwgqSsbG8MsR/IwHW
 XruOnVp0GQRJwlw07e9T3PKTLj3LWsAPe0LHm5W1Q+euoCLsZfYwr7phQ19HAxSCu8hzp43u
 zSw0+sEQsO+9wz2nGDgQCGepCcJR1lygVn2zwRTQKbq7Hjs+IWZ0gN2nDajScuR1RsxTE4WR
 lj0+Ne6VrAmPiW6QqRhliDO+e82riI75ywSWrJb9TQw0+UkIQ2DlNr0u0TwCUTcQNN6aKnru
 ouVt3qoRlcD5MuRhLH+ttAcmNITMg7GQ6RQajWrSKuKFrt6iuDbjgO2cnaTrLbNBBKPTG4oF
 D6kX8Zea0KvVBagBsaC1CDTDQQMxYBPDBSlqYCb/b2x7KHTvTAHUBSsBRL6MKz8wwruDodTM
 4E4ToV9URl4aE/msBZ4GLTtEmUHBh4/AYwk6ACYByYKyx5r3PDG0iHnJ8bV0OeyQ9ujfgBBP
 B2t4oASNnIOeGEEcQ2rjzsFNBFNPCKMBEACm7Xqafb1Dp1nDl06aw/3O9ixWsGMv1Uhfd2B6
 it6wh1HDCn9HpekgouR2HLMvdd3Y//GG89irEasjzENZPsK82PS0bvkxxIHRFm0pikF4ljIb
 6tca2sxFr/H7CCtWYZjZzPgnOPtnagN0qVVyEM7L5f7KjGb1/o5EDkVR2SVSSjrlmNdTL2Rd
 zaPqrBoxuR/y/n856deWqS1ZssOpqwKhxT1IVlF6S47CjFJ3+fiHNjkljLfxzDyQXwXCNoZn
 BKcW9PvAMf6W1DGASoXtsMg4HHzZ5fW+vnjzvWiC4pXrcP7Ivfxx5pB+nGiOfOY+/VSUlW/9
 GdzPlOIc1bGyKc6tGREH5lErmeoJZ5k7E9cMJx+xzuDItvnZbf6RuH5fg3QsljQy8jLlr4S6
 8YwxlObySJ5K+suPRzZOG2+kq77RJVqAgZXp3Zdvdaov4a5J3H8pxzjj0yZ2JZlndM4X7Msr
 P5tfxy1WvV4Km6QeFAsjcF5gM+wWl+mf2qrlp3dRwniG1vkLsnQugQ4oNUrx0ahwOSm9p6kM
 CIiTITo+W7O9KEE9XCb4vV0ejmLlgdDV8ASVUekeTJkmRIBnz0fa4pa1vbtZoi6/LlIdAEEt
 PY6p3hgkLLtr2GRodOW/Y3vPRd9+rJHq/tLIfwc58ZhQKmRcgrhtlnuTGTmyUqGSiMNfpwAR
 AQABwsFfBBgBAgAJBQJTTwijAhsMAAoJEAL1yD+ydue64BgP/33QKczgAvSdj9XTC14wZCGE
 U8ygZwkkyNf021iNMj+o0dpLU48PIhHIMTXlM2aiiZlPWgKVlDRjlYuc9EZqGgbOOuR/pNYA
 JX9vaqszyE34JzXBL9DBKUuAui8z8GcxRcz49/xtzzP0kH3OQbBIqZWuMRxKEpRptRT0wzBL
 O31ygf4FRxs68jvPCuZjTGKELIo656/Hmk17cmjoBAJK7JHfqdGkDXk5tneeHCkB411p9WJU
 vMO2EqsHjobjuFm89hI0pSxlUoiTL0Nuk9Edemjw70W4anGNyaQtBq+qu1RdjUPBvoJec7y/
 EXJtoGxq9Y+tmm22xwApSiIOyMwUi9A1iLjQLmngLeUdsHyrEWTbEYHd2sAM2sqKoZRyBDSv
 ejRvZD6zwkY/9nRqXt02H1quVOP42xlkwOQU6gxm93o/bxd7S5tEA359Sli5gZRaucpNQkwd
 KLQdCvFdksD270r4jU/rwR2R/Ubi+txfy0dk2wGBjl1xpSf0Lbl/KMR5TQntELfLR4etizLq
 Xpd2byn96Ivi8C8u9zJruXTueHH8vt7gJ1oax3yKRGU5o2eipCRiKZ0s/T7fvkdq+8beg9ku
 fDO4SAgJMIl6H5awliCY2zQvLHysS/Wb8QuB09hmhLZ4AifdHyF1J5qeePEhgTA+BaUbiUZf
 i4aIXCH3Wv6K
Organization: ARM Ltd.
Message-ID: <a680ed50-1f21-2e16-b970-fe19329ff210@arm.com>
Date:   Wed, 2 Dec 2020 23:06:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <3799948.NgY8yFQIOr@kista>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2020 21:03, Jernej Škrabec wrote:
> Dne sreda, 02. december 2020 ob 14:54:06 CET je Andre Przywara napisal(a):
>> While the clocks are fairly similar to the H6, many differ in tiny
>> details, so a separate clock driver seems indicated.
>>
>> Derived from the H6 clock driver, and adjusted according to the manual.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>  drivers/clk/sunxi-ng/Kconfig                |    7 +-
>>  drivers/clk/sunxi-ng/Makefile               |    1 +
>>  drivers/clk/sunxi-ng/ccu-sun50i-h616.c      | 1134 +++++++++++++++++++
>>  drivers/clk/sunxi-ng/ccu-sun50i-h616.h      |   58 +
>>  include/dt-bindings/clock/sun50i-h616-ccu.h |  110 ++
>>  include/dt-bindings/reset/sun50i-h616-ccu.h |   67 ++
>>  6 files changed, 1376 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h616.c
>>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h616.h
>>  create mode 100644 include/dt-bindings/clock/sun50i-h616-ccu.h
>>  create mode 100644 include/dt-bindings/reset/sun50i-h616-ccu.h
>>
>> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
>> index ce5f5847d5d3..cd46d8853876 100644
>> --- a/drivers/clk/sunxi-ng/Kconfig
>> +++ b/drivers/clk/sunxi-ng/Kconfig

....

>> +static int sun50i_h616_ccu_probe(struct platform_device *pdev)
>> +{
>> +	struct resource *res;
>> +	void __iomem *reg;
>> +	u32 val;
>> +	int i;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	reg = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(reg))
>> +		return PTR_ERR(reg);
>> +
>> +	/* Enable the lock bits on all PLLs */
>> +	for (i = 0; i < ARRAY_SIZE(pll_regs); i++) {
>> +		val = readl(reg + pll_regs[i]);
>> +		val |= BIT(29);
> 
> You should also add BIT(27) here. It enables PLL output (new functionality in 
> H616). Without this only clocks which are child of PLL_CPUX and PLL_PERIPH0 
> would work (set up by U-Boot). I'm pretty sure that's not intended usage but 
> until we know better, it's ok imo.

Ah right, the output enable bit. I was wondering if the A100 solution
would better here: use bit 27 as the .enable value, and actually enable
(bit31) all PLLs here.
Or we add another field, maybe a flag, to allow the kernel to decide
which bit to use. Clement suggested something like that on IRC.
But for now I can surely just set bit 27 here as well.

>> +		writel(val, reg + pll_regs[i]);
>> +	}
>> +
>> +	/*
>> +	 * Force the output divider of video PLLs to 0.
>> +	 *
>> +	 * See the comment before pll-video0 definition for the reason.
>> +	 */
>> +	for (i = 0; i < ARRAY_SIZE(pll_video_regs); i++) {
>> +		val = readl(reg + pll_video_regs[i]);
>> +		val &= ~BIT(0);
>> +		writel(val, reg + pll_video_regs[i]);
>> +	}
>> +
>> +	/*
>> +	 * Force OHCI 12M clock sources to 00 (12MHz divided from 48MHz)
>> +	 *
>> +	 * This clock mux is still mysterious, and the code just enforces
>> +	 * it to have a valid clock parent.
>> +	 */
>> +	for (i = 0; i < ARRAY_SIZE(usb2_clk_regs); i++) {
>> +		val = readl(reg + usb2_clk_regs[i]);
>> +		val &= ~GENMASK(25, 24);
>> +		writel (val, reg + usb2_clk_regs[i]);
>> +	}
>> +
>> +	/*
>> +	 * Force the post-divider of pll-audio to 12 and the output divider
>> +	 * of it to 2, so 24576000 and 22579200 rates can be set exactly.
>> +	 */
>> +	val = readl(reg + SUN50I_H616_PLL_AUDIO_REG);
>> +	val &= ~(GENMASK(21, 16) | BIT(0));
>> +	writel(val | (11 << 16) | BIT(0), reg + SUN50I_H616_PLL_AUDIO_REG);
>> +
>> +	/*
>> +	 * First clock parent (osc32K) is unusable for CEC. But since there
>> +	 * is no good way to force parent switch (both run with same frequency),
>> +	 * just set second clock parent here.
>> +	 */
>> +	val = readl(reg + SUN50I_H616_HDMI_CEC_CLK_REG);
>> +	val |= BIT(24);
>> +	writel(val, reg + SUN50I_H616_HDMI_CEC_CLK_REG);
>> +
>> +	return sunxi_ccu_probe(pdev->dev.of_node, reg, &sun50i_h616_ccu_desc);
>> +}
>> +
>> +static const struct of_device_id sun50i_h616_ccu_ids[] = {
>> +	{ .compatible = "allwinner,sun50i-h616-ccu",
>> +		.data = &sun50i_h616_ccu_desc },
>> +	{ }
>> +};
>> +
>> +static struct platform_driver sun50i_h616_ccu_driver = {
>> +	.probe	= sun50i_h616_ccu_probe,
>> +	.driver	= {
>> +		.name	= "sun50i-h616-ccu",
>> +		.of_match_table	= sun50i_h616_ccu_ids,
>> +	},
>> +};
>> +builtin_platform_driver(sun50i_h616_ccu_driver);
> 
> Please use CLK_OF_DECLARE() instead. That way clocks will be initialized 
> earlier and it will be actually possible to register both timer peripherals 
> (once DT nodes are added). If pdev or dev is ever needed, two stage 
> initialization can be made later.

Sure, will do.

Thanks for having a look!

Andre

> 
> Best regards,
> Jernej
> 
>> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h616.h b/drivers/clk/sunxi-ng/ccu-sun50i-h616.h
>> new file mode 100644
>> index 000000000000..da8f0b1206f9
>> --- /dev/null
>> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h616.h
>> @@ -0,0 +1,58 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright 2020 Arm Ltd.
>> + */
>> +
>> +#ifndef _CCU_SUN50I_H616_H_
>> +#define _CCU_SUN50I_H616_H_
>> +
>> +#include <dt-bindings/clock/sun50i-h616-ccu.h>
>> +#include <dt-bindings/reset/sun50i-h616-ccu.h>
>> +
>> +#define CLK_OSC12M		0
>> +#define CLK_PLL_CPUX		1
>> +#define CLK_PLL_DDR0		2
>> +#define CLK_PLL_DDR1		3
>> +
>> +/* PLL_PERIPH0 exported for PRCM */
>> +
>> +#define CLK_PLL_PERIPH0_2X	5
>> +#define CLK_PLL_PERIPH0_4X	6
>> +#define CLK_PLL_PERIPH1		7
>> +#define CLK_PLL_PERIPH1_2X	8
>> +#define CLK_PLL_PERIPH1_4X	9
>> +#define CLK_PLL_GPU		10
>> +#define CLK_PLL_VIDEO0		11
>> +#define CLK_PLL_VIDEO0_4X	12
>> +#define CLK_PLL_VIDEO1		13
>> +#define CLK_PLL_VIDEO1_4X	14
>> +#define CLK_PLL_VIDEO2		15
>> +#define CLK_PLL_VIDEO2_4X	16
>> +#define CLK_PLL_VE		17
>> +#define CLK_PLL_DE		18
>> +#define CLK_PLL_AUDIO_HS	19
>> +#define CLK_PLL_AUDIO_1X	20
>> +#define CLK_PLL_AUDIO_2X	21
>> +#define CLK_PLL_AUDIO_4X	22
>> +
>> +/* CPUX clock exported for DVFS */
>> +
>> +#define CLK_AXI			24
>> +#define CLK_CPUX_APB		25
>> +#define CLK_PSI_AHB1_AHB2	26
>> +#define CLK_AHB3		27
>> +
>> +/* APB1 clock exported for PIO */
>> +
>> +#define CLK_APB2		29
>> +#define CLK_MBUS		30
>> +
>> +/* All module clocks and bus gates are exported except DRAM */
>> +
>> +#define CLK_DRAM		51
>> +
>> +#define CLK_BUS_DRAM		58
>> +
>> +#define CLK_NUMBER		(CLK_BUS_HDCP + 1)
>> +
>> +#endif /* _CCU_SUN50I_H616_H_ */
>> diff --git a/include/dt-bindings/clock/sun50i-h616-ccu.h b/include/dt-bindings/clock/sun50i-h616-ccu.h
>> new file mode 100644
>> index 000000000000..a9cc8844e3a9
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/sun50i-h616-ccu.h
>> @@ -0,0 +1,110 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
>> +/*
>> + * Copyright (C) 2020 Arm Ltd.
>> + */
>> +
>> +#ifndef _DT_BINDINGS_CLK_SUN50I_H616_H_
>> +#define _DT_BINDINGS_CLK_SUN50I_H616_H_
>> +
>> +#define CLK_PLL_PERIPH0		4
>> +
>> +#define CLK_CPUX		23
>> +
>> +#define CLK_APB1		28
>> +
>> +#define CLK_DE			31
>> +#define CLK_BUS_DE		32
>> +#define CLK_DEINTERLACE		33
>> +#define CLK_BUS_DEINTERLACE	34
>> +#define CLK_G2D			35
>> +#define CLK_BUS_G2D		36
>> +#define CLK_GPU0		37
>> +#define CLK_BUS_GPU		38
>> +#define CLK_GPU1		39
>> +#define CLK_CE			40
>> +#define CLK_BUS_CE		41
>> +#define CLK_VE			42
>> +#define CLK_BUS_VE		43
>> +#define CLK_BUS_DMA		44
>> +#define CLK_BUS_HSTIMER		45
>> +#define CLK_AVS			46
>> +#define CLK_BUS_DBG		47
>> +#define CLK_BUS_PSI		48
>> +#define CLK_BUS_PWM		49
>> +#define CLK_BUS_IOMMU		50
>> +
>> +#define CLK_MBUS_DMA		52
>> +#define CLK_MBUS_VE		53
>> +#define CLK_MBUS_CE		54
>> +#define CLK_MBUS_TS		55
>> +#define CLK_MBUS_NAND		56
>> +#define CLK_MBUS_G2D		57
>> +
>> +#define CLK_NAND0		59
>> +#define CLK_NAND1		60
>> +#define CLK_BUS_NAND		61
>> +#define CLK_MMC0		62
>> +#define CLK_MMC1		63
>> +#define CLK_MMC2		64
>> +#define CLK_BUS_MMC0		65
>> +#define CLK_BUS_MMC1		66
>> +#define CLK_BUS_MMC2		67
>> +#define CLK_BUS_UART0		68
>> +#define CLK_BUS_UART1		69
>> +#define CLK_BUS_UART2		70
>> +#define CLK_BUS_UART3		71
>> +#define CLK_BUS_UART4		72
>> +#define CLK_BUS_UART5		73
>> +#define CLK_BUS_I2C0		74
>> +#define CLK_BUS_I2C1		75
>> +#define CLK_BUS_I2C2		76
>> +#define CLK_BUS_I2C3		77
>> +#define CLK_BUS_I2C4		78
>> +#define CLK_SPI0		79
>> +#define CLK_SPI1		80
>> +#define CLK_BUS_SPI0		81
>> +#define CLK_BUS_SPI1		82
>> +#define CLK_EMAC_25M		83
>> +#define CLK_BUS_EMAC0		84
>> +#define CLK_BUS_EMAC1		85
>> +#define CLK_TS			86
>> +#define CLK_BUS_TS		87
>> +#define CLK_BUS_THS		88
>> +#define CLK_SPDIF		89
>> +#define CLK_BUS_SPDIF		90
>> +#define CLK_DMIC		91
>> +#define CLK_BUS_DMIC		92
>> +#define CLK_AUDIO_CODEC_1X	93
>> +#define CLK_AUDIO_CODEC_4X	94
>> +#define CLK_BUS_AUDIO_CODEC	95
>> +#define CLK_AUDIO_HUB		96
>> +#define CLK_BUS_AUDIO_HUB	97
>> +#define CLK_USB_OHCI0		98
>> +#define CLK_USB_PHY0		99
>> +#define CLK_USB_OHCI1		100
>> +#define CLK_USB_PHY1		101
>> +#define CLK_USB_OHCI2		102
>> +#define CLK_USB_PHY2		103
>> +#define CLK_USB_OHCI3		104
>> +#define CLK_USB_PHY3		105
>> +#define CLK_BUS_OHCI0		106
>> +#define CLK_BUS_OHCI1		107
>> +#define CLK_BUS_OHCI2		108
>> +#define CLK_BUS_OHCI3		109
>> +#define CLK_BUS_EHCI0		110
>> +#define CLK_BUS_EHCI1		111
>> +#define CLK_BUS_EHCI2		112
>> +#define CLK_BUS_EHCI3		113
>> +#define CLK_BUS_OTG		114
>> +#define CLK_BUS_KEYADC		115
>> +#define CLK_HDMI		116
>> +#define CLK_HDMI_SLOW		117
>> +#define CLK_HDMI_CEC		118
>> +#define CLK_BUS_HDMI		119
>> +#define CLK_BUS_TCON_TOP	120
>> +#define CLK_TCON_TV0		121
>> +#define CLK_BUS_TCON_TV0	122
>> +#define CLK_HDCP		123
>> +#define CLK_BUS_HDCP		124
>> +
>> +#endif /* _DT_BINDINGS_CLK_SUN50I_H616_H_ */
>> diff --git a/include/dt-bindings/reset/sun50i-h616-ccu.h b/include/dt-bindings/reset/sun50i-h616-ccu.h
>> new file mode 100644
>> index 000000000000..1c992cfbbbab
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/sun50i-h616-ccu.h
>> @@ -0,0 +1,67 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
>> +/*
>> + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
>> + */
>> +
>> +#ifndef _DT_BINDINGS_RESET_SUN50I_H616_H_
>> +#define _DT_BINDINGS_RESET_SUN50I_H616_H_
>> +
>> +#define RST_MBUS		0
>> +#define RST_BUS_DE		1
>> +#define RST_BUS_DEINTERLACE	2
>> +#define RST_BUS_GPU		3
>> +#define RST_BUS_CE		4
>> +#define RST_BUS_VE		5
>> +#define RST_BUS_DMA		6
>> +#define RST_BUS_HSTIMER		7
>> +#define RST_BUS_DBG		8
>> +#define RST_BUS_PSI		9
>> +#define RST_BUS_PWM		10
>> +#define RST_BUS_IOMMU		11
>> +#define RST_BUS_DRAM		12
>> +#define RST_BUS_NAND		13
>> +#define RST_BUS_MMC0		14
>> +#define RST_BUS_MMC1		15
>> +#define RST_BUS_MMC2		16
>> +#define RST_BUS_UART0		17
>> +#define RST_BUS_UART1		18
>> +#define RST_BUS_UART2		19
>> +#define RST_BUS_UART3		20
>> +#define RST_BUS_UART4		21
>> +#define RST_BUS_UART5		22
>> +#define RST_BUS_I2C0		23
>> +#define RST_BUS_I2C1		24
>> +#define RST_BUS_I2C2		25
>> +#define RST_BUS_I2C3		26
>> +#define RST_BUS_I2C4		27
>> +#define RST_BUS_SPI0		28
>> +#define RST_BUS_SPI1		29
>> +#define RST_BUS_EMAC0		30
>> +#define RST_BUS_EMAC1		31
>> +#define RST_BUS_TS		32
>> +#define RST_BUS_THS		33
>> +#define RST_BUS_SPDIF		34
>> +#define RST_BUS_DMIC		35
>> +#define RST_BUS_AUDIO_CODEC	36
>> +#define RST_BUS_AUDIO_HUB	37
>> +#define RST_USB_PHY0		38
>> +#define RST_USB_PHY1		39
>> +#define RST_USB_PHY2		40
>> +#define RST_USB_PHY3		41
>> +#define RST_BUS_OHCI0		42
>> +#define RST_BUS_OHCI1		43
>> +#define RST_BUS_OHCI2		44
>> +#define RST_BUS_OHCI3		45
>> +#define RST_BUS_EHCI0		46
>> +#define RST_BUS_EHCI1		47
>> +#define RST_BUS_EHCI2		48
>> +#define RST_BUS_EHCI3		49
>> +#define RST_BUS_OTG		50
>> +#define RST_BUS_HDMI		51
>> +#define RST_BUS_HDMI_SUB	52
>> +#define RST_BUS_TCON_TOP	53
>> +#define RST_BUS_TCON_TV0	54
>> +#define RST_BUS_HDCP		55
>> +#define RST_BUS_KEYADC		56
>> +
>> +#endif /* _DT_BINDINGS_RESET_SUN50I_H616_H_ */
>> -- 
>> 2.17.5
>>
>>
>>
> 
> 

