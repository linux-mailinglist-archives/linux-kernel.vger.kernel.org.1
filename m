Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AB92F97A0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 03:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730983AbhARCKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 21:10:16 -0500
Received: from foss.arm.com ([217.140.110.172]:48090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730897AbhARCKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 21:10:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A54B31B;
        Sun, 17 Jan 2021 18:09:27 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 650403F719;
        Sun, 17 Jan 2021 18:09:25 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v3 00/21] arm64: sunxi: Initial Allwinner H616 SoC support
Date:   Mon, 18 Jan 2021 02:08:27 +0000
Message-Id: <20210118020848.11721-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

an update from the v2 in December, to add support for the Allwinner H616
SoC. This time it's based on sunxi/for-next, which is based on 5.11-rc1.
The A100 watchdog binding patch is already merged, so omitted,
and Ulf has already queued the two MMC patch to his next branch. I am
still including them here to get a complete series on the list.

I was wondering if at least the basic pinctrl, clock and MFD patch (up
until patch 9) might make it into 5.12? Maybe the EMAC (patches 10-12)
as well?

Besides some fixes and addressed comments, this version adds RSB support:
this seems to be a similar story like for the H6 (omitted from the manual,
but fully functional).

USB seems to work now *sometimes*, one issue was the dodgy power situation
when powering with a bad USB-C cable from a laptop. Powering from a proper
USB-C power supply works better, however I still get enumeration errors
from Linux ("error -62") occasionally. On some boots it works just fine.

I keep the reserved-memory node in the .dtsi for now. Trusted Firmware now
properly adds this to the DT, but U-Boot does not propagate this to a
freshly loaded DTB (using $fdtcontroladdr works, though). When this gets
fixed in U-Boot, we can remove this from the .dtsi.

For a more detailed changelog, see below.

Thanks!
Andre

==================
This series gathers patches to support the Allwinner H616 SoC. This is
a rather uninspired SoC (Quad-A53 with the usual peripherals), but
allows for some cheap development boards and TV boxes, and supports
up to 4GB of DRAM.

Various DT binding patches are sprinkled throughout the series, to add
the new compatible names right before they are used.
Patch 4 and 5 add pinctrl support, with the "-R" controller now being
crippled down to two I2C pins only. If we grow tired of repeating this
exercise for every new SoC variant, I am happy to revive my more
versatile sunxi pinctrl driver effort from a few years back [1].
Patch 7 and 8 add clock support. For the -R clock this is shared with
the H6 code, as the clocks are identical, with the H616 just having
fewer of them. The main clocks are different enough to warrant a separate
file.
Patch 9 teaches the AXP MFD driver to get along without having an
interrupt, as the H616 apparently does not have an NMI controller anymore.
Patch 11 and 12 add some tweaks to the syscon and EMAC driver, to deal
with the second EMAC clock used for the second Ethernet controller.
Patches 13 and 16 add USB support.

The remaining patches add DT bindings, which just add the new compatible
string along with an existing name as a fallback string.
Eventually we get the .dtsi for the SoC in patch 19, and the .dts for
the OrangePi Zero2 board[2] in the last patch.

We have U-Boot and Trusted-Firmware support in a working state, booting
via FEL or SD card and even TFTPing kernels work already [3][4].

Many thanks to Jernej for his tremendous help on this, also for the
awesome input and help from the #linux-sunxi Freenode channel.

The whole series can also be found here:
https://github.com/apritzel/linux/commits/h616-v3

Happy reviewing!

Cheers,
Andre

[1] https://patchwork.ozlabs.org/project/linux-gpio/cover/20171113012523.2328-1-andre.przywara@arm.com/
[2] https://linux-sunxi.org/Xunlong_Orange_Pi_Zero2
[3] https://github.com/jernejsk/u-boot/commits/h616-v2
[4] https://github.com/apritzel/arm-trusted-firmware/commits/h616-v1

Changelog v2 .. v3:
- Add Rob's Acks
- Drop redundant maxItems from pinctrl DT binding
- Rename h_i2s* to just i2s* in pinctrl names
- Use more declarative i2s0_d{in,out}{0,1} names
- Add RSB pins to pinctrl
- Include RSB clocks (sharing with newly added H6 versions)
- Fix CEC clock (add 2nd enable bit, also fix predivider flag)
- Rename PMU_UNK1 register in USB PHY
- Add USB and MUSB DT binding patches
- Add MMC/SD speed modes to .dtsi

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

Andre Przywara (19):
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
  phy: sun4i-usb: Rework HCI PHY (aka. "pmu_unk1") handling
  dt-bindings: usb: Add H616 compatible string
  dt-bindings: usb: sunxi-musb: Add H616 compatible string
  phy: sun4i-usb: Add support for the H616 USB PHY
  dt-bindings: watchdog: sun4i: Add H616 compatible string
  dt-bindings: allwinner: Add H616 compatible strings
  arm64: dts: allwinner: Add Allwinner H616 .dtsi file
  dt-bindings: arm: sunxi: Add OrangePi Zero 2 binding
  arm64: dts: allwinner: Add OrangePi Zero 2 .dts

Yangtao Li (2):
  dt-bindings: mmc: sunxi: Add Allwinner A100 and H616 compatibles
  mmc: sunxi: add support for A100 mmc controller

 .../devicetree/bindings/arm/sunxi.yaml        |    5 +
 .../clock/allwinner,sun4i-a10-ccu.yaml        |    2 +
 .../bindings/i2c/marvell,mv64xxx-i2c.yaml     |   21 +-
 .../media/allwinner,sun4i-a10-ir.yaml         |   16 +-
 .../bindings/mmc/allwinner,sun4i-a10-mmc.yaml |    8 +
 .../phy/allwinner,sun8i-h3-usb-phy.yaml       |    4 +-
 .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml  |   17 +-
 .../bindings/rtc/allwinner,sun6i-a31-rtc.yaml |    3 +
 .../bindings/spi/allwinner,sun6i-a31-spi.yaml |    1 +
 .../allwinner,sun4i-a10-system-control.yaml   |    1 +
 .../usb/allwinner,sun4i-a10-musb.yaml         |    3 +
 .../watchdog/allwinner,sun4i-a10-wdt.yaml     |   12 +-
 arch/arm64/boot/dts/allwinner/Makefile        |    1 +
 .../allwinner/sun50i-h616-orangepi-zero2.dts  |  240 ++++
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi |  750 +++++++++++
 drivers/clk/sunxi-ng/Kconfig                  |    7 +-
 drivers/clk/sunxi-ng/Makefile                 |    1 +
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c        |   48 +
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c        | 1150 +++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-h616.h        |   56 +
 drivers/mfd/axp20x.c                          |   17 +-
 drivers/mmc/host/sunxi-mmc.c                  |   28 +-
 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c |   12 +-
 drivers/phy/allwinner/phy-sun4i-usb.c         |   40 +-
 drivers/pinctrl/sunxi/Kconfig                 |   10 +
 drivers/pinctrl/sunxi/Makefile                |    2 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-h616-r.c |   56 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c   |  548 ++++++++
 drivers/soc/sunxi/sunxi_sram.c                |   31 +-
 include/dt-bindings/clock/sun50i-h616-ccu.h   |  115 ++
 include/dt-bindings/reset/sun50i-h616-ccu.h   |   70 +
 31 files changed, 3204 insertions(+), 71 deletions(-)
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

