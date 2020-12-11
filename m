Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04AAA2D6D4A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 02:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394798AbgLKBWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 20:22:23 -0500
Received: from foss.arm.com ([217.140.110.172]:49266 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404733AbgLKBUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 20:20:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 825361FB;
        Thu, 10 Dec 2020 17:19:53 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4564E3F66B;
        Thu, 10 Dec 2020 17:19:51 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Icenowy Zheng <icenowy@aosc.xyz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v2 00/21] arm64: sunxi: Initial Allwinner H616 SoC support
Date:   Fri, 11 Dec 2020 01:19:13 +0000
Message-Id: <20201211011934.6171-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is the quite expanded second version of the support series for the
Allwinner H616 SoC.
Besides many fixes for the bugs discovered by the diligent reviewers
(many thanks for that!) this version adds some patches to support some
slightly changed devices, like the second EMAC and the AXP not having
an interrupt.
Also I added quite some DT binding doc patches.
USB still does not work, but I include the patches anyway, hoping that
someone can help spotting the issue.
For a more detailed changelog see below.

Thanks!
Andre

==================
This series gathers patches to support the Allwinner H616 SoC. This is
a rather uninspired SoC (Quad-A53 with the usual peripherals), but
allows for some cheap development boards and TV boxes, and supports
up to 4GB of DRAM.

Various DT binding patches are sprinkled throughout the series, to add
the new compatible names right before they are used.
Patch 1/21 is the usual drive-by fix, discovered while staring at
the H6 clock code.
Patch 3 and 4 add pinctrl support, with the "-R" controller now being
crippled down to two I2C pins only. If we grow tired of repeating this
exercise for every new SoC variant, I am happy to revive my more
versatile sunxi pinctrl driver effort from a few years back [1].
Patch 6 and 7 add clock support. For the -R clock this is shared with
the H6 code, as the clocks are identical, with the H616 just having
fewer of them. The main clocks are different enough to warrant a separate
file.
Patch 08/21 is pulling a patch from Yangtao's A100 series, since we need
the same fix for MMC support. This will probably be merged separately,
I just include this here to provide a bootable solution.
Patch 10 teaches the AXP MFD driver to get along without having an
interrupt, as the H616 apparently does not have an NMI controller anymore.
Patch 12 and 13 add some tweaks to the syscon and EMAC driver, to deal
with the second EMAC clock used for the second Ethernet controller.
Patches 14 and 15 *try* to add USB support. The same approach works with
the very similar U-Boot PHY driver, but for some reason still fail in
Linux. Maybe someone spots the issue and can help fixing it?

The remaining patches add DT bindings, which just add the new compatible
string along with an existing name as a fallback string.
Eventually we get the .dtsi for the SoC in patch 19, and the .dts for
the OrangePi Zero2 board[2] in the last patch.

We have U-Boot and Trusted-Firmware support in a working state, booting
via FEL and even TFTPing kernels work already [3][4].

Many thanks to Jernej for his tremendous help on this, also for the
awesome input and help from the #linux-sunxi Freenode channel.

The whole series can also be found here:
https://github.com/apritzel/linux/commits/h616-v2

Happy reviewing!

Cheers,
Andre

[1] https://patchwork.ozlabs.org/project/linux-gpio/cover/20171113012523.2328-1-andre.przywara@arm.com/
[2] https://linux-sunxi.org/Xunlong_Orange_Pi_Zero2
[3] https://github.com/jernejsk/u-boot/commits/h616-v1
[4] https://github.com/apritzel/arm-trusted-firmware/commits/h616-WIP

Changelog v1 .. v2:
- pinctrl: adjust irq bank map to cover undocumented GPIO bank IRQs
- use differing h_i2s0 pin output names
- r-ccu: fix number of used clocks
- ccu: remove PLL-PERIPHy(4X)
- ccu: fix gpu1 divider range
- ccu: fix usb-phy3 parent
- ccu: add missing TV clocks
- ccu: rework to CLK_OF_DECLARE style
- ccu: enable output bit for PLL clocks
- ccu: renumber clocks
- .dtsi: drop sun50i-a64-system-control fallback
- .dtsi: drop unknown SRAM regions
- .dtsi: add more (undocumented) GPIO interrupts
- .dtsi: fix I2C3 pin names
- .dtsi: use a100-emmc fallback for MMC2
- .dtsi: add second EMAC controller
- .dtsi: use H3 MUSB controller fallback
- .dtsi: fix frame size for USB PHY PMU registers
- .dtsi: add USB0 PHY references
- .dtsi: fix IR controller clock source
- .dts: fix LED naming and swap pins
- .dts: use 5V supply parent for USB supply
- .dts: drop dummy IRQ for AXP
- .dts: enable 3V3 header pin power rail
- .dts: add SPI flash node
- .dts: make USB-C port peripheral only
- add IRQ-less AXP support
- add two patches to support more than one EMAC clock
- add patch to rework and extend USB PHY support
- add DT binding documentation patches

