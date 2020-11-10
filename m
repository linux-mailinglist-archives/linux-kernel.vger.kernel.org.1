Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A50F2AD462
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 12:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgKJLEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 06:04:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:48225 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgKJLEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:04:22 -0500
IronPort-SDR: 22VdS+u/Er+qy4tkp/nRLx+GdMTCOVh2VO9C0oJCco2LSPLOMhRA3uQF+0F/0uZFZpjlJIcnQe
 xL9t5TnvE31A==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="157735441"
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="gz'50?scan'50,208,50";a="157735441"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:04:20 -0800
IronPort-SDR: cl/MmpxPzbLCqEdPDtrcHLIKWyAqNUnLl045dC3vHItuzPK7q7+jaoI+o+iHtMZsYIBct46/lM
 usg+Lv2gHH7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="gz'50?scan'50,208,50";a="531157757"
Received: from lkp-server02.sh.intel.com (HELO c6c5fbb3488a) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 10 Nov 2020 03:04:17 -0800
Received: from kbuild by c6c5fbb3488a with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kcRRg-0000B6-GW; Tue, 10 Nov 2020 11:04:16 +0000
Date:   Tue, 10 Nov 2020 19:04:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Steen Hegelund <steen.hegelund@microchip.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     kbuild-all@lists.01.org,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Bjarni Jonasson <bjarni.jonasson@microchip.com>,
        Microsemi List <microsemi@lists.bootlin.com>,
        Microchip UNG Driver List <UNGLinuxDriver@microchip.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/4] phy: Add Sparx5 ethernet serdes PHY driver
Message-ID: <202011101848.FK7GQCVi-lkp@intel.com>
References: <20201105144429.2438358-4-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20201105144429.2438358-4-steen.hegelund@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Steen,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master phy/next linux/master v5.10-rc3 next-20201110]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Steen-Hegelund/Adding-the-Sparx5-Serdes-driver/20201105-224623
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: h8300-randconfig-r023-20201109 (attached as .config)
compiler: h8300-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/cf09fd205f64b7c78c3078d3888f54baccf102e4
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Steen-Hegelund/Adding-the-Sparx5-Serdes-driver/20201105-224623
        git checkout cf09fd205f64b7c78c3078d3888f54baccf102e4
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=h8300 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/init.h:5,
                    from include/linux/printk.h:6,
                    from drivers/phy/microchip/sparx5_serdes.c:9:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   include/asm-generic/page.h:93:50: warning: ordered comparison of pointer with null pointer [-Wextra]
      93 | #define virt_addr_valid(kaddr) (((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
         |                                                  ^~
   include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
      78 | # define unlikely(x) __builtin_expect(!!(x), 0)
         |                                          ^
   include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |  ^~~~~~
   include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
     143 |  BUG_ON(!virt_addr_valid(buf));
         |          ^~~~~~~~~~~~~~~
   drivers/phy/microchip/sparx5_serdes.c: In function 'sparx5_sd25g28_get_params':
>> drivers/phy/microchip/sparx5_serdes.c:821:33: warning: initialized field overwritten [-Woverride-init]
     821 |   .cfg_rx_reserve_15_8        = 0x61,
         |                                 ^~~~
   drivers/phy/microchip/sparx5_serdes.c:821:33: note: (near initialization for 'init.cfg_rx_reserve_15_8')
   drivers/phy/microchip/sparx5_serdes.c:828:33: warning: initialized field overwritten [-Woverride-init]
     828 |   .cfg_pi_en                  = 1,
         |                                 ^
   drivers/phy/microchip/sparx5_serdes.c:828:33: note: (near initialization for 'init.cfg_pi_en')
   drivers/phy/microchip/sparx5_serdes.c:843:33: warning: initialized field overwritten [-Woverride-init]
     843 |   .cfg_cdrck_en               = 1,
         |                                 ^
   drivers/phy/microchip/sparx5_serdes.c:843:33: note: (near initialization for 'init.cfg_cdrck_en')
   drivers/phy/microchip/sparx5_serdes.c: In function 'sparx5_sd10g28_get_params':
   drivers/phy/microchip/sparx5_serdes.c:949:34: warning: initialized field overwritten [-Woverride-init]
     949 |   .cfg_cdrck_en                = 1,
         |                                  ^
   drivers/phy/microchip/sparx5_serdes.c:949:34: note: (near initialization for 'init.cfg_cdrck_en')

