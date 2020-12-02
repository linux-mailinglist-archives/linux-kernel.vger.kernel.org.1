Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8267B2CBECB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 14:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388779AbgLBNzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 08:55:23 -0500
Received: from foss.arm.com ([217.140.110.172]:40246 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbgLBNzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 08:55:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1364D30E;
        Wed,  2 Dec 2020 05:54:37 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CFE93F718;
        Wed,  2 Dec 2020 05:54:35 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Icenowy Zheng <icenowy@aosc.xyz>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yangtao Li <frank@allwinnertech.com>,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 0/8] arm64: sunxi: Initial Allwinner H616 SoC support
Date:   Wed,  2 Dec 2020 13:54:01 +0000
Message-Id: <20201202135409.13683-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is the first attempt of supporting the Allwinner H616 SoC. This is
a rather uninspired SoC (Quad-A53 with the usual peripherals), but
allows for some cheap development boards and TV boxes, and supports
up to 4GB of DRAM.

There are surely many issues in this series, but I wanted to get the
discussion and review (on the tedious clock bits) started on this.

Patch 1/8 is the usual drive-by fix, discovered while staring at
the H6 clock code.
Patch 2 and 3 add pinctrl support, with the "-R" controller now being
crippled down to two I2C pins only. If we grow tired of repeating this
exercise for every new SoC variant, I am happy to revive my more
versatile sunxi pinctrl driver effort from a few years back [1].
Patch 4 and 5 add clock support. For the -R clock this is shared with
the H6 code, as the clocks are identical, with the H616 just having
fewer of them.
Originally I started with using the same approach for the main clocks
as well, but this started to look messy, so I eventually decided to
copy the H6 driver and adjust it in this new file.
For reference, the old approach is here[2], if people think there are
merits in keeping them together.
Patch 6/8 is pulling a patch from Yangtao's A100 series, since we need
the same fix for MMC support. This will probably be merged separately,
I just include this here to provide a booting solution.
Patch 7 adds the SoC .dtsi file, that's copied from the H6 .dtsi, and
scrubbed for those peripherals which require more love.
The final patch eventually adds support for the OrangePi Zero2 board
featuring this SoC. Find more information in the sunxi Wiki[3].

We have U-Boot and Trusted-Firmware support in a working state, booting
via FEL and even TFTPing kernels work already [4][5].

Many thanks to Jernej for his tremendous help on this, also for the
awesome input and help from the #linux-sunxi Freenode channel.

The whole series can also be found here:
https://github.com/apritzel/linux/commits/h616-v1
It boots some Debian just fine, with Ethernet working as well. USB
is not working yet, but should be around the corner.

Happy reviewing!

Cheers,
Andre

[1] https://patchwork.ozlabs.org/project/linux-gpio/cover/20171113012523.2328-1-andre.przywara@arm.com/
[2] https://github.com/apritzel/linux/commits/h616-sharedclk
[3] https://linux-sunxi.org/Xunlong_Orange_Pi_Zero2
[4] https://github.com/jernejsk/u-boot/commits/h616-v1
[5] https://github.com/apritzel/arm-trusted-firmware/commits/h616-WIP

Andre Przywara (7):
  clk: sunxi-ng: h6: Fix clock divider range on some clocks
  pinctrl: sunxi: Add support for the Allwinner H616 pin controller
  pinctrl: sunxi: Add support for the Allwinner H616-R pin controller
  clk: sunxi-ng: Add support for the Allwinner H616 R-CCU
  clk: sunxi-ng: Add support for the Allwinner H616 CCU
  arm64: dts: allwinner: Add Allwinner H616 .dtsi file
  arm64: dts: allwinner: Add OrangePi Zero 2 .dts

Yangtao Li (1):
  mmc: sunxi: add support for A100 mmc controller

 arch/arm64/boot/dts/allwinner/Makefile        |    1 +
 .../allwinner/sun50i-h616-orangepi-zero2.dts  |  228 ++++
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi |  704 ++++++++++
 drivers/clk/sunxi-ng/Kconfig                  |    7 +-
 drivers/clk/sunxi-ng/Makefile                 |    1 +
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c        |   47 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.h        |    3 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c          |    8 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c        | 1134 +++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-h616.h        |   58 +
 drivers/mmc/host/sunxi-mmc.c                  |   28 +-
 drivers/pinctrl/sunxi/Kconfig                 |   10 +
 drivers/pinctrl/sunxi/Makefile                |    2 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-h616-r.c |   58 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c   |  549 ++++++++
 include/dt-bindings/clock/sun50i-h616-ccu.h   |  110 ++
 include/dt-bindings/reset/sun50i-h616-ccu.h   |   67 +
 17 files changed, 3005 insertions(+), 10 deletions(-)
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

