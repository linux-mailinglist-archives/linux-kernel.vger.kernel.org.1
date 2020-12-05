Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1292CFC3C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 18:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgLERCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 12:02:01 -0500
Received: from relay-us1.mymailcheap.com ([51.81.35.219]:44046 "EHLO
        relay-us1.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgLEQoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 11:44:46 -0500
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.248.207])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id 55A6920EAE;
        Sat,  5 Dec 2020 16:43:04 +0000 (UTC)
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.155])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 5B7FA260EB;
        Sat,  5 Dec 2020 16:40:11 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay3.mymailcheap.com (Postfix) with ESMTPS id 80FF83ECDF;
        Sat,  5 Dec 2020 17:36:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id A50532A369;
        Sat,  5 Dec 2020 11:36:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1607186192;
        bh=pg68aeH0GawbYYMr2uDtz0qdPCG1WmJYRz/Ia83NVcY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Tc5UxoArb/pnZPKtPSoTt0qyBEUw5/ufivutFGni1WvZ7pUYldFTL2iT3FO1i4/ZJ
         3ml8Guv/SnFbeabkS48YrdGa86mVT0Rj26FX/G2gj4aZxarAw7gOpa3SVSDMY7on5R
         Ko2OJKjuZWuxBI3tESfJQr+VOQGazQ0cOc3t5Jnk=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id H8lnd33YcztK; Sat,  5 Dec 2020 11:36:31 -0500 (EST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Sat,  5 Dec 2020 11:36:30 -0500 (EST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 2D3E5422BA;
        Sat,  5 Dec 2020 16:36:29 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="ez0ENF5q";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.160.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id A7636422BA;
        Sat,  5 Dec 2020 16:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1607186181; bh=pg68aeH0GawbYYMr2uDtz0qdPCG1WmJYRz/Ia83NVcY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ez0ENF5qYmNf++rztjjW2afYWedzFe04107hsynCCKCbHD94LI86d+RBiynt+wNQB
         mv0wVYUbGycaedUiTiCXEuIC4lJNUWthoj5iwTaRdxFPwl2CdngVpREtTUV87qWhB3
         XmgiqhuTH2G8eNPzzzqTFW07AzmCeG5vpw4lCAJw=
Message-ID: <5fba433e61b562d4ea9836cb9ddec6c69578ad12.camel@aosc.io>
Subject: Re: [linux-sunxi] Re: [PATCH 5/8] clk: sunxi-ng: Add support for
 the Allwinner H616 CCU
From:   Icenowy Zheng <icenowy@aosc.io>
To:     andre.przywara@arm.com,
        Jernej =?gb2312?Q?=810=947krabec?= <jernej.skrabec@siol.net>,
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
        =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Date:   Sun, 06 Dec 2020 00:36:04 +0800
In-Reply-To: <a680ed50-1f21-2e16-b970-fe19329ff210@arm.com>
References: <20201202135409.13683-1-andre.przywara@arm.com>
         <20201202135409.13683-6-andre.przywara@arm.com> <3799948.NgY8yFQIOr@kista>
         <a680ed50-1f21-2e16-b970-fe19329ff210@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2D3E5422BA
X-Spamd-Result: default: False [1.40 / 10.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         R_SPF_SOFTFAIL(0.00)[~all];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1];
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_TWELVE(0.00)[15];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.160.105:received];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         FREEMAIL_CC(0.00)[lists.infradead.org,googlegroups.com,linaro.org,kernel.org,allwinnertech.com,vger.kernel.org,baylibre.com,pengutronix.de,gmail.com];
         SUSPICIOUS_RECIPS(1.50)[];
         RCVD_COUNT_TWO(0.00)[2]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020-12-02星期三的 23:06 +0000，André Przywara写道：
> On 02/12/2020 21:03, Jernej Škrabec wrote:
> > Dne sreda, 02. december 2020 ob 14:54:06 CET je Andre Przywara
> > napisal(a):
> > > While the clocks are fairly similar to the H6, many differ in
> > > tiny
> > > details, so a separate clock driver seems indicated.
> > > 
> > > Derived from the H6 clock driver, and adjusted according to the
> > > manual.
> > > 
> > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > ---
> > >  drivers/clk/sunxi-ng/Kconfig                |    7 +-
> > >  drivers/clk/sunxi-ng/Makefile               |    1 +
> > >  drivers/clk/sunxi-ng/ccu-sun50i-h616.c      | 1134
> > > +++++++++++++++++++
> > >  drivers/clk/sunxi-ng/ccu-sun50i-h616.h      |   58 +
> > >  include/dt-bindings/clock/sun50i-h616-ccu.h |  110 ++
> > >  include/dt-bindings/reset/sun50i-h616-ccu.h |   67 ++
> > >  6 files changed, 1376 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h616.c
> > >  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h616.h
> > >  create mode 100644 include/dt-bindings/clock/sun50i-h616-ccu.h
> > >  create mode 100644 include/dt-bindings/reset/sun50i-h616-ccu.h
> > > 
> > > diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-
> > > ng/Kconfig
> > > index ce5f5847d5d3..cd46d8853876 100644
> > > --- a/drivers/clk/sunxi-ng/Kconfig
> > > +++ b/drivers/clk/sunxi-ng/Kconfig
> 
> ....
> 
> > > +static int sun50i_h616_ccu_probe(struct platform_device *pdev)
> > > +{
> > > +	struct resource *res;
> > > +	void __iomem *reg;
> > > +	u32 val;
> > > +	int i;
> > > +
> > > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +	reg = devm_ioremap_resource(&pdev->dev, res);
> > > +	if (IS_ERR(reg))
> > > +		return PTR_ERR(reg);
> > > +
> > > +	/* Enable the lock bits on all PLLs */
> > > +	for (i = 0; i < ARRAY_SIZE(pll_regs); i++) {
> > > +		val = readl(reg + pll_regs[i]);
> > > +		val |= BIT(29);
> > 
> > You should also add BIT(27) here. It enables PLL output (new
> > functionality in 
> > H616). Without this only clocks which are child of PLL_CPUX and
> > PLL_PERIPH0 
> > would work (set up by U-Boot). I'm pretty sure that's not intended
> > usage but 
> > until we know better, it's ok imo.
> 
> Ah right, the output enable bit. I was wondering if the A100 solution
> would better here: use bit 27 as the .enable value, and actually
> enable

Why not .enable = BIT(27) | BIT(31) ?

> (bit31) all PLLs here.
> Or we add another field, maybe a flag, to allow the kernel to decide
> which bit to use. Clement suggested something like that on IRC.
> But for now I can surely just set bit 27 here as well.
> 
> > > +		writel(val, reg + pll_regs[i]);
> > > +	}
> > > +
> > > +	/*
> > > +	 * Force the output divider of video PLLs to 0.
> > > +	 *
> > > +	 * See the comment before pll-video0 definition for the reason.
> > > +	 */
> > > +	for (i = 0; i < ARRAY_SIZE(pll_video_regs); i++) {
> > > +		val = readl(reg + pll_video_regs[i]);
> > > +		val &= ~BIT(0);
> > > +		writel(val, reg + pll_video_regs[i]);
> > > +	}
> > > +
> > > +	/*
> > > +	 * Force OHCI 12M clock sources to 00 (12MHz divided from
> > > 48MHz)
> > > +	 *
> > > +	 * This clock mux is still mysterious, and the code just
> > > enforces
> > > +	 * it to have a valid clock parent.
> > > +	 */
> > > +	for (i = 0; i < ARRAY_SIZE(usb2_clk_regs); i++) {
> > > +		val = readl(reg + usb2_clk_regs[i]);
> > > +		val &= ~GENMASK(25, 24);
> > > +		writel (val, reg + usb2_clk_regs[i]);
> > > +	}
> > > +
> > > +	/*
> > > +	 * Force the post-divider of pll-audio to 12 and the output
> > > divider
> > > +	 * of it to 2, so 24576000 and 22579200 rates can be set
> > > exactly.
> > > +	 */
> > > +	val = readl(reg + SUN50I_H616_PLL_AUDIO_REG);
> > > +	val &= ~(GENMASK(21, 16) | BIT(0));
> > > +	writel(val | (11 << 16) | BIT(0), reg +
> > > SUN50I_H616_PLL_AUDIO_REG);
> > > +
> > > +	/*
> > > +	 * First clock parent (osc32K) is unusable for CEC. But since
> > > there
> > > +	 * is no good way to force parent switch (both run with same
> > > frequency),
> > > +	 * just set second clock parent here.
> > > +	 */
> > > +	val = readl(reg + SUN50I_H616_HDMI_CEC_CLK_REG);
> > > +	val |= BIT(24);
> > > +	writel(val, reg + SUN50I_H616_HDMI_CEC_CLK_REG);
> > > +
> > > +	return sunxi_ccu_probe(pdev->dev.of_node, reg,
> > > &sun50i_h616_ccu_desc);
> > > +}
> > > +
> > > +static const struct of_device_id sun50i_h616_ccu_ids[] = {
> > > +	{ .compatible = "allwinner,sun50i-h616-ccu",
> > > +		.data = &sun50i_h616_ccu_desc },
> > > +	{ }
> > > +};
> > > +
> > > +static struct platform_driver sun50i_h616_ccu_driver = {
> > > +	.probe	= sun50i_h616_ccu_probe,
> > > +	.driver	= {
> > > +		.name	= "sun50i-h616-ccu",
> > > +		.of_match_table	= sun50i_h616_ccu_ids,
> > > +	},
> > > +};
> > > +builtin_platform_driver(sun50i_h616_ccu_driver);
> > 
> > Please use CLK_OF_DECLARE() instead. That way clocks will be
> > initialized 
> > earlier and it will be actually possible to register both timer
> > peripherals 
> > (once DT nodes are added). If pdev or dev is ever needed, two
> > stage 
> > initialization can be made later.
> 
> Sure, will do.
> 
> Thanks for having a look!
> 
> Andre
> 
> > Best regards,
> > Jernej
> > 
> > > diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h616.h
> > > b/drivers/clk/sunxi-ng/ccu-sun50i-h616.h
> > > new file mode 100644
> > > index 000000000000..da8f0b1206f9
> > > --- /dev/null
> > > +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h616.h
> > > @@ -0,0 +1,58 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + * Copyright 2020 Arm Ltd.
> > > + */
> > > +
> > > +#ifndef _CCU_SUN50I_H616_H_
> > > +#define _CCU_SUN50I_H616_H_
> > > +
> > > +#include <dt-bindings/clock/sun50i-h616-ccu.h>
> > > +#include <dt-bindings/reset/sun50i-h616-ccu.h>
> > > +
> > > +#define CLK_OSC12M		0
> > > +#define CLK_PLL_CPUX		1
> > > +#define CLK_PLL_DDR0		2
> > > +#define CLK_PLL_DDR1		3
> > > +
> > > +/* PLL_PERIPH0 exported for PRCM */
> > > +
> > > +#define CLK_PLL_PERIPH0_2X	5
> > > +#define CLK_PLL_PERIPH0_4X	6
> > > +#define CLK_PLL_PERIPH1		7
> > > +#define CLK_PLL_PERIPH1_2X	8
> > > +#define CLK_PLL_PERIPH1_4X	9
> > > +#define CLK_PLL_GPU		10
> > > +#define CLK_PLL_VIDEO0		11
> > > +#define CLK_PLL_VIDEO0_4X	12
> > > +#define CLK_PLL_VIDEO1		13
> > > +#define CLK_PLL_VIDEO1_4X	14
> > > +#define CLK_PLL_VIDEO2		15
> > > +#define CLK_PLL_VIDEO2_4X	16
> > > +#define CLK_PLL_VE		17
> > > +#define CLK_PLL_DE		18
> > > +#define CLK_PLL_AUDIO_HS	19
> > > +#define CLK_PLL_AUDIO_1X	20
> > > +#define CLK_PLL_AUDIO_2X	21
> > > +#define CLK_PLL_AUDIO_4X	22
> > > +
> > > +/* CPUX clock exported for DVFS */
> > > +
> > > +#define CLK_AXI			24
> > > +#define CLK_CPUX_APB		25
> > > +#define CLK_PSI_AHB1_AHB2	26
> > > +#define CLK_AHB3		27
> > > +
> > > +/* APB1 clock exported for PIO */
> > > +
> > > +#define CLK_APB2		29
> > > +#define CLK_MBUS		30
> > > +
> > > +/* All module clocks and bus gates are exported except DRAM */
> > > +
> > > +#define CLK_DRAM		51
> > > +
> > > +#define CLK_BUS_DRAM		58
> > > +
> > > +#define CLK_NUMBER		(CLK_BUS_HDCP + 1)
> > > +
> > > +#endif /* _CCU_SUN50I_H616_H_ */
> > > diff --git a/include/dt-bindings/clock/sun50i-h616-ccu.h
> > > b/include/dt-bindings/clock/sun50i-h616-ccu.h
> > > new file mode 100644
> > > index 000000000000..a9cc8844e3a9
> > > --- /dev/null
> > > +++ b/include/dt-bindings/clock/sun50i-h616-ccu.h
> > > @@ -0,0 +1,110 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> > > +/*
> > > + * Copyright (C) 2020 Arm Ltd.
> > > + */
> > > +
> > > +#ifndef _DT_BINDINGS_CLK_SUN50I_H616_H_
> > > +#define _DT_BINDINGS_CLK_SUN50I_H616_H_
> > > +
> > > +#define CLK_PLL_PERIPH0		4
> > > +
> > > +#define CLK_CPUX		23
> > > +
> > > +#define CLK_APB1		28
> > > +
> > > +#define CLK_DE			31
> > > +#define CLK_BUS_DE		32
> > > +#define CLK_DEINTERLACE		33
> > > +#define CLK_BUS_DEINTERLACE	34
> > > +#define CLK_G2D			35
> > > +#define CLK_BUS_G2D		36
> > > +#define CLK_GPU0		37
> > > +#define CLK_BUS_GPU		38
> > > +#define CLK_GPU1		39
> > > +#define CLK_CE			40
> > > +#define CLK_BUS_CE		41
> > > +#define CLK_VE			42
> > > +#define CLK_BUS_VE		43
> > > +#define CLK_BUS_DMA		44
> > > +#define CLK_BUS_HSTIMER		45
> > > +#define CLK_AVS			46
> > > +#define CLK_BUS_DBG		47
> > > +#define CLK_BUS_PSI		48
> > > +#define CLK_BUS_PWM		49
> > > +#define CLK_BUS_IOMMU		50
> > > +
> > > +#define CLK_MBUS_DMA		52
> > > +#define CLK_MBUS_VE		53
> > > +#define CLK_MBUS_CE		54
> > > +#define CLK_MBUS_TS		55
> > > +#define CLK_MBUS_NAND		56
> > > +#define CLK_MBUS_G2D		57
> > > +
> > > +#define CLK_NAND0		59
> > > +#define CLK_NAND1		60
> > > +#define CLK_BUS_NAND		61
> > > +#define CLK_MMC0		62
> > > +#define CLK_MMC1		63
> > > +#define CLK_MMC2		64
> > > +#define CLK_BUS_MMC0		65
> > > +#define CLK_BUS_MMC1		66
> > > +#define CLK_BUS_MMC2		67
> > > +#define CLK_BUS_UART0		68
> > > +#define CLK_BUS_UART1		69
> > > +#define CLK_BUS_UART2		70
> > > +#define CLK_BUS_UART3		71
> > > +#define CLK_BUS_UART4		72
> > > +#define CLK_BUS_UART5		73
> > > +#define CLK_BUS_I2C0		74
> > > +#define CLK_BUS_I2C1		75
> > > +#define CLK_BUS_I2C2		76
> > > +#define CLK_BUS_I2C3		77
> > > +#define CLK_BUS_I2C4		78
> > > +#define CLK_SPI0		79
> > > +#define CLK_SPI1		80
> > > +#define CLK_BUS_SPI0		81
> > > +#define CLK_BUS_SPI1		82
> > > +#define CLK_EMAC_25M		83
> > > +#define CLK_BUS_EMAC0		84
> > > +#define CLK_BUS_EMAC1		85
> > > +#define CLK_TS			86
> > > +#define CLK_BUS_TS		87
> > > +#define CLK_BUS_THS		88
> > > +#define CLK_SPDIF		89
> > > +#define CLK_BUS_SPDIF		90
> > > +#define CLK_DMIC		91
> > > +#define CLK_BUS_DMIC		92
> > > +#define CLK_AUDIO_CODEC_1X	93
> > > +#define CLK_AUDIO_CODEC_4X	94
> > > +#define CLK_BUS_AUDIO_CODEC	95
> > > +#define CLK_AUDIO_HUB		96
> > > +#define CLK_BUS_AUDIO_HUB	97
> > > +#define CLK_USB_OHCI0		98
> > > +#define CLK_USB_PHY0		99
> > > +#define CLK_USB_OHCI1		100
> > > +#define CLK_USB_PHY1		101
> > > +#define CLK_USB_OHCI2		102
> > > +#define CLK_USB_PHY2		103
> > > +#define CLK_USB_OHCI3		104
> > > +#define CLK_USB_PHY3		105
> > > +#define CLK_BUS_OHCI0		106
> > > +#define CLK_BUS_OHCI1		107
> > > +#define CLK_BUS_OHCI2		108
> > > +#define CLK_BUS_OHCI3		109
> > > +#define CLK_BUS_EHCI0		110
> > > +#define CLK_BUS_EHCI1		111
> > > +#define CLK_BUS_EHCI2		112
> > > +#define CLK_BUS_EHCI3		113
> > > +#define CLK_BUS_OTG		114
> > > +#define CLK_BUS_KEYADC		115
> > > +#define CLK_HDMI		116
> > > +#define CLK_HDMI_SLOW		117
> > > +#define CLK_HDMI_CEC		118
> > > +#define CLK_BUS_HDMI		119
> > > +#define CLK_BUS_TCON_TOP	120
> > > +#define CLK_TCON_TV0		121
> > > +#define CLK_BUS_TCON_TV0	122
> > > +#define CLK_HDCP		123
> > > +#define CLK_BUS_HDCP		124
> > > +
> > > +#endif /* _DT_BINDINGS_CLK_SUN50I_H616_H_ */
> > > diff --git a/include/dt-bindings/reset/sun50i-h616-ccu.h
> > > b/include/dt-bindings/reset/sun50i-h616-ccu.h
> > > new file mode 100644
> > > index 000000000000..1c992cfbbbab
> > > --- /dev/null
> > > +++ b/include/dt-bindings/reset/sun50i-h616-ccu.h
> > > @@ -0,0 +1,67 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> > > +/*
> > > + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.io>
> > > + */
> > > +
> > > +#ifndef _DT_BINDINGS_RESET_SUN50I_H616_H_
> > > +#define _DT_BINDINGS_RESET_SUN50I_H616_H_
> > > +
> > > +#define RST_MBUS		0
> > > +#define RST_BUS_DE		1
> > > +#define RST_BUS_DEINTERLACE	2
> > > +#define RST_BUS_GPU		3
> > > +#define RST_BUS_CE		4
> > > +#define RST_BUS_VE		5
> > > +#define RST_BUS_DMA		6
> > > +#define RST_BUS_HSTIMER		7
> > > +#define RST_BUS_DBG		8
> > > +#define RST_BUS_PSI		9
> > > +#define RST_BUS_PWM		10
> > > +#define RST_BUS_IOMMU		11
> > > +#define RST_BUS_DRAM		12
> > > +#define RST_BUS_NAND		13
> > > +#define RST_BUS_MMC0		14
> > > +#define RST_BUS_MMC1		15
> > > +#define RST_BUS_MMC2		16
> > > +#define RST_BUS_UART0		17
> > > +#define RST_BUS_UART1		18
> > > +#define RST_BUS_UART2		19
> > > +#define RST_BUS_UART3		20
> > > +#define RST_BUS_UART4		21
> > > +#define RST_BUS_UART5		22
> > > +#define RST_BUS_I2C0		23
> > > +#define RST_BUS_I2C1		24
> > > +#define RST_BUS_I2C2		25
> > > +#define RST_BUS_I2C3		26
> > > +#define RST_BUS_I2C4		27
> > > +#define RST_BUS_SPI0		28
> > > +#define RST_BUS_SPI1		29
> > > +#define RST_BUS_EMAC0		30
> > > +#define RST_BUS_EMAC1		31
> > > +#define RST_BUS_TS		32
> > > +#define RST_BUS_THS		33
> > > +#define RST_BUS_SPDIF		34
> > > +#define RST_BUS_DMIC		35
> > > +#define RST_BUS_AUDIO_CODEC	36
> > > +#define RST_BUS_AUDIO_HUB	37
> > > +#define RST_USB_PHY0		38
> > > +#define RST_USB_PHY1		39
> > > +#define RST_USB_PHY2		40
> > > +#define RST_USB_PHY3		41
> > > +#define RST_BUS_OHCI0		42
> > > +#define RST_BUS_OHCI1		43
> > > +#define RST_BUS_OHCI2		44
> > > +#define RST_BUS_OHCI3		45
> > > +#define RST_BUS_EHCI0		46
> > > +#define RST_BUS_EHCI1		47
> > > +#define RST_BUS_EHCI2		48
> > > +#define RST_BUS_EHCI3		49
> > > +#define RST_BUS_OTG		50
> > > +#define RST_BUS_HDMI		51
> > > +#define RST_BUS_HDMI_SUB	52
> > > +#define RST_BUS_TCON_TOP	53
> > > +#define RST_BUS_TCON_TV0	54
> > > +#define RST_BUS_HDCP		55
> > > +#define RST_BUS_KEYADC		56
> > > +
> > > +#endif /* _DT_BINDINGS_RESET_SUN50I_H616_H_ */
> > > -- 
> > > 2.17.5
> > > 
> > > 
> > > 
