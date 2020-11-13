Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3413A2B2455
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 20:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgKMTR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 14:17:28 -0500
Received: from mga14.intel.com ([192.55.52.115]:3553 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgKMTR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 14:17:28 -0500
IronPort-SDR: hjoeB96b2/hNtpZZLeF6IUaGu/uaIlOCCT40U8t3yQcKiEofVySplKoWNnyU3pgKt5peX0YROx
 BSK3nXUI22LA==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="169737754"
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="gz'50?scan'50,208,50";a="169737754"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 11:17:25 -0800
IronPort-SDR: 1Qe4NHrkbhXW6czffeJImLPMQ3AUFDoKb+tFhp9laUU61bpdSPLZsoh+rBkXPeXYsAADSR6Bj7
 UQU0zQVxMbFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="gz'50?scan'50,208,50";a="367033801"
Received: from lkp-server02.sh.intel.com (HELO 697932c29306) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Nov 2020 11:17:23 -0800
Received: from kbuild by 697932c29306 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kdeZX-0000Vx-9J; Fri, 13 Nov 2020 19:17:23 +0000
Date:   Sat, 14 Nov 2020 03:16:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: phy-pxa-usb.c:undefined reference to `devm_ioremap_resource'
Message-ID: <202011140335.tceVqHmN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   585e5b17b92dead8a3aca4e3c9876fbca5f7e0ba
commit: 203b7ee14d3a38f1b8c44dd86ce0313d8fc4107d phy: Enable compile testing for some of drivers
date:   10 months ago
config: s390-randconfig-r022-20201113 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=203b7ee14d3a38f1b8c44dd86ce0313d8fc4107d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 203b7ee14d3a38f1b8c44dd86ce0313d8fc4107d
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
   irq-al-fic.c:(.init.text+0x5c): undefined reference to `of_iomap'
   s390-linux-ld: irq-al-fic.c:(.init.text+0x28c): undefined reference to `iounmap'
   s390-linux-ld: drivers/irqchip/irq-jcore-aic.o: in function `aic_irq_of_init':
   irq-jcore-aic.c:(.init.text+0x86): undefined reference to `of_iomap'
   s390-linux-ld: irq-jcore-aic.c:(.init.text+0xac): undefined reference to `iounmap'
   s390-linux-ld: drivers/irqchip/irq-renesas-irqc.o: in function `irqc_probe':
   irq-renesas-irqc.c:(.text+0x26a): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/irqchip/irq-renesas-h8s.o: in function `h8s_intc_of_init':
   irq-renesas-h8s.c:(.init.text+0xcc): undefined reference to `of_iomap'
   s390-linux-ld: drivers/irqchip/irq-uniphier-aidet.o: in function `uniphier_aidet_probe':
   irq-uniphier-aidet.c:(.text+0x356): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/phy/broadcom/phy-bcm-cygnus-pcie.o: in function `cygnus_pcie_phy_probe':
   phy-bcm-cygnus-pcie.c:(.text+0xb4): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/phy/broadcom/phy-bcm-ns2-usbdrd.o: in function `ns2_drd_phy_probe':
   phy-bcm-ns2-usbdrd.c:(.text+0x2ee): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: phy-bcm-ns2-usbdrd.c:(.text+0x324): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: phy-bcm-ns2-usbdrd.c:(.text+0x35a): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: phy-bcm-ns2-usbdrd.c:(.text+0x390): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/phy/broadcom/phy-brcm-sata.o:phy-brcm-sata.c:(.text+0x114): more undefined references to `devm_ioremap_resource' follow
   s390-linux-ld: drivers/phy/marvell/phy-mvebu-a3700-utmi.o: in function `mvebu_a3700_utmi_phy_probe':
   phy-mvebu-a3700-utmi.c:(.text+0x3bc): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/phy/marvell/phy-armada38x-comphy.o: in function `a38x_comphy_probe':
   phy-armada38x-comphy.c:(.text+0x126): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/phy/marvell/phy-pxa-usb.o: in function `pxa_usb_phy_probe':
>> phy-pxa-usb.c:(.text+0x2ce): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/phy/st/phy-stm32-usbphyc.o: in function `stm32_usbphyc_probe':
   phy-stm32-usbphyc.c:(.text+0x358): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/phy/ti/phy-omap-control.o: in function `omap_control_phy_probe':
   phy-omap-control.c:(.text+0x94): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: phy-omap-control.c:(.text+0xca): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/phy/ti/phy-omap-control.o:phy-omap-control.c:(.text+0x118): more undefined references to `devm_ioremap_resource' follow
   s390-linux-ld: drivers/char/ipmi/bt-bmc.o: in function `bt_bmc_probe':
   bt-bmc.c:(.text+0xa14): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/soc/bcm/brcmstb/common.o: in function `brcmstb_soc_device_early_init':
   common.c:(.init.text+0x6e): undefined reference to `of_iomap'
   s390-linux-ld: common.c:(.init.text+0xaa): undefined reference to `iounmap'
   s390-linux-ld: drivers/soc/bcm/brcmstb/biuctrl.o: in function `brcmstb_biuctrl_init':
   biuctrl.c:(.init.text+0x86): undefined reference to `of_iomap'
   s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_console_close':
   dpaa2-console.c:(.text+0x74): undefined reference to `iounmap'
   s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_console_probe':
   dpaa2-console.c:(.text+0xc8): undefined reference to `of_address_to_resource'
   s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_generic_console_open.isra.0.constprop.0':
   dpaa2-console.c:(.text+0x17e): undefined reference to `ioremap'
   s390-linux-ld: dpaa2-console.c:(.text+0x1a6): undefined reference to `iounmap'
   s390-linux-ld: dpaa2-console.c:(.text+0x1ba): undefined reference to `ioremap'
   s390-linux-ld: dpaa2-console.c:(.text+0x210): undefined reference to `iounmap'
   s390-linux-ld: drivers/soc/mediatek/mtk-pmic-wrap.o: in function `pwrap_probe':
   mtk-pmic-wrap.c:(.text+0x146e): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: mtk-pmic-wrap.c:(.text+0x14fe): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/soc/mediatek/mtk-scpsys.o: in function `scpsys_probe':
   mtk-scpsys.c:(.text+0x35c): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/soc/amlogic/meson-canvas.o: in function `meson_canvas_probe':
   meson-canvas.c:(.text+0x5e): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/soc/amlogic/meson-clk-measure.o: in function `meson_msr_probe':
   meson-clk-measure.c:(.text+0xde): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/soc/qcom/qcom-geni-se.o:qcom-geni-se.c:(.text+0x64): more undefined references to `devm_ioremap_resource' follow
   s390-linux-ld: drivers/regulator/stm32-vrefbuf.o: in function `stm32_vrefbuf_probe':
   stm32-vrefbuf.c:(.text+0x2e0): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/reset/reset-axs10x.o: in function `axs10x_reset_probe':
   reset-axs10x.c:(.text+0xce): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/reset/reset-lpc18xx.o: in function `lpc18xx_rgu_probe':
   reset-lpc18xx.c:(.text+0x23e): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/reset/reset-meson.o: in function `meson_reset_probe':
   reset-meson.c:(.text+0x8e): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/reset/reset-meson-audio-arb.o: in function `meson_audio_arb_probe':
   reset-meson-audio-arb.c:(.text+0x1b6): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/reset/reset-qcom-aoss.o: in function `qcom_aoss_reset_probe':
   reset-qcom-aoss.c:(.text+0x1b8): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/reset/reset-qcom-pdc.o:reset-qcom-pdc.c:(.text+0x13e): more undefined references to `devm_ioremap_resource' follow
   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_detach':
   main.c:(.text+0x9a): undefined reference to `iounmap'
   s390-linux-ld: main.c:(.text+0xe0): undefined reference to `iounmap'
   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_attach':
   main.c:(.text+0x31e): undefined reference to `iounmap'
   s390-linux-ld: main.c:(.text+0x35e): undefined reference to `iounmap'
   s390-linux-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_probe':
   main.c:(.text+0x4ea): undefined reference to `ioremap'
   s390-linux-ld: main.c:(.text+0x59e): undefined reference to `ioremap'
   s390-linux-ld: main.c:(.text+0x5f0): undefined reference to `iounmap'
   s390-linux-ld: main.c:(.text+0x636): undefined reference to `iounmap'
   s390-linux-ld: drivers/char/hw_random/meson-rng.o: in function `meson_rng_probe':
   meson-rng.c:(.text+0x72): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/mtk-rng.o: in function `mtk_rng_probe':
   mtk-rng.c:(.text+0x246): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/ks-sa-rng.o: in function `ks_sa_rng_probe':
   ks-sa-rng.c:(.text+0x2fa): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/npcm-rng.o: in function `npcm_rng_probe':
   npcm-rng.c:(.text+0x1fc): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/xillybus/xillybus_of.o: in function `xilly_drv_probe':
   xillybus_of.c:(.text+0x1f0): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/iommu/qcom_iommu.o: in function `qcom_iommu_ctx_probe':
   qcom_iommu.c:(.text+0x1c6): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/iommu/qcom_iommu.o: in function `qcom_iommu_device_probe':
   qcom_iommu.c:(.text+0x39c): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/mfd/syscon.o: in function `syscon_probe':
   syscon.c:(.text+0xa6): undefined reference to `devm_ioremap'
   s390-linux-ld: drivers/mfd/syscon.o: in function `of_syscon_register.isra.0':
   syscon.c:(.text+0x196): undefined reference to `of_address_to_resource'
   s390-linux-ld: syscon.c:(.text+0x1b8): undefined reference to `ioremap'
   s390-linux-ld: syscon.c:(.text+0x2ec): undefined reference to `iounmap'
   s390-linux-ld: drivers/mfd/stm32-timers.o: in function `stm32_timers_probe':
   stm32-timers.c:(.text+0xd2): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/net/phy/mdio-mux-bcm-iproc.o: in function `mdio_mux_iproc_probe':
   mdio-mux-bcm-iproc.c:(.text+0x2ee): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/net/phy/mdio-sun4i.o: in function `sun4i_mdio_probe':
   mdio-sun4i.c:(.text+0x29e): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `arc_rimi_exit':
   arc-rimi.c:(.exit.text+0x3c): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `arc_rimi_init':
   arc-rimi.c:(.init.text+0x2c2): undefined reference to `ioremap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x362): undefined reference to `iounmap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x552): undefined reference to `iounmap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x5f0): undefined reference to `ioremap'
   s390-linux-ld: arc-rimi.c:(.init.text+0x6ee): undefined reference to `iounmap'
   s390-linux-ld: drivers/net/arcnet/arc-rimi.o: in function `check_mirror':
   arc-rimi.c:(.text.unlikely+0x54): undefined reference to `ioremap'
   s390-linux-ld: arc-rimi.c:(.text.unlikely+0x76): undefined reference to `iounmap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
   cistpl.c:(.text+0x348): undefined reference to `ioremap'
   s390-linux-ld: cistpl.c:(.text+0x37e): undefined reference to `iounmap'
   s390-linux-ld: cistpl.c:(.text+0x3a6): undefined reference to `iounmap'
   s390-linux-ld: cistpl.c:(.text+0x3b8): undefined reference to `ioremap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
   cistpl.c:(.text+0xce0): undefined reference to `iounmap'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--mP3DRpeJDSE+ciuQ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AQA=

--mP3DRpeJDSE+ciuQ--