vim +821 drivers/phy/microchip/sparx5_serdes.c

   738	
   739	static void sparx5_sd25g28_get_params(struct sparx5_serdes_macro *macro,
   740					     struct sparx5_sd25g28_media_preset *media,
   741					     struct sparx5_sd25g28_mode_preset *mode,
   742					     struct sparx5_sd25g28_args *args,
   743					     struct sparx5_sd25g28_params *params)
   744	{
   745		struct sparx5_sd25g28_params init = {
   746			.r_d_width_ctrl_2_0         = sd25g28_get_iw_setting(mode->bitwidth),
   747			.r_txfifo_ck_div_pmad_2_0   = mode->fifo_ck_div,
   748			.r_rxfifo_ck_div_pmad_2_0   = mode->fifo_ck_div,
   749			.cfg_vco_div_mode_1_0       = mode->vco_div_mode,
   750			.cfg_pre_divsel_1_0         = mode->pre_divsel,
   751			.cfg_sel_div_3_0            = mode->sel_div,
   752			.cfg_vco_start_code_3_0     = 0,
   753			.cfg_pma_tx_ck_bitwidth_2_0 = mode->ck_bitwidth,
   754			.cfg_tx_prediv_1_0          = mode->tx_pre_div,
   755			.cfg_rxdiv_sel_2_0          = mode->ck_bitwidth,
   756			.cfg_tx_subrate_2_0         = mode->subrate,
   757			.cfg_rx_subrate_2_0         = mode->subrate,
   758			.r_multi_lane_mode          = 0,
   759			.cfg_cdrck_en               = 1,
   760			.cfg_dfeck_en               = mode->dfe_enable,
   761			.cfg_dfe_pd                 = mode->dfe_enable == 1 ? 0 : 1,
   762			.cfg_dfedmx_pd              = 1,
   763			.cfg_dfetap_en_5_1          = mode->dfe_tap,
   764			.cfg_dmux_pd                = 0,
   765			.cfg_dmux_clk_pd            = 1,
   766			.cfg_erramp_pd              = mode->dfe_enable == 1 ? 0 : 1,
   767			.cfg_pi_DFE_en              = mode->dfe_enable,
   768			.cfg_pi_en                  = 1,
   769			.cfg_pd_ctle                = 0,
   770			.cfg_summer_en              = 1,
   771			.cfg_pmad_ck_pd             = 0,
   772			.cfg_pd_clk                 = 0,
   773			.cfg_pd_cml                 = 0,
   774			.cfg_pd_driver              = 0,
   775			.cfg_rx_reg_pu              = 1,
   776			.cfg_pd_rms_det             = 1,
   777			.cfg_dcdr_pd                = 0,
   778			.cfg_ecdr_pd                = 1,
   779			.cfg_pd_sq                  = 1,
   780			.cfg_itx_ipdriver_base_2_0  = mode->txmargin,
   781			.cfg_tap_dly_4_0            = media->cfg_tap_dly_4_0,
   782			.cfg_tap_main               = media->cfg_tap_main,
   783			.cfg_en_main                = media->cfg_en_main,
   784			.cfg_tap_adv_3_0            = media->cfg_tap_adv_3_0,
   785			.cfg_en_adv                 = media->cfg_en_adv,
   786			.cfg_en_dly                 = media->cfg_en_dly,
   787			.cfg_iscan_en               = 0,
   788			.l1_pcs_en_fast_iscan       = 0,
   789			.l0_cfg_bw_1_0              = 0,
   790			.cfg_en_dummy               = 0,
   791			.cfg_pll_reserve_3_0        = args->com_pll_reserve,
   792			.l0_cfg_txcal_en            = mode->com_txcal_en,
   793			.l0_cfg_tx_reserve_15_8     = mode->com_tx_reserve_msb,
   794			.l0_cfg_tx_reserve_7_0      = mode->com_tx_reserve_lsb,
   795			.cfg_tx_reserve_15_8        = mode->tx_reserve_msb,
   796			.cfg_tx_reserve_7_0         = mode->tx_reserve_lsb,
   797			.cfg_bw_1_0                 = mode->bw,
   798			.cfg_txcal_man_en           = 1,
   799			.cfg_phase_man_4_0          = 0,
   800			.cfg_quad_man_1_0           = 0,
   801			.cfg_txcal_shift_code_5_0   = 2,
   802			.cfg_txcal_valid_sel_3_0    = 4,
   803			.cfg_txcal_en               = 0,
   804			.cfg_cdr_kf_2_0             = 1,
   805			.cfg_cdr_m_7_0              = 6,
   806			.cfg_pi_bw_3_0              = mode->cfg_pi_bw_3_0,
   807			.cfg_pi_steps_1_0           = 0,
   808			.cfg_dis_2ndorder           = 1,
   809			.cfg_ctle_rstn              = mode->cfg_ctle_rstn,
   810			.r_dfe_rstn                 = mode->r_dfe_rstn,
   811			.cfg_alos_thr_2_0           = media->cfg_alos_thr_2_0,
   812			.cfg_itx_ipcml_base_1_0     = mode->cfg_itx_ipcml_base,
   813			.cfg_rx_reserve_7_0         = 0xbf,
   814			.cfg_rx_reserve_15_8        = 0x61,
   815			.cfg_rxterm_2_0             = mode->rxterm,
   816			.cfg_fom_selm               = 0,
   817			.cfg_rx_sp_ctle_1_0         = 0,
   818			.cfg_isel_ctle_1_0          = 0,
   819			.cfg_vga_ctrl_byp_4_0       = media->cfg_vga_ctrl_byp_4_0,
   820			.cfg_vga_byp                = 1,
 > 821			.cfg_rx_reserve_15_8        = 0x61,
   822			.cfg_agc_adpt_byp           = 1,
   823			.cfg_eqr_byp                = 1,
   824			.cfg_eqr_force_3_0          = media->cfg_eq_r_force_3_0,
   825			.cfg_eqc_force_3_0          = media->cfg_eq_c_force_3_0,
   826			.cfg_sum_setcm_en           = 1,
   827			.cfg_pi_dfe_en              = 1,
   828			.cfg_pi_en                  = 1,
   829			.cfg_init_pos_iscan_6_0     = 6,
   830			.cfg_init_pos_ipi_6_0       = 9,
   831			.cfg_dfedig_m_2_0           = 6,
   832			.cfg_en_dfedig              = mode->dfe_enable,
   833			.r_d_width_ctrl_from_hwt    = 0,
   834			.r_reg_manual               = 1,
   835			.reg_rst                    = args->reg_rst,
   836			.cfg_jc_byp                 = 1,
   837			.cfg_common_reserve_7_0     = 1,
   838			.cfg_pll_lol_set            = 1,
   839			.cfg_tx2rx_lp_en            = 0,
   840			.cfg_txlb_en                = 0,
   841			.cfg_rx2tx_lp_en            = 0,
   842			.cfg_rxlb_en                = 0,
   843			.cfg_cdrck_en               = 1,
   844			.r_tx_pol_inv               = args->txinvert,
   845			.r_rx_pol_inv               = args->rxinvert,
   846		};
   847	
   848		*params = init;
   849	}
   850	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--OXfL5xGRrasGEqWY
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AQA=

--OXfL5xGRrasGEqWY--