Andre Przywara (18):
  clk: sunxi-ng: h6: Fix clock divider range on some clocks
  dt-bindings: pinctrl: Add Allwinner H616 compatible strings
  pinctrl: sunxi: Add support for the Allwinner H616 pin controller
  pinctrl: sunxi: Add support for the Allwinner H616-R pin controller
  dt-bindings: clk: sunxi-ccu: Add compatible string for Allwinner H616
  clk: sunxi-ng: Add support for the Allwinner H616 R-CCU
  clk: sunxi-ng: Add support for the Allwinner H616 CCU
  mfd: axp20x: Allow AXP chips without interrupt lines
  dt-bindings: sram: sunxi-sram: Add H616 compatible string
  soc: sunxi: sram: Add support for more than one EMAC clock
  net: stmmac: dwmac-sun8i: Prepare for second EMAC clock register
  phy: sun4i-usb: Rework "pmu_unk1" handling
  phy: sun4i-usb: Add support for the H616 USB PHY
  dt-bindings: watchdog: sun4i: Add H616 compatible string
  dt-bindings: allwinner: Add H616 compatible strings
  arm64: dts: allwinner: Add Allwinner H616 .dtsi file
  dt-bindings: arm: sunxi: Add OrangePi Zero 2 binding
  arm64: dts: allwinner: Add OrangePi Zero 2 .dts

Yangtao Li (3):
  dt-bindings: mmc: sunxi: Add Allwinner A100 and H616 compatibles
  mmc: sunxi: add support for A100 mmc controller
  dt-bindings: watchdog: sun4i: Add A100 compatible

 .../devicetree/bindings/arm/sunxi.yaml        |    5 +
 .../clock/allwinner,sun4i-a10-ccu.yaml        |    2 +
 .../bindings/i2c/marvell,mv64xxx-i2c.yaml     |   21 +-
 .../media/allwinner,sun4i-a10-ir.yaml         |   16 +-
 .../bindings/mmc/allwinner,sun4i-a10-mmc.yaml |    8 +
 .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml  |    2 +
 .../bindings/rtc/allwinner,sun6i-a31-rtc.yaml |    3 +
 .../bindings/spi/allwinner,sun6i-a31-spi.yaml |    1 +
 .../allwinner,sun4i-a10-system-control.yaml   |    1 +
 .../watchdog/allwinner,sun4i-a10-wdt.yaml     |    9 +-
 arch/arm64/boot/dts/allwinner/Makefile        |    1 +
 .../allwinner/sun50i-h616-orangepi-zero2.dts  |  240 ++++
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi |  715 ++++++++++
 drivers/clk/sunxi-ng/Kconfig                  |    7 +-
 drivers/clk/sunxi-ng/Makefile                 |    1 +
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c        |   47 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h        |    3 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c          |    8 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c        | 1150 +++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-h616.h        |   56 +
 drivers/mfd/axp20x.c                          |   17 +-
 drivers/mmc/host/sunxi-mmc.c                  |   28 +-
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |   12 +-
 drivers/phy/allwinner/phy-sun4i-usb.c         |   39 +-
 drivers/pinctrl/sunxi/Kconfig                 |   10 +
 drivers/pinctrl/sunxi/Makefile                |    2 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-h616-r.c |   54 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c   |  548 ++++++++
 drivers/soc/sunxi/sunxi_sram.c                |   31 +-
 include/dt-bindings/clock/sun50i-h616-ccu.h   |  115 ++
 include/dt-bindings/reset/sun50i-h616-ccu.h   |   70 +
 31 files changed, 3151 insertions(+), 71 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h616.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-h616.h
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-h616-r.c
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
 create mode 100644 include/dt-bindings/clock/sun50i-h616-ccu.h
 create mode 100644 include/dt-bindings/reset/sun50i-h616-ccu.h

-- 
2.17.5

