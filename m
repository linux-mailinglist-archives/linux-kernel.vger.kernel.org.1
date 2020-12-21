Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80262DF78A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 02:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgLUBw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 20:52:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:44536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbgLUBw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 20:52:56 -0500
From:   Stephen Boyd <sboyd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk changes for the merge window
Date:   Sun, 20 Dec 2020 17:52:14 -0800
Message-Id: <20201221015214.3466681-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit cd3caa573ebd1f32727962cf7dead43f5144d080:

  dt-bindings: clk: axg-clkc: add MIPI DSI Host clock binding (2020-11-23 09:06:34 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to abe7e32f1d50392fbfb6391f4fe1a9f1348b24f3:

  Merge branches 'clk-ingenic', 'clk-vc5', 'clk-cleanup', 'clk-canaan' and 'clk-marvell' into clk-next (2020-12-20 17:18:05 -0800)

----------------------------------------------------------------
The core framework got some nice improvements this time around. We gained the
ability to get struct clk pointers from a struct clk_hw so that clk providers
can consume the clks they provide, if they need to do something like that. This
has been a long missing part of the clk provider API that will help us move
away from exposing a struct clk pointer in the struct clk_hw. Tracepoints are
added for the clk_set_rate() "range" functions, similar to the tracepoints we
already have for clk_set_rate() and we added a column to debugfs to help
developers understand the hardware enable state of clks in case firmware or
bootloader state is different than what is expected. Overall the core changes
are mostly improving the clk driver writing experience.

At the driver level, we have the usual collection of driver updates and new
drivers for new SoCs. This time around the Qualcomm folks introduced a good
handful of clk drivers for various parts of three or four SoCs. The SiFive
folks added a new clk driver for their FU740 SoCs, coming in second on the
diffstat and then Atmel AT91 and Amlogic SoCs had lots of work done after that
for various new features. One last thing to note in the driver area is that the
i.MX driver has gained a new binding to support SCU clks after being on the
list for many months. It uses a two cell binding which is sort of rare in clk
DT bindings. Beyond that we have the usual set of driver fixes and tweaks that
come from more testing and finding out that some configuration was wrong or
that a driver could support being built as a module.

Core:
 - Add some trace points for clk_set_rate() "range" functions
 - Add hardware enable information to clk_summary debugfs
 - Replace clk-provider.h with of_clk.h when possible
 - Add devm variant of clk_notifier_register()
 - Add clk_hw_get_clk() to generate a struct clk from a struct clk_hw

New Drivers:
 - Bindings for Canaan K210 SoC clks
 - Support for SiFive FU740 PRCI
 - Camera clks on Qualcomm SC7180 SoCs
 - GCC and RPMh clks on Qualcomm SDX55 SoCs
 - RPMh clks on Qualcomm SM8350 SoCs
 - LPASS clks on Qualcomm SM8250 SoCs

Updates:
 - DVFS support for AT91 clk driver
 - Update git repo branch for Renesas clock drivers
 - Add camera (CSI) and video-in (VIN) clocks on Renesas R-Car V3U
 - Add RPC (QSPI/HyperFLASH) clocks on Renesas RZ/G2M, RZ/G2N, and RZ/G2E
 - Stop using __raw_*() I/O accessors in Renesas clk drivers
 - One more conversion of DT bindings to json-schema
 - Make i.MX clk-gate2 driver more flexible
 - New two cell binding for i.MX SCU clks
 - Drop of_match_ptr() in i.MX8 clk drivers
 - Add arch dependencies for Rockchip clk drivers
 - Fix i2s on Rockchip rk3066
 - Add MIPI DSI clks on Amlogic axg and g12 SoCs
 - Support modular builds of Amlogic clk drivers
 - Fix an Amlogic Video PLL clock dependency
 - Samsung Kconfig dependencies updates for better compile test coverage
 - Refactoring of the Samsung PLL clocks driver
 - Small Tegra driver cleanups
 - Minor fixes to Ingenic and VC5 clk drivers
 - Cleanup patches to remove unused variables and plug memory leaks

----------------------------------------------------------------
Abel Vesa (5):
      clk: imx: gate2: Remove the IMX_CLK_GATE2_SINGLE_BIT special case
      clk: imx: gate2: Keep the register writing in on place
      clk: imx: gate2: Check if clock is enabled against cgr_val
      clk: imx: gate2: Add cgr_mask for more flexible number of control bits
      clk: imx: gate2: Add locking in is_enabled op

Alexandre Belloni (1):
      clk: at91: sam9x60: remove atmel,osc-bypass support

Alexandru Ardelean (3):
      dt-bindings: clock: adi,axi-clkgen: convert old binding to yaml format
      clk: axi-clkgen: wrap limits in a struct and keep copy on the state object
      clk: axi-clkgen: move the OF table at the bottom of the file

Biju Das (2):
      clk: renesas: r8a774a1: Add RPC clocks
      clk: renesas: r8a774b1: Add RPC clocks

Christophe JAILLET (1):
      clk: s2mps11: Fix a resource leak in error handling paths in the probe function

Claudiu Beznea (7):
      clk: at91: sama7g5: fix compilation error
      clk: at91: clk-sam9x60-pll: allow runtime changes for pll
      clk: at91: sama7g5: remove mck0 from parent list of other clocks
      clk: at91: sama7g5: decrease lower limit for MCK0 rate
      clk: at91: sama7g5: do not allow cpu pll to go higher than 1GHz
      clk: at91: clk-master: re-factor master clock
      clk: at91: sama7g5: register cpu clock

Colin Ian King (2):
      clk: imx: remove redundant assignment to pointer np
      clk: qcom: Kconfig: Fix spelling mistake "dyanmic" -> "dynamic"

Damien Le Moal (2):
      dt-bindings: Add Canaan vendor prefix
      dt-binding: clock: Document canaan,k210-clk bindings

Dan Carpenter (1):
      clk: qcom: lpass-sc7180: Clean up on error in lpass_sc7180_init()

David Shah (1):
      clk: ti: omap5: Fix reboot DPLL lock failure when using ABE TIMERs

Dmitry Baryshkov (1):
      clk: qcom: dispcc-sm8250: handle MMCX power domain

Dmitry Osipenko (2):
      clk: tegra: Fix duplicated SE clock entry
      clk: Add hardware-enable column to clk summary

Dong Aisheng (11):
      clk: imx: scu: add two cells binding support
      clk: imx: scu: bypass cpu power domains
      clk: imx: scu: allow scu clk to take device pointer
      clk: imx: scu: add runtime pm support
      clk: imx: scu: add suspend/resume support
      clk: imx: imx8qxp-lpcg: add parsing clocks from device tree
      clk: imx: lpcg: allow lpcg clk to take device pointer
      clk: imx: clk-imx8qxp-lpcg: add runtime pm support
      clk: imx: lpcg: add suspend/resume support
      clk: imx: scu: fix build break when compiled as modules
      clk: imx: scu: remove the calling of device_is_bound

Douglas Anderson (4):
      clk: qcom: lpasscc-sc7810: Use devm in probe
      clk: qcom: lpass-sc7180: Disentangle the two clock devices
      clk: qcom: gcc-sc7180: Use floor ops for sdcc clks
      clk: qcom: gcc-sc7180: Add 50 MHz clock rate for SDC2

Eugen Hristev (4):
      dt-bindings: clock: at91: add sama7g5 pll defines
      clk: at91: sama7g5: allow SYS and CPU PLLs to be exported and referenced in DT
      clk: at91: clk-master: add 5th divisor for mck master
      clk: at91: sama7g5: add 5th divisor for mck0 layout and characteristics

Geert Uytterhoeven (8):
      sh: boards: Replace <linux/clk-provider.h> by <linux/of_clk.h>
      xtensa: Replace <linux/clk-provider.h> by <linux/of_clk.h>
      clk: qoriq: Add platform dependencies
      clk: renesas: r8a779a0: Make rcar_r8a779a0_cpg_clk_register() static
      MAINTAINERS: Update git repo for Renesas clock drivers
      clk: renesas: r8a779a0: Fix R and OSC clocks
      clk: renesas: sh73a0: Stop using __raw_*() I/O accessors
      clk: vc5: Use "idt,voltage-microvolt" instead of "idt,voltage-microvolts"

Jacopo Mondi (2):
      clk: renesas: r8a779a0: Add CSI4[0-3] clocks
      clk: renesas: r8a779a0: Add VIN clocks

Jernej Skrabec (1):
      clk: sunxi-ng: Make sure divider tables have sentinel

Jerome Brunet (7):
      clk: avoid devm_clk_release name clash
      clk: add api to get clk consumer from clk_hw
      clk: meson: g12: drop use of __clk_lookup()
      clk: add devm variant of clk_notifier_register
      clk: meson: g12: use devm variant to register notifiers
      Merge branch 'v5.11/headers' into integ
      Merge branch 'v5.11/headers' into v5.11/drivers

Johan Jonker (2):
      clk: rockchip: add CLK_SET_RATE_PARENT to sclk for rk3066a i2s and uart clocks
      clk: rockchip: fix i2s gate bits on rk3066 and rk3188

Kevin Hilman (2):
      clk: meson: Kconfig: fix dependency for G12A
      clk: meson: enable building as modules

Krzysztof Kozlowski (8):
      clk: imx8mm: drop of_match_ptr from of_device_id table
      clk: imx8mn: drop of_match_ptr from of_device_id table
      clk: imx8mp: drop of_match_ptr from of_device_id table
      clk: imx8mq: drop of_match_ptr from of_device_id table
      clk: samsung: Allow compile testing of Exynos, S3C64xx and S5Pv210
      clk: renesas: cpg-mssr: fix kerneldoc of cpg_mssr_priv
      clk: pwm: drop of_match_ptr from of_device_id table
      clk: scpi: mark scpi_clk_match as maybe unused

Lad Prabhakar (1):
      clk: renesas: r8a774c0: Add RPC clocks

Lukas Bulwahn (1):
      clk: remove unneeded dead-store initialization

Manivannan Sadhasivam (3):
      clk: qcom: Add support for SDX55 RPMh clocks
      dt-bindings: clock: Add GDSC in SDX55 GCC
      clk: qcom: Add GDSC support for SDX55 GCC

Mauro Carvalho Chehab (1):
      clk: fix a kernel-doc markup

Maxime Ripard (1):
      clk: Trace clk_set_rate() "range" functions

Michael Walle (7):
      clk: fsl-sai: fix memory leak
      clk: composite: add devm_clk_hw_register_composite_pdata()
      clk: fsl-sai: use devm_clk_hw_register_composite_pdata()
      clk: qoriq: provide constants for the type
      clk: divider: add devm_clk_hw_register_divider_table()
      dt-bindings: clock: document the fsl-flexspi-clk device
      clk: fsl-flexspi: new driver

Naveen Yadav (1):
      clk: qcom: Add SDX55 GCC support

Neil Armstrong (4):
      clk: meson: axg: add Video Clocks
      clk: meson: axg: add MIPI DSI Host clock
      dt-bindings: clk: g12a-clkc: add DSI Pixel clock bindings
      clk: meson: g12a: add MIPI DSI Host Pixel Clock

Nicolas Saenz Julienne (1):
      clk: bcm: dvp: Add MODULE_DEVICE_TABLE()

Nicolin Chen (1):
      clk: tegra: Do not return 0 on failure

Paul Cercueil (1):
      clk: ingenic: Fix divider calculation with div tables

Pragnesh Patel (1):
      clk: sifive: Add clock enable and disable ops

Robin Murphy (1):
      clk: rockchip: Add appropriate arch dependencies

Sascha Hauer (1):
      clk: si5351: Wait for bit clear after PLL reset

Sivaram Nair (1):
      clk: tegra: bpmp: Clamp clock rates on requests

Srinivas Kandagatla (4):
      dt-bindings: clock: Add support for LPASS Audio Clock Controller
      dt-bindings: clock: Add support for LPASS Always ON Controller
      clk: qcom: Add support to LPASS AUDIO_CC Glitch Free Mux clocks
      clk: qcom: Add support to LPASS AON_CC Glitch Free Mux clocks

Stephen Boyd (12):
      clk: qcom: camcc-sc7180: Use runtime PM ops instead of clk ones
      Merge tag 'for-5.11-clk' of git://git.kernel.org/.../tegra/linux into clk-tegra
      Merge tag 'clk-v5.11-samsung' of https://git.kernel.org/.../snawrocki/clk into clk-samsung
      Merge tag 'clk-meson-v5.11-1' of https://github.com/BayLibre/clk-meson into clk-amlogic
      Merge tag 'v5.11-rockchip-clk-1' of git://git.kernel.org/.../mmind/linux-rockchip into clk-rockchip
      Merge tag 'clk-imx-5.11' of git://git.kernel.org/.../shawnguo/linux into clk-imx
      Merge tag 'renesas-clk-for-v5.11-tag3' of git://git.kernel.org/.../geert/renesas-drivers into clk-renesas
      Merge branches 'clk-doc', 'clk-qcom', 'clk-simplify', 'clk-hw', 'clk-renesas' and 'clk-samsung' into clk-next
      Merge branches 'clk-amlogic', 'clk-rockchip', 'clk-of', 'clk-freescale' and 'clk-unused' into clk-next
      Merge branches 'clk-tegra', 'clk-imx', 'clk-sifive', 'clk-mediatek' and 'clk-summary' into clk-next
      Merge branches 'clk-ti', 'clk-analog', 'clk-trace', 'clk-at91' and 'clk-silabs' into clk-next
      Merge branches 'clk-ingenic', 'clk-vc5', 'clk-cleanup', 'clk-canaan' and 'clk-marvell' into clk-next

Sylwester Nawrocki (1):
      clk: samsung: Prevent potential endless loop in the PLL ops

Taniya Das (5):
      clk: qcom: clk-alpha-pll: Add support for helper functions
      clk: qcom: clk-alpha-pll: Add support for controlling Agera PLLs
      dt-bindings: clock: Add YAML schemas for the QCOM Camera clock bindings.
      clk: qcom: camcc: Add camera clock controller driver for SC7180
      clk: qcom: lpasscc: Introduce pm autosuspend for SC7180

Terry Zhou (1):
      clk: mvebu: a3700: fix the XTAL MODE pin to MPP1_9

Thara Gopinath (2):
      dt-bindings: clock: Add entry for crypto engine RPMH clock resource
      clk: qcom: rpmh: Add CE clock on sdm845.

Tom Rix (1):
      clk: imx: remove unneeded semicolon

Uwe Kleine-König (1):
      clk: bcm: dvp: drop a variable that is assigned to only

Vinod Koul (4):
      dt-bindings: clock: Add SDX55 GCC clock bindings
      dt-bindings: clock: Introduce RPMHCC bindings for SDX55
      dt-bindings: clock: Add RPMHCC bindings for SM8350
      clk: qcom: rpmh: add support for SM8350 rpmh clocks

Weiyi Lu (1):
      clk: mediatek: Make mtk_clk_register_mux() a static function

Wolfram Sang (1):
      clk: renesas: rcar-gen3: Remove stp_ck handling for SDHI

Xu Wang (1):
      clk: rockchip: Remove redundant null check before clk_prepare_enable

Yejune Deng (1):
      clk: renesas: rcar-usb2-clock-sel: Replace devm_reset_control_array_get()

Yoshihiro Shimoda (1):
      dt-bindings: clock: renesas: rcar-usb2-clock-sel: Convert bindings to json-schema

Zhang Qilong (1):
      clk: ti: Fix memleak in ti_fapll_synth_setup

Zong Li (5):
      dt-bindings: fu740: prci: add YAML documentation for the FU740 PRCI
      clk: sifive: Extract prci core to common base
      clk: sifive: Use common name for prci configuration
      clk: sifive: Add a driver for the SiFive FU740 PRCI IP block
      clk: sifive: Fix the wrong bit field shift

Zou Wei (2):
      clk: imx: gate2: Remove unused variable ret
      clk: imx: scu: Make pd_np with static keyword

 .../devicetree/bindings/clock/adi,axi-clkgen.yaml  |   53 +
 .../devicetree/bindings/clock/axi-clkgen.txt       |   25 -
 .../devicetree/bindings/clock/canaan,k210-clk.yaml |   54 +
 .../bindings/clock/fsl,flexspi-clock.yaml          |   55 +
 .../bindings/clock/qcom,aoncc-sm8250.yaml          |   58 +
 .../bindings/clock/qcom,audiocc-sm8250.yaml        |   58 +
 .../devicetree/bindings/clock/qcom,gcc-sdx55.yaml  |   77 +
 .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |    2 +
 .../bindings/clock/qcom,sc7180-camcc.yaml          |   73 +
 .../bindings/clock/renesas,rcar-usb2-clock-sel.txt |   68 -
 .../clock/renesas,rcar-usb2-clock-sel.yaml         |  100 ++
 .../bindings/clock/sifive/fu740-prci.yaml          |   60 +
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 MAINTAINERS                                        |    2 +-
 arch/riscv/Kconfig.socs                            |    2 +-
 arch/sh/boards/of-generic.c                        |    2 +-
 arch/xtensa/kernel/time.c                          |    2 +-
 drivers/clk/Kconfig                                |   11 +-
 drivers/clk/Makefile                               |    1 +
 drivers/clk/at91/at91rm9200.c                      |   21 +-
 drivers/clk/at91/at91sam9260.c                     |   26 +-
 drivers/clk/at91/at91sam9g45.c                     |   32 +-
 drivers/clk/at91/at91sam9n12.c                     |   36 +-
 drivers/clk/at91/at91sam9rl.c                      |   23 +-
 drivers/clk/at91/at91sam9x5.c                      |   28 +-
 drivers/clk/at91/clk-master.c                      |  337 +++-
 drivers/clk/at91/clk-sam9x60-pll.c                 |  145 +-
 drivers/clk/at91/dt-compat.c                       |   15 +-
 drivers/clk/at91/pmc.h                             |   22 +-
 drivers/clk/at91/sam9x60.c                         |   51 +-
 drivers/clk/at91/sama5d2.c                         |   42 +-
 drivers/clk/at91/sama5d3.c                         |   38 +-
 drivers/clk/at91/sama5d4.c                         |   40 +-
 drivers/clk/at91/sama7g5.c                         |  223 ++-
 drivers/clk/bcm/clk-bcm2711-dvp.c                  |    4 +-
 drivers/clk/clk-axi-clkgen.c                       |   64 +-
 drivers/clk/clk-composite.c                        |   50 +
 drivers/clk/clk-divider.c                          |   34 +
 drivers/clk/clk-fsl-flexspi.c                      |  106 ++
 drivers/clk/clk-fsl-sai.c                          |   14 +-
 drivers/clk/clk-pwm.c                              |    2 +-
 drivers/clk/clk-qoriq.c                            |   13 +-
 drivers/clk/clk-s2mps11.c                          |    1 +
 drivers/clk/clk-scpi.c                             |    2 +-
 drivers/clk/clk-si5351.c                           |   13 +-
 drivers/clk/clk-versaclock5.c                      |    4 +-
 drivers/clk/clk.c                                  |  132 +-
 drivers/clk/imx/clk-gate2.c                        |   68 +-
 drivers/clk/imx/clk-imx8mm.c                       |    2 +-
 drivers/clk/imx/clk-imx8mn.c                       |    2 +-
 drivers/clk/imx/clk-imx8mp.c                       |    4 +-
 drivers/clk/imx/clk-imx8mq.c                       |    2 +-
 drivers/clk/imx/clk-imx8qxp-lpcg.c                 |  139 ++
 drivers/clk/imx/clk-imx8qxp.c                      |  136 +-
 drivers/clk/imx/clk-lpcg-scu.c                     |   53 +-
 drivers/clk/imx/clk-pll14xx.c                      |    2 +-
 drivers/clk/imx/clk-scu.c                          |  227 ++-
 drivers/clk/imx/clk-scu.h                          |   56 +-
 drivers/clk/imx/clk.h                              |   27 +-
 drivers/clk/ingenic/cgu.c                          |   14 +-
 drivers/clk/mediatek/clk-mux.c                     |    2 +-
 drivers/clk/mediatek/clk-mux.h                     |    4 -
 drivers/clk/meson/Kconfig                          |    7 +-
 drivers/clk/meson/axg-aoclk.c                      |    5 +-
 drivers/clk/meson/axg.c                            |  824 +++++++++-
 drivers/clk/meson/axg.h                            |   23 +-
 drivers/clk/meson/g12a-aoclk.c                     |    5 +-
 drivers/clk/meson/g12a.c                           |  181 +-
 drivers/clk/meson/g12a.h                           |    3 +-
 drivers/clk/meson/gxbb-aoclk.c                     |    5 +-
 drivers/clk/meson/gxbb.c                           |    5 +-
 drivers/clk/meson/meson-aoclk.c                    |    4 +
 drivers/clk/meson/meson-eeclk.c                    |    3 +
 drivers/clk/mvebu/armada-37xx-xtal.c               |    4 +-
 drivers/clk/qcom/Kconfig                           |   25 +-
 drivers/clk/qcom/Makefile                          |    3 +
 drivers/clk/qcom/camcc-sc7180.c                    | 1732 ++++++++++++++++++++
 drivers/clk/qcom/clk-alpha-pll.c                   |  217 ++-
 drivers/clk/qcom/clk-alpha-pll.h                   |    4 +
 drivers/clk/qcom/clk-rpmh.c                        |   56 +
 drivers/clk/qcom/dispcc-sm8250.c                   |    1 +
 drivers/clk/qcom/gcc-sc7180.c                      |    5 +-
 drivers/clk/qcom/gcc-sdx55.c                       | 1659 +++++++++++++++++++
 drivers/clk/qcom/lpass-gfm-sm8250.c                |  320 ++++
 drivers/clk/qcom/lpasscorecc-sc7180.c              |  135 +-
 drivers/clk/renesas/clk-sh73a0.c                   |    2 +-
 drivers/clk/renesas/r8a774a1-cpg-mssr.c            |    8 +
 drivers/clk/renesas/r8a774b1-cpg-mssr.c            |    8 +
 drivers/clk/renesas/r8a774c0-cpg-mssr.c            |    9 +
 drivers/clk/renesas/r8a779a0-cpg-mssr.c            |   51 +-
 drivers/clk/renesas/rcar-gen3-cpg.c                |   79 +-
 drivers/clk/renesas/rcar-gen3-cpg.h                |    5 +
 drivers/clk/renesas/rcar-usb2-clock-sel.c          |    2 +-
 drivers/clk/renesas/renesas-cpg-mssr.c             |    3 +-
 drivers/clk/rockchip/Kconfig                       |   12 +-
 drivers/clk/rockchip/clk-rk3188.c                  |   35 +-
 drivers/clk/rockchip/clk.c                         |    3 +-
 drivers/clk/samsung/Kconfig                        |   67 +-
 drivers/clk/samsung/Makefile                       |   22 +-
 drivers/clk/samsung/clk-pll.c                      |  147 +-
 drivers/clk/sifive/Kconfig                         |    8 +-
 drivers/clk/sifive/Makefile                        |    2 +-
 drivers/clk/sifive/fu540-prci.c                    |  599 +------
 drivers/clk/sifive/fu540-prci.h                    |   21 +
 drivers/clk/sifive/fu740-prci.c                    |  123 ++
 drivers/clk/sifive/fu740-prci.h                    |   21 +
 drivers/clk/sifive/sifive-prci.c                   |  574 +++++++
 drivers/clk/sifive/sifive-prci.h                   |  299 ++++
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c              |    1 +
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c                |    1 +
 drivers/clk/tegra/clk-bpmp.c                       |    6 +-
 drivers/clk/tegra/clk-dfll.c                       |    4 +-
 drivers/clk/tegra/clk-id.h                         |    1 +
 drivers/clk/tegra/clk-tegra-periph.c               |    2 +-
 drivers/clk/ti/clk-54xx.c                          |   12 +-
 drivers/clk/ti/fapll.c                             |   11 +-
 include/dt-bindings/clock/at91.h                   |   11 +
 include/dt-bindings/clock/fsl,qoriq-clockgen.h     |   15 +
 include/dt-bindings/clock/g12a-clkc.h              |    2 +
 include/dt-bindings/clock/k210-clk.h               |   56 +-
 include/dt-bindings/clock/qcom,camcc-sc7180.h      |  121 ++
 include/dt-bindings/clock/qcom,gcc-sdx55.h         |  117 ++
 include/dt-bindings/clock/qcom,rpmh.h              |   10 +
 .../dt-bindings/clock/qcom,sm8250-lpass-aoncc.h    |   11 +
 .../dt-bindings/clock/qcom,sm8250-lpass-audiocc.h  |   13 +
 include/dt-bindings/clock/sifive-fu740-prci.h      |   23 +
 include/linux/clk-provider.h                       |   39 +
 include/linux/clk.h                                |   20 +-
 include/linux/clk/samsung.h                        |    4 +-
 include/trace/events/clk.h                         |   44 +
 130 files changed, 9320 insertions(+), 1491 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/axi-clkgen.txt
 create mode 100644 Documentation/devicetree/bindings/clock/canaan,k210-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,flexspi-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,aoncc-sm8250.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,audiocc-sm8250.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sdx55.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc7180-camcc.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/renesas,rcar-usb2-clock-sel.txt
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,rcar-usb2-clock-sel.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/sifive/fu740-prci.yaml
 create mode 100644 drivers/clk/clk-fsl-flexspi.c
 create mode 100644 drivers/clk/qcom/camcc-sc7180.c
 create mode 100644 drivers/clk/qcom/gcc-sdx55.c
 create mode 100644 drivers/clk/qcom/lpass-gfm-sm8250.c
 create mode 100644 drivers/clk/sifive/fu540-prci.h
 create mode 100644 drivers/clk/sifive/fu740-prci.c
 create mode 100644 drivers/clk/sifive/fu740-prci.h
 create mode 100644 drivers/clk/sifive/sifive-prci.c
 create mode 100644 drivers/clk/sifive/sifive-prci.h
 create mode 100644 include/dt-bindings/clock/fsl,qoriq-clockgen.h
 create mode 100644 include/dt-bindings/clock/qcom,camcc-sc7180.h
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sdx55.h
 create mode 100644 include/dt-bindings/clock/qcom,sm8250-lpass-aoncc.h
 create mode 100644 include/dt-bindings/clock/qcom,sm8250-lpass-audiocc.h
 create mode 100644 include/dt-bindings/clock/sifive-fu740-prci.h

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
