Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6659F2D9D83
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 18:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408458AbgLNRVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 12:21:32 -0500
Received: from mga11.intel.com ([192.55.52.93]:47368 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408430AbgLNRVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:21:10 -0500
IronPort-SDR: rQf0QLLgMB1U3SPvzd+b24BKdilHjakx2opwOFgbRXRlGfB00Wew7RiX82pnSnIGL0UhA+/wi2
 twgIgqbhywkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9834"; a="171234225"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="gz'50?scan'50,208,50";a="171234225"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 09:20:24 -0800
IronPort-SDR: DgOMdAZD/SBdd3DXHORJRvGPckAEFXOW4V0btqpTmqesYaQuKSmmhYvn/9JQ+/nov6XreG+F62
 LVvqMMGmwnpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="gz'50?scan'50,208,50";a="553745504"
Received: from lkp-server02.sh.intel.com (HELO a947d92d0467) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 14 Dec 2020 09:20:20 -0800
Received: from kbuild by a947d92d0467 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1korWF-0000PZ-TW; Mon, 14 Dec 2020 17:20:19 +0000
Date:   Tue, 15 Dec 2020 01:19:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: drivers/clk/imx/clk-imx8mp.c:446:25: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202012150153.IPuadMa3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2c85ebc57b3e1817b6ce1a6b703928e113a90442
commit: 9a976cd278eafa496ce30196810ef2e879a4a7d5 clk: imx8m: Support module build
date:   4 months ago
config: openrisc-randconfig-s031-20201214 (attached as .config)
compiler: or1k-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-184-g1b896707-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9a976cd278eafa496ce30196810ef2e879a4a7d5
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9a976cd278eafa496ce30196810ef2e879a4a7d5
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=openrisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
>> drivers/clk/imx/clk-imx8mp.c:446:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *[assigned] anatop_base @@
   drivers/clk/imx/clk-imx8mp.c:446:25: sparse:     expected void *addr
   drivers/clk/imx/clk-imx8mp.c:446:25: sparse:     got void [noderef] __iomem *[assigned] anatop_base
   drivers/clk/imx/clk-imx8mp.c:452:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *[assigned] anatop_base @@
   drivers/clk/imx/clk-imx8mp.c:452:25: sparse:     expected void *addr
   drivers/clk/imx/clk-imx8mp.c:452:25: sparse:     got void [noderef] __iomem *[assigned] anatop_base

vim +446 drivers/clk/imx/clk-imx8mp.c

9c140d9926761b0 Anson Huang 2020-01-08  429  
9c140d9926761b0 Anson Huang 2020-01-08  430  static int imx8mp_clocks_probe(struct platform_device *pdev)
9c140d9926761b0 Anson Huang 2020-01-08  431  {
9c140d9926761b0 Anson Huang 2020-01-08  432  	struct device *dev = &pdev->dev;
9c140d9926761b0 Anson Huang 2020-01-08  433  	struct device_node *np = dev->of_node;
9c140d9926761b0 Anson Huang 2020-01-08  434  	void __iomem *anatop_base, *ccm_base;
9c140d9926761b0 Anson Huang 2020-01-08  435  	int i;
9c140d9926761b0 Anson Huang 2020-01-08  436  
9c140d9926761b0 Anson Huang 2020-01-08  437  	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mp-anatop");
9c140d9926761b0 Anson Huang 2020-01-08  438  	anatop_base = of_iomap(np, 0);
680fbce528169ea Anson Huang 2020-02-12  439  	of_node_put(np);
9c140d9926761b0 Anson Huang 2020-01-08  440  	if (WARN_ON(!anatop_base))
9c140d9926761b0 Anson Huang 2020-01-08  441  		return -ENOMEM;
9c140d9926761b0 Anson Huang 2020-01-08  442  
9c140d9926761b0 Anson Huang 2020-01-08  443  	np = dev->of_node;
9c140d9926761b0 Anson Huang 2020-01-08  444  	ccm_base = devm_platform_ioremap_resource(pdev, 0);
9c140d9926761b0 Anson Huang 2020-01-08  445  	if (WARN_ON(IS_ERR(ccm_base))) {
9c140d9926761b0 Anson Huang 2020-01-08 @446  		iounmap(anatop_base);
9c140d9926761b0 Anson Huang 2020-01-08  447  		return PTR_ERR(ccm_base);
9c140d9926761b0 Anson Huang 2020-01-08  448  	}
9c140d9926761b0 Anson Huang 2020-01-08  449  
9c140d9926761b0 Anson Huang 2020-01-08  450  	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws, IMX8MP_CLK_END), GFP_KERNEL);
9c140d9926761b0 Anson Huang 2020-01-08  451  	if (WARN_ON(!clk_hw_data)) {
9c140d9926761b0 Anson Huang 2020-01-08  452  		iounmap(anatop_base);
9c140d9926761b0 Anson Huang 2020-01-08  453  		return -ENOMEM;
9c140d9926761b0 Anson Huang 2020-01-08  454  	}
9c140d9926761b0 Anson Huang 2020-01-08  455  
9c140d9926761b0 Anson Huang 2020-01-08  456  	clk_hw_data->num = IMX8MP_CLK_END;
9c140d9926761b0 Anson Huang 2020-01-08  457  	hws = clk_hw_data->hws;
9c140d9926761b0 Anson Huang 2020-01-08  458  
9c140d9926761b0 Anson Huang 2020-01-08  459  	hws[IMX8MP_CLK_DUMMY] = imx_clk_hw_fixed("dummy", 0);
9c140d9926761b0 Anson Huang 2020-01-08  460  	hws[IMX8MP_CLK_24M] = imx_obtain_fixed_clk_hw(np, "osc_24m");
9c140d9926761b0 Anson Huang 2020-01-08  461  	hws[IMX8MP_CLK_32K] = imx_obtain_fixed_clk_hw(np, "osc_32k");
9c140d9926761b0 Anson Huang 2020-01-08  462  	hws[IMX8MP_CLK_EXT1] = imx_obtain_fixed_clk_hw(np, "clk_ext1");
9c140d9926761b0 Anson Huang 2020-01-08  463  	hws[IMX8MP_CLK_EXT2] = imx_obtain_fixed_clk_hw(np, "clk_ext2");
9c140d9926761b0 Anson Huang 2020-01-08  464  	hws[IMX8MP_CLK_EXT3] = imx_obtain_fixed_clk_hw(np, "clk_ext3");
9c140d9926761b0 Anson Huang 2020-01-08  465  	hws[IMX8MP_CLK_EXT4] = imx_obtain_fixed_clk_hw(np, "clk_ext4");
9c140d9926761b0 Anson Huang 2020-01-08  466  
9c140d9926761b0 Anson Huang 2020-01-08  467  	hws[IMX8MP_AUDIO_PLL1_REF_SEL] = imx_clk_hw_mux("audio_pll1_ref_sel", anatop_base + 0x0, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
9c140d9926761b0 Anson Huang 2020-01-08  468  	hws[IMX8MP_AUDIO_PLL2_REF_SEL] = imx_clk_hw_mux("audio_pll2_ref_sel", anatop_base + 0x14, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
9c140d9926761b0 Anson Huang 2020-01-08  469  	hws[IMX8MP_VIDEO_PLL1_REF_SEL] = imx_clk_hw_mux("video_pll1_ref_sel", anatop_base + 0x28, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
9c140d9926761b0 Anson Huang 2020-01-08  470  	hws[IMX8MP_DRAM_PLL_REF_SEL] = imx_clk_hw_mux("dram_pll_ref_sel", anatop_base + 0x50, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
9c140d9926761b0 Anson Huang 2020-01-08  471  	hws[IMX8MP_GPU_PLL_REF_SEL] = imx_clk_hw_mux("gpu_pll_ref_sel", anatop_base + 0x64, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
9c140d9926761b0 Anson Huang 2020-01-08  472  	hws[IMX8MP_VPU_PLL_REF_SEL] = imx_clk_hw_mux("vpu_pll_ref_sel", anatop_base + 0x74, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
9c140d9926761b0 Anson Huang 2020-01-08  473  	hws[IMX8MP_ARM_PLL_REF_SEL] = imx_clk_hw_mux("arm_pll_ref_sel", anatop_base + 0x84, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
9c140d9926761b0 Anson Huang 2020-01-08  474  	hws[IMX8MP_SYS_PLL1_REF_SEL] = imx_clk_hw_mux("sys_pll1_ref_sel", anatop_base + 0x94, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
9c140d9926761b0 Anson Huang 2020-01-08  475  	hws[IMX8MP_SYS_PLL2_REF_SEL] = imx_clk_hw_mux("sys_pll2_ref_sel", anatop_base + 0x104, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
9c140d9926761b0 Anson Huang 2020-01-08  476  	hws[IMX8MP_SYS_PLL3_REF_SEL] = imx_clk_hw_mux("sys_pll3_ref_sel", anatop_base + 0x114, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
9c140d9926761b0 Anson Huang 2020-01-08  477  
9c140d9926761b0 Anson Huang 2020-01-08  478  	hws[IMX8MP_AUDIO_PLL1] = imx_clk_hw_pll14xx("audio_pll1", "audio_pll1_ref_sel", anatop_base, &imx_1443x_pll);
9c140d9926761b0 Anson Huang 2020-01-08  479  	hws[IMX8MP_AUDIO_PLL2] = imx_clk_hw_pll14xx("audio_pll2", "audio_pll2_ref_sel", anatop_base + 0x14, &imx_1443x_pll);
9c140d9926761b0 Anson Huang 2020-01-08  480  	hws[IMX8MP_VIDEO_PLL1] = imx_clk_hw_pll14xx("video_pll1", "video_pll1_ref_sel", anatop_base + 0x28, &imx_1443x_pll);
9c140d9926761b0 Anson Huang 2020-01-08  481  	hws[IMX8MP_DRAM_PLL] = imx_clk_hw_pll14xx("dram_pll", "dram_pll_ref_sel", anatop_base + 0x50, &imx_1443x_dram_pll);
9c140d9926761b0 Anson Huang 2020-01-08  482  	hws[IMX8MP_GPU_PLL] = imx_clk_hw_pll14xx("gpu_pll", "gpu_pll_ref_sel", anatop_base + 0x64, &imx_1416x_pll);
9c140d9926761b0 Anson Huang 2020-01-08  483  	hws[IMX8MP_VPU_PLL] = imx_clk_hw_pll14xx("vpu_pll", "vpu_pll_ref_sel", anatop_base + 0x74, &imx_1416x_pll);
9c140d9926761b0 Anson Huang 2020-01-08  484  	hws[IMX8MP_ARM_PLL] = imx_clk_hw_pll14xx("arm_pll", "arm_pll_ref_sel", anatop_base + 0x84, &imx_1416x_pll);
9c140d9926761b0 Anson Huang 2020-01-08  485  	hws[IMX8MP_SYS_PLL1] = imx_clk_hw_pll14xx("sys_pll1", "sys_pll1_ref_sel", anatop_base + 0x94, &imx_1416x_pll);
9c140d9926761b0 Anson Huang 2020-01-08  486  	hws[IMX8MP_SYS_PLL2] = imx_clk_hw_pll14xx("sys_pll2", "sys_pll2_ref_sel", anatop_base + 0x104, &imx_1416x_pll);
9c140d9926761b0 Anson Huang 2020-01-08  487  	hws[IMX8MP_SYS_PLL3] = imx_clk_hw_pll14xx("sys_pll3", "sys_pll3_ref_sel", anatop_base + 0x114, &imx_1416x_pll);
9c140d9926761b0 Anson Huang 2020-01-08  488  
dc6e21da3402976 Peng Fan    2020-05-07  489  	hws[IMX8MP_AUDIO_PLL1_BYPASS] = imx_clk_hw_mux_flags("audio_pll1_bypass", anatop_base, 16, 1, audio_pll1_bypass_sels, ARRAY_SIZE(audio_pll1_bypass_sels), CLK_SET_RATE_PARENT);
dc6e21da3402976 Peng Fan    2020-05-07  490  	hws[IMX8MP_AUDIO_PLL2_BYPASS] = imx_clk_hw_mux_flags("audio_pll2_bypass", anatop_base + 0x14, 16, 1, audio_pll2_bypass_sels, ARRAY_SIZE(audio_pll2_bypass_sels), CLK_SET_RATE_PARENT);
dc6e21da3402976 Peng Fan    2020-05-07  491  	hws[IMX8MP_VIDEO_PLL1_BYPASS] = imx_clk_hw_mux_flags("video_pll1_bypass", anatop_base + 0x28, 16, 1, video_pll1_bypass_sels, ARRAY_SIZE(video_pll1_bypass_sels), CLK_SET_RATE_PARENT);
dc6e21da3402976 Peng Fan    2020-05-07  492  	hws[IMX8MP_DRAM_PLL_BYPASS] = imx_clk_hw_mux_flags("dram_pll_bypass", anatop_base + 0x50, 16, 1, dram_pll_bypass_sels, ARRAY_SIZE(dram_pll_bypass_sels), CLK_SET_RATE_PARENT);
dc6e21da3402976 Peng Fan    2020-05-07  493  	hws[IMX8MP_GPU_PLL_BYPASS] = imx_clk_hw_mux_flags("gpu_pll_bypass", anatop_base + 0x64, 28, 1, gpu_pll_bypass_sels, ARRAY_SIZE(gpu_pll_bypass_sels), CLK_SET_RATE_PARENT);
dc6e21da3402976 Peng Fan    2020-05-07  494  	hws[IMX8MP_VPU_PLL_BYPASS] = imx_clk_hw_mux_flags("vpu_pll_bypass", anatop_base + 0x74, 28, 1, vpu_pll_bypass_sels, ARRAY_SIZE(vpu_pll_bypass_sels), CLK_SET_RATE_PARENT);
dc6e21da3402976 Peng Fan    2020-05-07  495  	hws[IMX8MP_ARM_PLL_BYPASS] = imx_clk_hw_mux_flags("arm_pll_bypass", anatop_base + 0x84, 28, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels), CLK_SET_RATE_PARENT);
dc6e21da3402976 Peng Fan    2020-05-07  496  	hws[IMX8MP_SYS_PLL1_BYPASS] = imx_clk_hw_mux_flags("sys_pll1_bypass", anatop_base + 0x94, 28, 1, sys_pll1_bypass_sels, ARRAY_SIZE(sys_pll1_bypass_sels), CLK_SET_RATE_PARENT);
dc6e21da3402976 Peng Fan    2020-05-07  497  	hws[IMX8MP_SYS_PLL2_BYPASS] = imx_clk_hw_mux_flags("sys_pll2_bypass", anatop_base + 0x104, 28, 1, sys_pll2_bypass_sels, ARRAY_SIZE(sys_pll2_bypass_sels), CLK_SET_RATE_PARENT);
dc6e21da3402976 Peng Fan    2020-05-07  498  	hws[IMX8MP_SYS_PLL3_BYPASS] = imx_clk_hw_mux_flags("sys_pll3_bypass", anatop_base + 0x114, 28, 1, sys_pll3_bypass_sels, ARRAY_SIZE(sys_pll3_bypass_sels), CLK_SET_RATE_PARENT);
9c140d9926761b0 Anson Huang 2020-01-08  499  
9c140d9926761b0 Anson Huang 2020-01-08  500  	hws[IMX8MP_AUDIO_PLL1_OUT] = imx_clk_hw_gate("audio_pll1_out", "audio_pll1_bypass", anatop_base, 13);
9c140d9926761b0 Anson Huang 2020-01-08  501  	hws[IMX8MP_AUDIO_PLL2_OUT] = imx_clk_hw_gate("audio_pll2_out", "audio_pll2_bypass", anatop_base + 0x14, 13);
9c140d9926761b0 Anson Huang 2020-01-08  502  	hws[IMX8MP_VIDEO_PLL1_OUT] = imx_clk_hw_gate("video_pll1_out", "video_pll1_bypass", anatop_base + 0x28, 13);
9c140d9926761b0 Anson Huang 2020-01-08  503  	hws[IMX8MP_DRAM_PLL_OUT] = imx_clk_hw_gate("dram_pll_out", "dram_pll_bypass", anatop_base + 0x50, 13);
9c140d9926761b0 Anson Huang 2020-01-08  504  	hws[IMX8MP_GPU_PLL_OUT] = imx_clk_hw_gate("gpu_pll_out", "gpu_pll_bypass", anatop_base + 0x64, 11);
9c140d9926761b0 Anson Huang 2020-01-08  505  	hws[IMX8MP_VPU_PLL_OUT] = imx_clk_hw_gate("vpu_pll_out", "vpu_pll_bypass", anatop_base + 0x74, 11);
9c140d9926761b0 Anson Huang 2020-01-08  506  	hws[IMX8MP_ARM_PLL_OUT] = imx_clk_hw_gate("arm_pll_out", "arm_pll_bypass", anatop_base + 0x84, 11);
9c140d9926761b0 Anson Huang 2020-01-08  507  	hws[IMX8MP_SYS_PLL3_OUT] = imx_clk_hw_gate("sys_pll3_out", "sys_pll3_bypass", anatop_base + 0x114, 11);
9c140d9926761b0 Anson Huang 2020-01-08  508  
77f5d2d97353149 Peng Fan    2020-05-07  509  	hws[IMX8MP_SYS_PLL1_40M_CG] = imx_clk_hw_gate("sys_pll1_40m_cg", "sys_pll1_bypass", anatop_base + 0x94, 27);
77f5d2d97353149 Peng Fan    2020-05-07  510  	hws[IMX8MP_SYS_PLL1_80M_CG] = imx_clk_hw_gate("sys_pll1_80m_cg", "sys_pll1_bypass", anatop_base + 0x94, 25);
77f5d2d97353149 Peng Fan    2020-05-07  511  	hws[IMX8MP_SYS_PLL1_100M_CG] = imx_clk_hw_gate("sys_pll1_100m_cg", "sys_pll1_bypass", anatop_base + 0x94, 23);
77f5d2d97353149 Peng Fan    2020-05-07  512  	hws[IMX8MP_SYS_PLL1_133M_CG] = imx_clk_hw_gate("sys_pll1_133m_cg", "sys_pll1_bypass", anatop_base + 0x94, 21);
77f5d2d97353149 Peng Fan    2020-05-07  513  	hws[IMX8MP_SYS_PLL1_160M_CG] = imx_clk_hw_gate("sys_pll1_160m_cg", "sys_pll1_bypass", anatop_base + 0x94, 19);
77f5d2d97353149 Peng Fan    2020-05-07  514  	hws[IMX8MP_SYS_PLL1_200M_CG] = imx_clk_hw_gate("sys_pll1_200m_cg", "sys_pll1_bypass", anatop_base + 0x94, 17);
77f5d2d97353149 Peng Fan    2020-05-07  515  	hws[IMX8MP_SYS_PLL1_266M_CG] = imx_clk_hw_gate("sys_pll1_266m_cg", "sys_pll1_bypass", anatop_base + 0x94, 15);
77f5d2d97353149 Peng Fan    2020-05-07  516  	hws[IMX8MP_SYS_PLL1_400M_CG] = imx_clk_hw_gate("sys_pll1_400m_cg", "sys_pll1_bypass", anatop_base + 0x94, 13);
77f5d2d97353149 Peng Fan    2020-05-07  517  	hws[IMX8MP_SYS_PLL1_OUT] = imx_clk_hw_gate("sys_pll1_out", "sys_pll1_bypass", anatop_base + 0x94, 11);
77f5d2d97353149 Peng Fan    2020-05-07  518  
77f5d2d97353149 Peng Fan    2020-05-07  519  	hws[IMX8MP_SYS_PLL1_40M] = imx_clk_hw_fixed_factor("sys_pll1_40m", "sys_pll1_40m_cg", 1, 20);
77f5d2d97353149 Peng Fan    2020-05-07  520  	hws[IMX8MP_SYS_PLL1_80M] = imx_clk_hw_fixed_factor("sys_pll1_80m", "sys_pll1_80m_cg", 1, 10);
77f5d2d97353149 Peng Fan    2020-05-07  521  	hws[IMX8MP_SYS_PLL1_100M] = imx_clk_hw_fixed_factor("sys_pll1_100m", "sys_pll1_100m_cg", 1, 8);
77f5d2d97353149 Peng Fan    2020-05-07  522  	hws[IMX8MP_SYS_PLL1_133M] = imx_clk_hw_fixed_factor("sys_pll1_133m", "sys_pll1_133m_cg", 1, 6);
77f5d2d97353149 Peng Fan    2020-05-07  523  	hws[IMX8MP_SYS_PLL1_160M] = imx_clk_hw_fixed_factor("sys_pll1_160m", "sys_pll1_160m_cg", 1, 5);
77f5d2d97353149 Peng Fan    2020-05-07  524  	hws[IMX8MP_SYS_PLL1_200M] = imx_clk_hw_fixed_factor("sys_pll1_200m", "sys_pll1_200m_cg", 1, 4);
77f5d2d97353149 Peng Fan    2020-05-07  525  	hws[IMX8MP_SYS_PLL1_266M] = imx_clk_hw_fixed_factor("sys_pll1_266m", "sys_pll1_266m_cg", 1, 3);
77f5d2d97353149 Peng Fan    2020-05-07  526  	hws[IMX8MP_SYS_PLL1_400M] = imx_clk_hw_fixed_factor("sys_pll1_400m", "sys_pll1_400m_cg", 1, 2);
9c140d9926761b0 Anson Huang 2020-01-08  527  	hws[IMX8MP_SYS_PLL1_800M] = imx_clk_hw_fixed_factor("sys_pll1_800m", "sys_pll1_out", 1, 1);
9c140d9926761b0 Anson Huang 2020-01-08  528  
77f5d2d97353149 Peng Fan    2020-05-07  529  	hws[IMX8MP_SYS_PLL2_50M_CG] = imx_clk_hw_gate("sys_pll2_50m_cg", "sys_pll2_bypass", anatop_base + 0x104, 27);
77f5d2d97353149 Peng Fan    2020-05-07  530  	hws[IMX8MP_SYS_PLL2_100M_CG] = imx_clk_hw_gate("sys_pll2_100m_cg", "sys_pll2_bypass", anatop_base + 0x104, 25);
77f5d2d97353149 Peng Fan    2020-05-07  531  	hws[IMX8MP_SYS_PLL2_125M_CG] = imx_clk_hw_gate("sys_pll2_125m_cg", "sys_pll2_bypass", anatop_base + 0x104, 23);
77f5d2d97353149 Peng Fan    2020-05-07  532  	hws[IMX8MP_SYS_PLL2_166M_CG] = imx_clk_hw_gate("sys_pll2_166m_cg", "sys_pll2_bypass", anatop_base + 0x104, 21);
77f5d2d97353149 Peng Fan    2020-05-07  533  	hws[IMX8MP_SYS_PLL2_200M_CG] = imx_clk_hw_gate("sys_pll2_200m_cg", "sys_pll2_bypass", anatop_base + 0x104, 19);
77f5d2d97353149 Peng Fan    2020-05-07  534  	hws[IMX8MP_SYS_PLL2_250M_CG] = imx_clk_hw_gate("sys_pll2_250m_cg", "sys_pll2_bypass", anatop_base + 0x104, 17);
77f5d2d97353149 Peng Fan    2020-05-07  535  	hws[IMX8MP_SYS_PLL2_333M_CG] = imx_clk_hw_gate("sys_pll2_333m_cg", "sys_pll2_bypass", anatop_base + 0x104, 15);
77f5d2d97353149 Peng Fan    2020-05-07  536  	hws[IMX8MP_SYS_PLL2_500M_CG] = imx_clk_hw_gate("sys_pll2_500m_cg", "sys_pll2_bypass", anatop_base + 0x104, 13);
77f5d2d97353149 Peng Fan    2020-05-07  537  	hws[IMX8MP_SYS_PLL2_OUT] = imx_clk_hw_gate("sys_pll2_out", "sys_pll2_bypass", anatop_base + 0x104, 11);
77f5d2d97353149 Peng Fan    2020-05-07  538  
77f5d2d97353149 Peng Fan    2020-05-07  539  	hws[IMX8MP_SYS_PLL2_50M] = imx_clk_hw_fixed_factor("sys_pll2_50m", "sys_pll2_50m_cg", 1, 20);
77f5d2d97353149 Peng Fan    2020-05-07  540  	hws[IMX8MP_SYS_PLL2_100M] = imx_clk_hw_fixed_factor("sys_pll2_100m", "sys_pll2_100m_cg", 1, 10);
77f5d2d97353149 Peng Fan    2020-05-07  541  	hws[IMX8MP_SYS_PLL2_125M] = imx_clk_hw_fixed_factor("sys_pll2_125m", "sys_pll2_125m_cg", 1, 8);
77f5d2d97353149 Peng Fan    2020-05-07  542  	hws[IMX8MP_SYS_PLL2_166M] = imx_clk_hw_fixed_factor("sys_pll2_166m", "sys_pll2_166m_cg", 1, 6);
77f5d2d97353149 Peng Fan    2020-05-07  543  	hws[IMX8MP_SYS_PLL2_200M] = imx_clk_hw_fixed_factor("sys_pll2_200m", "sys_pll2_200m_cg", 1, 5);
77f5d2d97353149 Peng Fan    2020-05-07  544  	hws[IMX8MP_SYS_PLL2_250M] = imx_clk_hw_fixed_factor("sys_pll2_250m", "sys_pll2_250m_cg", 1, 4);
77f5d2d97353149 Peng Fan    2020-05-07  545  	hws[IMX8MP_SYS_PLL2_333M] = imx_clk_hw_fixed_factor("sys_pll2_333m", "sys_pll2_333m_cg", 1, 3);
77f5d2d97353149 Peng Fan    2020-05-07  546  	hws[IMX8MP_SYS_PLL2_500M] = imx_clk_hw_fixed_factor("sys_pll2_500m", "sys_pll2_500m_cg", 1, 2);
9c140d9926761b0 Anson Huang 2020-01-08  547  	hws[IMX8MP_SYS_PLL2_1000M] = imx_clk_hw_fixed_factor("sys_pll2_1000m", "sys_pll2_out", 1, 1);
9c140d9926761b0 Anson Huang 2020-01-08  548  
8c83a8ff4dd9287 Peng Fan    2020-05-07  549  	hws[IMX8MP_CLK_A53_DIV] = imx8m_clk_hw_composite_core("arm_a53_div", imx8mp_a53_sels, ccm_base + 0x8000);
8c83a8ff4dd9287 Peng Fan    2020-05-07  550  	hws[IMX8MP_CLK_A53_SRC] = hws[IMX8MP_CLK_A53_DIV];
8c83a8ff4dd9287 Peng Fan    2020-05-07  551  	hws[IMX8MP_CLK_A53_CG] = hws[IMX8MP_CLK_A53_DIV];
8c83a8ff4dd9287 Peng Fan    2020-05-07  552  	hws[IMX8MP_CLK_M7_CORE] = imx8m_clk_hw_composite_core("m7_core", imx8mp_m7_sels, ccm_base + 0x8080);
8c83a8ff4dd9287 Peng Fan    2020-05-07  553  	hws[IMX8MP_CLK_ML_CORE] = imx8m_clk_hw_composite_core("ml_core", imx8mp_ml_sels, ccm_base + 0x8100);
8c83a8ff4dd9287 Peng Fan    2020-05-07  554  	hws[IMX8MP_CLK_GPU3D_CORE] = imx8m_clk_hw_composite_core("gpu3d_core", imx8mp_gpu3d_core_sels, ccm_base + 0x8180);
8c83a8ff4dd9287 Peng Fan    2020-05-07  555  	hws[IMX8MP_CLK_GPU3D_SHADER_CORE] = imx8m_clk_hw_composite("gpu3d_shader_core", imx8mp_gpu3d_shader_sels, ccm_base + 0x8200);
8c83a8ff4dd9287 Peng Fan    2020-05-07  556  	hws[IMX8MP_CLK_GPU2D_CORE] = imx8m_clk_hw_composite("gpu2d_core", imx8mp_gpu2d_sels, ccm_base + 0x8280);
8c83a8ff4dd9287 Peng Fan    2020-05-07  557  	hws[IMX8MP_CLK_AUDIO_AXI] = imx8m_clk_hw_composite("audio_axi", imx8mp_audio_axi_sels, ccm_base + 0x8300);
8c83a8ff4dd9287 Peng Fan    2020-05-07  558  	hws[IMX8MP_CLK_AUDIO_AXI_SRC] = hws[IMX8MP_CLK_AUDIO_AXI];
8c83a8ff4dd9287 Peng Fan    2020-05-07  559  	hws[IMX8MP_CLK_HSIO_AXI] = imx8m_clk_hw_composite("hsio_axi", imx8mp_hsio_axi_sels, ccm_base + 0x8380);
8c83a8ff4dd9287 Peng Fan    2020-05-07  560  	hws[IMX8MP_CLK_MEDIA_ISP] = imx8m_clk_hw_composite("media_isp", imx8mp_media_isp_sels, ccm_base + 0x8400);
9c140d9926761b0 Anson Huang 2020-01-08  561  
7ab227210110a41 Peng Fan    2020-02-19  562  	/* CORE SEL */
0d77abc4fc31e03 Anson Huang 2020-02-25  563  	hws[IMX8MP_CLK_A53_CORE] = imx_clk_hw_mux2("arm_a53_core", ccm_base + 0x9880, 24, 1, imx8mp_a53_core_sels, ARRAY_SIZE(imx8mp_a53_core_sels));
7ab227210110a41 Peng Fan    2020-02-19  564  
9c140d9926761b0 Anson Huang 2020-01-08  565  	hws[IMX8MP_CLK_MAIN_AXI] = imx8m_clk_hw_composite_critical("main_axi", imx8mp_main_axi_sels, ccm_base + 0x8800);
b1657ad708f761f Peng Fan    2020-05-07  566  	hws[IMX8MP_CLK_ENET_AXI] = imx8m_clk_hw_composite_bus("enet_axi", imx8mp_enet_axi_sels, ccm_base + 0x8880);
9c140d9926761b0 Anson Huang 2020-01-08  567  	hws[IMX8MP_CLK_NAND_USDHC_BUS] = imx8m_clk_hw_composite_critical("nand_usdhc_bus", imx8mp_nand_usdhc_sels, ccm_base + 0x8900);
b1657ad708f761f Peng Fan    2020-05-07  568  	hws[IMX8MP_CLK_VPU_BUS] = imx8m_clk_hw_composite_bus("vpu_bus", imx8mp_vpu_bus_sels, ccm_base + 0x8980);
b1657ad708f761f Peng Fan    2020-05-07  569  	hws[IMX8MP_CLK_MEDIA_AXI] = imx8m_clk_hw_composite_bus("media_axi", imx8mp_media_axi_sels, ccm_base + 0x8a00);
b1657ad708f761f Peng Fan    2020-05-07  570  	hws[IMX8MP_CLK_MEDIA_APB] = imx8m_clk_hw_composite_bus("media_apb", imx8mp_media_apb_sels, ccm_base + 0x8a80);
b1657ad708f761f Peng Fan    2020-05-07  571  	hws[IMX8MP_CLK_HDMI_APB] = imx8m_clk_hw_composite_bus("hdmi_apb", imx8mp_media_apb_sels, ccm_base + 0x8b00);
b1657ad708f761f Peng Fan    2020-05-07  572  	hws[IMX8MP_CLK_HDMI_AXI] = imx8m_clk_hw_composite_bus("hdmi_axi", imx8mp_media_axi_sels, ccm_base + 0x8b80);
b1657ad708f761f Peng Fan    2020-05-07  573  	hws[IMX8MP_CLK_GPU_AXI] = imx8m_clk_hw_composite_bus("gpu_axi", imx8mp_gpu_axi_sels, ccm_base + 0x8c00);
b1657ad708f761f Peng Fan    2020-05-07  574  	hws[IMX8MP_CLK_GPU_AHB] = imx8m_clk_hw_composite_bus("gpu_ahb", imx8mp_gpu_ahb_sels, ccm_base + 0x8c80);
9c140d9926761b0 Anson Huang 2020-01-08  575  	hws[IMX8MP_CLK_NOC] = imx8m_clk_hw_composite_critical("noc", imx8mp_noc_sels, ccm_base + 0x8d00);
9c140d9926761b0 Anson Huang 2020-01-08  576  	hws[IMX8MP_CLK_NOC_IO] = imx8m_clk_hw_composite_critical("noc_io", imx8mp_noc_io_sels, ccm_base + 0x8d80);
b1657ad708f761f Peng Fan    2020-05-07  577  	hws[IMX8MP_CLK_ML_AXI] = imx8m_clk_hw_composite_bus("ml_axi", imx8mp_ml_axi_sels, ccm_base + 0x8e00);
b1657ad708f761f Peng Fan    2020-05-07  578  	hws[IMX8MP_CLK_ML_AHB] = imx8m_clk_hw_composite_bus("ml_ahb", imx8mp_ml_ahb_sels, ccm_base + 0x8e80);
9c140d9926761b0 Anson Huang 2020-01-08  579  
9c140d9926761b0 Anson Huang 2020-01-08  580  	hws[IMX8MP_CLK_AHB] = imx8m_clk_hw_composite_critical("ahb_root", imx8mp_ahb_sels, ccm_base + 0x9000);
b1657ad708f761f Peng Fan    2020-05-07  581  	hws[IMX8MP_CLK_AUDIO_AHB] = imx8m_clk_hw_composite_bus("audio_ahb", imx8mp_audio_ahb_sels, ccm_base + 0x9100);
b1657ad708f761f Peng Fan    2020-05-07  582  	hws[IMX8MP_CLK_MIPI_DSI_ESC_RX] = imx8m_clk_hw_composite_bus("mipi_dsi_esc_rx", imx8mp_mipi_dsi_esc_rx_sels, ccm_base + 0x9200);
9c140d9926761b0 Anson Huang 2020-01-08  583  
9c140d9926761b0 Anson Huang 2020-01-08  584  	hws[IMX8MP_CLK_IPG_ROOT] = imx_clk_hw_divider2("ipg_root", "ahb_root", ccm_base + 0x9080, 0, 1);
9c140d9926761b0 Anson Huang 2020-01-08  585  	hws[IMX8MP_CLK_IPG_AUDIO_ROOT] = imx_clk_hw_divider2("ipg_audio_root", "audio_ahb", ccm_base + 0x9180, 0, 1);
9c140d9926761b0 Anson Huang 2020-01-08  586  
9c140d9926761b0 Anson Huang 2020-01-08  587  	hws[IMX8MP_CLK_DRAM_ALT] = imx8m_clk_hw_composite("dram_alt", imx8mp_dram_alt_sels, ccm_base + 0xa000);
9c140d9926761b0 Anson Huang 2020-01-08  588  	hws[IMX8MP_CLK_DRAM_APB] = imx8m_clk_hw_composite_critical("dram_apb", imx8mp_dram_apb_sels, ccm_base + 0xa080);
9c140d9926761b0 Anson Huang 2020-01-08  589  	hws[IMX8MP_CLK_VPU_G1] = imx8m_clk_hw_composite("vpu_g1", imx8mp_vpu_g1_sels, ccm_base + 0xa100);
9c140d9926761b0 Anson Huang 2020-01-08  590  	hws[IMX8MP_CLK_VPU_G2] = imx8m_clk_hw_composite("vpu_g2", imx8mp_vpu_g2_sels, ccm_base + 0xa180);
9c140d9926761b0 Anson Huang 2020-01-08  591  	hws[IMX8MP_CLK_CAN1] = imx8m_clk_hw_composite("can1", imx8mp_can1_sels, ccm_base + 0xa200);
9c140d9926761b0 Anson Huang 2020-01-08  592  	hws[IMX8MP_CLK_CAN2] = imx8m_clk_hw_composite("can2", imx8mp_can2_sels, ccm_base + 0xa280);
9c140d9926761b0 Anson Huang 2020-01-08  593  	hws[IMX8MP_CLK_MEMREPAIR] = imx8m_clk_hw_composite("memrepair", imx8mp_memrepair_sels, ccm_base + 0xa300);
9c140d9926761b0 Anson Huang 2020-01-08  594  	hws[IMX8MP_CLK_PCIE_PHY] = imx8m_clk_hw_composite("pcie_phy", imx8mp_pcie_phy_sels, ccm_base + 0xa380);
9c140d9926761b0 Anson Huang 2020-01-08  595  	hws[IMX8MP_CLK_PCIE_AUX] = imx8m_clk_hw_composite("pcie_aux", imx8mp_pcie_aux_sels, ccm_base + 0xa400);
9c140d9926761b0 Anson Huang 2020-01-08  596  	hws[IMX8MP_CLK_I2C5] = imx8m_clk_hw_composite("i2c5", imx8mp_i2c5_sels, ccm_base + 0xa480);
9c140d9926761b0 Anson Huang 2020-01-08  597  	hws[IMX8MP_CLK_I2C6] = imx8m_clk_hw_composite("i2c6", imx8mp_i2c6_sels, ccm_base + 0xa500);
9c140d9926761b0 Anson Huang 2020-01-08  598  	hws[IMX8MP_CLK_SAI1] = imx8m_clk_hw_composite("sai1", imx8mp_sai1_sels, ccm_base + 0xa580);
9c140d9926761b0 Anson Huang 2020-01-08  599  	hws[IMX8MP_CLK_SAI2] = imx8m_clk_hw_composite("sai2", imx8mp_sai2_sels, ccm_base + 0xa600);
9c140d9926761b0 Anson Huang 2020-01-08  600  	hws[IMX8MP_CLK_SAI3] = imx8m_clk_hw_composite("sai3", imx8mp_sai3_sels, ccm_base + 0xa680);
9c140d9926761b0 Anson Huang 2020-01-08  601  	hws[IMX8MP_CLK_SAI4] = imx8m_clk_hw_composite("sai4", imx8mp_sai4_sels, ccm_base + 0xa700);
9c140d9926761b0 Anson Huang 2020-01-08  602  	hws[IMX8MP_CLK_SAI5] = imx8m_clk_hw_composite("sai5", imx8mp_sai5_sels, ccm_base + 0xa780);
9c140d9926761b0 Anson Huang 2020-01-08  603  	hws[IMX8MP_CLK_SAI6] = imx8m_clk_hw_composite("sai6", imx8mp_sai6_sels, ccm_base + 0xa800);
9c140d9926761b0 Anson Huang 2020-01-08  604  	hws[IMX8MP_CLK_ENET_QOS] = imx8m_clk_hw_composite("enet_qos", imx8mp_enet_qos_sels, ccm_base + 0xa880);
9c140d9926761b0 Anson Huang 2020-01-08  605  	hws[IMX8MP_CLK_ENET_QOS_TIMER] = imx8m_clk_hw_composite("enet_qos_timer", imx8mp_enet_qos_timer_sels, ccm_base + 0xa900);
9c140d9926761b0 Anson Huang 2020-01-08  606  	hws[IMX8MP_CLK_ENET_REF] = imx8m_clk_hw_composite("enet_ref", imx8mp_enet_ref_sels, ccm_base + 0xa980);
9c140d9926761b0 Anson Huang 2020-01-08  607  	hws[IMX8MP_CLK_ENET_TIMER] = imx8m_clk_hw_composite("enet_timer", imx8mp_enet_timer_sels, ccm_base + 0xaa00);
9c140d9926761b0 Anson Huang 2020-01-08  608  	hws[IMX8MP_CLK_ENET_PHY_REF] = imx8m_clk_hw_composite("enet_phy_ref", imx8mp_enet_phy_ref_sels, ccm_base + 0xaa80);
9c140d9926761b0 Anson Huang 2020-01-08  609  	hws[IMX8MP_CLK_NAND] = imx8m_clk_hw_composite("nand", imx8mp_nand_sels, ccm_base + 0xab00);
9c140d9926761b0 Anson Huang 2020-01-08  610  	hws[IMX8MP_CLK_QSPI] = imx8m_clk_hw_composite("qspi", imx8mp_qspi_sels, ccm_base + 0xab80);
9c140d9926761b0 Anson Huang 2020-01-08  611  	hws[IMX8MP_CLK_USDHC1] = imx8m_clk_hw_composite("usdhc1", imx8mp_usdhc1_sels, ccm_base + 0xac00);
9c140d9926761b0 Anson Huang 2020-01-08  612  	hws[IMX8MP_CLK_USDHC2] = imx8m_clk_hw_composite("usdhc2", imx8mp_usdhc2_sels, ccm_base + 0xac80);
9c140d9926761b0 Anson Huang 2020-01-08  613  	hws[IMX8MP_CLK_I2C1] = imx8m_clk_hw_composite("i2c1", imx8mp_i2c1_sels, ccm_base + 0xad00);
9c140d9926761b0 Anson Huang 2020-01-08  614  	hws[IMX8MP_CLK_I2C2] = imx8m_clk_hw_composite("i2c2", imx8mp_i2c2_sels, ccm_base + 0xad80);
9c140d9926761b0 Anson Huang 2020-01-08  615  	hws[IMX8MP_CLK_I2C3] = imx8m_clk_hw_composite("i2c3", imx8mp_i2c3_sels, ccm_base + 0xae00);
9c140d9926761b0 Anson Huang 2020-01-08  616  	hws[IMX8MP_CLK_I2C4] = imx8m_clk_hw_composite("i2c4", imx8mp_i2c4_sels, ccm_base + 0xae80);
9c140d9926761b0 Anson Huang 2020-01-08  617  
9c140d9926761b0 Anson Huang 2020-01-08  618  	hws[IMX8MP_CLK_UART1] = imx8m_clk_hw_composite("uart1", imx8mp_uart1_sels, ccm_base + 0xaf00);
9c140d9926761b0 Anson Huang 2020-01-08  619  	hws[IMX8MP_CLK_UART2] = imx8m_clk_hw_composite("uart2", imx8mp_uart2_sels, ccm_base + 0xaf80);
9c140d9926761b0 Anson Huang 2020-01-08  620  	hws[IMX8MP_CLK_UART3] = imx8m_clk_hw_composite("uart3", imx8mp_uart3_sels, ccm_base + 0xb000);
9c140d9926761b0 Anson Huang 2020-01-08  621  	hws[IMX8MP_CLK_UART4] = imx8m_clk_hw_composite("uart4", imx8mp_uart4_sels, ccm_base + 0xb080);
9c140d9926761b0 Anson Huang 2020-01-08  622  	hws[IMX8MP_CLK_USB_CORE_REF] = imx8m_clk_hw_composite("usb_core_ref", imx8mp_usb_core_ref_sels, ccm_base + 0xb100);
9c140d9926761b0 Anson Huang 2020-01-08  623  	hws[IMX8MP_CLK_USB_PHY_REF] = imx8m_clk_hw_composite("usb_phy_ref", imx8mp_usb_phy_ref_sels, ccm_base + 0xb180);
9c140d9926761b0 Anson Huang 2020-01-08  624  	hws[IMX8MP_CLK_GIC] = imx8m_clk_hw_composite_critical("gic", imx8mp_gic_sels, ccm_base + 0xb200);
9c140d9926761b0 Anson Huang 2020-01-08  625  	hws[IMX8MP_CLK_ECSPI1] = imx8m_clk_hw_composite("ecspi1", imx8mp_ecspi1_sels, ccm_base + 0xb280);
9c140d9926761b0 Anson Huang 2020-01-08  626  	hws[IMX8MP_CLK_ECSPI2] = imx8m_clk_hw_composite("ecspi2", imx8mp_ecspi2_sels, ccm_base + 0xb300);
9c140d9926761b0 Anson Huang 2020-01-08  627  	hws[IMX8MP_CLK_PWM1] = imx8m_clk_hw_composite("pwm1", imx8mp_pwm1_sels, ccm_base + 0xb380);
9c140d9926761b0 Anson Huang 2020-01-08  628  	hws[IMX8MP_CLK_PWM2] = imx8m_clk_hw_composite("pwm2", imx8mp_pwm2_sels, ccm_base + 0xb400);
9c140d9926761b0 Anson Huang 2020-01-08  629  	hws[IMX8MP_CLK_PWM3] = imx8m_clk_hw_composite("pwm3", imx8mp_pwm3_sels, ccm_base + 0xb480);
9c140d9926761b0 Anson Huang 2020-01-08  630  	hws[IMX8MP_CLK_PWM4] = imx8m_clk_hw_composite("pwm4", imx8mp_pwm4_sels, ccm_base + 0xb500);
9c140d9926761b0 Anson Huang 2020-01-08  631  
9c140d9926761b0 Anson Huang 2020-01-08  632  	hws[IMX8MP_CLK_GPT1] = imx8m_clk_hw_composite("gpt1", imx8mp_gpt1_sels, ccm_base + 0xb580);
9c140d9926761b0 Anson Huang 2020-01-08  633  	hws[IMX8MP_CLK_GPT2] = imx8m_clk_hw_composite("gpt2", imx8mp_gpt2_sels, ccm_base + 0xb600);
9c140d9926761b0 Anson Huang 2020-01-08  634  	hws[IMX8MP_CLK_GPT3] = imx8m_clk_hw_composite("gpt3", imx8mp_gpt3_sels, ccm_base + 0xb680);
9c140d9926761b0 Anson Huang 2020-01-08  635  	hws[IMX8MP_CLK_GPT4] = imx8m_clk_hw_composite("gpt4", imx8mp_gpt4_sels, ccm_base + 0xb700);
9c140d9926761b0 Anson Huang 2020-01-08  636  	hws[IMX8MP_CLK_GPT5] = imx8m_clk_hw_composite("gpt5", imx8mp_gpt5_sels, ccm_base + 0xb780);
9c140d9926761b0 Anson Huang 2020-01-08  637  	hws[IMX8MP_CLK_GPT6] = imx8m_clk_hw_composite("gpt6", imx8mp_gpt6_sels, ccm_base + 0xb800);
9c140d9926761b0 Anson Huang 2020-01-08  638  	hws[IMX8MP_CLK_WDOG] = imx8m_clk_hw_composite("wdog", imx8mp_wdog_sels, ccm_base + 0xb900);
9c140d9926761b0 Anson Huang 2020-01-08  639  	hws[IMX8MP_CLK_WRCLK] = imx8m_clk_hw_composite("wrclk", imx8mp_wrclk_sels, ccm_base + 0xb980);
9c140d9926761b0 Anson Huang 2020-01-08  640  	hws[IMX8MP_CLK_IPP_DO_CLKO1] = imx8m_clk_hw_composite("ipp_do_clko1", imx8mp_ipp_do_clko1_sels, ccm_base + 0xba00);
9c140d9926761b0 Anson Huang 2020-01-08  641  	hws[IMX8MP_CLK_IPP_DO_CLKO2] = imx8m_clk_hw_composite("ipp_do_clko2", imx8mp_ipp_do_clko2_sels, ccm_base + 0xba80);
9c140d9926761b0 Anson Huang 2020-01-08  642  	hws[IMX8MP_CLK_HDMI_FDCC_TST] = imx8m_clk_hw_composite("hdmi_fdcc_tst", imx8mp_hdmi_fdcc_tst_sels, ccm_base + 0xbb00);
c267bd443f38972 Anson Huang 2020-02-19  643  	hws[IMX8MP_CLK_HDMI_24M] = imx8m_clk_hw_composite("hdmi_24m", imx8mp_hdmi_24m_sels, ccm_base + 0xbb80);
9c140d9926761b0 Anson Huang 2020-01-08  644  	hws[IMX8MP_CLK_HDMI_REF_266M] = imx8m_clk_hw_composite("hdmi_ref_266m", imx8mp_hdmi_ref_266m_sels, ccm_base + 0xbc00);
9c140d9926761b0 Anson Huang 2020-01-08  645  	hws[IMX8MP_CLK_USDHC3] = imx8m_clk_hw_composite("usdhc3", imx8mp_usdhc3_sels, ccm_base + 0xbc80);
9c140d9926761b0 Anson Huang 2020-01-08  646  	hws[IMX8MP_CLK_MEDIA_CAM1_PIX] = imx8m_clk_hw_composite("media_cam1_pix", imx8mp_media_cam1_pix_sels, ccm_base + 0xbd00);
9c140d9926761b0 Anson Huang 2020-01-08  647  	hws[IMX8MP_CLK_MEDIA_MIPI_PHY1_REF] = imx8m_clk_hw_composite("media_mipi_phy1_ref", imx8mp_media_mipi_phy1_ref_sels, ccm_base + 0xbd80);
9c140d9926761b0 Anson Huang 2020-01-08  648  	hws[IMX8MP_CLK_MEDIA_DISP1_PIX] = imx8m_clk_hw_composite("media_disp1_pix", imx8mp_media_disp1_pix_sels, ccm_base + 0xbe00);
9c140d9926761b0 Anson Huang 2020-01-08  649  	hws[IMX8MP_CLK_MEDIA_CAM2_PIX] = imx8m_clk_hw_composite("media_cam2_pix", imx8mp_media_cam2_pix_sels, ccm_base + 0xbe80);
9c140d9926761b0 Anson Huang 2020-01-08  650  	hws[IMX8MP_CLK_MEDIA_MIPI_PHY2_REF] = imx8m_clk_hw_composite("media_mipi_phy2_ref", imx8mp_media_mipi_phy2_ref_sels, ccm_base + 0xbf00);
9c140d9926761b0 Anson Huang 2020-01-08  651  	hws[IMX8MP_CLK_MEDIA_MIPI_CSI2_ESC] = imx8m_clk_hw_composite("media_mipi_csi2_esc", imx8mp_media_mipi_csi2_esc_sels, ccm_base + 0xbf80);
9c140d9926761b0 Anson Huang 2020-01-08  652  	hws[IMX8MP_CLK_PCIE2_CTRL] = imx8m_clk_hw_composite("pcie2_ctrl", imx8mp_pcie2_ctrl_sels, ccm_base + 0xc000);
9c140d9926761b0 Anson Huang 2020-01-08  653  	hws[IMX8MP_CLK_PCIE2_PHY] = imx8m_clk_hw_composite("pcie2_phy", imx8mp_pcie2_phy_sels, ccm_base + 0xc080);
9c140d9926761b0 Anson Huang 2020-01-08  654  	hws[IMX8MP_CLK_MEDIA_MIPI_TEST_BYTE] = imx8m_clk_hw_composite("media_mipi_test_byte", imx8mp_media_mipi_test_byte_sels, ccm_base + 0xc100);
9c140d9926761b0 Anson Huang 2020-01-08  655  	hws[IMX8MP_CLK_ECSPI3] = imx8m_clk_hw_composite("ecspi3", imx8mp_ecspi3_sels, ccm_base + 0xc180);
9c140d9926761b0 Anson Huang 2020-01-08  656  	hws[IMX8MP_CLK_PDM] = imx8m_clk_hw_composite("pdm", imx8mp_pdm_sels, ccm_base + 0xc200);
9c140d9926761b0 Anson Huang 2020-01-08  657  	hws[IMX8MP_CLK_VPU_VC8000E] = imx8m_clk_hw_composite("vpu_vc8000e", imx8mp_vpu_vc8000e_sels, ccm_base + 0xc280);
9c140d9926761b0 Anson Huang 2020-01-08  658  	hws[IMX8MP_CLK_SAI7] = imx8m_clk_hw_composite("sai7", imx8mp_sai7_sels, ccm_base + 0xc300);
9c140d9926761b0 Anson Huang 2020-01-08  659  
9c140d9926761b0 Anson Huang 2020-01-08  660  	hws[IMX8MP_CLK_DRAM_ALT_ROOT] = imx_clk_hw_fixed_factor("dram_alt_root", "dram_alt", 1, 4);
9c140d9926761b0 Anson Huang 2020-01-08  661  	hws[IMX8MP_CLK_DRAM_CORE] = imx_clk_hw_mux2_flags("dram_core_clk", ccm_base + 0x9800, 24, 1, imx8mp_dram_core_sels, ARRAY_SIZE(imx8mp_dram_core_sels), CLK_IS_CRITICAL);
9c140d9926761b0 Anson Huang 2020-01-08  662  
9c140d9926761b0 Anson Huang 2020-01-08  663  	hws[IMX8MP_CLK_DRAM1_ROOT] = imx_clk_hw_gate4_flags("dram1_root_clk", "dram_core_clk", ccm_base + 0x4050, 0, CLK_IS_CRITICAL);
9c140d9926761b0 Anson Huang 2020-01-08  664  	hws[IMX8MP_CLK_ECSPI1_ROOT] = imx_clk_hw_gate4("ecspi1_root_clk", "ecspi1", ccm_base + 0x4070, 0);
9c140d9926761b0 Anson Huang 2020-01-08  665  	hws[IMX8MP_CLK_ECSPI2_ROOT] = imx_clk_hw_gate4("ecspi2_root_clk", "ecspi2", ccm_base + 0x4080, 0);
9c140d9926761b0 Anson Huang 2020-01-08  666  	hws[IMX8MP_CLK_ECSPI3_ROOT] = imx_clk_hw_gate4("ecspi3_root_clk", "ecspi3", ccm_base + 0x4090, 0);
9c140d9926761b0 Anson Huang 2020-01-08  667  	hws[IMX8MP_CLK_ENET1_ROOT] = imx_clk_hw_gate4("enet1_root_clk", "enet_axi", ccm_base + 0x40a0, 0);
9c140d9926761b0 Anson Huang 2020-01-08  668  	hws[IMX8MP_CLK_GPIO1_ROOT] = imx_clk_hw_gate4("gpio1_root_clk", "ipg_root", ccm_base + 0x40b0, 0);
9c140d9926761b0 Anson Huang 2020-01-08  669  	hws[IMX8MP_CLK_GPIO2_ROOT] = imx_clk_hw_gate4("gpio2_root_clk", "ipg_root", ccm_base + 0x40c0, 0);
9c140d9926761b0 Anson Huang 2020-01-08  670  	hws[IMX8MP_CLK_GPIO3_ROOT] = imx_clk_hw_gate4("gpio3_root_clk", "ipg_root", ccm_base + 0x40d0, 0);
9c140d9926761b0 Anson Huang 2020-01-08  671  	hws[IMX8MP_CLK_GPIO4_ROOT] = imx_clk_hw_gate4("gpio4_root_clk", "ipg_root", ccm_base + 0x40e0, 0);
9c140d9926761b0 Anson Huang 2020-01-08  672  	hws[IMX8MP_CLK_GPIO5_ROOT] = imx_clk_hw_gate4("gpio5_root_clk", "ipg_root", ccm_base + 0x40f0, 0);
9c140d9926761b0 Anson Huang 2020-01-08  673  	hws[IMX8MP_CLK_GPT1_ROOT] = imx_clk_hw_gate4("gpt1_root_clk", "gpt1", ccm_base + 0x4100, 0);
9c140d9926761b0 Anson Huang 2020-01-08  674  	hws[IMX8MP_CLK_GPT2_ROOT] = imx_clk_hw_gate4("gpt2_root_clk", "gpt2", ccm_base + 0x4110, 0);
9c140d9926761b0 Anson Huang 2020-01-08  675  	hws[IMX8MP_CLK_GPT3_ROOT] = imx_clk_hw_gate4("gpt3_root_clk", "gpt3", ccm_base + 0x4120, 0);
9c140d9926761b0 Anson Huang 2020-01-08  676  	hws[IMX8MP_CLK_GPT4_ROOT] = imx_clk_hw_gate4("gpt4_root_clk", "gpt4", ccm_base + 0x4130, 0);
9c140d9926761b0 Anson Huang 2020-01-08  677  	hws[IMX8MP_CLK_GPT5_ROOT] = imx_clk_hw_gate4("gpt5_root_clk", "gpt5", ccm_base + 0x4140, 0);
9c140d9926761b0 Anson Huang 2020-01-08  678  	hws[IMX8MP_CLK_GPT6_ROOT] = imx_clk_hw_gate4("gpt6_root_clk", "gpt6", ccm_base + 0x4150, 0);
9c140d9926761b0 Anson Huang 2020-01-08  679  	hws[IMX8MP_CLK_I2C1_ROOT] = imx_clk_hw_gate4("i2c1_root_clk", "i2c1", ccm_base + 0x4170, 0);
9c140d9926761b0 Anson Huang 2020-01-08  680  	hws[IMX8MP_CLK_I2C2_ROOT] = imx_clk_hw_gate4("i2c2_root_clk", "i2c2", ccm_base + 0x4180, 0);
9c140d9926761b0 Anson Huang 2020-01-08  681  	hws[IMX8MP_CLK_I2C3_ROOT] = imx_clk_hw_gate4("i2c3_root_clk", "i2c3", ccm_base + 0x4190, 0);
9c140d9926761b0 Anson Huang 2020-01-08  682  	hws[IMX8MP_CLK_I2C4_ROOT] = imx_clk_hw_gate4("i2c4_root_clk", "i2c4", ccm_base + 0x41a0, 0);
94ae59ac5d12cc9 Peng Fan    2020-06-01  683  	hws[IMX8MP_CLK_MU_ROOT] = imx_clk_hw_gate4("mu_root_clk", "ipg_root", ccm_base + 0x4210, 0);
14875e57d8ea965 Peng Fan    2020-01-19  684  	hws[IMX8MP_CLK_OCOTP_ROOT] = imx_clk_hw_gate4("ocotp_root_clk", "ipg_root", ccm_base + 0x4220, 0);
9c140d9926761b0 Anson Huang 2020-01-08  685  	hws[IMX8MP_CLK_PCIE_ROOT] = imx_clk_hw_gate4("pcie_root_clk", "pcie_aux", ccm_base + 0x4250, 0);
9c140d9926761b0 Anson Huang 2020-01-08  686  	hws[IMX8MP_CLK_PWM1_ROOT] = imx_clk_hw_gate4("pwm1_root_clk", "pwm1", ccm_base + 0x4280, 0);
9c140d9926761b0 Anson Huang 2020-01-08  687  	hws[IMX8MP_CLK_PWM2_ROOT] = imx_clk_hw_gate4("pwm2_root_clk", "pwm2", ccm_base + 0x4290, 0);
9c140d9926761b0 Anson Huang 2020-01-08  688  	hws[IMX8MP_CLK_PWM3_ROOT] = imx_clk_hw_gate4("pwm3_root_clk", "pwm3", ccm_base + 0x42a0, 0);
9c140d9926761b0 Anson Huang 2020-01-08  689  	hws[IMX8MP_CLK_PWM4_ROOT] = imx_clk_hw_gate4("pwm4_root_clk", "pwm4", ccm_base + 0x42b0, 0);
9c140d9926761b0 Anson Huang 2020-01-08  690  	hws[IMX8MP_CLK_QOS_ROOT] = imx_clk_hw_gate4("qos_root_clk", "ipg_root", ccm_base + 0x42c0, 0);
9c140d9926761b0 Anson Huang 2020-01-08  691  	hws[IMX8MP_CLK_QOS_ENET_ROOT] = imx_clk_hw_gate4("qos_enet_root_clk", "ipg_root", ccm_base + 0x42e0, 0);
9c140d9926761b0 Anson Huang 2020-01-08  692  	hws[IMX8MP_CLK_QSPI_ROOT] = imx_clk_hw_gate4("qspi_root_clk", "qspi", ccm_base + 0x42f0, 0);
9c140d9926761b0 Anson Huang 2020-01-08  693  	hws[IMX8MP_CLK_NAND_ROOT] = imx_clk_hw_gate2_shared2("nand_root_clk", "nand", ccm_base + 0x4300, 0, &share_count_nand);
9c140d9926761b0 Anson Huang 2020-01-08  694  	hws[IMX8MP_CLK_NAND_USDHC_BUS_RAWNAND_CLK] = imx_clk_hw_gate2_shared2("nand_usdhc_rawnand_clk", "nand_usdhc_bus", ccm_base + 0x4300, 0, &share_count_nand);
9c140d9926761b0 Anson Huang 2020-01-08  695  	hws[IMX8MP_CLK_I2C5_ROOT] = imx_clk_hw_gate2("i2c5_root_clk", "i2c5", ccm_base + 0x4330, 0);
9c140d9926761b0 Anson Huang 2020-01-08  696  	hws[IMX8MP_CLK_I2C6_ROOT] = imx_clk_hw_gate2("i2c6_root_clk", "i2c6", ccm_base + 0x4340, 0);
9c140d9926761b0 Anson Huang 2020-01-08  697  	hws[IMX8MP_CLK_CAN1_ROOT] = imx_clk_hw_gate2("can1_root_clk", "can1", ccm_base + 0x4350, 0);
9c140d9926761b0 Anson Huang 2020-01-08  698  	hws[IMX8MP_CLK_CAN2_ROOT] = imx_clk_hw_gate2("can2_root_clk", "can2", ccm_base + 0x4360, 0);
9c140d9926761b0 Anson Huang 2020-01-08  699  	hws[IMX8MP_CLK_SDMA1_ROOT] = imx_clk_hw_gate4("sdma1_root_clk", "ipg_root", ccm_base + 0x43a0, 0);
857c9d31f59f0c0 Fugang Duan 2020-02-19  700  	hws[IMX8MP_CLK_ENET_QOS_ROOT] = imx_clk_hw_gate4("enet_qos_root_clk", "sim_enet_root_clk", ccm_base + 0x43b0, 0);
9c140d9926761b0 Anson Huang 2020-01-08  701  	hws[IMX8MP_CLK_SIM_ENET_ROOT] = imx_clk_hw_gate4("sim_enet_root_clk", "enet_axi", ccm_base + 0x4400, 0);
8c83a8ff4dd9287 Peng Fan    2020-05-07  702  	hws[IMX8MP_CLK_GPU2D_ROOT] = imx_clk_hw_gate4("gpu2d_root_clk", "gpu2d_core", ccm_base + 0x4450, 0);
8c83a8ff4dd9287 Peng Fan    2020-05-07  703  	hws[IMX8MP_CLK_GPU3D_ROOT] = imx_clk_hw_gate4("gpu3d_root_clk", "gpu3d_core", ccm_base + 0x4460, 0);
9c140d9926761b0 Anson Huang 2020-01-08  704  	hws[IMX8MP_CLK_SNVS_ROOT] = imx_clk_hw_gate4("snvs_root_clk", "ipg_root", ccm_base + 0x4470, 0);
9c140d9926761b0 Anson Huang 2020-01-08  705  	hws[IMX8MP_CLK_UART1_ROOT] = imx_clk_hw_gate4("uart1_root_clk", "uart1", ccm_base + 0x4490, 0);
9c140d9926761b0 Anson Huang 2020-01-08  706  	hws[IMX8MP_CLK_UART2_ROOT] = imx_clk_hw_gate4("uart2_root_clk", "uart2", ccm_base + 0x44a0, 0);
9c140d9926761b0 Anson Huang 2020-01-08  707  	hws[IMX8MP_CLK_UART3_ROOT] = imx_clk_hw_gate4("uart3_root_clk", "uart3", ccm_base + 0x44b0, 0);
9c140d9926761b0 Anson Huang 2020-01-08  708  	hws[IMX8MP_CLK_UART4_ROOT] = imx_clk_hw_gate4("uart4_root_clk", "uart4", ccm_base + 0x44c0, 0);
9c140d9926761b0 Anson Huang 2020-01-08  709  	hws[IMX8MP_CLK_USB_ROOT] = imx_clk_hw_gate4("usb_root_clk", "osc_32k", ccm_base + 0x44d0, 0);
9c140d9926761b0 Anson Huang 2020-01-08  710  	hws[IMX8MP_CLK_USB_PHY_ROOT] = imx_clk_hw_gate4("usb_phy_root_clk", "usb_phy_ref", ccm_base + 0x44f0, 0);
9c140d9926761b0 Anson Huang 2020-01-08  711  	hws[IMX8MP_CLK_USDHC1_ROOT] = imx_clk_hw_gate4("usdhc1_root_clk", "usdhc1", ccm_base + 0x4510, 0);
9c140d9926761b0 Anson Huang 2020-01-08  712  	hws[IMX8MP_CLK_USDHC2_ROOT] = imx_clk_hw_gate4("usdhc2_root_clk", "usdhc2", ccm_base + 0x4520, 0);
9c140d9926761b0 Anson Huang 2020-01-08  713  	hws[IMX8MP_CLK_WDOG1_ROOT] = imx_clk_hw_gate4("wdog1_root_clk", "wdog", ccm_base + 0x4530, 0);
9c140d9926761b0 Anson Huang 2020-01-08  714  	hws[IMX8MP_CLK_WDOG2_ROOT] = imx_clk_hw_gate4("wdog2_root_clk", "wdog", ccm_base + 0x4540, 0);
9c140d9926761b0 Anson Huang 2020-01-08  715  	hws[IMX8MP_CLK_WDOG3_ROOT] = imx_clk_hw_gate4("wdog3_root_clk", "wdog", ccm_base + 0x4550, 0);
9c140d9926761b0 Anson Huang 2020-01-08  716  	hws[IMX8MP_CLK_VPU_G1_ROOT] = imx_clk_hw_gate4("vpu_g1_root_clk", "vpu_g1", ccm_base + 0x4560, 0);
9c140d9926761b0 Anson Huang 2020-01-08  717  	hws[IMX8MP_CLK_GPU_ROOT] = imx_clk_hw_gate4("gpu_root_clk", "gpu_axi", ccm_base + 0x4570, 0);
9c140d9926761b0 Anson Huang 2020-01-08  718  	hws[IMX8MP_CLK_VPU_VC8KE_ROOT] = imx_clk_hw_gate4("vpu_vc8ke_root_clk", "vpu_vc8000e", ccm_base + 0x4590, 0);
9c140d9926761b0 Anson Huang 2020-01-08  719  	hws[IMX8MP_CLK_VPU_G2_ROOT] = imx_clk_hw_gate4("vpu_g2_root_clk", "vpu_g2", ccm_base + 0x45a0, 0);
8c83a8ff4dd9287 Peng Fan    2020-05-07  720  	hws[IMX8MP_CLK_NPU_ROOT] = imx_clk_hw_gate4("npu_root_clk", "ml_core", ccm_base + 0x45b0, 0);
9c140d9926761b0 Anson Huang 2020-01-08  721  	hws[IMX8MP_CLK_HSIO_ROOT] = imx_clk_hw_gate4("hsio_root_clk", "ipg_root", ccm_base + 0x45c0, 0);
9c140d9926761b0 Anson Huang 2020-01-08  722  	hws[IMX8MP_CLK_MEDIA_APB_ROOT] = imx_clk_hw_gate2_shared2("media_apb_root_clk", "media_apb", ccm_base + 0x45d0, 0, &share_count_media);
9c140d9926761b0 Anson Huang 2020-01-08  723  	hws[IMX8MP_CLK_MEDIA_AXI_ROOT] = imx_clk_hw_gate2_shared2("media_axi_root_clk", "media_axi", ccm_base + 0x45d0, 0, &share_count_media);
9c140d9926761b0 Anson Huang 2020-01-08  724  	hws[IMX8MP_CLK_MEDIA_CAM1_PIX_ROOT] = imx_clk_hw_gate2_shared2("media_cam1_pix_root_clk", "media_cam1_pix", ccm_base + 0x45d0, 0, &share_count_media);
9c140d9926761b0 Anson Huang 2020-01-08  725  	hws[IMX8MP_CLK_MEDIA_CAM2_PIX_ROOT] = imx_clk_hw_gate2_shared2("media_cam2_pix_root_clk", "media_cam2_pix", ccm_base + 0x45d0, 0, &share_count_media);
9c140d9926761b0 Anson Huang 2020-01-08  726  	hws[IMX8MP_CLK_MEDIA_DISP1_PIX_ROOT] = imx_clk_hw_gate2_shared2("media_disp1_pix_root_clk", "media_disp1_pix", ccm_base + 0x45d0, 0, &share_count_media);
9c140d9926761b0 Anson Huang 2020-01-08  727  	hws[IMX8MP_CLK_MEDIA_DISP2_PIX_ROOT] = imx_clk_hw_gate2_shared2("media_disp2_pix_root_clk", "media_disp2_pix", ccm_base + 0x45d0, 0, &share_count_media);
8c83a8ff4dd9287 Peng Fan    2020-05-07  728  	hws[IMX8MP_CLK_MEDIA_ISP_ROOT] = imx_clk_hw_gate2_shared2("media_isp_root_clk", "media_isp", ccm_base + 0x45d0, 0, &share_count_media);
9c140d9926761b0 Anson Huang 2020-01-08  729  
9c140d9926761b0 Anson Huang 2020-01-08  730  	hws[IMX8MP_CLK_USDHC3_ROOT] = imx_clk_hw_gate4("usdhc3_root_clk", "usdhc3", ccm_base + 0x45e0, 0);
9c140d9926761b0 Anson Huang 2020-01-08  731  	hws[IMX8MP_CLK_HDMI_ROOT] = imx_clk_hw_gate4("hdmi_root_clk", "hdmi_axi", ccm_base + 0x45f0, 0);
9c140d9926761b0 Anson Huang 2020-01-08  732  	hws[IMX8MP_CLK_TSENSOR_ROOT] = imx_clk_hw_gate4("tsensor_root_clk", "ipg_root", ccm_base + 0x4620, 0);
9c140d9926761b0 Anson Huang 2020-01-08  733  	hws[IMX8MP_CLK_VPU_ROOT] = imx_clk_hw_gate4("vpu_root_clk", "vpu_bus", ccm_base + 0x4630, 0);
9c140d9926761b0 Anson Huang 2020-01-08  734  	hws[IMX8MP_CLK_AUDIO_ROOT] = imx_clk_hw_gate4("audio_root_clk", "ipg_root", ccm_base + 0x4650, 0);
9c140d9926761b0 Anson Huang 2020-01-08  735  
7ab227210110a41 Peng Fan    2020-02-19  736  	hws[IMX8MP_CLK_ARM] = imx_clk_hw_cpu("arm", "arm_a53_core",
7ab227210110a41 Peng Fan    2020-02-19  737  					     hws[IMX8MP_CLK_A53_CORE]->clk,
7ab227210110a41 Peng Fan    2020-02-19  738  					     hws[IMX8MP_CLK_A53_CORE]->clk,
9c140d9926761b0 Anson Huang 2020-01-08  739  					     hws[IMX8MP_ARM_PLL_OUT]->clk,
7ab227210110a41 Peng Fan    2020-02-19  740  					     hws[IMX8MP_CLK_A53_DIV]->clk);
9c140d9926761b0 Anson Huang 2020-01-08  741  
9c140d9926761b0 Anson Huang 2020-01-08  742  	imx_check_clk_hws(hws, IMX8MP_CLK_END);
9c140d9926761b0 Anson Huang 2020-01-08  743  
9c140d9926761b0 Anson Huang 2020-01-08  744  	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
9c140d9926761b0 Anson Huang 2020-01-08  745  
9c140d9926761b0 Anson Huang 2020-01-08  746  	for (i = 0; i < ARRAY_SIZE(uart_clk_ids); i++) {
9c140d9926761b0 Anson Huang 2020-01-08  747  		int index = uart_clk_ids[i];
9c140d9926761b0 Anson Huang 2020-01-08  748  
9c140d9926761b0 Anson Huang 2020-01-08  749  		uart_clks[i] = &hws[index]->clk;
9c140d9926761b0 Anson Huang 2020-01-08  750  	}
9c140d9926761b0 Anson Huang 2020-01-08  751  
9c140d9926761b0 Anson Huang 2020-01-08  752  	imx_register_uart_clocks(uart_clks);
9c140d9926761b0 Anson Huang 2020-01-08  753  
9c140d9926761b0 Anson Huang 2020-01-08  754  	return 0;
9c140d9926761b0 Anson Huang 2020-01-08  755  }
9c140d9926761b0 Anson Huang 2020-01-08  756  

:::::: The code at line 446 was first introduced by commit
:::::: 9c140d9926761b0f5d329ff6c09a1540f3d5e1d3 clk: imx: Add support for i.MX8MP clock driver

:::::: TO: Anson Huang <Anson.Huang@nxp.com>
:::::: CC: Shawn Guo <shawnguo@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--9amGYk9869ThD9tj
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--9amGYk9869ThD9tj--
