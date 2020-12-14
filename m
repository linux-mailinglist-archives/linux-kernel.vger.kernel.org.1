Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC172D918A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 02:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437294AbgLNBTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 20:19:53 -0500
Received: from foss.arm.com ([217.140.110.172]:42998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730052AbgLNBTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 20:19:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB94C1FB;
        Sun, 13 Dec 2020 17:19:06 -0800 (PST)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B42D23F66E;
        Sun, 13 Dec 2020 17:19:04 -0800 (PST)
Subject: Re: [PATCH v2 00/21] arm64: sunxi: Initial Allwinner H616 SoC support
To:     Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Icenowy Zheng <icenowy@aosc.xyz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20201211011934.6171-1-andre.przywara@arm.com>
 <7bc85e6acaa4c73cb32d73c6da3a3dd43bd5411d.camel@aosc.io>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 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
 i4aIXCH3Wv6K
Organization: ARM Ltd.
Message-ID: <bdf40337-22f1-b63c-f498-a4c210eaf92b@arm.com>
Date:   Mon, 14 Dec 2020 01:18:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <7bc85e6acaa4c73cb32d73c6da3a3dd43bd5411d.camel@aosc.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/2020 17:47, Icenowy Zheng wrote:

Hi Icenowy,

> 在 2020-12-11星期五的 01:19 +0000，Andre Przywara写道：
>> Hi,
>>
>> this is the quite expanded second version of the support series for
>> the
>> Allwinner H616 SoC.
>> Besides many fixes for the bugs discovered by the diligent reviewers
>> (many thanks for that!) this version adds some patches to support
>> some
>> slightly changed devices, like the second EMAC and the AXP not having
>> an interrupt.
>> Also I added quite some DT binding doc patches.
>> USB still does not work, but I include the patches anyway, hoping
>> that
>> someone can help spotting the issue.
>> For a more detailed changelog see below.
>>
>> Thanks!
>> Andre
>>
>> ==================
>> This series gathers patches to support the Allwinner H616 SoC. This
>> is
>> a rather uninspired SoC (Quad-A53 with the usual peripherals), but
>> allows for some cheap development boards and TV boxes, and supports
>> up to 4GB of DRAM.
>>
>> Various DT binding patches are sprinkled throughout the series, to
>> add
>> the new compatible names right before they are used.
>> Patch 1/21 is the usual drive-by fix, discovered while staring at
>> the H6 clock code.
>> Patch 3 and 4 add pinctrl support, with the "-R" controller now being
>> crippled down to two I2C pins only. If we grow tired of repeating
>> this
>> exercise for every new SoC variant, I am happy to revive my more
>> versatile sunxi pinctrl driver effort from a few years back [1].
>> Patch 6 and 7 add clock support. For the -R clock this is shared with
>> the H6 code, as the clocks are identical, with the H616 just having
>> fewer of them. The main clocks are different enough to warrant a
>> separate
>> file.
>> Patch 08/21 is pulling a patch from Yangtao's A100 series, since we
>> need
>> the same fix for MMC support. This will probably be merged
>> separately,
>> I just include this here to provide a bootable solution.
>> Patch 10 teaches the AXP MFD driver to get along without having an
>> interrupt, as the H616 apparently does not have an NMI controller
>> anymore.
>> Patch 12 and 13 add some tweaks to the syscon and EMAC driver, to
>> deal
>> with the second EMAC clock used for the second Ethernet controller.
>> Patches 14 and 15 *try* to add USB support. The same approach works
>> with
>> the very similar U-Boot PHY driver, but for some reason still fail in
>> Linux. Maybe someone spots the issue and can help fixing it?
> 
> There's a judge currently checks for phy type A83T/H6. You may need to
> add H616 there.

You mean for setting PHY_CTL_VBUSVLDEXT and clearing PHY_CTL_SIDDQ? This
is guarded by .type == sun50i_h6_phy, which I also use for the H616.
So this should be covered.

> Or should we have a bool in the data struct to mark it? I think all
> chips that need that is 28nm.

Yeah, the usage of .type seems somewhat arbitrary, at the end of the day
it's just another quirk for a group of SoCs.

Thanks!
Andre

> 
>>
>> The remaining patches add DT bindings, which just add the new
>> compatible
>> string along with an existing name as a fallback string.
>> Eventually we get the .dtsi for the SoC in patch 19, and the .dts for
>> the OrangePi Zero2 board[2] in the last patch.
>>
>> We have U-Boot and Trusted-Firmware support in a working state,
>> booting
>> via FEL and even TFTPing kernels work already [3][4].
>>
>> Many thanks to Jernej for his tremendous help on this, also for the
>> awesome input and help from the #linux-sunxi Freenode channel.
>>
>> The whole series can also be found here:
>> https://github.com/apritzel/linux/commits/h616-v2
>>
>> Happy reviewing!
>>
>> Cheers,
>> Andre
>>
>> [1] 
>> https://patchwork.ozlabs.org/project/linux-gpio/cover/20171113012523.2328-1-andre.przywara@arm.com/
>> [2] https://linux-sunxi.org/Xunlong_Orange_Pi_Zero2
>> [3] https://github.com/jernejsk/u-boot/commits/h616-v1
>> [4] https://github.com/apritzel/arm-trusted-firmware/commits/h616-WIP
>>
>> Changelog v1 .. v2:
>> - pinctrl: adjust irq bank map to cover undocumented GPIO bank IRQs
>> - use differing h_i2s0 pin output names
>> - r-ccu: fix number of used clocks
>> - ccu: remove PLL-PERIPHy(4X)
>> - ccu: fix gpu1 divider range
>> - ccu: fix usb-phy3 parent
>> - ccu: add missing TV clocks
>> - ccu: rework to CLK_OF_DECLARE style
>> - ccu: enable output bit for PLL clocks
>> - ccu: renumber clocks
>> - .dtsi: drop sun50i-a64-system-control fallback
>> - .dtsi: drop unknown SRAM regions
>> - .dtsi: add more (undocumented) GPIO interrupts
>> - .dtsi: fix I2C3 pin names
>> - .dtsi: use a100-emmc fallback for MMC2
>> - .dtsi: add second EMAC controller
>> - .dtsi: use H3 MUSB controller fallback
>> - .dtsi: fix frame size for USB PHY PMU registers
>> - .dtsi: add USB0 PHY references
>> - .dtsi: fix IR controller clock source
>> - .dts: fix LED naming and swap pins
>> - .dts: use 5V supply parent for USB supply
>> - .dts: drop dummy IRQ for AXP
>> - .dts: enable 3V3 header pin power rail
>> - .dts: add SPI flash node
>> - .dts: make USB-C port peripheral only
>> - add IRQ-less AXP support
>> - add two patches to support more than one EMAC clock
>> - add patch to rework and extend USB PHY support
>> - add DT binding documentation patches
>>
>> Andre Przywara (18):
>>   clk: sunxi-ng: h6: Fix clock divider range on some clocks
>>   dt-bindings: pinctrl: Add Allwinner H616 compatible strings
>>   pinctrl: sunxi: Add support for the Allwinner H616 pin controller
>>   pinctrl: sunxi: Add support for the Allwinner H616-R pin controller
>>   dt-bindings: clk: sunxi-ccu: Add compatible string for Allwinner
>> H616
>>   clk: sunxi-ng: Add support for the Allwinner H616 R-CCU
>>   clk: sunxi-ng: Add support for the Allwinner H616 CCU
>>   mfd: axp20x: Allow AXP chips without interrupt lines
>>   dt-bindings: sram: sunxi-sram: Add H616 compatible string
>>   soc: sunxi: sram: Add support for more than one EMAC clock
>>   net: stmmac: dwmac-sun8i: Prepare for second EMAC clock register
>>   phy: sun4i-usb: Rework "pmu_unk1" handling
>>   phy: sun4i-usb: Add support for the H616 USB PHY
>>   dt-bindings: watchdog: sun4i: Add H616 compatible string
>>   dt-bindings: allwinner: Add H616 compatible strings
>>   arm64: dts: allwinner: Add Allwinner H616 .dtsi file
>>   dt-bindings: arm: sunxi: Add OrangePi Zero 2 binding
>>   arm64: dts: allwinner: Add OrangePi Zero 2 .dts
>>
>> Yangtao Li (3):
>>   dt-bindings: mmc: sunxi: Add Allwinner A100 and H616 compatibles
>>   mmc: sunxi: add support for A100 mmc controller
>>   dt-bindings: watchdog: sun4i: Add A100 compatible
>>
>>  .../devicetree/bindings/arm/sunxi.yaml        |    5 +
>>  .../clock/allwinner,sun4i-a10-ccu.yaml        |    2 +
>>  .../bindings/i2c/marvell,mv64xxx-i2c.yaml     |   21 +-
>>  .../media/allwinner,sun4i-a10-ir.yaml         |   16 +-
>>  .../bindings/mmc/allwinner,sun4i-a10-mmc.yaml |    8 +
>>  .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml  |    2 +
>>  .../bindings/rtc/allwinner,sun6i-a31-rtc.yaml |    3 +
>>  .../bindings/spi/allwinner,sun6i-a31-spi.yaml |    1 +
>>  .../allwinner,sun4i-a10-system-control.yaml   |    1 +
>>  .../watchdog/allwinner,sun4i-a10-wdt.yaml     |    9 +-
>>  arch/arm64/boot/dts/allwinner/Makefile        |    1 +
>>  .../allwinner/sun50i-h616-orangepi-zero2.dts  |  240 ++++
>>  .../arm64/boot/dts/allwinner/sun50i-h616.dtsi |  715 ++++++++++
>>  drivers/clk/sunxi-ng/Kconfig                  |    7 +-
>>  drivers/clk/sunxi-ng/Makefile                 |    1 +
>>  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c        |   47 +-
>>  drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h        |    3 +-
>>  drivers/clk/sunxi-ng/ccu-sun50i-h6.c          |    8 +-
>>  drivers/clk/sunxi-ng/ccu-sun50i-h616.c        | 1150
>> +++++++++++++++++
>>  drivers/clk/sunxi-ng/ccu-sun50i-h616.h        |   56 +
>>  drivers/mfd/axp20x.c                          |   17 +-
>>  drivers/mmc/host/sunxi-mmc.c                  |   28 +-
>>  .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |   12 +-
>>  drivers/phy/allwinner/phy-sun4i-usb.c         |   39 +-
>>  drivers/pinctrl/sunxi/Kconfig                 |   10 +
>>  drivers/pinctrl/sunxi/Makefile                |    2 +
>>  drivers/pinctrl/sunxi/pinctrl-sun50i-h616-r.c |   54 +
>>  drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c   |  548 ++++++++
>>  drivers/soc/sunxi/sunxi_sram.c                |   31 +-
>>  include/dt-bindings/clock/sun50i-h616-ccu.h   |  115 ++
>>  include/dt-bindings/reset/sun50i-h616-ccu.h   |   70 +
>>  31 files changed, 3151 insertions(+), 71 deletions(-)
>>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-
>> orangepi-zero2.dts
>>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
>>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h616.c
>>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h616.h
>>  create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-h616-r.c
>>  create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
>>  create mode 100644 include/dt-bindings/clock/sun50i-h616-ccu.h
>>  create mode 100644 include/dt-bindings/reset/sun50i-h616-ccu.h
>>

