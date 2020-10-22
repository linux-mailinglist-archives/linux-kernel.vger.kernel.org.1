Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9A42964D0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 20:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369528AbgJVSsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 14:48:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2900092AbgJVSsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 14:48:36 -0400
Received: from mail.kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38A9924630;
        Thu, 22 Oct 2020 18:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603392514;
        bh=pVdjukbDb8Cu25/l/eW49B1Oltp2/CPYr/oTOQ7dGj0=;
        h=From:To:Cc:Subject:Date:From;
        b=or/qjF5jRJq2r8dCMJhT5EUY2V3fAuVljQAXV/jEiXhZnYiXA0cxNgbMrZnEkXVHL
         ld5QeEuN9guhVf32e08GI+ifUd3zLx3BI+bL5caAjwiEtHbpOcF4tKBAqL0ME7r0+i
         zk2T3tNp93tbNjfNVQI/fJB8J+etv8zW4jUhM23s=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Thu, 22 Oct 2020 11:48:33 -0700
Message-Id: <20201022184833.405787-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0212a0483b0a36cc94cfab882b3edbb41fcfe1cd:

  clk: samsung: Keep top BPLL mux on Exynos542x enabled (2020-09-15 13:56:51 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 5f56888fad46812bab9ecb455d92da675ef4fbd0:

  Merge branches 'clk-ingenic', 'clk-at91', 'clk-kconfig', 'clk-imx', 'clk-qcom', 'clk-prima2' and 'clk-bcm' into clk-next (2020-10-20 11:47:07 -0700)

----------------------------------------------------------------
This pull request contains zero diff to the core framework. It is a collection
of various clk driver updates. The biggest driver updates in terms of lines of
code is the Allwinner driver, closely followed by the Qualcomm and Mediatek
drivers. All of those hit high because we add so many lines of clk data. Coming
in fourth place is i.MX which also adds a bunch of clk data. This accounts for
the new driver additions this time around.

Otherwise the patches are lots of little cleanups and fixes for various clk
drivers that have baked in linux-next for a while. I suppose one highlight or
theme is that more clk drivers are being updated to work as modules, which is
interesting to see such critical SoC infrastructure work as a loadable module.

New Drivers:
 - Support qcom SM8150/SM8250 video and display clks
 - Support Mediatek MT8167 clks
 - Add clock for CRC block found on vf610 SoCs
 - Add support for the Renesas R-Car V3U (R8A779A0) SoC
 - Add support for the VSP for Resizing clock on Renesas RZ/G1H
 - Support Allwinner A100 SoC clks

Removed Drivers:
 - Remove i.MX21 clock driver, as i.MX21 platform support is being dropped

Updates:
 - Change how qcom's display port clks work
 - Small non-critical fixes for TI clk driver
 - Remove various unused variables in clk drivers
 - Allow Rockchip clk driver to be a module
 - Remove most __clk_lookup() calls in Samsung drivers (yay!)
 - Support building i.MX ARMv8 platforms clock driver as module
 - Some kerneldoc fixes here and there
 - A couple of minor i.MX clk data corrections
 - Update audio clock inverter and fdiv2 flag on Amlogic g12
 - Make amlogic clk drivers configurable in Kconfig
 - Fix Renesas VSP clock names to match corrected hardware documentation
 - Sigma-delta modulation on Allwinner R40
 - Various fixes for at91 clk driver
 - Use semicolons instead of commas in some places
 - Mark some variables const so they can move to RO memory

----------------------------------------------------------------
Abel Vesa (1):
      clk: imx8mq: Fix usdhc parents order

Anson Huang (7):
      clk: imx6sl: Use BIT(x) to avoid shifting signed 32-bit value by 31 bits
      clk: composite: Export clk_hw_register_composite()
      clk: imx: Support building i.MX common clock driver as module
      clk: imx: Add clock configuration for ARMv7 platforms
      clk: imx8m: Support module build
      clk: imx8qxp: Support building i.MX8QXP clock driver as module
      clk: imx: Explicitly include bits.h

Claudiu Beznea (4):
      clk: at91: remove the checking of parent_name
      clk: at91: clk-main: update key before writing AT91_CKGR_MOR
      clk: at91: clk-sam9x60-pll: remove unused variable
      clk: at91: sam9x60: support only two programmable clocks

Elaine Zhang (6):
      clk: rockchip: Use clk_hw_register_composite instead of clk_register_composite calls
      clk: rockchip: Export rockchip_clk_register_ddrclk()
      clk: rockchip: Export rockchip_register_softrst()
      clk: rockchip: Export some clock common APIs for module drivers
      clk: rockchip: fix the clk config to support module build
      clk: rockchip: rk3399: Support module build

Fabien Parent (2):
      dt-bindings: clock: mediatek: add bindings for MT8167 clocks
      clk: mediatek: Add MT8167 clock support

Fabio Estevam (1):
      clk: imx: imx21: Remove clock driver

Geert Uytterhoeven (2):
      Merge tag 'renesas-r8a779a0-dt-binding-defs-tag' into clk-renesas-for-v5.10
      clk: Restrict CLK_HSDK to ARC_SOC_HSDK

Hanks Chen (1):
      clk: mediatek: add UART0 clock support

Hoegeun Kwon (1):
      clk: bcm: rpi: Add register to control pixel bvb clk

Jacky Bai (2):
      clk: imx: Correct the root clk of media ldb on imx8mp
      clk: imx: Correct the memrepair clock on imx8mp

Jason Yan (2):
      clk: qcom: ipq8074: make pcie0_rchng_clk_src static
      clk: qcom: gcc-msm8939: remove defined but not used variables

Jernej Skrabec (1):
      clk: sunxi-ng: sun8i: r40: Use sigma delta modulation for audio PLL

Jerome Brunet (4):
      clk: meson: add sclk-ws driver
      clk: meson: axg-audio: separate axg and g12a regmap tables
      clk: meson: axg-audio: fix g12a tdmout sclk inverter
      clk: meson: make shipped controller configurable

Jonathan Marek (7):
      dt-bindings: clock: combine qcom,sdm845-videocc and qcom,sc7180-videocc
      dt-bindings: clock: add SM8150 QCOM video clock bindings
      dt-bindings: clock: add SM8250 QCOM video clock bindings
      clk: qcom: add video clock controller driver for SM8150
      clk: qcom: add video clock controller driver for SM8250
      dt-bindings: clock: add QCOM SM8150 and SM8250 display clock bindings
      clk: qcom: Add display clock controller driver for SM8150 and SM8250

Jonathan Neuschäfer (1):
      clk: imx: gate2: Fix a few typos

Julia Lawall (3):
      clk: uniphier: use semicolons rather than commas to separate statements
      clk: mvebu: ap80x-cpu: use semicolons rather than commas to separate statements
      clk: meson: use semicolons rather than commas to separate statements

Konrad Dybcio (2):
      clk: qcom: gcc-sdm660: Fix wrong parent_map
      clk: qcom: gcc-msm8994: Add missing clocks, resets and GDSCs

Krzysztof Kozlowski (9):
      clk: imx: vf610: Add CRC clock
      clk: imx: Fix and update kerneldoc
      clk: rockchip: rk3308: drop unused mux_timer_src_p
      clk: s2mps11: initialize driver via module_platform_driver
      clk: fixed: add missing kerneldoc
      clk: davinci: add missing kerneldoc
      clk: at91: drop unused at91sam9g45_pcr_layout
      clk: mmp: pxa1928: drop unused 'clk' variable
      clk: si5341: drop unused 'err' variable

Lad Prabhakar (3):
      clk: renesas: r8a7742: Add clk entry for VSPR
      clk: renesas: rcar-gen2: Rename vsp1-(sy|rt) clocks to vsp(s|r)
      clk: renesas: rcar-gen3: Update description for RZ/G2

Lars-Peter Clausen (2):
      clk: axi-clkgen: Add support for fractional dividers
      clk: axi-clkgen: Set power bits for fractional mode

Liu Shixin (2):
      clk: mediatek: mt6797: simplify the return expression of mtk_infrasys_init
      clk: mediatek: mt7629: simplify the return expression of mtk_infrasys_init

Lubomir Rintel (1):
      clk: mmp2: Fix the display clock divider base

Navid Emamdoost (1):
      clk: bcm2835: add missing release if devm_clk_hw_register fails

Paul Cercueil (5):
      clk: ingenic: Use to_clk_info() macro for all clocks
      clk: ingenic: Use readl_poll_timeout instead of custom loop
      clk: ingenic: Don't use CLK_SET_RATE_GATE for PLL
      clk: ingenic: Don't tag custom clocks with CLK_SET_RATE_PARENT
      clk: ingenic: Respect CLK_SET_RATE_PARENT in .round_rate

Peng Fan (2):
      clk: imx: fix composite peripheral flags
      clk: imx: fix i.MX7D peripheral clk mux flags

Rikard Falkeborn (1):
      clk: pxa: Constify static struct clk_ops

Serge Semin (1):
      clk: baikal-t1: Mark Ethernet PLL as critical

Stefan Agner (1):
      clk: meson: g12a: mark fclk_div2 as critical

Stephen Boyd (14):
      Merge tag 'clk-renesas-for-v5.10-tag2' of git://git.kernel.org/.../geert/renesas-drivers into clk-renesas
      Merge tag 'clk-meson-v5.10-1' of https://github.com/BayLibre/clk-meson into clk-amlogic
      Merge tag 'sunxi-clk-for-5.10-1' of https://git.kernel.org/.../sunxi/linux into clk-allwinner
      clk: qcom: dispcc: Update DP clk ops for phy design
      Merge tag 'clk-imx-5.10' of git://git.kernel.org/.../shawnguo/linux into clk-imx
      Merge tag 'clk-v5.10-samsung' of https://git.kernel.org/.../snawrocki/clk into clk-samsung
      clk: tegra: Drop !provider check in tegra210_clk_emc_set_rate()
      Merge tag 'v5.10-rockchip-clk1' of git://git.kernel.org/.../mmind/linux-rockchip into clk-rockchip
      clk: rockchip: Initialize hw to error to avoid undefined behavior
      clk: qcom: gdsc: Keep RETAIN_FF bit set if gdsc is already on
      Merge branches 'clk-renesas', 'clk-amlogic', 'clk-allwinner', 'clk-samsung', 'clk-doc' and 'clk-unused' into clk-next
      Merge branches 'clk-simplify', 'clk-ti', 'clk-tegra', 'clk-rockchip' and 'clk-mediatek' into clk-next
      Merge branches 'clk-semicolon', 'clk-axi-clkgen', 'clk-qoriq', 'clk-baikal', 'clk-const' and 'clk-mmp2' into clk-next
      Merge branches 'clk-ingenic', 'clk-at91', 'clk-kconfig', 'clk-imx', 'clk-qcom', 'clk-prima2' and 'clk-bcm' into clk-next

Sylwester Nawrocki (5):
      clk: samsung: exynos5420: Add definition of clock ID for mout_sw_aclk_g3d
      clk: samsung: exynos5420: Avoid __clk_lookup() calls when enabling clocks
      clk: samsung: Add clk ID definitions for the CPU parent clocks
      clk: samsung: exynos5420/5250: Add IDs to the CPU parent clk definitions
      clk: samsung: Use cached clk_hws instead of __clk_lookup() calls

Tero Kristo (6):
      clk: keystone: sci-clk: fix parsing assigned-clock data during probe
      clk: keystone: sci-clk: cache results of last query rate operation
      clk: keystone: sci-clk: add 10% slack to set_rate
      clk: ti: autoidle: add checks against NULL pointer reference
      clk: ti: clockdomain: fix static checker warning
      clk: ti: dra7: add missing clkctrl register for SHA2 instance

Wang Qing (1):
      clk/qcom: fix spelling typo

Xu Wang (1):
      clk: clk-prima2: fix return value check in prima2_clk_init()

Yangtao Li (2):
      dt-bindings: clk: sunxi-ccu: add compatible string for A100 CCU and R-CCU
      clk: sunxi-ng: add support for the Allwinner A100 CCU

Yoshihiro Shimoda (6):
      dt-bindings: power: Add r8a779a0 SYSC power domain definitions
      dt-bindings: clock: Add r8a779a0 CPG Core Clock Definitions
      dt-bindings: clock: renesas,cpg-mssr: Document r8a779a0
      clk: renesas: cpg-mssr: Use enum clk_reg_layout instead of a boolean flag
      clk: renesas: cpg-mssr: Add register pointers into struct cpg_mssr_priv
      clk: renesas: cpg-mssr: Add support for R-Car V3U

YueHaibing (1):
      clk: socfpga: agilex: Remove unused variable 'cntr_mux'

Zhao Qiang (1):
      clk: qoriq: modify MAX_PLL_DIV to 32

Zou Wei (1):
      clk: mediatek: fix platform_no_drv_owner.cocci warnings

 .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |    1 +
 .../bindings/arm/mediatek/mediatek,audsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,imgsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,infracfg.txt    |    1 +
 .../bindings/arm/mediatek/mediatek,mfgcfg.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,topckgen.txt    |    1 +
 .../bindings/arm/mediatek/mediatek,vdecsys.txt     |    1 +
 .../bindings/clock/allwinner,sun4i-a10-ccu.yaml    |    7 +-
 .../bindings/clock/qcom,dispcc-sm8x50.yaml         |   93 ++
 .../bindings/clock/qcom,sc7180-videocc.yaml        |   65 -
 ...{qcom,sdm845-videocc.yaml => qcom,videocc.yaml} |   18 +-
 .../bindings/clock/renesas,cpg-mssr.yaml           |    1 +
 drivers/clk/Kconfig                                |    3 +-
 drivers/clk/at91/at91sam9g45.c                     |    7 -
 drivers/clk/at91/clk-main.c                        |   11 +-
 drivers/clk/at91/clk-peripheral.c                  |    4 +-
 drivers/clk/at91/clk-sam9x60-pll.c                 |    3 +-
 drivers/clk/at91/sam9x60.c                         |    2 +-
 drivers/clk/baikal-t1/clk-ccu-pll.c                |   14 +-
 drivers/clk/bcm/clk-bcm2835.c                      |    4 +-
 drivers/clk/bcm/clk-raspberrypi.c                  |    1 +
 drivers/clk/clk-axi-clkgen.c                       |  187 ++-
 drivers/clk/clk-composite.c                        |    1 +
 drivers/clk/clk-fixed-factor.c                     |    1 +
 drivers/clk/clk-fixed-rate.c                       |    1 +
 drivers/clk/clk-qoriq.c                            |    2 +-
 drivers/clk/clk-s2mps11.c                          |   13 +-
 drivers/clk/clk-si5341.c                           |    4 +-
 drivers/clk/davinci/da8xx-cfgchip.c                |    1 +
 drivers/clk/imx/Kconfig                            |   90 +-
 drivers/clk/imx/Makefile                           |   78 +-
 drivers/clk/imx/clk-busy.c                         |    1 +
 drivers/clk/imx/clk-composite-7ulp.c               |    1 +
 drivers/clk/imx/clk-composite-8m.c                 |    3 +
 drivers/clk/imx/clk-cpu.c                          |    2 +
 drivers/clk/imx/clk-fixup-mux.c                    |    1 +
 drivers/clk/imx/clk-frac-pll.c                     |    2 +
 drivers/clk/imx/clk-gate2.c                        |    4 +-
 drivers/clk/imx/clk-imx21.c                        |  171 ---
 drivers/clk/imx/clk-imx6q.c                        |    1 +
 drivers/clk/imx/clk-imx6sl.c                       |   15 +-
 drivers/clk/imx/clk-imx6sx.c                       |    1 +
 drivers/clk/imx/clk-imx7d.c                        |  132 +-
 drivers/clk/imx/clk-imx8mm.c                       |    4 +
 drivers/clk/imx/clk-imx8mn.c                       |    4 +
 drivers/clk/imx/clk-imx8mp.c                       |   28 +-
 drivers/clk/imx/clk-imx8mq.c                       |    8 +-
 drivers/clk/imx/clk-imx8qxp-lpcg.c                 |    4 +
 drivers/clk/imx/clk-imx8qxp.c                      |    4 +
 drivers/clk/imx/clk-lpcg-scu.c                     |    1 +
 drivers/clk/imx/clk-pfd.c                          |    2 +-
 drivers/clk/imx/clk-pfdv2.c                        |    2 +-
 drivers/clk/imx/clk-pll14xx.c                      |    7 +-
 drivers/clk/imx/clk-pllv1.c                        |    1 +
 drivers/clk/imx/clk-pllv3.c                        |    5 +-
 drivers/clk/imx/clk-pllv4.c                        |    1 +
 drivers/clk/imx/clk-sscg-pll.c                     |    2 +
 drivers/clk/imx/clk-vf610.c                        |    2 +
 drivers/clk/imx/clk.c                              |   18 +-
 drivers/clk/imx/clk.h                              |    7 +
 drivers/clk/ingenic/cgu.c                          |  134 +-
 drivers/clk/keystone/sci-clk.c                     |   19 +-
 drivers/clk/mediatek/Kconfig                       |   48 +
 drivers/clk/mediatek/Makefile                      |    6 +
 drivers/clk/mediatek/clk-mt6765.c                  |    1 -
 drivers/clk/mediatek/clk-mt6779.c                  |    2 +
 drivers/clk/mediatek/clk-mt6797.c                  |    8 +-
 drivers/clk/mediatek/clk-mt7629.c                  |    9 +-
 drivers/clk/mediatek/clk-mt8167-aud.c              |   66 +
 drivers/clk/mediatek/clk-mt8167-img.c              |   60 +
 drivers/clk/mediatek/clk-mt8167-mfgcfg.c           |   58 +
 drivers/clk/mediatek/clk-mt8167-mm.c               |  132 ++
 drivers/clk/mediatek/clk-mt8167-vdec.c             |   73 ++
 drivers/clk/mediatek/clk-mt8167.c                  | 1062 ++++++++++++++++
 drivers/clk/meson/Kconfig                          |   26 +-
 drivers/clk/meson/axg-audio.c                      |  214 +++-
 drivers/clk/meson/clk-phase.c                      |   56 +
 drivers/clk/meson/clk-phase.h                      |    6 +
 drivers/clk/meson/g12a.c                           |   11 +
 drivers/clk/meson/meson-aoclk.c                    |    2 +-
 drivers/clk/mmp/clk-of-mmp2.c                      |    4 +-
 drivers/clk/mmp/clk-of-pxa1928.c                   |    3 +-
 drivers/clk/mvebu/ap-cpu-clk.c                     |    2 +-
 drivers/clk/pxa/clk-pxa.h                          |    8 +-
 drivers/clk/qcom/Kconfig                           |   27 +
 drivers/clk/qcom/Makefile                          |    3 +
 drivers/clk/qcom/clk-alpha-pll.c                   |   10 +-
 drivers/clk/qcom/clk-rcg2.c                        |   19 +-
 drivers/clk/qcom/dispcc-sc7180.c                   |    3 -
 drivers/clk/qcom/dispcc-sm8250.c                   | 1107 +++++++++++++++++
 drivers/clk/qcom/gcc-ipq8074.c                     |    2 +-
 drivers/clk/qcom/gcc-msm8939.c                     |   12 -
 drivers/clk/qcom/gcc-msm8994.c                     |  388 +++++-
 drivers/clk/qcom/gcc-sdm660.c                      |    2 +-
 drivers/clk/qcom/gdsc.c                            |    8 +
 drivers/clk/qcom/videocc-sm8150.c                  |  276 +++++
 drivers/clk/qcom/videocc-sm8250.c                  |  369 ++++++
 drivers/clk/renesas/Kconfig                        |    7 +-
 drivers/clk/renesas/Makefile                       |    1 +
 drivers/clk/renesas/r7s9210-cpg-mssr.c             |    2 +-
 drivers/clk/renesas/r8a7742-cpg-mssr.c             |    3 +-
 drivers/clk/renesas/r8a7743-cpg-mssr.c             |    2 +-
 drivers/clk/renesas/r8a7745-cpg-mssr.c             |    2 +-
 drivers/clk/renesas/r8a77470-cpg-mssr.c            |    2 +-
 drivers/clk/renesas/r8a7790-cpg-mssr.c             |    4 +-
 drivers/clk/renesas/r8a7791-cpg-mssr.c             |    2 +-
 drivers/clk/renesas/r8a7792-cpg-mssr.c             |    2 +-
 drivers/clk/renesas/r8a7794-cpg-mssr.c             |    2 +-
 drivers/clk/renesas/r8a779a0-cpg-mssr.c            |  276 +++++
 drivers/clk/renesas/renesas-cpg-mssr.c             |  136 ++-
 drivers/clk/renesas/renesas-cpg-mssr.h             |   14 +-
 drivers/clk/rockchip/Kconfig                       |   78 ++
 drivers/clk/rockchip/Makefile                      |   42 +-
 drivers/clk/rockchip/clk-ddr.c                     |    1 +
 drivers/clk/rockchip/clk-half-divider.c            |   18 +-
 drivers/clk/rockchip/clk-rk3308.c                  |    1 -
 drivers/clk/rockchip/clk-rk3399.c                  |   56 +
 drivers/clk/rockchip/clk.c                         |  113 +-
 drivers/clk/rockchip/softrst.c                     |    7 +-
 drivers/clk/samsung/clk-cpu.c                      |   37 +-
 drivers/clk/samsung/clk-cpu.h                      |    6 +-
 drivers/clk/samsung/clk-exynos3250.c               |    6 +-
 drivers/clk/samsung/clk-exynos4.c                  |    7 +-
 drivers/clk/samsung/clk-exynos5250.c               |    8 +-
 drivers/clk/samsung/clk-exynos5420.c               |   27 +-
 drivers/clk/samsung/clk-exynos5433.c               |   10 +-
 drivers/clk/sirf/clk-prima2.c                      |    2 +-
 drivers/clk/socfpga/clk-agilex.c                   |   13 -
 drivers/clk/sunxi-ng/Kconfig                       |   10 +
 drivers/clk/sunxi-ng/Makefile                      |    2 +
 drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c           |  214 ++++
 drivers/clk/sunxi-ng/ccu-sun50i-a100-r.h           |   21 +
 drivers/clk/sunxi-ng/ccu-sun50i-a100.c             | 1276 ++++++++++++++++++++
 drivers/clk/sunxi-ng/ccu-sun50i-a100.h             |   56 +
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c               |   37 +-
 drivers/clk/tegra/clk-tegra210-emc.c               |    2 +-
 drivers/clk/ti/autoidle.c                          |   14 +-
 drivers/clk/ti/clk-7xx.c                           |    1 +
 drivers/clk/ti/clockdomain.c                       |    2 +
 drivers/clk/uniphier/clk-uniphier-cpugear.c        |    2 +-
 drivers/clk/uniphier/clk-uniphier-mux.c            |    2 +-
 include/dt-bindings/clock/dra7.h                   |    1 +
 include/dt-bindings/clock/exynos5250.h             |    4 +-
 include/dt-bindings/clock/exynos5420.h             |    6 +
 include/dt-bindings/clock/imx8mp-clock.h           |    2 +-
 include/dt-bindings/clock/mt8167-clk.h             |  131 ++
 include/dt-bindings/clock/qcom,dispcc-sm8150.h     |    1 +
 include/dt-bindings/clock/qcom,dispcc-sm8250.h     |   66 +
 include/dt-bindings/clock/qcom,gcc-msm8994.h       |   36 +
 include/dt-bindings/clock/qcom,videocc-sm8150.h    |   25 +
 include/dt-bindings/clock/qcom,videocc-sm8250.h    |   34 +
 include/dt-bindings/clock/r8a779a0-cpg-mssr.h      |   55 +
 include/dt-bindings/clock/sun50i-a100-ccu.h        |  116 ++
 include/dt-bindings/clock/sun50i-a100-r-ccu.h      |   23 +
 include/dt-bindings/clock/vf610-clock.h            |    3 +-
 include/dt-bindings/power/r8a779a0-sysc.h          |   59 +
 include/dt-bindings/reset/sun50i-a100-ccu.h        |   68 ++
 include/dt-bindings/reset/sun50i-a100-r-ccu.h      |   18 +
 158 files changed, 7582 insertions(+), 880 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7180-videocc.yaml
 rename Documentation/devicetree/bindings/clock/{qcom,sdm845-videocc.yaml => qcom,videocc.yaml} (68%)
 delete mode 100644 drivers/clk/imx/clk-imx21.c
 create mode 100644 drivers/clk/mediatek/clk-mt8167-aud.c
 create mode 100644 drivers/clk/mediatek/clk-mt8167-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt8167-mfgcfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8167-mm.c
 create mode 100644 drivers/clk/mediatek/clk-mt8167-vdec.c
 create mode 100644 drivers/clk/mediatek/clk-mt8167.c
 create mode 100644 drivers/clk/qcom/dispcc-sm8250.c
 create mode 100644 drivers/clk/qcom/videocc-sm8150.c
 create mode 100644 drivers/clk/qcom/videocc-sm8250.c
 create mode 100644 drivers/clk/renesas/r8a779a0-cpg-mssr.c
 create mode 100644 drivers/clk/rockchip/Kconfig
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-a100-r.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-a100-r.h
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-a100.c
 create mode 100644 drivers/clk/sunxi-ng/ccu-sun50i-a100.h
 create mode 100644 include/dt-bindings/clock/mt8167-clk.h
 create mode 120000 include/dt-bindings/clock/qcom,dispcc-sm8150.h
 create mode 100644 include/dt-bindings/clock/qcom,dispcc-sm8250.h
 create mode 100644 include/dt-bindings/clock/qcom,videocc-sm8150.h
 create mode 100644 include/dt-bindings/clock/qcom,videocc-sm8250.h
 create mode 100644 include/dt-bindings/clock/r8a779a0-cpg-mssr.h
 create mode 100644 include/dt-bindings/clock/sun50i-a100-ccu.h
 create mode 100644 include/dt-bindings/clock/sun50i-a100-r-ccu.h
 create mode 100644 include/dt-bindings/power/r8a779a0-sysc.h
 create mode 100644 include/dt-bindings/reset/sun50i-a100-ccu.h
 create mode 100644 include/dt-bindings/reset/sun50i-a100-r-ccu.h

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
