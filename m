Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755E32B87E6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 23:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgKRWoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 17:44:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:23485 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgKRWoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 17:44:18 -0500
IronPort-SDR: h3j80STffSgvm6TwauGFIqOpMhyGDXAGww+ltM9IkBvae5379qwJ8uUxxcsFECEZ6bi8rk/LkF
 +X+0o1NxnC6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="170415371"
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="gz'50?scan'50,208,50";a="170415371"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 14:44:15 -0800
IronPort-SDR: JNMHGSaBz4eMN575R6do6fzdcN3YlLQPeM1DplWsTJwgxeX1410ihvBXc2KXXY7Vt1cb2BG2CD
 dRrecLGpH95Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="gz'50?scan'50,208,50";a="359692084"
Received: from lkp-server02.sh.intel.com (HELO 67996b229c47) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 18 Nov 2020 14:44:13 -0800
Received: from kbuild by 67996b229c47 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kfWBQ-0000Gx-QB; Wed, 18 Nov 2020 22:44:12 +0000
Date:   Thu, 19 Nov 2020 06:44:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: s390-linux-ld: ll_temac_main.c:undefined reference to `devm_ioremap'
Message-ID: <202011190658.kxLhIx6l-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c2e7554e1b85935d962127efa3c2a76483b0b3b6
commit: 4bdc0d676a643140bdf17dbf7eafedee3d496a3c remove ioremap_nocache and devm_ioremap_nocache
date:   11 months ago
config: s390-randconfig-r023-20201119 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4bdc0d676a643140bdf17dbf7eafedee3d496a3c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4bdc0d676a643140bdf17dbf7eafedee3d496a3c
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/irqchip/irq-imx-irqsteer.o: in function `imx_irqsteer_probe':
   irq-imx-irqsteer.c:(.text+0x1d2): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/phy/hisilicon/phy-histb-combphy.o: in function `histb_combphy_probe':
   phy-histb-combphy.c:(.text+0x62): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/phy/hisilicon/phy-hisi-inno-usb2.o: in function `hisi_inno_phy_probe':
   phy-hisi-inno-usb2.c:(.text+0x42): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/phy/marvell/phy-mmp3-usb.o: in function `mmp3_usb_phy_probe':
   phy-mmp3-usb.c:(.text+0x40e): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/pwm/pwm-hibvt.o: in function `hibvt_pwm_probe':
   pwm-hibvt.c:(.text+0x36e): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/pwm/pwm-mediatek.o: in function `pwm_mediatek_probe':
   pwm-mediatek.c:(.text+0x39e): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/char/ipmi/bt-bmc.o: in function `bt_bmc_probe':
   bt-bmc.c:(.text+0xfd8): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/soc/amlogic/meson-canvas.o: in function `meson_canvas_probe':
   meson-canvas.c:(.text+0x54): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/soc/amlogic/meson-clk-measure.o: in function `meson_msr_probe':
   meson-clk-measure.c:(.text+0x138): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/soc/qcom/qcom-geni-se.o: in function `geni_se_probe':
   qcom-geni-se.c:(.text+0x70): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/soc/qcom/qcom_gsbi.o: in function `gsbi_probe':
   qcom_gsbi.c:(.text+0x7c): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/soc/qcom/llcc-qcom.o: in function `qcom_llcc_init_mmio':
   llcc-qcom.c:(.text+0x316): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/regulator/stm32-vrefbuf.o: in function `stm32_vrefbuf_probe':
   stm32-vrefbuf.c:(.text+0x6a0): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/reset/reset-ath79.o: in function `ath79_reset_probe':
   reset-ath79.c:(.text+0x11c): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/reset/reset-brcmstb.o: in function `brcmstb_reset_probe':
   reset-brcmstb.c:(.text+0x2c8): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/reset/reset-meson.o: in function `meson_reset_probe':
   reset-meson.c:(.text+0x54): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/reset/reset-stm32mp1.o: in function `stm32_reset_probe':
   reset-stm32mp1.c:(.text+0x280): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/exynos-trng.o: in function `exynos_trng_probe':
   exynos-trng.c:(.text+0x578): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/meson-rng.o: in function `meson_rng_probe':
   meson-rng.c:(.text+0x14a): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/mtk-rng.o: in function `mtk_rng_probe':
   mtk-rng.c:(.text+0x652): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/mfd/syscon.o: in function `syscon_probe':
   syscon.c:(.text+0x174): undefined reference to `devm_ioremap'
   s390-linux-ld: drivers/net/ethernet/altera/altera_tse_main.o: in function `request_and_map':
   altera_tse_main.c:(.text+0x312): undefined reference to `devm_ioremap'
   s390-linux-ld: drivers/net/ethernet/freescale/fec_main.o: in function `fec_probe':
   fec_main.c:(.text+0xe780): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/net/ethernet/freescale/fsl_pq_mdio.o: in function `fsl_pq_mdio_remove':
   fsl_pq_mdio.c:(.text+0x9a): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/freescale/gianfar.o: in function `gfar_remove':
   gianfar.c:(.text+0x1edc): undefined reference to `iounmap'
   s390-linux-ld: gianfar.c:(.text+0x1f0c): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/freescale/fman/fman_muram.o: in function `fman_muram_init':
   fman_muram.c:(.text+0xb0): undefined reference to `ioremap'
   s390-linux-ld: fman_muram.c:(.text+0x1cc): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/nxp/lpc_eth.o: in function `lpc_eth_drv_remove':
   lpc_eth.c:(.text+0x7c2): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/nxp/lpc_eth.o: in function `lpc_eth_drv_probe':
   lpc_eth.c:(.text+0x1be2): undefined reference to `ioremap'
   s390-linux-ld: lpc_eth.c:(.text+0x1dce): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/ethernet/xilinx/ll_temac_main.o: in function `temac_probe':
   ll_temac_main.c:(.text+0x453c): undefined reference to `devm_ioremap'
