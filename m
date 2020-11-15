Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9293A2B31F7
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 03:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgKOCVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 21:21:48 -0500
Received: from mga01.intel.com ([192.55.52.88]:9411 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726136AbgKOCVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 21:21:47 -0500
IronPort-SDR: 4cMLZx5tsSb8g+rymyzzbQ8P953fhzQCNSxQ+M7TxBYCJt9wc3tZQ4MZek9GqO7TAakuXC643U
 GBzUuW99wdug==
X-IronPort-AV: E=McAfee;i="6000,8403,9805"; a="188649860"
X-IronPort-AV: E=Sophos;i="5.77,479,1596524400"; 
   d="gz'50?scan'50,208,50";a="188649860"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2020 18:21:45 -0800
IronPort-SDR: T9IEOCPlalEbYdyhEf9GWfvm0ziGaNAVyk+G10haGvHHebsLgPxmhIduC9Vt3z/opPSiNd/Oz0
 gonCoNFCVNWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,479,1596524400"; 
   d="gz'50?scan'50,208,50";a="475116886"
Received: from lkp-server02.sh.intel.com (HELO 697932c29306) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 14 Nov 2020 18:21:43 -0800
Received: from kbuild by 697932c29306 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ke7fi-00013x-Jy; Sun, 15 Nov 2020 02:21:42 +0000
Date:   Sun, 15 Nov 2020 10:21:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Freeman Liu <freeman.liu@unisoc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>
Subject: sprd_thermal.c:undefined reference to
 `devm_platform_ioremap_resource'
Message-ID: <202011151010.wzmGxTZU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e28c0d7c92c89016c12a677616668957351e7542
commit: 554fdbaf19b188224d52d2fa80c049e4d42002e8 thermal: sprd: Add Spreadtrum thermal driver support
date:   8 months ago
config: s390-randconfig-r014-20201115 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=554fdbaf19b188224d52d2fa80c049e4d42002e8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 554fdbaf19b188224d52d2fa80c049e4d42002e8
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: aspeed-lpc-ctrl.c:(.text+0x184): undefined reference to `of_address_to_resource'
   s390-linux-ld: drivers/soc/aspeed/aspeed-p2a-ctrl.o: in function `aspeed_p2a_ctrl_probe':
   aspeed-p2a-ctrl.c:(.text+0x326): undefined reference to `of_address_to_resource'
   s390-linux-ld: drivers/soc/bcm/brcmstb/common.o: in function `brcmstb_soc_device_early_init':
   common.c:(.init.text+0x36): undefined reference to `of_iomap'
   s390-linux-ld: common.c:(.init.text+0x5e): undefined reference to `iounmap'
   s390-linux-ld: drivers/soc/bcm/brcmstb/biuctrl.o: in function `brcmstb_biuctrl_init':
   biuctrl.c:(.init.text+0x42): undefined reference to `of_iomap'
   s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_console_close':
   dpaa2-console.c:(.text+0x64): undefined reference to `iounmap'
   s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_console_probe':
   dpaa2-console.c:(.text+0xbc): undefined reference to `of_address_to_resource'
   s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_generic_console_open.isra.0.constprop.0':
   dpaa2-console.c:(.text+0x1be): undefined reference to `ioremap'
   s390-linux-ld: dpaa2-console.c:(.text+0x1e6): undefined reference to `iounmap'
   s390-linux-ld: dpaa2-console.c:(.text+0x1fa): undefined reference to `ioremap'
   s390-linux-ld: dpaa2-console.c:(.text+0x316): undefined reference to `iounmap'
   s390-linux-ld: drivers/soc/mediatek/mtk-pmic-wrap.o: in function `pwrap_probe':
   mtk-pmic-wrap.c:(.text+0x114e): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: mtk-pmic-wrap.c:(.text+0x1424): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/soc/amlogic/meson-canvas.o: in function `meson_canvas_probe':
   meson-canvas.c:(.text+0x56): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/soc/qcom/qcom-geni-se.o: in function `geni_se_probe':
   qcom-geni-se.c:(.text+0x5c): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/soc/qcom/qcom_gsbi.o: in function `gsbi_probe':
   qcom_gsbi.c:(.text+0x6c): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/soc/qcom/smem.o: in function `qcom_smem_map_memory':
   smem.c:(.text+0xaa): undefined reference to `of_address_to_resource'
   s390-linux-ld: smem.c:(.text+0xe6): undefined reference to `devm_ioremap_wc'
   s390-linux-ld: drivers/soc/qcom/llcc-qcom.o: in function `qcom_llcc_init_mmio':
   llcc-qcom.c:(.text+0x1a2): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/soc/renesas/renesas-soc.o: in function `renesas_soc_init':
   renesas-soc.c:(.init.text+0x64): undefined reference to `of_iomap'
   s390-linux-ld: renesas-soc.c:(.init.text+0x7c): undefined reference to `iounmap'
   s390-linux-ld: renesas-soc.c:(.init.text+0xd0): undefined reference to `of_iomap'
   s390-linux-ld: renesas-soc.c:(.init.text+0xf4): undefined reference to `ioremap'
   s390-linux-ld: renesas-soc.c:(.init.text+0x108): undefined reference to `iounmap'
   s390-linux-ld: drivers/soc/renesas/rcar-sysc.o: in function `rcar_sysc_pd_init':
   rcar-sysc.c:(.init.text+0x7c): undefined reference to `of_iomap'
   s390-linux-ld: drivers/regulator/stm32-vrefbuf.o: in function `stm32_vrefbuf_probe':
   stm32-vrefbuf.c:(.text+0x2a0): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/regulator/stm32-pwr.o: in function `stm32_pwr_regulator_probe':
   stm32-pwr.c:(.text+0x250): undefined reference to `of_iomap'
   s390-linux-ld: drivers/regulator/uniphier-regulator.o: in function `uniphier_regulator_probe':
   uniphier-regulator.c:(.text+0xd0): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/reset/reset-ath79.o: in function `ath79_reset_probe':
   reset-ath79.c:(.text+0x8c): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/reset/reset-brcmstb-rescal.o: in function `brcm_rescal_reset_probe':
   reset-brcmstb-rescal.c:(.text+0x66): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/reset/reset-lpc18xx.o: in function `lpc18xx_rgu_probe':
   reset-lpc18xx.c:(.text+0x106): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/reset/reset-meson.o: in function `meson_reset_probe':
   reset-meson.c:(.text+0x86): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/reset/reset-meson-audio-arb.o: in function `meson_audio_arb_probe':
   reset-meson-audio-arb.c:(.text+0xd6): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/reset/reset-npcm.o: in function `npcm_rc_probe':
   reset-npcm.c:(.text+0x254): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/reset/reset-qcom-pdc.o: in function `qcom_pdc_reset_probe':
   reset-qcom-pdc.c:(.text+0x116): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/reset/reset-simple.o: in function `reset_simple_probe':
   reset-simple.c:(.text+0xa8): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/reset/reset-stm32mp1.o: in function `stm32_reset_probe':
   reset-stm32mp1.c:(.text+0x11a): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/reset/reset-sunxi.o: in function `sun6i_reset_init':
   reset-sunxi.c:(.init.text+0x6a): undefined reference to `of_address_to_resource'
   s390-linux-ld: reset-sunxi.c:(.init.text+0xb6): undefined reference to `ioremap'
   s390-linux-ld: drivers/reset/reset-uniphier-glue.o: in function `uniphier_glue_reset_probe':
   reset-uniphier-glue.c:(.text+0x11a): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/mfd/syscon.o: in function `syscon_probe':
   syscon.c:(.text+0x96): undefined reference to `devm_ioremap'
   s390-linux-ld: drivers/mfd/syscon.o: in function `of_syscon_register.isra.0':
   syscon.c:(.text+0x1a6): undefined reference to `of_address_to_resource'
   s390-linux-ld: syscon.c:(.text+0x1e6): undefined reference to `ioremap'
   s390-linux-ld: syscon.c:(.text+0x374): undefined reference to `iounmap'
   s390-linux-ld: drivers/mtd/nand/raw/mxic_nand.o: in function `mxic_nfc_probe':
   mxic_nand.c:(.text+0x1fc): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/mtd/nand/raw/stm32_fmc2_nand.o: in function `stm32_fmc2_probe':
   stm32_fmc2_nand.c:(.text+0x19ce): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: stm32_fmc2_nand.c:(.text+0x1a3e): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: stm32_fmc2_nand.c:(.text+0x1a88): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: stm32_fmc2_nand.c:(.text+0x1ac6): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/mtd/nand/raw/meson_nand.o: in function `meson_nfc_probe':
   meson_nand.c:(.text+0x44e): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
   cistpl.c:(.text+0xac4): undefined reference to `iounmap'
   s390-linux-ld: cistpl.c:(.text+0xad6): undefined reference to `ioremap'
   s390-linux-ld: cistpl.c:(.text+0xb38): undefined reference to `ioremap'
   s390-linux-ld: cistpl.c:(.text+0xb52): undefined reference to `iounmap'
   s390-linux-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
   cistpl.c:(.text+0xcf8): undefined reference to `iounmap'
   s390-linux-ld: drivers/input/serio/apbps2.o: in function `apbps2_of_probe':
   apbps2.c:(.text+0x246): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/input/serio/olpc_apsp.o: in function `olpc_apsp_probe':
   olpc_apsp.c:(.text+0x2dc): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/input/serio/sun4i-ps2.o: in function `sun4i_ps2_remove':
   sun4i-ps2.c:(.text+0x40): undefined reference to `iounmap'
   s390-linux-ld: drivers/input/serio/sun4i-ps2.o: in function `sun4i_ps2_probe':
   sun4i-ps2.c:(.text+0x350): undefined reference to `ioremap'
   s390-linux-ld: sun4i-ps2.c:(.text+0x4f2): undefined reference to `iounmap'
   s390-linux-ld: drivers/thermal/sprd_thermal.o: in function `sprd_thm_probe':
>> sprd_thermal.c:(.text+0xe4): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/crypto/atmel-aes.o: in function `atmel_aes_probe':
   atmel-aes.c:(.text+0x7be): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/crypto/atmel-tdes.o: in function `atmel_tdes_probe':
   atmel-tdes.c:(.text+0x856): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/crypto/img-hash.o: in function `img_hash_probe':
   img-hash.c:(.text+0xd70): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: img-hash.c:(.text+0xda8): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/crypto/mediatek/mtk-platform.o: in function `mtk_crypto_probe':
   mtk-platform.c:(.text+0x6f4): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/crypto/qcom-rng.o: in function `qcom_rng_probe':
   qcom-rng.c:(.text+0x11c): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_init':
   timer-of.c:(.init.text+0x38): undefined reference to `of_iomap'
   s390-linux-ld: timer-of.c:(.init.text+0x1f2): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_cleanup':
   timer-of.c:(.init.text+0x276): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-davinci.o: in function `of_davinci_timer_register':
   timer-davinci.c:(.init.text+0x2a): undefined reference to `of_address_to_resource'
   s390-linux-ld: drivers/clocksource/timer-davinci.o: in function `davinci_timer_register':
   timer-davinci.c:(.init.text+0x11e): undefined reference to `ioremap'
   s390-linux-ld: drivers/clocksource/clps711x-timer.o: in function `clps711x_timer_init':
   clps711x-timer.c:(.init.text+0x32): undefined reference to `of_iomap'
   s390-linux-ld: drivers/clocksource/timer-zevio.o: in function `zevio_timer_init':
   timer-zevio.c:(.init.text+0x44): undefined reference to `of_iomap'
   s390-linux-ld: timer-zevio.c:(.init.text+0x86): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/bcm_kona_timer.o: in function `kona_timer_init':
   bcm_kona_timer.c:(.init.text+0x60): undefined reference to `of_iomap'
   s390-linux-ld: drivers/mailbox/imx-mailbox.o: in function `imx_mu_probe':
   imx-mailbox.c:(.text+0x12c): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/mailbox/rockchip-mailbox.o: in function `rockchip_mbox_probe':
   rockchip-mailbox.c:(.text+0x40e): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/mailbox/bcm-pdc-mailbox.o: in function `pdc_probe':
   bcm-pdc-mailbox.c:(.text+0x788): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/mailbox/qcom-apcs-ipc-mailbox.o: in function `qcom_apcs_ipc_probe':
   qcom-apcs-ipc-mailbox.c:(.text+0x102): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/mailbox/mtk-cmdq-mailbox.o: in function `cmdq_probe':
   mtk-cmdq-mailbox.c:(.text+0x196): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/rpmsg/qcom_smd.o: in function `qcom_smd_channel_peek':
   qcom_smd.c:(.text+0x680): undefined reference to `__ioread32_copy'
   s390-linux-ld: qcom_smd.c:(.text+0x6aa): undefined reference to `__ioread32_copy'
   s390-linux-ld: drivers/rpmsg/qcom_smd.o: in function `qcom_smd_write_fifo':
   qcom_smd.c:(.text+0xc18): undefined reference to `__iowrite32_copy'
   s390-linux-ld: qcom_smd.c:(.text+0xc3c): undefined reference to `__iowrite32_copy'
   s390-linux-ld: drivers/fpga/socfpga-a10.o: in function `socfpga_a10_fpga_probe':
   socfpga-a10.c:(.text+0x346): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: socfpga-a10.c:(.text+0x374): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/fpga/zynq-fpga.o: in function `zynq_fpga_probe':
   zynq-fpga.c:(.text+0x53c): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/counter/ti-eqep.o: in function `ti_eqep_probe':
   ti-eqep.c:(.text+0x464): undefined reference to `devm_platform_ioremap_resource'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--KsGdsel6WgEHnImy
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
m6PMiWz6P5RK6P/G5AAA

--KsGdsel6WgEHnImy--
