Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A012D8F2B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 18:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgLMRtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 12:49:31 -0500
Received: from relay4.mymailcheap.com ([137.74.80.156]:43171 "EHLO
        relay4.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgLMRta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 12:49:30 -0500
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id B4E6F3F1CF;
        Sun, 13 Dec 2020 18:47:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 829C82A469;
        Sun, 13 Dec 2020 18:47:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1607881675;
        bh=RJnyj0/+TQI3VeV3A7Fg3e8tvWtZnAB7xF950PWxdV0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=wi8T8d0+Pdnh8PFMe2m5MfqvMzqBKuGlhjLUx19PF6ifKxuar4HpxvPQP49/MzFZu
         1PQCPduXyi2ELYGlACilGFz8939p1JYsHVKmoa5D8pl4F1J6gv0RLekzmDgH2hb2HD
         5duRkZbWAAx0Sk7BxFBmRlxDzgTWew8sqHNxexCQ=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JrucsKJkUotC; Sun, 13 Dec 2020 18:47:53 +0100 (CET)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Sun, 13 Dec 2020 18:47:53 +0100 (CET)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id C702A41A53;
        Sun, 13 Dec 2020 17:47:52 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="Mr0ykHzn";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.162.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id BC4DF41A53;
        Sun, 13 Dec 2020 17:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1607881666; bh=RJnyj0/+TQI3VeV3A7Fg3e8tvWtZnAB7xF950PWxdV0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Mr0ykHznj7/3Lbg+Hic2oBTT4lSSayrpWSPYdWLqcGZmpHLlFbg/MudqcvPua3KwB
         1rQ0ZEEtSz2syFX7mLzU/eVKQEJm3sGhZJjkHNWhW9RPT4scjoZUMW5prWlH6D8M0l
         2UggVE1iQYloRcgJplbWlks7KkozTqxFyWjbFljQ=
Message-ID: <7bc85e6acaa4c73cb32d73c6da3a3dd43bd5411d.camel@aosc.io>
Subject: Re: [PATCH v2 00/21] arm64: sunxi: Initial Allwinner H616 SoC
 support
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Icenowy Zheng <icenowy@aosc.xyz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?ISO-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Date:   Mon, 14 Dec 2020 01:47:33 +0800
In-Reply-To: <20201211011934.6171-1-andre.przywara@arm.com>
References: <20201211011934.6171-1-andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: mail20.mymailcheap.com
X-Spamd-Result: default: False [1.40 / 20.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         R_SPF_SOFTFAIL(0.00)[~all];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_TWELVE(0.00)[16];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.162.102:received];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         FREEMAIL_CC(0.00)[aosc.xyz,linaro.org,kernel.org,gmail.com,allwinnertech.com,lists.infradead.org,vger.kernel.org,googlegroups.com,baylibre.com,pengutronix.de];
         SUSPICIOUS_RECIPS(1.50)[];
         RCVD_COUNT_TWO(0.00)[2]
X-Rspamd-Queue-Id: C702A41A53
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020-12-11星期五的 01:19 +0000，Andre Przywara写道：
> Hi,
> 
> this is the quite expanded second version of the support series for
> the
> Allwinner H616 SoC.
> Besides many fixes for the bugs discovered by the diligent reviewers
> (many thanks for that!) this version adds some patches to support
> some
> slightly changed devices, like the second EMAC and the AXP not having
> an interrupt.
> Also I added quite some DT binding doc patches.
> USB still does not work, but I include the patches anyway, hoping
> that
> someone can help spotting the issue.
> For a more detailed changelog see below.
> 
> Thanks!
> Andre
> 
> ==================
> This series gathers patches to support the Allwinner H616 SoC. This
> is
> a rather uninspired SoC (Quad-A53 with the usual peripherals), but
> allows for some cheap development boards and TV boxes, and supports
> up to 4GB of DRAM.
> 
> Various DT binding patches are sprinkled throughout the series, to
> add
> the new compatible names right before they are used.
> Patch 1/21 is the usual drive-by fix, discovered while staring at
> the H6 clock code.
> Patch 3 and 4 add pinctrl support, with the "-R" controller now being
> crippled down to two I2C pins only. If we grow tired of repeating
> this
> exercise for every new SoC variant, I am happy to revive my more
> versatile sunxi pinctrl driver effort from a few years back [1].
> Patch 6 and 7 add clock support. For the -R clock this is shared with
> the H6 code, as the clocks are identical, with the H616 just having
> fewer of them. The main clocks are different enough to warrant a
> separate
> file.
> Patch 08/21 is pulling a patch from Yangtao's A100 series, since we
> need
> the same fix for MMC support. This will probably be merged
> separately,
> I just include this here to provide a bootable solution.
> Patch 10 teaches the AXP MFD driver to get along without having an
> interrupt, as the H616 apparently does not have an NMI controller
> anymore.
> Patch 12 and 13 add some tweaks to the syscon and EMAC driver, to
> deal
> with the second EMAC clock used for the second Ethernet controller.
> Patches 14 and 15 *try* to add USB support. The same approach works
> with
> the very similar U-Boot PHY driver, but for some reason still fail in
> Linux. Maybe someone spots the issue and can help fixing it?

There's a judge currently checks for phy type A83T/H6. You may need to
add H616 there.

Or should we have a bool in the data struct to mark it? I think all
chips that need that is 28nm.

> 
> The remaining patches add DT bindings, which just add the new
> compatible
> string along with an existing name as a fallback string.
> Eventually we get the .dtsi for the SoC in patch 19, and the .dts for
> the OrangePi Zero2 board[2] in the last patch.
> 
> We have U-Boot and Trusted-Firmware support in a working state,
> booting
> via FEL and even TFTPing kernels work already [3][4].
> 
> Many thanks to Jernej for his tremendous help on this, also for the
> awesome input and help from the #linux-sunxi Freenode channel.
> 
> The whole series can also be found here:
> https://github.com/apritzel/linux/commits/h616-v2
> 
> Happy reviewing!
> 
> Cheers,
> Andre
> 
> [1] 
> https://patchwork.ozlabs.org/project/linux-gpio/cover/20171113012523.2328-1-andre.przywara@arm.com/
> [2] https://linux-sunxi.org/Xunlong_Orange_Pi_Zero2
> [3] https://github.com/jernejsk/u-boot/commits/h616-v1
> [4] https://github.com/apritzel/arm-trusted-firmware/commits/h616-WIP
> 
> Changelog v1 .. v2:
> - pinctrl: adjust irq bank map to cover undocumented GPIO bank IRQs
> - use differing h_i2s0 pin output names
> - r-ccu: fix number of used clocks
> - ccu: remove PLL-PERIPHy(4X)
> - ccu: fix gpu1 divider range
> - ccu: fix usb-phy3 parent
> - ccu: add missing TV clocks
> - ccu: rework to CLK_OF_DECLARE style
> - ccu: enable output bit for PLL clocks
> - ccu: renumber clocks
> - .dtsi: drop sun50i-a64-system-control fallback
> - .dtsi: drop unknown SRAM regions
> - .dtsi: add more (undocumented) GPIO interrupts
> - .dtsi: fix I2C3 pin names
> - .dtsi: use a100-emmc fallback for MMC2
> - .dtsi: add second EMAC controller
> - .dtsi: use H3 MUSB controller fallback
> - .dtsi: fix frame size for USB PHY PMU registers
> - .dtsi: add USB0 PHY references
> - .dtsi: fix IR controller clock source
> - .dts: fix LED naming and swap pins
> - .dts: use 5V supply parent for USB supply
> - .dts: drop dummy IRQ for AXP
> - .dts: enable 3V3 header pin power rail
> - .dts: add SPI flash node
> - .dts: make USB-C port peripheral only
> - add IRQ-less AXP support
> - add two patches to support more than one EMAC clock
> - add patch to rework and extend USB PHY support
> - add DT binding documentation patches
> 
> Andre Przywara (18):
>   clk: sunxi-ng: h6: Fix clock divider range on some clocks
>   dt-bindings: pinctrl: Add Allwinner H616 compatible strings
>   pinctrl: sunxi: Add support for the Allwinner H616 pin controller
>   pinctrl: sunxi: Add support for the Allwinner H616-R pin controller
>   dt-bindings: clk: sunxi-ccu: Add compatible string for Allwinner
> H616
>   clk: sunxi-ng: Add support for the Allwinner H616 R-CCU
>   clk: sunxi-ng: Add support for the Allwinner H616 CCU
>   mfd: axp20x: Allow AXP chips without interrupt lines
>   dt-bindings: sram: sunxi-sram: Add H616 compatible string
>   soc: sunxi: sram: Add support for more than one EMAC clock
>   net: stmmac: dwmac-sun8i: Prepare for second EMAC clock register
>   phy: sun4i-usb: Rework "pmu_unk1" handling
>   phy: sun4i-usb: Add support for the H616 USB PHY
>   dt-bindings: watchdog: sun4i: Add H616 compatible string
>   dt-bindings: allwinner: Add H616 compatible strings
>   arm64: dts: allwinner: Add Allwinner H616 .dtsi file
>   dt-bindings: arm: sunxi: Add OrangePi Zero 2 binding
>   arm64: dts: allwinner: Add OrangePi Zero 2 .dts
> 
> Yangtao Li (3):
>   dt-bindings: mmc: sunxi: Add Allwinner A100 and H616 compatibles
>   mmc: sunxi: add support for A100 mmc controller
>   dt-bindings: watchdog: sun4i: Add A100 compatible
> 
>  .../devicetree/bindings/arm/sunxi.yaml        |    5 +
>  .../clock/allwinner,sun4i-a10-ccu.yaml        |    2 +
>  .../bindings/i2c/marvell,mv64xxx-i2c.yaml     |   21 +-
>  .../media/allwinner,sun4i-a10-ir.yaml         |   16 +-
>  .../bindings/mmc/allwinner,sun4i-a10-mmc.yaml |    8 +
>  .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml  |    2 +
>  .../bindings/rtc/allwinner,sun6i-a31-rtc.yaml |    3 +
>  .../bindings/spi/allwinner,sun6i-a31-spi.yaml |    1 +
>  .../allwinner,sun4i-a10-system-control.yaml   |    1 +
>  .../watchdog/allwinner,sun4i-a10-wdt.yaml     |    9 +-
>  arch/arm64/boot/dts/allwinner/Makefile        |    1 +
>  .../allwinner/sun50i-h616-orangepi-zero2.dts  |  240 ++++
>  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi |  715 ++++++++++
>  drivers/clk/sunxi-ng/Kconfig                  |    7 +-
>  drivers/clk/sunxi-ng/Makefile                 |    1 +
>  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c        |   47 +-
>  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h        |    3 +-
>  drivers/clk/sunxi-ng/ccu-sun50i-h6.c          |    8 +-
>  drivers/clk/sunxi-ng/ccu-sun50i-h616.c        | 1150
> +++++++++++++++++
>  drivers/clk/sunxi-ng/ccu-sun50i-h616.h        |   56 +
>  drivers/mfd/axp20x.c                          |   17 +-
>  drivers/mmc/host/sunxi-mmc.c                  |   28 +-
>  .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |   12 +-
>  drivers/phy/allwinner/phy-sun4i-usb.c         |   39 +-
>  drivers/pinctrl/sunxi/Kconfig                 |   10 +
>  drivers/pinctrl/sunxi/Makefile                |    2 +
>  drivers/pinctrl/sunxi/pinctrl-sun50i-h616-r.c |   54 +
>  drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c   |  548 ++++++++
>  drivers/soc/sunxi/sunxi_sram.c                |   31 +-
>  include/dt-bindings/clock/sun50i-h616-ccu.h   |  115 ++
>  include/dt-bindings/reset/sun50i-h616-ccu.h   |   70 +
>  31 files changed, 3151 insertions(+), 71 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-
> orangepi-zero2.dts
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h616.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h616.h
>  create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-h616-r.c
>  create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
>  create mode 100644 include/dt-bindings/clock/sun50i-h616-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun50i-h616-ccu.h
> 