>> s390-linux-ld: ll_temac_main.c:(.text+0x4736): undefined reference to `devm_ioremap'
   s390-linux-ld: ll_temac_main.c:(.text+0x50ca): undefined reference to `devm_ioremap'
   s390-linux-ld: drivers/input/serio/olpc_apsp.o: in function `olpc_apsp_probe':
   olpc_apsp.c:(.text+0xa72): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/input/serio/sun4i-ps2.o: in function `sun4i_ps2_remove':
   sun4i-ps2.c:(.text+0xc4): undefined reference to `iounmap'
   s390-linux-ld: drivers/input/serio/sun4i-ps2.o: in function `sun4i_ps2_probe':
   sun4i-ps2.c:(.text+0xd02): undefined reference to `ioremap'
   s390-linux-ld: sun4i-ps2.c:(.text+0x121e): undefined reference to `iounmap'
   s390-linux-ld: drivers/input/keyboard/ep93xx_keypad.o: in function `ep93xx_keypad_remove':
   ep93xx_keypad.c:(.text+0x156): undefined reference to `iounmap'
   s390-linux-ld: drivers/input/keyboard/ep93xx_keypad.o: in function `ep93xx_keypad_probe':
   ep93xx_keypad.c:(.text+0xbe0): undefined reference to `ioremap'
   s390-linux-ld: ep93xx_keypad.c:(.text+0xf38): undefined reference to `iounmap'
   s390-linux-ld: drivers/input/keyboard/goldfish_events.o: in function `events_probe':
   goldfish_events.c:(.text+0x3b4): undefined reference to `devm_ioremap'
   s390-linux-ld: drivers/input/keyboard/sh_keysc.o: in function `sh_keysc_remove':
   sh_keysc.c:(.text+0xec): undefined reference to `iounmap'
   s390-linux-ld: drivers/input/keyboard/sh_keysc.o: in function `sh_keysc_probe':
   sh_keysc.c:(.text+0x4b0): undefined reference to `ioremap'
   s390-linux-ld: sh_keysc.c:(.text+0xd3c): undefined reference to `iounmap'
   s390-linux-ld: drivers/input/keyboard/st-keyscan.o: in function `keyscan_probe':
   st-keyscan.c:(.text+0x854): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/media/rc/ir-hix5hd2.o: in function `hix5hd2_ir_probe':
   ir-hix5hd2.c:(.text+0x7aa): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/media/rc/meson-ir.o: in function `meson_ir_probe':
   meson-ir.c:(.text+0x2a2): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/media/rc/img-ir/img-ir-core.o: in function `img_ir_probe':
   img-ir-core.c:(.text+0x394): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/media/rc/mtk-cir.o: in function `mtk_ir_probe':
   mtk-cir.c:(.text+0x8d4): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/media/rc/zx-irdec.o:zx-irdec.c:(.text+0x412): more undefined references to `devm_ioremap_resource' follow
   s390-linux-ld: drivers/watchdog/armada_37xx_wdt.o: in function `armada_37xx_wdt_probe':
   armada_37xx_wdt.c:(.text+0xbc2): undefined reference to `devm_ioremap'
   s390-linux-ld: drivers/watchdog/at91sam9_wdt.o: in function `at91wdt_probe':
   at91sam9_wdt.c:(.init.text+0x278): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/watchdog/omap_wdt.o: in function `omap_wdt_probe':
   omap_wdt.c:(.text+0x1cd8): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/watchdog/sama5d4_wdt.o: in function `sama5d4_wdt_probe':
   sama5d4_wdt.c:(.text+0x642): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/watchdog/npcm_wdt.o: in function `npcm_wdt_probe':
   npcm_wdt.c:(.text+0x782): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/watchdog/ts72xx_wdt.o: in function `ts72xx_wdt_probe':
   ts72xx_wdt.c:(.text+0x38a): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/watchdog/ts72xx_wdt.o:ts72xx_wdt.c:(.text+0x3c4): more undefined references to `devm_platform_ioremap_resource' follow
   s390-linux-ld: drivers/watchdog/sc520_wdt.o: in function `sc520_wdt_init':
   sc520_wdt.c:(.init.text+0x52): undefined reference to `ioremap'
   s390-linux-ld: sc520_wdt.c:(.init.text+0x102): undefined reference to `iounmap'
   s390-linux-ld: drivers/watchdog/sc520_wdt.o: in function `sc520_wdt_unload':
   sc520_wdt.c:(.exit.text+0x50): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_init':
   timer-of.c:(.init.text+0x260): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_cleanup':
   timer-of.c:(.init.text+0x3e0): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-davinci.o: in function `davinci_timer_register':
   timer-davinci.c:(.init.text+0x100): undefined reference to `ioremap'
   s390-linux-ld: drivers/mailbox/imx-mailbox.o: in function `imx_mu_probe':
   imx-mailbox.c:(.text+0x66): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/mailbox/rockchip-mailbox.o: in function `rockchip_mbox_probe':
   rockchip-mailbox.c:(.text+0x1010): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/mailbox/bcm-pdc-mailbox.o: in function `pdc_probe':
   bcm-pdc-mailbox.c:(.text+0x1de0): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/mailbox/mtk-cmdq-mailbox.o: in function `cmdq_probe':
   mtk-cmdq-mailbox.c:(.text+0x4cc): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/rpmsg/qcom_smd.o: in function `qcom_smd_channel_peek':
   qcom_smd.c:(.text+0x17d0): undefined reference to `__ioread32_copy'
   s390-linux-ld: qcom_smd.c:(.text+0x1816): undefined reference to `__ioread32_copy'
   s390-linux-ld: drivers/rpmsg/qcom_smd.o: in function `qcom_smd_write_fifo':
   qcom_smd.c:(.text+0x1baa): undefined reference to `__iowrite32_copy'
   s390-linux-ld: qcom_smd.c:(.text+0x1c48): undefined reference to `__iowrite32_copy'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--Qxx1br4bt0+wmkIi
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--Qxx1br4bt0+wmkIi--
