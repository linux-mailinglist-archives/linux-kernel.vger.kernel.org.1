Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938C42BC1EE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 21:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgKUUHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 15:07:41 -0500
Received: from mga05.intel.com ([192.55.52.43]:59131 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728444AbgKUUHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 15:07:40 -0500
IronPort-SDR: 4cNXiDwlzT0lFpyTSGZ97JBcuhh0Qa+5KSA5hr5orrFA5L8uPdZ/+ZmWkEA/+hpKFcEqTk257c
 t7MOBJfCsMEQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9812"; a="256318745"
X-IronPort-AV: E=Sophos;i="5.78,359,1599548400"; 
   d="gz'50?scan'50,208,50";a="256318745"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2020 12:07:40 -0800
IronPort-SDR: /TzGsOk4L9+h/+Ro1nUsqrIRu3YkKxQua7b69UiOrPE+zmG2LDgZmnIJPMVlte8ktuovh6A8MU
 tHjAzNTswv/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,359,1599548400"; 
   d="gz'50?scan'50,208,50";a="326739382"
Received: from lkp-server01.sh.intel.com (HELO 00bc34107a07) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Nov 2020 12:07:38 -0800
Received: from kbuild by 00bc34107a07 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kgZAX-0000PW-OR; Sat, 21 Nov 2020 20:07:37 +0000
Date:   Sun, 22 Nov 2020 04:06:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: brcmstb_dpfe.c:undefined reference to `devm_ioremap_resource'
Message-ID: <202011220438.D1GFrA5T-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a349e4c659609fd20e4beea89e5c4a4038e33a95
commit: 904ffa81b709f79b906077e72f4656bdb9930340 memory: brcmstb_dpfe: add separate entry for compile test
date:   3 months ago
config: s390-randconfig-r023-20201121 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=904ffa81b709f79b906077e72f4656bdb9930340
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 904ffa81b709f79b906077e72f4656bdb9930340
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: drivers/dma/sf-pdma/sf-pdma.o: in function `sf_pdma_probe':
   sf-pdma.c:(.text+0x5b0): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/stm32-dmamux.o: in function `stm32_dmamux_probe':
   stm32-dmamux.c:(.text+0x200): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/sprd-dma.o: in function `sprd_dma_probe':
   sprd-dma.c:(.text+0x6d6): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/dma/timb_dma.o: in function `td_remove':
   timb_dma.c:(.text+0xe6): undefined reference to `iounmap'
   s390-linux-ld: drivers/dma/timb_dma.o: in function `td_probe':
   timb_dma.c:(.text+0x1350): undefined reference to `ioremap'
   s390-linux-ld: timb_dma.c:(.text+0x1684): undefined reference to `iounmap'
   s390-linux-ld: drivers/dma/xgene-dma.o: in function `xgene_dma_probe':
   xgene-dma.c:(.text+0x1686): undefined reference to `devm_ioremap'
   s390-linux-ld: xgene-dma.c:(.text+0x16ea): undefined reference to `devm_ioremap'
   s390-linux-ld: xgene-dma.c:(.text+0x174e): undefined reference to `devm_ioremap'
   s390-linux-ld: xgene-dma.c:(.text+0x17b4): undefined reference to `devm_ioremap'
   s390-linux-ld: drivers/dma/zx_dma.o: in function `zx_dma_probe':
   zx_dma.c:(.text+0x154c): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/dma/qcom/hidma_mgmt.o: in function `hidma_mgmt_probe':
   hidma_mgmt.c:(.text+0x29a): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/qcom/hidma.o: in function `hidma_probe':
   hidma.c:(.text+0xf32): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: hidma.c:(.text+0xf72): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/ti/edma.o: in function `edma_probe':
   edma.c:(.text+0x2cc0): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/dma/ti/omap-dma.o: in function `omap_dma_probe':
   omap-dma.c:(.text+0x62): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/soc/amlogic/meson-canvas.o:meson-canvas.c:(.text+0x56): more undefined references to `devm_ioremap_resource' follow
   s390-linux-ld: drivers/mfd/syscon.o: in function `syscon_probe':
   syscon.c:(.text+0xb0): undefined reference to `devm_ioremap'
   s390-linux-ld: drivers/mtd/nand/raw/mxic_nand.o: in function `mxic_nfc_probe':
   mxic_nand.c:(.text+0x838): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/input/serio/olpc_apsp.o: in function `olpc_apsp_probe':
   olpc_apsp.c:(.text+0xbc): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/input/serio/sun4i-ps2.o: in function `sun4i_ps2_probe':
   sun4i-ps2.c:(.text+0x16a): undefined reference to `ioremap'
   s390-linux-ld: sun4i-ps2.c:(.text+0x300): undefined reference to `iounmap'
   s390-linux-ld: drivers/input/serio/sun4i-ps2.o: in function `sun4i_ps2_remove':
   sun4i-ps2.c:(.text+0x47e): undefined reference to `iounmap'
   s390-linux-ld: drivers/media/cec/platform/s5p/s5p_cec.o: in function `s5p_cec_probe':
   s5p_cec.c:(.text+0x462): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/media/cec/platform/sti/stih-cec.o: in function `stih_cec_probe':
   stih-cec.c:(.text+0x24a): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/media/cec/platform/tegra/tegra_cec.o: in function `tegra_cec_probe':
   tegra_cec.c:(.text+0x28c): undefined reference to `devm_ioremap'
   s390-linux-ld: drivers/power/reset/brcm-kona-reset.o: in function `kona_reset_probe':
   brcm-kona-reset.c:(.text+0x5a): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/power/reset/ocelot-reset.o: in function `ocelot_reset_probe':
   ocelot-reset.c:(.text+0x56): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/thermal/broadcom/sr-thermal.o: in function `sr_thermal_probe':
   sr-thermal.c:(.text+0x74): undefined reference to `devm_memremap'
   s390-linux-ld: drivers/thermal/tango_thermal.o: in function `tango_thermal_probe':
   tango_thermal.c:(.text+0x56): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/thermal/zx2967_thermal.o: in function `zx2967_thermal_probe':
   zx2967_thermal.c:(.text+0x126): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/watchdog/at91sam9_wdt.o: in function `at91wdt_probe':
   at91sam9_wdt.c:(.init.text+0xa4): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/watchdog/omap_wdt.o: in function `omap_wdt_probe':
   omap_wdt.c:(.text+0x408): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/watchdog/s3c2410_wdt.o: in function `s3c2410wdt_probe':
   s3c2410_wdt.c:(.text+0x668): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/watchdog/sama5d4_wdt.o: in function `sama5d4_wdt_probe':
   sama5d4_wdt.c:(.text+0x3c4): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/watchdog/ep93xx_wdt.o: in function `ep93xx_wdt_probe':
   ep93xx_wdt.c:(.text+0xa4): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/watchdog/pnx4008_wdt.o:pnx4008_wdt.c:(.text+0x226): more undefined references to `devm_platform_ioremap_resource' follow
   s390-linux-ld: drivers/watchdog/sc520_wdt.o: in function `sc520_wdt_unload':
   sc520_wdt.c:(.exit.text+0x50): undefined reference to `iounmap'
   s390-linux-ld: drivers/watchdog/sc520_wdt.o: in function `sc520_wdt_init':
   sc520_wdt.c:(.init.text+0x52): undefined reference to `ioremap'
   s390-linux-ld: sc520_wdt.c:(.init.text+0x100): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_init':
   timer-of.c:(.init.text+0xfc): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/timer-of.o: in function `timer_of_cleanup':
   timer-of.c:(.init.text+0x1a8): undefined reference to `iounmap'
   s390-linux-ld: drivers/clocksource/ingenic-ost.o: in function `ingenic_ost_probe':
   ingenic-ost.c:(.init.text+0x76): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/mailbox/bcm-pdc-mailbox.o: in function `pdc_probe':
   bcm-pdc-mailbox.c:(.text+0x8b6): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/mailbox/mtk-cmdq-mailbox.o: in function `cmdq_probe':
   mtk-cmdq-mailbox.c:(.text+0x166): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/mailbox/sun6i-msgbox.o: in function `sun6i_msgbox_probe':
   sun6i-msgbox.c:(.text+0x132): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/mailbox/qcom-ipcc.o: in function `qcom_ipcc_probe':
   qcom-ipcc.c:(.text+0x2e2): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/hwspinlock/omap_hwspinlock.o: in function `omap_hwspinlock_probe':
   omap_hwspinlock.c:(.text+0x86): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/hwspinlock/qcom_hwspinlock.o: in function `qcom_hwspinlock_probe':
   qcom_hwspinlock.c:(.text+0xcc): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/hwspinlock/sirf_hwspinlock.o: in function `sirf_hwspinlock_probe':
   sirf_hwspinlock.c:(.text+0x7e): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/hwspinlock/stm32_hwspinlock.o: in function `stm32_hwspinlock_probe':
   stm32_hwspinlock.c:(.text+0xd0): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/devfreq/event/exynos-nocp.o: in function `exynos_nocp_probe':
   exynos-nocp.c:(.text+0x4b6): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/devfreq/event/exynos-ppmu.o: in function `exynos_ppmu_probe':
   exynos-ppmu.c:(.text+0xbc): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/devfreq/event/rockchip-dfi.o: in function `rockchip_dfi_probe':
   rockchip-dfi.c:(.text+0x222): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/memory/brcmstb_dpfe.o: in function `brcmstb_dpfe_probe':
>> brcmstb_dpfe.c:(.text+0x30a): undefined reference to `devm_ioremap_resource'
>> s390-linux-ld: brcmstb_dpfe.c:(.text+0x354): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: brcmstb_dpfe.c:(.text+0x390): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/fpga/socfpga.o: in function `socfpga_fpga_probe':
   socfpga.c:(.text+0x2ee): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: socfpga.c:(.text+0x322): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/fpga/zynq-fpga.o:zynq-fpga.c:(.text+0x7e8): more undefined references to `devm_ioremap_resource' follow

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--/04w6evG8XlLl3ft
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICChtuV8AAy5jb25maWcAnDxrb+O2st/7K4QWuGiBs93EeewGF/lAUZTFRhK1ImU7+SK4
WW83ONkksJ2e7vn1d4bUg6RoZ3EPcLbRzPA1HM6LQ//y0y8Red0/f1vvH+7Xj4/fo782T5vt
er/5HH15eNz8b5SIqBQqYglXvwNx/vD0+s/73dnVSXTx+9XvJ++296fRzWb7tHmM6PPTl4e/
XqH1w/PTT7/8REWZ8nlLabtgteSibBVbqeufsfW7R+zo3V/399Gvc0p/i65+P/v95GerDZct
IK6/96D52M/11cnZyUmPyJMBPjs7P9H/G/rJSTkf0CdW9xmRLZFFOxdKjINYCF7mvGQWSpRS
1Q1VopYjlNef2qWob0ZI3PA8UbxgrSJxzlopajViVVYzkkDnqYB/gERiU2DWL9Fcc/4x2m32
ry8j+3jJVcvKRUtqWCsvuLo+m42TKioOgygmrUFyQUneL/rnn52ZtZLkygJmZMHaG1aXLG/n
d7wae7ExMWBmYVR+V5AwZnV3qIU4hDgPI5oSF1ozKVkCFL9EHY017+hhFz0975F7E7ye/TEC
XMMx/OrOxvptRWBKsJRjHdoLCnSdsJQ0udJ7b+1VD86EVCUp2PXPvz49P21++3nsXy5JmBXy
Vi54RYO4JVE0az81rGFBPK2FlG3BClHftkQpQrPApBvJch57G0hq6Jk0oD1gAiCVeS/tcHCi
3eufu++7/eabJe1wnhJREF66Z0zywgUYojbjrMYxbkesrEgtGRLZ+zJnJas5NW1Z3MxT6a51
8/Q5ev7izesnr7U+14txKR6awsm7YQtWKtmvUz1822x3oaVmd20FrUTCqT3RUiCGJ3l4LzQ6
iMn4PGtBpPQk6/DqJrPpJwOyyIpKQfda5w2d9vCFyJtSkfo2OHRHFRCKvj0V0LznCa2a92q9
+3e0h+lEa5jabr/e76L1/f3z69P+4emvkUsLXkPrqmkJ1X3wcj7yPYBsS6L4wtLbsUxgFoLC
WUMyZa/Ox7WLs/D6JA+y8wcWMmhqmCWXIofZibJnRE2bSE4lQwHTWsCNi4CPlq1AXCwtLx0K
3cYDgXGRumknnwHUBNQkLARXNaGBOUkF5wCtUCFKF1MyBraGzWmcc9s2IS4lpWjU9eX5FNjm
jKTXp5dOV4LGyL+Dc2q1TS1ivbXd1risHTTHjfnDFgJ+k0Fz78QMlhTNZtrKjKfq+vSDDccd
LcjKxs9GseelugFbmzK/jzOz9fL+6+bz6+NmG33ZrPev281Og7vZB7B911qjyqaqwK+QbdkU
pI0JuDnUORmdIwOzOJ19tMDzWjSVtJcPap3Og1If5zddg7BV0KhW0sy1YT5BxRN5DF8nrvF1
sSnI9R2r7RkD4yVTR/tM2IJTdrhX6MLXBf1sWZ0e6zmujqK1aQmMi+YaDBNomnEzGtw/+1uy
2gEA58z3OErG6E0lYFtR04MrGjYSek/A7Cox2b7RHUglzBb0MyXK9ap8XLsIO081y0nYHqDk
wBZo/6UOC0csBFoF/DvMT9qKCiwZv2NtKmq9L6IuQM6D2+pRS/jD0pRgr1UOCpSySuk4BDWH
ZSKqdPzw1WwBHhfHrbH6mzNVgApqR0fAY16HCMw0zUgJtt3aZCH5qrPZFlQrEP+7LQtuRxrW
gY8J+Dxp404mbSDiCkyCVcKbNZ+XJE/DW6Xnlob8VO3qpK7wZKBQAqSEO24yF20DSwodFZIs
OKylY6Gvq2JS1+DzhfxxpL4tLCb2kNZx1gaoZhkKsecwVGk78fC01l0SOHe9E45kf3BHhaCU
aOQBRoJb+inExSJmSaLPoO06o8S3gzPZywECYZx2UcD8hOM5VvT0xIk6tEXpgvNqs/3yvP22
frrfROzvzRN4KQRsDUU/BVzC0fkIDqvVWnjwzmL94DCD51aYMYxj6Ig+RkYE+KuD6lGuchKH
dV3exCEFlwsrFsHWID31nPX758psk6YQRVcE8HplBFRrWGsqVrQJUQSTCjzltPfnLF9YpDwP
i7bWO1p9S5t3buQ/KJ7C8njuwC9vEzvSRvcjRukpE04s5wtDENDdvYtg8QDithvjM01wfQCT
LRlEEQGEo2ss4HB+Wr0sZyNdT6UTIWBxLzs9GUaHmniEQZTDBbYDD6s61GMDrI5tgyrPrk6s
L20ERQGdpzWY336G1mGamxRNDqIIiubCOX45LKrCwLh31qvt8/1mt3veRvvvL8bbt1w3u2mh
53l3dXLSpoyoprYn6VBcvUnRnp5cvUFz+lYnp1eXb1Awejp7q5Mzm2BUycNag6dzXOhRNK7y
GMHp0eawvmNoXFzgMA7rCiznNJy96bEXh7vDLVWNG0Tjd693whYWCXweujgt2X6Dg2wz+ANc
65AHmGawPs/8xuE4uUOGmdchQ7y7PI9dS2psQEgDF5Y6KGsdC1iBZCZUlTfzLlockyZNMMQw
GkIWylcaBfUh4K7e+LCkJkvHLdRQBXoLQr5be/zsDnYqtLmAmF2ceKRnB86S6SXczTV0MyYm
V4x6SrMGr1NYKbQuD1mKuLJHB+dXYNr7kL+PlhFVZjAbckxBag1abL49b7/7CW6j1HXSDvw7
sGc4gK/zB/Rovm28adSnKDspeIumhr8W/kgdlaxysBtVkbSVQotqxQMQ8lfZrcTJgNTK6/NL
y/iDiTWGNhzUYPg2xXfYJanLNrmFUBFsqyaynQSHeSaF+l44ecVhmE8JFwfGlxTF9EDQCAtq
DmRFnaH0WMnrtxeAvbw8b/f24LQmMmuTpqiCPTnNxvBt2VvZxcN2/7p+fPhvf4tkO1aKUR2P
8lo1JOd32vlq5w2EwqHcoycptLAOAPoKbXZbQbCW+hbvZmERuoM5qf5FKNDRHesp2bvnLcuk
gDaPX/ab3X5nr1I3b8olLzF9lqfKW9uYIhpaO7dH6+3914f95h6P3bvPmxegBi88en7BcS1H
xWwTFTWzlQIoDg+mGSKMU+sYtT9gh1twq1koytWtWAr+MUcnv4HgEiJMzElQTLZ6Zw5DCryc
UrxsY7zB8PfDd/QMtGYqjDDQFkQj9SJ9jU+bkmrBYXUt6paXfzDa7a1N5sTa42WG7jFzzIFG
gnOO+QzF541orCn1zjJYLp3V764APRZgsi4Fr5ant60UTU19vYQEkqlOfQUCUzmoDqVTE/qu
0l+ALNpCJN3VoM+3ms0hVEa5Q93TbVVLKp8NGMaGYlVsH4LrvJbpE9VCiKmjMB3HBsJ1CJPa
OVEZjGG8ecwYBtGYKX6DBOIO89eE+0YgTEaXFtWKZnNvqh3U3L4ewCWimRo3nVbgFW3NxVV/
cRtghGQUPaMWzqITyGiKozclowzB5OAcAh2mdd7uAuX3wDEo0Srj8c6aOcPALjhlkao2gX5v
PSzIYW/bGcVI2toQkTQ5HGDUC6AC9aYHlqJR2q9xsn2dLOfcGPIh6rUMQY7RdAwIMLmJtC62
BV6Q87lsYFJlcjZBEE9RdLmKsxl4Am2AoXquC4hhLXve25UBGsqBDdulQHeo3l2rlys7nj+I
8psbhnY0wwzQr7GzMKELkKEn45rR+rYarvHmVCze/bnebT5H/zbZn5ft85eHR+f+Dom6OQbm
p7GdcWn7TGqfFTnSvcNkrAxBf4+7uXILHDSgP2gx+6EwF4HpVNvc6AyixGTY9YkVJRrxDcWI
nWDry7ocbEhjacPY9TMxhy6p5CDKnxqnvKPPrsdyHgQ6t/BjKl6xec3tY9ijMLeUuGBaJBgG
GI3kXL4gdhmH3C3THSZ5bIfKhoZGkpijqWyFiVBTfNMLnOd3BQnaFHYh9k6Tydust/sH3MtI
QVhiZzoJ2FvdliQLvFhwEtkE/KBypAmmtFcj3m4qZHq8YQGaxGnaIxSpeQjB4yIELggNz6CQ
iZBH55AnwR4RrLfL0jNzHh4EnOvaZkE4qmiOM/GG1AUJ989SfrQplrRcfgytwhJfq9s+TPXk
wZa74pO2gfquwsRYYryLtUQH6LjosgDgzLmVYhby5ja27XQPjtNP9ozcQUbxxDyzJRyyPPVU
aHcKZIWlZPWtq0AOUbRxdoTojT5+rIOu+OYtEkkm4bdN1pRvTMYQHJ9OR3N8QiNRd6saptVl
Bkf5rCl+AH1wziPFwRk7JIdZqMmOsdAiOD6dt1joER1l4RJMEDvOQ0PyI/iD07ZIDs7apTnM
R0N3jJE2xRtTeouVPtWEl0355gkZ7keIEhgO1sXS0k3owpjGYPfEsrTVU72U4OUdQOopHcCN
/qa5N4V1kKqyKcYyDq1W2T+b+9f9+s/HjS4zjvSdoZsIiXmZFgqd/ENu6UiBfrSyr3ANRtKa
V2oCLrh07k0x4XEwX3VopnZCs1g/rf/afAvmWYbMpWVQx1znCpOQLIRawD8YIfjp0AmFH1ax
QjuSOkfZTvEpkaqd235nlxC1i9PsC3croRqywSZPqnOkJhk/5OJ1bEQn16N4x1ozlNDwHSn4
RjXxoyxMq7TevaFeIEkSiPunFwgxBDTBSpEbae1Ef5evOV3wUnd3fX5yNdSfHQ9zQ1iY5pLc
OpFIkKwwdQ6hYpacgTdKwFOwPRriiCz4TIdKjQac7YYjECZA5PVQw3ZXCWG53XdxY7nmd2cp
hLz2kHfSXPqHy5VZXeNVik46mT3Wtcuj55P09+sYi9+Y3MQoFKzGrAOe4nBZ1xwrr8DZzwpS
H42XK8VMQoE4seThg2pdEjE1iR2Szd8P95so2T787fh/JrlFubMIyoNzryglbhHUmLB9uO/6
jsSgOEb/2sTmGcsrt+BloIDoTRWVX8ncH01FyoRgqiNcl6s7TzmYBxAM8zigV8/pw/bbf9bb
TfT4vP682Y7rTpdgB7BY0tLsPUhvb4KljiMSFRwZBrFK2cdWOjto1hjq1EIPIV6Irq+nt3fd
X0bfqqvjWQya34n7QMiXDjYo8RjRJjVf2LPuoGzhXKIbKObxuwatf/EEVhOvIlgNCkFY/Q1l
5ZiRa5TQee0wetHk8EFiDuqYOzURAus0LEDN5o5VMN8tn9EJrCi4mBLavgsmvWVGarPvqcMM
QKVwZNlQbedmXqair0Uvft1Fn/Wpc70BddqSKlToozEr5yQWGT94k2X3b+mXUgbzNWo4EmPU
+LLe7txgUGEm84OONi1GIzimxeXZahVC2TGqhzJZl5YXcKAUmQeRql65cNyGSuah/mB7dLnl
EVTCa4ZPm267NNS7U4udfhf6PkffBQdfr0zpMUIQZX4bDsN7hmo+N/BnVDxjLGxKx9R2/bR7
1NdmUb7+PuE8hO1w4ny+u35xqixDV06+wPG1xYcjLLCuOk26nkYdK9MkZBFl4Y6JcxLCK7zG
zZzU8Lo7bbIXWJEAbtvoPtekeF+L4n36uN59je6/PrxEn30TpWUs5f6If7CEUa1IDowKWqXt
FY3TEjrDRJkutBXlgeOCHmcbk/KmXfJEZe2pywMPOzuKPfcODIzPTwOwWQBWKpbjY8MJhhSJ
VElobWAvQ0UiPbpR3NtQ2AUPoCssnI5JLMHMBjXRkU3Um1yC+Xa3EyHe9ewAZpS2cgmOCSjt
cv4mAUgo9Vez1ISHm8ZjLVy9/s97OLbrx8fNo55o9MWs4vlpv31+fJxIou6HFFgGmNtJrQFX
rDgNgKUqzmZtWtBZqA2T41ua4mF3HxgT/zGPxwbGa8bqNnkF/n70P+a/s6iiRfTNeIrB46TJ
3Hl80i85x/PSDfF2x66YNHHYdxThxwZd5n7iU5YQE0ZyWpOB8DYNP/7TOEXqOQuLqdPnwOmQ
jSbJxexi1SaVCFe5gS9V3KL/EDhlnMqrs5k8P7EOODgPuZANOKcSXSPn7cQn8PfgKHDwL+wy
bQ3GELeunBCfVIm8+ngyI3nYV+Yyn12dnJyFZqZRM7uwlJXgpslWAebiIoCIs9MPH5yqrh6j
53F1EqrJzwp6eXZhiXkiTy8/Wt901tXsmgwKA6ErQgU4BtMSNTsPDNNhczYn1LoL6sAFWV1+
/HAxgV+d0dXlBApauv14lVVMOveKHZax05OT86BMeZM3DyU3/6x3EX/a7bev33Th+O4r+O6f
oz06AEgXPT48baLPIH0PL/in/WDq/9HadvnBthI0AFU+OVP8aQ86ruAUjvN286ifxo9c73pY
iKrzssf7XRFOKB3rb+AvzYQTvtonztQOUck7yHQ2+tqwEI6VqwlP8O1u8JkbNrDEGJubWvNx
rG4QU9r3K7Dx3/+K9uuXzb8imryDzfzN8da7m0UZcg9pVhukW/HZQ4MpjR5p14jraQ46wjlt
iKH4Xp+Eb7U1QS7mc8dUaqikpGyJvC2ps3zVi9HOY7OsuGGr3w/+jMABeM5j+E8AgQ+73RJX
g6qroa+x/sublrd8CGJ1Wfuh1SfZhGNJ1tYJCVuJniCrwBM43GfLChrql+QNCZ6GkBwP9tW7
KkYJKFzXzTxySxgWBoYrtsFqQ5RFQq85ikSfCkuBd5DTKWRKdH5x6cD0O7GKqMyB6vyiUwsc
68zewfvzBZy8vhhuuvzEcTD7u9pQggI7Sd03Vz25iY5A15cQX9Y6sR9OxWInHL0bLu10LN4c
Y40SRCSYRzGXlPYoDf5SBq/CP20AZrsrIrGbyJJUMhOhugLAqozroGTBsTLKObTYn5sq7SFw
kJxMhblcmRKzWLrfNXE7y0Xptig4Fg46IJQIb0l3rA5X4WIPvbCE15vgy0qn/6SxK0CSwkuv
ItN1Qs8BpTm5YW4/+GpJhUDmPdMtxDBCZVgaKt1X0iNhyoI5YNjDJVe2ggYQvn3WbJfe5Mdi
FIdlGOuG3kBo99QLfRSFjrxAH2FYS2TnrRBWuRYuh1gcE4ldx47GiquAN2w8AcZYdHp2dR79
mj5sN0v4/29T45vymi25PdEegn3PbBV+tMMhQbFwzjx8thWog4Cf8vK6n7oEVlajaqZrytbb
zzpFihXevn3DX6ewvVv4xH+9Z2UaDCatkjPX5UU4RJUha6Fx0KBwCrQNWOQVBUdZVpOhm/Kc
t5Vdr2cQ88r0NsIbb+5zUjDvxVsHaUt5cfExAM/P7a0K8Wn06AKcN6wHH3R9v99srXCpl0pX
+BchzdeUfHX1sa3UrXV8jOd+ENj90sbswnqVkCdcUm0pMVkeGKhs8tyfUffrCqJRwde23UNC
Xtp10As6yYnjRpDclKbZaWgLTlWtR3c3CACTV9AjzLzZux7u6UzVjnb6hH1dyquCtzcUYjI7
30FkhT9PgXBN4CBLiNY/rFYHsF3TWNm48ZBVRdz9+IBWcnVKaPgxTbbsaleDtwsL58IYvm8c
AOZqfEbjuxQNx2Sos/0ZKefm5Yl+yT3RAfI9/pzXvSer0xSIKs9mHyxHyHx3cuPCUvf+0wC7
zQk/DgOS4NMwSfPKF00NO9abJlio2UzPLsz/AmV1cWhEkdqvh/FNBgSHbAgJNMcw/Im+9ooh
oHKHdu3Z+SoU81sEF/bT1UVBK/dLX+DqXzUY7tcLUWrT6pRn6h4XRVMHve2pPholCmURTjX4
Gf7rOQeHWX1z5Ta1QDM6NYfOvRJ8QAekTjBr5pybGT385k8jM2jFFm5XRbMasn+vj3uI6zf/
wNpwHhTTqSErCM1IHRuTAZ3mOSvnIW+8618T+jM1cPj3SLtc0fOzk8vJhNuKkquL89NQnwb1
z5Fei3xFq+5evs8NHFu5O0Z3jYqG4MAYsjBK+v8Ye5LlxnEl7/MVjnfqjph5I5JaqMMcIJKS
WMUFJiiZrgvDz6V2O7rKqrBdb3r+fpAASGJJ0HWpsjITiQSINZHL+D3Jt6fr6/P7n9/fjE/K
L3SH2jK5GMA0wZWWEx6/ClrVGWIVhnnWCFKqJlsKectJ8JeViQCEMY5j2vgdqSPdFZQaLkHM
/GGMbHm44ndbUyM+gb89g5ZKsygAlQUf5BNLSpnxY7TLnc6CLQWEa/HMYaoCbA4Ar6QQjlmf
nR3BpRGnB1MShVFzY6xTxY68vurVSmxLuUTXx79sRPYiTKvo8Z6fIIXLaJW1EFARzHvEfsVa
UlK4n75fuYCXm/c/LzcPX7+Kp8OHb5Lr2z91XaBbmdb2vILjBtJiaIxhOa8AQp0MVzUVfHE1
RXkaKPLmNjnmhhWBHGFAgNuzwPIjQsWgq6god/n7B+8PYwcWxUhK+Yk1NgUdoE7YO8Dxo8Em
Qh2HJ3TYWQwV1HzvlydtWKYim15BUQEEbuMVgK8Y8WrTOcVamidhHHjLtWy5XSzsKWx1ntwe
9ul8p7a3ZRevjXXVLWKJRw6Hhp+78VAhsg/55fRkjAta38EKfMa0khLXZCzTjsEasN81Sfm5
rojLcMKzFjOS0KnqJCvqdqwH5QR2p6RBnWo1KpaE/KBsywr2p8U9DnXXMGEXI0hQvS/cxBsx
uBdrTS23Iy0/+Nz3JGnj7XJFXExyFy6ClQtPWbiJjYvqgGE7T0gxJYQPP+jRfPiB/+4Wequb
peGTLtgsltiIt0iMJgwicly8XeCxGQaagsabcDPT2faJZyzYRutVMMubN3EZrPAmGjRbrIU6
RbjaTN9OR2yiFYpY8XpxRKyfrMePWe6i5cYdHgdyOmRweAu3y8At1rR8tK2w3oG5EAVzrUq3
W366065Kx6wpdccnBRBmkDlr84S5uEwEMargrg9zpt7vpbKwL9kU3ngghuuBcIIEbax5I1MU
gwHsoYb3mIz2d7hJKka/J3kjjb8+4iwdgClBDXKHAg5LBD+KiKN3EOwZ/sHRkxjmTn3eN9nt
QDkjYVaeXAvpzxFWUns55OeV1+/8oDJdpwWSJDS/yas2Wi46hGbchubpzEdFGy0N6l6vD18f
r9+RSoaxL7cNbUBqjxVlX7GZvgEC1hhFB0M7X73yBv3w/e3ny9Ncy30kk1K4OtRazaLs7c+H
b7xSrLUjYy/NwPlLF27XG3eCMtqkLlRET07rgwsZFNZjd46Iqr4j9/UJ22BHGhkoUAZKlF4A
KVJFTbNKnJMhourCQYsz5tA5dw/vj39+vT7d0NcLRKy9/ny/OVx501+ur4Ylx1icNpniDTPI
GeEjQ5+dtPD+djsoJdvFKvQhVh7EOvIhMFZlVu3DYFcmOm6yZs/zBi6QAw57Hiy6/i41jkjg
q5iSPgL14ExJ0m6DptyGiwUiFyAZKbcdguNwskqXqMT7lguzCBZzFbMo4ZsrVmtGt1GHVVmD
0Z0LplW3XCxitMPP/A6VozLyxbBp8zkJm2rVrgOMLztVXY7AB3UsUqItKW9Ux+tMEHTLNqFZ
TjuydZvNOpzty7zsQvX9J8jmVFB7UJR1x4/KAMW+SN7swQQblQLM1/pDt9vNDkNBhZdPc9Jm
n+dKp/khT+qibtCRWBC2QRBNVmVgjmA1dAA3XwjeWKUbR74ULJwIOFnBNzBr4TvKUnxvtArY
b+AKhJQa4e6j+NRlFKpc2Mwn/Hm97NYOflpSehIG5qjg3+AQxtiIPpUFti7tU+EmZx4j+EUS
DhfoVTJxgvIApKrbfJ8bLwAwHgTOie8oWBz5fd68NnCoHF7EEy+KE9g6DA3Flys+a/l3XFGz
Kn54tQFlFJogeAEeTYwOrw8//nx+NNVVg7eAjRv7l+36+siXoiJv2yJzImGWWQmn6M/mnJEw
d4xoDn3s/fnxL+PkYJc+VSIQDL8Gn0rUkJqP+Nq2QoeQswriVHa8vr1DAhWlK3R30iq76/kJ
wHjzS0ETR5hxsp+g8PzPMAMDjUTYIYj1weGxayASaAUhgI53cIupDpnrxcRJsY4SHEiTm/ZH
Jrooo1WE3QMnbGi1lgPXSxuo7qsGHY22y6XTJACvsFCQAiuUVPolUoditQBqHXVuz6VhvPBW
0yZkvVpsnFJtkay2gUc/MHbJ6u+ZTwDOqTf/+vb88tdvwe83fHrcNIedwPMyP0GHdcN+XB6f
+ZH3mI/f7eY3/kOY2ByEFZ/RlCKvPpdWu/nBiC9XFvBkxQmRbeJzszyp/ACo4O3r89OTMdBl
QT74DkYwWR0s3zE9uJoP2WPderDSowfDHDO+i+8y4isJ9iKFGRzXwBsJCgwMOMGeLWMXg8Cr
Jjaohhs10pPPP4SH8tvNu+zO6XtXl/c/nr/Bi9+jyM508xv0+vvD69Pl/Xdnxo79Cw6rueW4
gDaalNJcCudDSZVjxkIWEaheKl/nnVJTHSXDkuXC0+0eO/HwI3pmWYtPMDu4iYY5Dyjp+VkS
davRxqawC+3bbogSCasiBF9yLZ8IJznkpt0YGWIJDuX0OHjSBLlkByPIM+mEJa72/CIu3Dsy
GJwNG2p93C6CKIjN+j59WW7ihQljJAg6G3aq1tqOnd7pFU923fIOkXpyJeUlWDwmNn7AgkdO
n3PkWtOBKWhNe2K0m18kUtPjuUz2fearuixpT+eQLS5Uee47c+srO+ZpQLWje9UrxhUkCj0g
+Tqtn4CtJonbmuxQ3OhWHJH4CZnQnUcoScFvfGb38fVxZ0rVgbOoLUAHccq7/st9dcv7KLV7
UFF96Zxv0X7uj8zb3xyb3OK8hH/GEUZBXx70uLsTwhiG0DXW2VdBta7di2/vXl/Mz3KE35kI
2eVAjZN4Qhrnk1ic4eRpCsF3uswUnjexNhxt21zGiIRkWjsy+vJBRyX2a/C40Ng8zURv0zoz
rAcDy91pr8WimIYcsAUDSczaTBYzuEPeGvBVlreNewc3RChlDoZvp6bKWYerQPr46j1RDUEP
htCxZrO0LeHUpTmjvmwkoIEvEszu7aSf6U7wEpk2Z/CAtB4xAZVCzA2JQmsRsROlURb2uDeG
lTIKwBthVp1whinFJ9hZuAnY5ZRr1uPr9e36x/vN8f9+XF7/63zz9PPCbxbIteojUu2xs8nu
LXfqca0jpgsFn8X8EmrcMQXEH6xiQKukGjCmIInL593/hItlPENWkk6nXFikEORl+By2fP2u
rlJESDvWromlxLJ8VXDGzn1aUQeeM+IVgCbFJghQcLhEJBOI9YxsHB8tMH5xEOL84gCP/65T
xPMUZbRBfcwUASlpwb9BXoPGhfeGI54koEkYrRXermOkWEdA4a+LT6V44XaAAGMdkJIEvaKN
aBasS/cDcfgi9sgqysyyxCSEUh74erkIXXjLL5eIYBwcBJhUgMAD8usUqw8pNh9RhJg53IAv
+aGI2CH+AbMvVmh2hmEAgJ1FXgdhH7vDh+PyvKn7YI0wTtYdKD89ii21SNBkPTuC09sg3DkV
V+DyBZrAlfvdFK7GEUZADQsRrLE1iWMLsqPJ/PDnc5GkyPQvUxK4Y4jDMUE4+ISAhY7oNkJk
Y6u5NSkO9dfuCbhCOAG4n2vgZ/m/YaCFLDNzSww+mbHP0eJfCWzhTYdBuf1Jxetw+CIvX1+v
z18No1M7NubwtqtIB36To4gwjp8q2t+B5TtYeLd1y++PIr6blvZiwkOoIYWesgQfWL+nBwIv
idpxp8r5KQzCUo1K2Ie3vy7vhmf3oII1MdqjVJ4VKT8b2N7o02Vgn4oTb486DSXHpobEPAVp
IbmbmerOW6rMioJUdTeW04sJ75GuDjaYMbmMxV1oOtlERA9xYvEOhPAASg1zBKnLUkzkRxam
hpoGjjTlTXP54/J6gSxYXy9vz0/mKTxP8HMGhMOlcWBYtP0id1c89cgVrzHZAbldxisUd8zX
hh5UQ7GktE93E4riMQx0mnwVLVEjGZNmZe9kGnLp3cwGol0ZxDGeQkWjStIk2yw869dIxPii
sugTivbGnhV80fJ1yCEr8yqf5y9fzPCuDkvKrDPiWKzL4X8jNDvACxYswpjwiVGk+QEtKhQB
HonrriLYMV8fNyUNXZ2ckCnxhYUR2IoU9QHypfR3DYWcsUUVxkczSoP4eCT/zFe41mNoBhRJ
GfLDc5+eschcA0UcrRzWSdlDNKY5zoIAcgB4MmErKnhqnO+oHPIKYxIk94cKvUwNBMcmxMpV
zJOGdcSjxyiFZY05Uho+8nZZ09xT3/A95nwarpMzbjhsE279XNbrjxmsNwvPUhRttnFytrd2
bakK9dAc0i71mBvhDNrTDiXWECCkpwU7ftlGVO75y9Pl5fnxhl2TN9ekip8KsgpCsx2G1w+d
u44FFS1q72kThavdHA/Uutom0nXBOq6DvFI+VBwhqDY5qT1Qs0FDekRTfslH79mds7x8fX5o
L38BDy1Vjbb8KJMHz7cq23Cz+GB/ARrrTGyi+l1KmRnA06XJywOn+WiPUcSf6CHNkl+nL/eH
ZO9Ji+sSlxZjL+VZCjHfsHNW/Zqk683ae2nUqTZ4hjqLaotaJOs0m3VoX+RNZJ+1x1/oCkF6
zPdzPSFo+C73a+y2nsEEKCXUHMUoC0YRBxF+SAPUxr6UmchfGxoxn+AzbOJIbve/NCYEeUJ+
tVo1i7ztAwp6Evp/fPm3iHynRo2MpLhFgo9phSUecInljJ2TUXyLOYJpdvpJ5Nz0kawcPYiJ
REa0/5phLMXGyUG+gZjHiazMzqEJar6QwIJs2DYMzH0WwDHZRATVwigs3yCxQpul78QjsRFe
yLNqjfiN5+owEhB0hxnRO7vZApp4mpDNMtvECK/NFmWF+1SM2AAvNNuF2yVeCLtbT9g13tTt
erap2/UKaevWOBiO0NhThSfNrEYw8/W3ZLE+LCI876m4kh35QPX2Mrwb8sNRyG+LB0tmhYo8
qBPb8VIywL6eJkmbblCyL5lzjDewLcWxaX7GtQDKgE/vy6y7r2qw3SrXS40U7ZOBli8rTF6X
8TwtyirZUJ2Yr+D84PFBXYJsGXnI9I+U7438cBOs359Wy0VPGzNut3ia/6B2wQQMlLHmCcPl
JNHMfzgoP/f7IOHnauagVou8J9C7CPy49oEbhZjkFuFQCHRscsLlWrlyrXmRKEB4xRwRRn5e
gI8iT8E4amdLHj0FzxGbLZdmIV6wWc40ewsSLZymQzETqE2FFrT9VI8lebyDbBemCecEsx73
NQSYMqAIsAXXW6KjaIO9T+sUyoJ2Kg25Ok7xyryea/cqdv35iobxAOO5vtYe+iXEii7OO4U1
yRADfKxW6VbcUCITXhpiDzZ6kwGAchzwlQSrI7qzbfuEffLahtZ3hVtBkxIvczkZjsziI+xn
XE4JSWXk8jZxOU5mB6zchuvFDEVSULYJgs4rljLBdwQAMyQ/W9rkJQm9TCs+aJrM7jIZcwtM
zHk3I02Wn1taLxWYZo1vCedNKUw3cn1OCK1h31Bm1zhsPzVnag+2vOxE2PukNURUygVbuAHB
S9So6nwgqHXrmDJPmhoc83uat+vlzlWrW1NkLEjyYlcbhr0gb8lh6PfgtXwW9XgphHkToSKi
EPakAbOGpolgoDWgFZn4bi2wXMVLdrBkFBuZLYIuAK/bjFZUQ+pT5SzgrCLN5fv1/fLj9fro
riGQwaDNbBXnBO0T34PQ8KXO/HrVACl6HUHqljL9+P72hIhDSz0Xovgpm3wojAhVNqZnMq7S
1ISJgJXYkiwJNGueQWJDMunjyBv3GxMps2/qFxGY5febNzDA/mNMfjD5g37/dn2S2jMk+LRw
0khIddYvXgoq1GLEjoE6OBdBAgiISYK+owFJOZLozcHEkXLyBly+4mKCo9P4oqEtk8IrCN7l
7NAbGA2r6hpdfiQJDYlgYwjryqSxbreBkCzHPueIZfvxHXT0XPU2UnnM6jKghWRQ7o7+9/71
cnl7fPh2ubm9vua3Fucp1vYHpNLY+59l5xeNL1SxEe3cIZfq644u//7bkWOYpBzbdf1tecA3
IIWvaIbOXoS5cniZdApYhHW52pnrHx+YDTF0KwClkNgMkowZQ74Vr5A+TRWgHY2YliEIkc10
KfZ0llxN+KLWM/zRSBKwHXZ5ELiiMNdlAeQLzdHPjmMpNp7VyqUHixsWMyjjQCHfm5k7TSFo
SB0Yc8prC4cOv0sqxpDZbjtgG32tDeJJxzRtbvcsmdH6aOjIUwy/+WsE6BOKhieBh/MOf6zU
KJIPWGce1qby3EHrkS00aIBCQ7yKLaZ509ArlJmp49ERH/XF1vNsoFF88CG2Md7srU8mj9Kn
Ya3Qv3grS0jjcizrHW4/PZ4CD412txJ7y6hmUcBBccLOGAxO2ohKBnije5jC07JP+aVUZsE2
UaN3Kb/xnmhhhQysk9HT4FwXLSRpU2RYzwzUkUPtMMUWvFPHb6xqPx423A6SerubkVotEKwu
zJfWyLzxa4eugQH0mYz/MciifhpxEYYLqooUIiKR5CVvcl9XaVYS05hYJ6NZAwZKpPJEATVo
IaAL5CHF7sYaHXjaDVFMMDaEMakAM9rjOJTyQTYMD2XApbpBw8Otx0ROxyqOlrfnoQb0xjiO
LIf/1PW9HblaBw8yVrVuhIOSUFqefCTj5Ez3uT492mTKIJP9/f54ffHGspDEliOoApaki6LV
yoHTtloZVqIKLndPCCBbGsH1FLpp4+0mIuYiIDCsXK1Qw2WFB88UU0KZwnP6PUR7Selez5ja
Bn0R8i3bTG81Zt/pM/T4MniAW1FwPVa39M5w+ZAH0eZW5j5CAhWSot/nc344edUmEHCO5pYz
vUI3t3Ol4YVK0GCqBjBwwFPVDMWPsRRA0180t2BWSY85OC7mqRlfDSYTZBpuM3RhFeiqlV5j
9toPnPmQ2eWVRyVU1HV1gOscTY49zfFbtdPXU5OYCK9etU1dFKYOBzCkPZqPTgrcsQDNZaPC
0WVNoScxMILU2eCCVG1+60BpEsR6iDkJHhI/WfKoWAbwXA1BXvFNX1BCUBGv3DTnR2K+WNR2
tVKLU5sO9xqKornghlh5euxQBRObiAOFSVfSYLVxq+G7G1jy+muBtwibIfj3OTrvwVJKWT7h
SGUvJUN4Hu9v2M9/vYmtVYueqJJQcrQuLkTvHJIf8jUJC0MAJLJ+oNA2BgGHJQpGPMIXzLv4
VKlq8XCGrzScjHYECLz4sqTRLIH4prCgHlkfxlX5MSHDb55AM70BckI8Qh+QQf4XmpEmiIIF
3xug0/GemwiXitDsQdbmx+Vi43atXNM5mP8wsynLvTrYLnsankxMSmL5IU0wKderJVirp7q3
tQgppBaT3hCszfnkollkf1HpBpyVJTZ/gMDwVNWPe+aoHIvAUSoR2gE5di+vIm83WEx/v748
v19fMZe4OTJtJhI3aOtk9D9sXVXa1LqHtgJADnJIV5vTxIfT0zZbpQbH9n/86xm8+//zz/9V
f/z75av86x/++kZnTUN1ZrkgpMTYfkTOGYLrtCExnLufH+8g5dbj88sTGhG9LdGdCSk1SATr
3dQh8KsvD82wEurC2jh4G8W1jdLZnkK39J4w0SMzGHOYELsmT/Vc4ALIL1pG5nIBTPeFIyaH
9WSPvV8aFZfUqpofHoZBzf/Erks6eDwDinQzRdZNKUT1sOFYpJtT15P0sNmGHidvFRodUytD
nPLS1I5jtWkXgZoaijyWe55RWJGXTmLf8eDGPyr/u/KlghKJMTzHp9J6Vpp8js3LwH/I7Njf
LjdyxTH67EyKPCVt1u+ZytKLfV4Gzy760zE/uYdWwgQF6jvI+oUf9qN+b9zzBYAvfCznHy4p
LG4CybLk1OBBMzjJ0ma4nGO4/BWGVqyNT7vU0EHBb69jMGdf7qxkTU2WM1gfDUlHoEhxYR6Z
RnJvT34auE1S6a1GB8snT9MNAl+7RGEkwGtnNQt+355qM7dW55NNw+seyvC7rkSaaZY0p53N
S+HAxynHeqfbOwFTAEQY79e235NWd1I77Jk9jnet7H7skTovRvrhk4dWHwgAdBZGJj+pC9ZH
rIUaPpqxGofD0LHkNCmk33lefcqEm8sMIYNjq0hFn6PWUJDjyhl00M8Eu0nhDco6eLG11wwJ
U9ndauppTV5kMynfePmsEgnazH1MB0PiBObD5XJIDTneJpox85jeaJVSzB+wb6JROfEgL1lF
2hPvYFT8MVDFdIaRINRqQGCG2FUDD2IHu3DmochBJMH9HWkqqy+nxxBB4VsKJLZtMv31ZV+2
/TmwAaEljKWngYwee7bEZ5pEmlOIt9gagf9f2ZEtt5HjfsXlp92qzCTyFXur8sDupqQe9eU+
LNkvKsXuOKrYsktHzWS/fgGy2c0DVLIPGY8AkM0TAEEQCBsy8HMXpEIvnMOEYMRpGoaZ30Uu
eUwpf5yAJXN2Dw3LkySfk6Souy5IzALmTvSMxKYchigv7pWyE64ev5u5iseVk4Zx8A2R1JJc
JDf9GN1FQuwPUl8toSq/wROsJUPyJLbTKavtDyXIaWqisapFtYP+tjTr5tVH4L8f+QL/m9V0
68YW60wrKGe19U4SUZuJ1X3EjTCPQEiAvntx/nngQnb9EqLKxDlGXsEsA6eH/bfr/miS1dZy
FAAiuwkuljmtlh3rvjzy7drD09vJN2NYtA2ch3SnpffKNE6iUn9dOeNlpjdZxVUe3PGaCa+T
gN6BZThdTlm1nMQTNHOFSzGUmtUF/wxCQR1H3S70E4nRTZCVy0A6+k4sMVCjNcAsogEwvAYb
GfukNRf83NZSFRANb5V4Ck/5MDrCDiBF0ni+FLjCUYB8TDRwyLmvE3+NbY1DQbrF90lX4TqM
SLEVNOMxqc1LsqpJU6bb2PvSlo7SwwmZ3uM0LcVAaWoFSHfx2NYmeTDiI0hY8mDcz0tgiS52
3v6Apmga1LsGpMAElhnoL96SkgTEY24Lex2PcXs8ivNANGZ3eVNC6+nDXMlScpKr24ZVU3NF
KJhUfnz5d00qKaPIWiKOU4G5DyfkRbBNKE7fx2oSBHhXGBZ0KKi+gO8Y0xN0K8AtmTyQ9/wD
Ws/02X/ugazroaqpe+gefyGSFQfC8f6Bk1XwNOBRRCZ7HeahZJMUL++6dL5Y13mvmCycjY/P
7Rf01s9TiwFOCwtwmy0unBoBeOVwk+F82dVKSZGqNoLWyd8oGRM0EKit7BDANOjIQV4p9EWP
9n4VqabhsWquL85+oxqcZX9LvQi7j0odILuTO2S0ZZzq2O+UMPpAFaA71bf59Kn99rLat6dO
zeGR9JMdCXqKHhleI6t0Bwz02CQDDP9h9sPTUwI3Q4dUsTmGgDAaWuQF5QwvzPqAMKA13Bmr
v3GWvoRI8Ud2sjkilDExjSOWO9gvC9lCs4fTtiiFPWaMUjQPcUHUG4IyUotAtJj6RyR5G/Wq
qR6kFX4MK2O9e7u+vrz5Y3Sqo5WevAQ92SzYYz6fGxd7Jo4MW2OQXOvuBBbmzIu59GJ8zby+
8n7nauTtwPUV5ZxgkZwfKU5Hd7GIfj1IV1fext94MDfnV9523VxSLmlWcd/o31z4Pnn9+cLE
wOEQF5Ue7MwoMDrzzj6gnGlhVRhTbhv6p0Z0C87suhTi/Bf1eXp06auPisCj4z/T9d346hvR
l6sGiX+R9SS0yyCSzPL4ekm+u1HIxm4bRrEFbYHRdkNFEXIMxv8LkqzmTUnrxD1RmbM6ZpTx
sSe5L+MkiUOqoRPGk5i6iO0JSs5n5qwgOIb2W65wPSprYkrsGmNj5G5QmLopZ3E1NRFNPb42
ZFUW4zYgLQXGZY18ltE+Hrbr/U8tPm5Xz4zrj+vxF0jO2wYzFFo3EaCrVzEIDUyhymEss4kp
66Q9FFOMc483OiCW0RTTN5XMCZw06MudUMPos5Xw56jL2HO/dUQAKpRldM5LYf6s4JxFpmYT
9xShMI/ikUymD9aOCRQaw7lPv5x+3H1dbz4edu329e2p/eN7+/KOl9OaMxSTreJ4U73MS5le
GjOr5zm1VJRRaRgRPfxyUqVfTvFJ19Pb35sPP1evqw8vb6un9/Xmw271rYV61k8f1pt9+4wz
/+Hr+7dTuRhm7XbTvogs3u0Gr5+HRaHl6DhZb9b79epl/d8VYvU4PzE67LBwJs7FQ4MEQpjK
kzzUQvfr469oxrCfPNH9tecJZDsU2t+N3i/WXvWqpQsYe3FloJuHRJxoM+62hKU8DYt7GyqD
qBug4taGYITqK1jCYX5nozDQdVyJkPrFLd6jmnGvHSJss0Mltlyfjzjc/nzfv508vm3bk7ft
iVyAWkwhQQxHfT3JcgdkyYQVsQd85sK5EXpzALqk1SyMi6m+hyyEW2TKdO6nAV3S0ojE3MNI
Qu1UZjXc2xLma/ysKFzqWVG4NeD5yiXtEqj64GbUHwPVLwgRg9xjKDIK8EWND35tcpN4Mh6d
XadN4rQoaxIaSLWxEH+PNUr8oUwgaryaegqiRC3p4vD1Zf34x4/258mjWN3PmBnpp7Ooy8rZ
FSBqiBbyMKKfGPX4MqKDsnbtb8o7fnYpo79JP6jD/nu72a8f4cz8dMI3op3Abk7+Xu+/n7Dd
7u1xLVDRar/SDfKqRtItU01LmDr9CqcgmNnZpyJP7kfnny6JXjI+iSuY0GM9rfhtfOf/Modv
ALe+U90MxOthlGw7Z/TDICQaEY6ptMwKWbuLP6xdxsTDwIElpgm/g+bHPlfIJprARV0R9YCW
gq/s/HVlU23krXHHbFx1484Z2rD7oZyudt99I2lkWFCsz0pKopoPffK38k4Wkjdn6+d2t3c/
VobnZ+7nBJj63mJqJdeyKYKEzfjZkWmQBO4swyfr0acoHjuYCSkMjiz9NCLDKikkWSSGtc4T
/OsvWqYRbCiiNCLocI89/uzyyukCgM/1yIxqV06NEFI9kKoCwJcjaqYAQR1ZFTY9p8rgpXxA
JlTsKOpJObqhPjcvrHjmksut378bj0l63kSoHxwjKVCMLGuC+KiUY2XoiY6rllw+H8dkUji1
+BhGV45dARIyPAWpUJYuzt3/CHXnKSJ6PFbeIg77mbIHdkRAViypGLFwlFSgppablw4uvizo
xFf9irkgqq35ETlZz/NxTOzcDj4Mq1wrb6/v23a3Mw4a/egJ47orBcxLvg56feGJZaUKHeEO
wtbufAft6aqd5Wrz9PZ6kh1ev7bbk0m7abfqdOSu3CpehkVJXhCrrpWByLDZuEsGMR6+L3G/
YMWCKCQvzjQK57t/xZiYjKMfu37k0XTwZff6WT9xvKy/bldwVNu+HfbrDSHWkjgg9z3CO5mg
XlUQHdaojkweEMk9oNXkI6FRvWp3vAZdA3TR1GZHuBJZoKrivcXoGMmxz3t1j6F3hmroEvXS
xB7n6ZwYXjiIpilHE4yw39T3hXlAVsiiCZKOpmoCk2xx+elmGXI0vcQhXpRJV2HNtjQLq2u8
Q79DLNZBUXzunC7o8p/FEQcL611D1zkMocHlFTc61ok2xER847Dd7vHJLGjrOxEQEuPMr/YH
OE4/fm8ff6w3z1rgCeGF0ptwOpOYZily8BXeZQ0Nk3h5ONPGhjZl5VnEynvia3Z9sE8wZ2PV
G+lod6/f6Kn6ehBn+Gnh/zdWGz/x7nhp8iiMh7MKtgzgaAdcraQC2aEPJSuXwpfHvMFlPs/N
IAalBZMNaWtNPc4ax1mE2SVgJIBM2wh5GelbCwNLcTjQpoGRtEhaKHVfX+HRhE6EYVoswulE
eJSW3FBZQzjNAQc1QKMrk8JVdMNlXDdLs5SROhh/mk9ZTAxsPB7c+057GolPUxIkrJzT60/i
zVEsQz2nIfy0NISQCm4M3Kc/c+i01wStPG2YqyiL8lQbCcrTGBkcSChTY3iQjJmEjpM61K2q
pjeCBpWOKzbccjsY4CS9x79AgCn6xQOC7d/LhZ7hooOJ919mboEOEzPPDWOHx+waxPj3yHoK
m4OoF/OoUAemDh2EfzmNNFP5qa0qDMYYqkHbfhj3qMqT3NC9dSheOOhby8DBt3RcoCcqFY9m
0JJqeiEvWFmy+95xqRdwGO8FeMEdXwqCATW10y2K9Ie6bTXDJom8j6ywQ84IboI4FkXlsl5e
XRj7q3efHOdlKJJYLpusv2LRpMw8zuskMBshcwjKk3/7bXV42WMm3P36+fB22J28SrP6atuu
gO3/t/2Ppq3hDQUmmEuDe5iqL6MrB4MeW6Aeoi/nSPMd7PEVnqNFaZrV6HRDXRTTMWo0ffNM
HPmIAElYAsIfvam+XA9lxZgX/ux81SSRC1LjbkWTsmq2zMdjce+hreAkD8xfOptWxZOHZc3M
TAblLSpy1HuWtDAzPuGDRnxiB+dzbfFV+OAzt6WTaN2c6Q41AhTxQk+DVMFSM55jwUZO9ZvI
PPiLTUztokZdguS8vVLh6ATmbZPSnwT0fbve7H+cwHHq5Om13T1TiTuFxjFbetw2O2zIzMf7
ofRRAuE8SUA1SHqj/2cvxW0T8/pL70ekdEynhp4ius8YBuOy8yrrYOsmCfTkIEf9mJclUBkO
gpIe/oEmE+R2QK1ucL0D1p+f1y/tH/v1a6fB7QTpo4RvqeHt8jmnDRo58DEQ5Q5fQlvFcw8j
NSWuhgJjgWK/jHdpLBKVssqI5jMFOGhXwHphOZKrXo5BJV8aoat3yozs0jZGtAnfct27IylZ
5rjJwu7lDnCB5TlpltQLzDmbIUvqspoPuvLvjq1MKIY2gfWjWvZR+/Xw/Iy3k/Fmt98eXs2c
tymbyBCfpR4CbgD2V6Rysr58+mdEUdm501wcWvsbjO+q+dN1na+IEawEC5wvj00WurXFlaRL
8Z3pkXo8DtS9lGuCimWggWZxjWyd6VdOAqfXLYlry0ZvoQNoUUTLIEmAzwmoJykCOUgObSH8
1tSaY4RPKHjiDoz9cf3eva93WCbC2QlOijyrYvM+XVaHeCGzKD6JZfN5ZhyXxRk6j6s8s06R
JgbmTU4KGZHBJH3gpeZOPbRraRyRJLzMI1YzSxuUKBA93LgHMsCEdDXxY6nTWeOjsCLILmVD
MsnmeTnzfaAMG8HOfHjp0a4eXvuoOt6rJEu/qUUOvm7ppDxNgCW5vVEYcnF3jFS4ZzQVrVpV
wO6jjobDKVm9IrZ3pazrLl0Wk1qwH6cpd3SAELugd8RloCbhFeKsHcmJUXfWfdiZUMShgTNW
6SqLhcDrL0uJC0WfJNY1sEkszrxc9wMvAv1cuZSbjinDRrWk2FSm0u4UcCA6yd/edx9OkrfH
H4d3KT2mq82zqe0wEcwZhJr1jJXCoydIA+LAROLyzptaf9MT8RqfHU4xYFUNOixR8fwWhCmI
1Cif6J083nDpVQbS8OmAIlDnWYP7DYG21wg2ecZ5Ydl3pI0JL5wHLvuv3ft6g5fQ0KDXw779
p4X/afePf/75578HVikeAou6RZrSLtCzbu7B1O7dY2AbXLK5rCADFmNxxi4iPaMdtQRXq0GZ
qvmCO9zLDarfLX+afD6XmGUFslP4ltn8c14ZD+AkVLTQWvUIA+3f3bkdwtsZOI6jLlslnBfU
h3Bw8RilGHLljBWc5/HJspNhvKcaunn0VPF/rALVTNANQKGDXThOmP5sW7A8gdRbK1RJGDc4
YeNNGbBGaWnyjs1MsnFzi/+QWsHTag/HalAHHtGaauzwbvBi0nDVMT3EOqtnYkPEY+1Y2iv7
6oV8yZZCssLho2wK99W+sbc9LTY/FZYwIlkNKmSl+gsikFRS5BYyM1f0QF+/9VViGPugCEaS
9C8fpPCtMY0E1A8QeCzhlrqBOJQv4kTSs86zkfUBXCzez/Nb4mnHEB7dGCd7HQDbleeOUsg5
75KQoQ1A+cP3ZabxF1o/zesikQJfvD8SAagor+O8kH0pLZHZH5OOYyegbU9pGnXsHauN5Ucu
53E9RWuGLdE7dCrUJuEvWUYWCUaiFTOFlKB2ZrVTCV5b3ltA7LisdkDIj4UmRxb2DfnodQDK
QJpIb0gLHGeckQr6E7rDUoASmsLug9MX2Vqnvg6gSavBYdlZgYqXYZpv86JEghR7OnbegqWE
YbDj7nxmWBSFt3VHoVlNcwcjmMHu/OYTxQ1MFkz1rIKSy6KOmpSSQpyVSXfpZGTctL6nm5jq
drdHEYFaSoihbFfPrc5/Z01Ge+R33BRtM3k5BDwxpsEfC8Ue25nh7NsplqBOArgbFdNKj/QU
74IlizdTtVRFlJvAIGNnUU2JKHEJKi4AK2vABSaNMzy/UEMu8JWhLQVKXgoZbXPQAC3oNlA3
w5sow/Bu4aS6cXVB3nLpvtRecSBaP+ULz3qSnZNWTOm1XzljA+gqLKizrrxZBnytJyUR0P5e
1KxLmlj9LQW8SCTvp2ia+AhWXlf48RgZZAxb29eZEm/XnFOdHERGeksJXBwxh15ajynrIV7B
QkeHa19r7MZxmYL2xS1wE/FEv2mRC5enIYOPWeDeVG1OpLgy1g+Vqo4O2vcAQF7V8yhfcZ4h
mLfmQqlM4wpfzC+jPGzQmoRL7n+CF65Uf/oAAA==

--/04w6evG8XlLl3ft--
