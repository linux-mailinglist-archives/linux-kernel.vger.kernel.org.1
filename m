Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8632EFF20
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 12:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbhAILHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 06:07:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:10140 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbhAILHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 06:07:54 -0500
IronPort-SDR: LzrKCYheQkYnH/WIbpL+z5E9WgQY2GppiSsBNYOncedlCzG8jd0SOJLLcQ6CTePu3qjsDdwTzy
 7+XwFzO5vxRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9858"; a="176924849"
X-IronPort-AV: E=Sophos;i="5.79,333,1602572400"; 
   d="gz'50?scan'50,208,50";a="176924849"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2021 03:07:10 -0800
IronPort-SDR: bIBJYrytfaGZuzowr5+GxEz7w1dB1nl0z8Dst63ZZ1vB/frDZmptqwSOnUvQT15ozXW2je1rzZ
 xoaL4mZ6Xc2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,333,1602572400"; 
   d="gz'50?scan'50,208,50";a="498093811"
Received: from lkp-server01.sh.intel.com (HELO 412602b27703) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 Jan 2021 03:07:08 -0800
Received: from kbuild by 412602b27703 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kyC5L-00012i-Fu; Sat, 09 Jan 2021 11:07:07 +0000
Date:   Sat, 9 Jan 2021 19:06:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: drivers/net/wan/fsl_ucc_hdlc.c:305:57: sparse: sparse: incorrect
 type in argument 2 (different address spaces)
Message-ID: <202101091911.UzsdDT9M-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   996e435fd401de35df62ac943ab9402cfe85c430
commit: 894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e powerpc: inline iomap accessors
date:   5 weeks ago
config: powerpc-randconfig-s032-20210109 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-208-g46a52ca4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
>> drivers/net/wan/fsl_ucc_hdlc.c:305:57: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:305:57: sparse:     expected void [noderef] __iomem *addr
   drivers/net/wan/fsl_ucc_hdlc.c:305:57: sparse:     got restricted __be16 *
>> drivers/net/wan/fsl_ucc_hdlc.c:307:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:307:46: sparse:     expected void [noderef] __iomem *addr
   drivers/net/wan/fsl_ucc_hdlc.c:307:46: sparse:     got restricted __be32 *
   drivers/net/wan/fsl_ucc_hdlc.c:316:57: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:316:57: sparse:     expected void [noderef] __iomem *addr
   drivers/net/wan/fsl_ucc_hdlc.c:316:57: sparse:     got restricted __be16 *
   drivers/net/wan/fsl_ucc_hdlc.c:318:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:318:46: sparse:     expected void [noderef] __iomem *addr
   drivers/net/wan/fsl_ucc_hdlc.c:318:46: sparse:     got restricted __be32 *
   drivers/net/wan/fsl_ucc_hdlc.c:368:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __be16 [usertype] @@
   drivers/net/wan/fsl_ucc_hdlc.c:368:29: sparse:     expected unsigned short [usertype]
   drivers/net/wan/fsl_ucc_hdlc.c:368:29: sparse:     got restricted __be16 [usertype]
   drivers/net/wan/fsl_ucc_hdlc.c:375:36: sparse: sparse: restricted __be16 degrades to integer
   drivers/net/wan/fsl_ucc_hdlc.c:398:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct qe_bd [noderef] __iomem *bd @@     got struct qe_bd *curtx_bd @@
   drivers/net/wan/fsl_ucc_hdlc.c:398:12: sparse:     expected struct qe_bd [noderef] __iomem *bd
   drivers/net/wan/fsl_ucc_hdlc.c:398:12: sparse:     got struct qe_bd *curtx_bd
   drivers/net/wan/fsl_ucc_hdlc.c:421:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct qe_bd [noderef] __iomem *[assigned] bd @@     got struct qe_bd *tx_bd_base @@
   drivers/net/wan/fsl_ucc_hdlc.c:421:20: sparse:     expected struct qe_bd [noderef] __iomem *[assigned] bd
   drivers/net/wan/fsl_ucc_hdlc.c:421:20: sparse:     got struct qe_bd *tx_bd_base
   drivers/net/wan/fsl_ucc_hdlc.c:423:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/net/wan/fsl_ucc_hdlc.c:423:16: sparse:    struct qe_bd [noderef] __iomem *
   drivers/net/wan/fsl_ucc_hdlc.c:423:16: sparse:    struct qe_bd *
>> drivers/net/wan/fsl_ucc_hdlc.c:458:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:502:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:524:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:548:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:592:67: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:607:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:631:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/wan/fsl_ucc_hdlc.c:631:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
   drivers/net/wan/fsl_ucc_hdlc.c:850:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct qe_mux *qe_mux_reg @@     got struct qe_mux [noderef] __iomem * @@
>> drivers/net/wan/fsl_ucc_hdlc.c:853:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:854:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:857:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:860:37: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *s @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:865:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct qe_mux *qe_mux_reg @@     got struct qe_mux [noderef] __iomem * @@
   drivers/net/wan/fsl_ucc_hdlc.c:867:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:869:40: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:870:40: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:872:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:992:57: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:994:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:1003:57: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:1005:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:408:35: sparse: sparse: dereference of noderef expression
   drivers/net/wan/fsl_ucc_hdlc.c:723:29: sparse: sparse: dereference of noderef expression
   drivers/net/wan/fsl_ucc_hdlc.c:814:21: sparse: sparse: dereference of noderef expression
   drivers/net/wan/fsl_ucc_hdlc.c:1020:29: sparse: sparse: dereference of noderef expression

vim +305 drivers/net/wan/fsl_ucc_hdlc.c

c19b6d246a35627c Zhao Qiang       2016-06-06   77  
c19b6d246a35627c Zhao Qiang       2016-06-06   78  static int uhdlc_init(struct ucc_hdlc_private *priv)
c19b6d246a35627c Zhao Qiang       2016-06-06   79  {
c19b6d246a35627c Zhao Qiang       2016-06-06   80  	struct ucc_tdm_info *ut_info;
c19b6d246a35627c Zhao Qiang       2016-06-06   81  	struct ucc_fast_info *uf_info;
c19b6d246a35627c Zhao Qiang       2016-06-06   82  	u32 cecr_subblock;
c19b6d246a35627c Zhao Qiang       2016-06-06   83  	u16 bd_status;
c19b6d246a35627c Zhao Qiang       2016-06-06   84  	int ret, i;
c19b6d246a35627c Zhao Qiang       2016-06-06   85  	void *bd_buffer;
c19b6d246a35627c Zhao Qiang       2016-06-06   86  	dma_addr_t bd_dma_addr;
be2e9415f8b366ab Rasmus Villemoes 2019-11-28   87  	s32 riptr;
be2e9415f8b366ab Rasmus Villemoes 2019-11-28   88  	s32 tiptr;
c19b6d246a35627c Zhao Qiang       2016-06-06   89  	u32 gumr;
c19b6d246a35627c Zhao Qiang       2016-06-06   90  
c19b6d246a35627c Zhao Qiang       2016-06-06   91  	ut_info = priv->ut_info;
c19b6d246a35627c Zhao Qiang       2016-06-06   92  	uf_info = &ut_info->uf_info;
c19b6d246a35627c Zhao Qiang       2016-06-06   93  
c19b6d246a35627c Zhao Qiang       2016-06-06   94  	if (priv->tsa) {
c19b6d246a35627c Zhao Qiang       2016-06-06   95  		uf_info->tsa = 1;
c19b6d246a35627c Zhao Qiang       2016-06-06   96  		uf_info->ctsp = 1;
040b7c94e4ec5851 David Gounaris   2018-09-03   97  		uf_info->cds = 1;
040b7c94e4ec5851 David Gounaris   2018-09-03   98  		uf_info->ctss = 1;
040b7c94e4ec5851 David Gounaris   2018-09-03   99  	} else {
040b7c94e4ec5851 David Gounaris   2018-09-03  100  		uf_info->cds = 0;
040b7c94e4ec5851 David Gounaris   2018-09-03  101  		uf_info->ctsp = 0;
040b7c94e4ec5851 David Gounaris   2018-09-03  102  		uf_info->ctss = 0;
c19b6d246a35627c Zhao Qiang       2016-06-06  103  	}
067bb938dad61e58 Holger Brunck    2017-05-17  104  
067bb938dad61e58 Holger Brunck    2017-05-17  105  	/* This sets HPM register in CMXUCR register which configures a
067bb938dad61e58 Holger Brunck    2017-05-17  106  	 * open drain connected HDLC bus
067bb938dad61e58 Holger Brunck    2017-05-17  107  	 */
067bb938dad61e58 Holger Brunck    2017-05-17  108  	if (priv->hdlc_bus)
067bb938dad61e58 Holger Brunck    2017-05-17  109  		uf_info->brkpt_support = 1;
067bb938dad61e58 Holger Brunck    2017-05-17  110  
c19b6d246a35627c Zhao Qiang       2016-06-06  111  	uf_info->uccm_mask = ((UCC_HDLC_UCCE_RXB | UCC_HDLC_UCCE_RXF |
c19b6d246a35627c Zhao Qiang       2016-06-06  112  				UCC_HDLC_UCCE_TXB) << 16);
c19b6d246a35627c Zhao Qiang       2016-06-06  113  
c19b6d246a35627c Zhao Qiang       2016-06-06  114  	ret = ucc_fast_init(uf_info, &priv->uccf);
c19b6d246a35627c Zhao Qiang       2016-06-06  115  	if (ret) {
c19b6d246a35627c Zhao Qiang       2016-06-06  116  		dev_err(priv->dev, "Failed to init uccf.");
c19b6d246a35627c Zhao Qiang       2016-06-06  117  		return ret;
c19b6d246a35627c Zhao Qiang       2016-06-06  118  	}
c19b6d246a35627c Zhao Qiang       2016-06-06  119  
c19b6d246a35627c Zhao Qiang       2016-06-06  120  	priv->uf_regs = priv->uccf->uf_regs;
c19b6d246a35627c Zhao Qiang       2016-06-06  121  	ucc_fast_disable(priv->uccf, COMM_DIR_RX | COMM_DIR_TX);
c19b6d246a35627c Zhao Qiang       2016-06-06  122  
c19b6d246a35627c Zhao Qiang       2016-06-06  123  	/* Loopback mode */
c19b6d246a35627c Zhao Qiang       2016-06-06  124  	if (priv->loopback) {
c19b6d246a35627c Zhao Qiang       2016-06-06  125  		dev_info(priv->dev, "Loopback Mode\n");
54e9e0874938ba5b Holger Brunck    2017-05-17  126  		/* use the same clock when work in loopback */
54e9e0874938ba5b Holger Brunck    2017-05-17  127  		qe_setbrg(ut_info->uf_info.rx_clock, 20000000, 1);
54e9e0874938ba5b Holger Brunck    2017-05-17  128  
c19b6d246a35627c Zhao Qiang       2016-06-06  129  		gumr = ioread32be(&priv->uf_regs->gumr);
c19b6d246a35627c Zhao Qiang       2016-06-06  130  		gumr |= (UCC_FAST_GUMR_LOOPBACK | UCC_FAST_GUMR_CDS |
c19b6d246a35627c Zhao Qiang       2016-06-06  131  			 UCC_FAST_GUMR_TCI);
c19b6d246a35627c Zhao Qiang       2016-06-06  132  		gumr &= ~(UCC_FAST_GUMR_CTSP | UCC_FAST_GUMR_RSYN);
c19b6d246a35627c Zhao Qiang       2016-06-06  133  		iowrite32be(gumr, &priv->uf_regs->gumr);
c19b6d246a35627c Zhao Qiang       2016-06-06  134  	}
c19b6d246a35627c Zhao Qiang       2016-06-06  135  
c19b6d246a35627c Zhao Qiang       2016-06-06  136  	/* Initialize SI */
c19b6d246a35627c Zhao Qiang       2016-06-06  137  	if (priv->tsa)
c19b6d246a35627c Zhao Qiang       2016-06-06  138  		ucc_tdm_init(priv->utdm, priv->ut_info);
c19b6d246a35627c Zhao Qiang       2016-06-06  139  
c19b6d246a35627c Zhao Qiang       2016-06-06  140  	/* Write to QE CECR, UCCx channel to Stop Transmission */
c19b6d246a35627c Zhao Qiang       2016-06-06  141  	cecr_subblock = ucc_fast_get_qe_cr_subblock(uf_info->ucc_num);
c19b6d246a35627c Zhao Qiang       2016-06-06  142  	ret = qe_issue_cmd(QE_STOP_TX, cecr_subblock,
c19b6d246a35627c Zhao Qiang       2016-06-06  143  			   QE_CR_PROTOCOL_UNSPECIFIED, 0);
c19b6d246a35627c Zhao Qiang       2016-06-06  144  
c19b6d246a35627c Zhao Qiang       2016-06-06  145  	/* Set UPSMR normal mode (need fixed)*/
c19b6d246a35627c Zhao Qiang       2016-06-06  146  	iowrite32be(0, &priv->uf_regs->upsmr);
c19b6d246a35627c Zhao Qiang       2016-06-06  147  
067bb938dad61e58 Holger Brunck    2017-05-17  148  	/* hdlc_bus mode */
067bb938dad61e58 Holger Brunck    2017-05-17  149  	if (priv->hdlc_bus) {
067bb938dad61e58 Holger Brunck    2017-05-17  150  		u32 upsmr;
067bb938dad61e58 Holger Brunck    2017-05-17  151  
067bb938dad61e58 Holger Brunck    2017-05-17  152  		dev_info(priv->dev, "HDLC bus Mode\n");
067bb938dad61e58 Holger Brunck    2017-05-17  153  		upsmr = ioread32be(&priv->uf_regs->upsmr);
067bb938dad61e58 Holger Brunck    2017-05-17  154  
067bb938dad61e58 Holger Brunck    2017-05-17  155  		/* bus mode and retransmit enable, with collision window
067bb938dad61e58 Holger Brunck    2017-05-17  156  		 * set to 8 bytes
067bb938dad61e58 Holger Brunck    2017-05-17  157  		 */
067bb938dad61e58 Holger Brunck    2017-05-17  158  		upsmr |= UCC_HDLC_UPSMR_RTE | UCC_HDLC_UPSMR_BUS |
067bb938dad61e58 Holger Brunck    2017-05-17  159  				UCC_HDLC_UPSMR_CW8;
067bb938dad61e58 Holger Brunck    2017-05-17  160  		iowrite32be(upsmr, &priv->uf_regs->upsmr);
067bb938dad61e58 Holger Brunck    2017-05-17  161  
067bb938dad61e58 Holger Brunck    2017-05-17  162  		/* explicitly disable CDS & CTSP */
067bb938dad61e58 Holger Brunck    2017-05-17  163  		gumr = ioread32be(&priv->uf_regs->gumr);
067bb938dad61e58 Holger Brunck    2017-05-17  164  		gumr &= ~(UCC_FAST_GUMR_CDS | UCC_FAST_GUMR_CTSP);
067bb938dad61e58 Holger Brunck    2017-05-17  165  		/* set automatic sync to explicitly ignore CD signal */
067bb938dad61e58 Holger Brunck    2017-05-17  166  		gumr |= UCC_FAST_GUMR_SYNL_AUTO;
067bb938dad61e58 Holger Brunck    2017-05-17  167  		iowrite32be(gumr, &priv->uf_regs->gumr);
067bb938dad61e58 Holger Brunck    2017-05-17  168  	}
067bb938dad61e58 Holger Brunck    2017-05-17  169  
c19b6d246a35627c Zhao Qiang       2016-06-06  170  	priv->rx_ring_size = RX_BD_RING_LEN;
c19b6d246a35627c Zhao Qiang       2016-06-06  171  	priv->tx_ring_size = TX_BD_RING_LEN;
c19b6d246a35627c Zhao Qiang       2016-06-06  172  	/* Alloc Rx BD */
c19b6d246a35627c Zhao Qiang       2016-06-06  173  	priv->rx_bd_base = dma_alloc_coherent(priv->dev,
5b8aad93c52bdda6 Holger Brunck    2017-05-17  174  			RX_BD_RING_LEN * sizeof(struct qe_bd),
c19b6d246a35627c Zhao Qiang       2016-06-06  175  			&priv->dma_rx_bd, GFP_KERNEL);
c19b6d246a35627c Zhao Qiang       2016-06-06  176  
c19b6d246a35627c Zhao Qiang       2016-06-06  177  	if (!priv->rx_bd_base) {
c19b6d246a35627c Zhao Qiang       2016-06-06  178  		dev_err(priv->dev, "Cannot allocate MURAM memory for RxBDs\n");
c19b6d246a35627c Zhao Qiang       2016-06-06  179  		ret = -ENOMEM;
1efb597d8bf56cbe Zhao Qiang       2016-07-15  180  		goto free_uccf;
c19b6d246a35627c Zhao Qiang       2016-06-06  181  	}
c19b6d246a35627c Zhao Qiang       2016-06-06  182  
c19b6d246a35627c Zhao Qiang       2016-06-06  183  	/* Alloc Tx BD */
c19b6d246a35627c Zhao Qiang       2016-06-06  184  	priv->tx_bd_base = dma_alloc_coherent(priv->dev,
5b8aad93c52bdda6 Holger Brunck    2017-05-17  185  			TX_BD_RING_LEN * sizeof(struct qe_bd),
c19b6d246a35627c Zhao Qiang       2016-06-06  186  			&priv->dma_tx_bd, GFP_KERNEL);
c19b6d246a35627c Zhao Qiang       2016-06-06  187  
c19b6d246a35627c Zhao Qiang       2016-06-06  188  	if (!priv->tx_bd_base) {
c19b6d246a35627c Zhao Qiang       2016-06-06  189  		dev_err(priv->dev, "Cannot allocate MURAM memory for TxBDs\n");
c19b6d246a35627c Zhao Qiang       2016-06-06  190  		ret = -ENOMEM;
1efb597d8bf56cbe Zhao Qiang       2016-07-15  191  		goto free_rx_bd;
c19b6d246a35627c Zhao Qiang       2016-06-06  192  	}
c19b6d246a35627c Zhao Qiang       2016-06-06  193  
c19b6d246a35627c Zhao Qiang       2016-06-06  194  	/* Alloc parameter ram for ucc hdlc */
85deed56032b6c98 Holger Brunck    2017-05-22  195  	priv->ucc_pram_offset = qe_muram_alloc(sizeof(struct ucc_hdlc_param),
c19b6d246a35627c Zhao Qiang       2016-06-06  196  				ALIGNMENT_OF_UCC_HDLC_PRAM);
c19b6d246a35627c Zhao Qiang       2016-06-06  197  
be2e9415f8b366ab Rasmus Villemoes 2019-11-28  198  	if (priv->ucc_pram_offset < 0) {
24a24d07d688a462 Colin Ian King   2016-08-28  199  		dev_err(priv->dev, "Can not allocate MURAM for hdlc parameter.\n");
c19b6d246a35627c Zhao Qiang       2016-06-06  200  		ret = -ENOMEM;
1efb597d8bf56cbe Zhao Qiang       2016-07-15  201  		goto free_tx_bd;
c19b6d246a35627c Zhao Qiang       2016-06-06  202  	}
c19b6d246a35627c Zhao Qiang       2016-06-06  203  
6396bb221514d287 Kees Cook        2018-06-12  204  	priv->rx_skbuff = kcalloc(priv->rx_ring_size,
6396bb221514d287 Kees Cook        2018-06-12  205  				  sizeof(*priv->rx_skbuff),
c19b6d246a35627c Zhao Qiang       2016-06-06  206  				  GFP_KERNEL);
c19b6d246a35627c Zhao Qiang       2016-06-06  207  	if (!priv->rx_skbuff)
1efb597d8bf56cbe Zhao Qiang       2016-07-15  208  		goto free_ucc_pram;
c19b6d246a35627c Zhao Qiang       2016-06-06  209  
6396bb221514d287 Kees Cook        2018-06-12  210  	priv->tx_skbuff = kcalloc(priv->tx_ring_size,
6396bb221514d287 Kees Cook        2018-06-12  211  				  sizeof(*priv->tx_skbuff),
c19b6d246a35627c Zhao Qiang       2016-06-06  212  				  GFP_KERNEL);
c19b6d246a35627c Zhao Qiang       2016-06-06  213  	if (!priv->tx_skbuff)
1efb597d8bf56cbe Zhao Qiang       2016-07-15  214  		goto free_rx_skbuff;
c19b6d246a35627c Zhao Qiang       2016-06-06  215  
c19b6d246a35627c Zhao Qiang       2016-06-06  216  	priv->skb_curtx = 0;
c19b6d246a35627c Zhao Qiang       2016-06-06  217  	priv->skb_dirtytx = 0;
c19b6d246a35627c Zhao Qiang       2016-06-06  218  	priv->curtx_bd = priv->tx_bd_base;
c19b6d246a35627c Zhao Qiang       2016-06-06  219  	priv->dirty_tx = priv->tx_bd_base;
c19b6d246a35627c Zhao Qiang       2016-06-06  220  	priv->currx_bd = priv->rx_bd_base;
c19b6d246a35627c Zhao Qiang       2016-06-06  221  	priv->currx_bdnum = 0;
c19b6d246a35627c Zhao Qiang       2016-06-06  222  
c19b6d246a35627c Zhao Qiang       2016-06-06  223  	/* init parameter base */
c19b6d246a35627c Zhao Qiang       2016-06-06  224  	cecr_subblock = ucc_fast_get_qe_cr_subblock(uf_info->ucc_num);
c19b6d246a35627c Zhao Qiang       2016-06-06  225  	ret = qe_issue_cmd(QE_ASSIGN_PAGE_TO_DEVICE, cecr_subblock,
c19b6d246a35627c Zhao Qiang       2016-06-06  226  			   QE_CR_PROTOCOL_UNSPECIFIED, priv->ucc_pram_offset);
c19b6d246a35627c Zhao Qiang       2016-06-06  227  
c19b6d246a35627c Zhao Qiang       2016-06-06  228  	priv->ucc_pram = (struct ucc_hdlc_param __iomem *)
c19b6d246a35627c Zhao Qiang       2016-06-06  229  					qe_muram_addr(priv->ucc_pram_offset);
c19b6d246a35627c Zhao Qiang       2016-06-06  230  
c19b6d246a35627c Zhao Qiang       2016-06-06  231  	/* Zero out parameter ram */
c19b6d246a35627c Zhao Qiang       2016-06-06  232  	memset_io(priv->ucc_pram, 0, sizeof(struct ucc_hdlc_param));
c19b6d246a35627c Zhao Qiang       2016-06-06  233  
c19b6d246a35627c Zhao Qiang       2016-06-06  234  	/* Alloc riptr, tiptr */
c19b6d246a35627c Zhao Qiang       2016-06-06  235  	riptr = qe_muram_alloc(32, 32);
be2e9415f8b366ab Rasmus Villemoes 2019-11-28  236  	if (riptr < 0) {
c19b6d246a35627c Zhao Qiang       2016-06-06  237  		dev_err(priv->dev, "Cannot allocate MURAM mem for Receive internal temp data pointer\n");
c19b6d246a35627c Zhao Qiang       2016-06-06  238  		ret = -ENOMEM;
1efb597d8bf56cbe Zhao Qiang       2016-07-15  239  		goto free_tx_skbuff;
c19b6d246a35627c Zhao Qiang       2016-06-06  240  	}
c19b6d246a35627c Zhao Qiang       2016-06-06  241  
c19b6d246a35627c Zhao Qiang       2016-06-06  242  	tiptr = qe_muram_alloc(32, 32);
be2e9415f8b366ab Rasmus Villemoes 2019-11-28  243  	if (tiptr < 0) {
c19b6d246a35627c Zhao Qiang       2016-06-06  244  		dev_err(priv->dev, "Cannot allocate MURAM mem for Transmit internal temp data pointer\n");
c19b6d246a35627c Zhao Qiang       2016-06-06  245  		ret = -ENOMEM;
1efb597d8bf56cbe Zhao Qiang       2016-07-15  246  		goto free_riptr;
c19b6d246a35627c Zhao Qiang       2016-06-06  247  	}
148587a59f6b8583 Rasmus Villemoes 2019-11-28  248  	if (riptr != (u16)riptr || tiptr != (u16)tiptr) {
148587a59f6b8583 Rasmus Villemoes 2019-11-28  249  		dev_err(priv->dev, "MURAM allocation out of addressable range\n");
148587a59f6b8583 Rasmus Villemoes 2019-11-28  250  		ret = -ENOMEM;
148587a59f6b8583 Rasmus Villemoes 2019-11-28  251  		goto free_tiptr;
148587a59f6b8583 Rasmus Villemoes 2019-11-28  252  	}
c19b6d246a35627c Zhao Qiang       2016-06-06  253  
c19b6d246a35627c Zhao Qiang       2016-06-06  254  	/* Set RIPTR, TIPTR */
c19b6d246a35627c Zhao Qiang       2016-06-06  255  	iowrite16be(riptr, &priv->ucc_pram->riptr);
c19b6d246a35627c Zhao Qiang       2016-06-06  256  	iowrite16be(tiptr, &priv->ucc_pram->tiptr);
c19b6d246a35627c Zhao Qiang       2016-06-06  257  
c19b6d246a35627c Zhao Qiang       2016-06-06  258  	/* Set MRBLR */
c19b6d246a35627c Zhao Qiang       2016-06-06  259  	iowrite16be(MAX_RX_BUF_LENGTH, &priv->ucc_pram->mrblr);
c19b6d246a35627c Zhao Qiang       2016-06-06  260  
c19b6d246a35627c Zhao Qiang       2016-06-06  261  	/* Set RBASE, TBASE */
c19b6d246a35627c Zhao Qiang       2016-06-06  262  	iowrite32be(priv->dma_rx_bd, &priv->ucc_pram->rbase);
c19b6d246a35627c Zhao Qiang       2016-06-06  263  	iowrite32be(priv->dma_tx_bd, &priv->ucc_pram->tbase);
c19b6d246a35627c Zhao Qiang       2016-06-06  264  
c19b6d246a35627c Zhao Qiang       2016-06-06  265  	/* Set RSTATE, TSTATE */
c19b6d246a35627c Zhao Qiang       2016-06-06  266  	iowrite32be(BMR_GBL | BMR_BIG_ENDIAN, &priv->ucc_pram->rstate);
c19b6d246a35627c Zhao Qiang       2016-06-06  267  	iowrite32be(BMR_GBL | BMR_BIG_ENDIAN, &priv->ucc_pram->tstate);
c19b6d246a35627c Zhao Qiang       2016-06-06  268  
c19b6d246a35627c Zhao Qiang       2016-06-06  269  	/* Set C_MASK, C_PRES for 16bit CRC */
c19b6d246a35627c Zhao Qiang       2016-06-06  270  	iowrite32be(CRC_16BIT_MASK, &priv->ucc_pram->c_mask);
c19b6d246a35627c Zhao Qiang       2016-06-06  271  	iowrite32be(CRC_16BIT_PRES, &priv->ucc_pram->c_pres);
c19b6d246a35627c Zhao Qiang       2016-06-06  272  
c19b6d246a35627c Zhao Qiang       2016-06-06  273  	iowrite16be(MAX_FRAME_LENGTH, &priv->ucc_pram->mflr);
c19b6d246a35627c Zhao Qiang       2016-06-06  274  	iowrite16be(DEFAULT_RFTHR, &priv->ucc_pram->rfthr);
c19b6d246a35627c Zhao Qiang       2016-06-06  275  	iowrite16be(DEFAULT_RFTHR, &priv->ucc_pram->rfcnt);
045f77baf6b429a4 David Gounaris   2018-09-03  276  	iowrite16be(priv->hmask, &priv->ucc_pram->hmask);
c19b6d246a35627c Zhao Qiang       2016-06-06  277  	iowrite16be(DEFAULT_HDLC_ADDR, &priv->ucc_pram->haddr1);
c19b6d246a35627c Zhao Qiang       2016-06-06  278  	iowrite16be(DEFAULT_HDLC_ADDR, &priv->ucc_pram->haddr2);
c19b6d246a35627c Zhao Qiang       2016-06-06  279  	iowrite16be(DEFAULT_HDLC_ADDR, &priv->ucc_pram->haddr3);
c19b6d246a35627c Zhao Qiang       2016-06-06  280  	iowrite16be(DEFAULT_HDLC_ADDR, &priv->ucc_pram->haddr4);
c19b6d246a35627c Zhao Qiang       2016-06-06  281  
c19b6d246a35627c Zhao Qiang       2016-06-06  282  	/* Get BD buffer */
750afb08ca71310f Luis Chamberlain 2019-01-04  283  	bd_buffer = dma_alloc_coherent(priv->dev,
750afb08ca71310f Luis Chamberlain 2019-01-04  284  				       (RX_BD_RING_LEN + TX_BD_RING_LEN) * MAX_RX_BUF_LENGTH,
c19b6d246a35627c Zhao Qiang       2016-06-06  285  				       &bd_dma_addr, GFP_KERNEL);
c19b6d246a35627c Zhao Qiang       2016-06-06  286  
c19b6d246a35627c Zhao Qiang       2016-06-06  287  	if (!bd_buffer) {
c19b6d246a35627c Zhao Qiang       2016-06-06  288  		dev_err(priv->dev, "Could not allocate buffer descriptors\n");
c19b6d246a35627c Zhao Qiang       2016-06-06  289  		ret = -ENOMEM;
1efb597d8bf56cbe Zhao Qiang       2016-07-15  290  		goto free_tiptr;
c19b6d246a35627c Zhao Qiang       2016-06-06  291  	}
c19b6d246a35627c Zhao Qiang       2016-06-06  292  
c19b6d246a35627c Zhao Qiang       2016-06-06  293  	priv->rx_buffer = bd_buffer;
c19b6d246a35627c Zhao Qiang       2016-06-06  294  	priv->tx_buffer = bd_buffer + RX_BD_RING_LEN * MAX_RX_BUF_LENGTH;
c19b6d246a35627c Zhao Qiang       2016-06-06  295  
c19b6d246a35627c Zhao Qiang       2016-06-06  296  	priv->dma_rx_addr = bd_dma_addr;
c19b6d246a35627c Zhao Qiang       2016-06-06  297  	priv->dma_tx_addr = bd_dma_addr + RX_BD_RING_LEN * MAX_RX_BUF_LENGTH;
c19b6d246a35627c Zhao Qiang       2016-06-06  298  
c19b6d246a35627c Zhao Qiang       2016-06-06  299  	for (i = 0; i < RX_BD_RING_LEN; i++) {
c19b6d246a35627c Zhao Qiang       2016-06-06  300  		if (i < (RX_BD_RING_LEN - 1))
c19b6d246a35627c Zhao Qiang       2016-06-06  301  			bd_status = R_E_S | R_I_S;
c19b6d246a35627c Zhao Qiang       2016-06-06  302  		else
c19b6d246a35627c Zhao Qiang       2016-06-06  303  			bd_status = R_E_S | R_I_S | R_W_S;
c19b6d246a35627c Zhao Qiang       2016-06-06  304  
c19b6d246a35627c Zhao Qiang       2016-06-06 @305  		iowrite16be(bd_status, &priv->rx_bd_base[i].status);
c19b6d246a35627c Zhao Qiang       2016-06-06  306  		iowrite32be(priv->dma_rx_addr + i * MAX_RX_BUF_LENGTH,
c19b6d246a35627c Zhao Qiang       2016-06-06 @307  			    &priv->rx_bd_base[i].buf);
c19b6d246a35627c Zhao Qiang       2016-06-06  308  	}
c19b6d246a35627c Zhao Qiang       2016-06-06  309  
c19b6d246a35627c Zhao Qiang       2016-06-06  310  	for (i = 0; i < TX_BD_RING_LEN; i++) {
c19b6d246a35627c Zhao Qiang       2016-06-06  311  		if (i < (TX_BD_RING_LEN - 1))
c19b6d246a35627c Zhao Qiang       2016-06-06  312  			bd_status =  T_I_S | T_TC_S;
c19b6d246a35627c Zhao Qiang       2016-06-06  313  		else
c19b6d246a35627c Zhao Qiang       2016-06-06  314  			bd_status =  T_I_S | T_TC_S | T_W_S;
c19b6d246a35627c Zhao Qiang       2016-06-06  315  
c19b6d246a35627c Zhao Qiang       2016-06-06  316  		iowrite16be(bd_status, &priv->tx_bd_base[i].status);
c19b6d246a35627c Zhao Qiang       2016-06-06  317  		iowrite32be(priv->dma_tx_addr + i * MAX_RX_BUF_LENGTH,
c19b6d246a35627c Zhao Qiang       2016-06-06  318  			    &priv->tx_bd_base[i].buf);
c19b6d246a35627c Zhao Qiang       2016-06-06  319  	}
c19b6d246a35627c Zhao Qiang       2016-06-06  320  
c19b6d246a35627c Zhao Qiang       2016-06-06  321  	return 0;
c19b6d246a35627c Zhao Qiang       2016-06-06  322  
1efb597d8bf56cbe Zhao Qiang       2016-07-15  323  free_tiptr:
c19b6d246a35627c Zhao Qiang       2016-06-06  324  	qe_muram_free(tiptr);
1efb597d8bf56cbe Zhao Qiang       2016-07-15  325  free_riptr:
c19b6d246a35627c Zhao Qiang       2016-06-06  326  	qe_muram_free(riptr);
1efb597d8bf56cbe Zhao Qiang       2016-07-15  327  free_tx_skbuff:
c19b6d246a35627c Zhao Qiang       2016-06-06  328  	kfree(priv->tx_skbuff);
1efb597d8bf56cbe Zhao Qiang       2016-07-15  329  free_rx_skbuff:
c19b6d246a35627c Zhao Qiang       2016-06-06  330  	kfree(priv->rx_skbuff);
1efb597d8bf56cbe Zhao Qiang       2016-07-15  331  free_ucc_pram:
c19b6d246a35627c Zhao Qiang       2016-06-06  332  	qe_muram_free(priv->ucc_pram_offset);
1efb597d8bf56cbe Zhao Qiang       2016-07-15  333  free_tx_bd:
c19b6d246a35627c Zhao Qiang       2016-06-06  334  	dma_free_coherent(priv->dev,
5b8aad93c52bdda6 Holger Brunck    2017-05-17  335  			  TX_BD_RING_LEN * sizeof(struct qe_bd),
c19b6d246a35627c Zhao Qiang       2016-06-06  336  			  priv->tx_bd_base, priv->dma_tx_bd);
1efb597d8bf56cbe Zhao Qiang       2016-07-15  337  free_rx_bd:
c19b6d246a35627c Zhao Qiang       2016-06-06  338  	dma_free_coherent(priv->dev,
5b8aad93c52bdda6 Holger Brunck    2017-05-17  339  			  RX_BD_RING_LEN * sizeof(struct qe_bd),
c19b6d246a35627c Zhao Qiang       2016-06-06  340  			  priv->rx_bd_base, priv->dma_rx_bd);
1efb597d8bf56cbe Zhao Qiang       2016-07-15  341  free_uccf:
c19b6d246a35627c Zhao Qiang       2016-06-06  342  	ucc_fast_free(priv->uccf);
c19b6d246a35627c Zhao Qiang       2016-06-06  343  
c19b6d246a35627c Zhao Qiang       2016-06-06  344  	return ret;
c19b6d246a35627c Zhao Qiang       2016-06-06  345  }
c19b6d246a35627c Zhao Qiang       2016-06-06  346  
c19b6d246a35627c Zhao Qiang       2016-06-06  347  static netdev_tx_t ucc_hdlc_tx(struct sk_buff *skb, struct net_device *dev)
c19b6d246a35627c Zhao Qiang       2016-06-06  348  {
c19b6d246a35627c Zhao Qiang       2016-06-06  349  	hdlc_device *hdlc = dev_to_hdlc(dev);
c19b6d246a35627c Zhao Qiang       2016-06-06  350  	struct ucc_hdlc_private *priv = (struct ucc_hdlc_private *)hdlc->priv;
c19b6d246a35627c Zhao Qiang       2016-06-06  351  	struct qe_bd __iomem *bd;
c19b6d246a35627c Zhao Qiang       2016-06-06  352  	u16 bd_status;
c19b6d246a35627c Zhao Qiang       2016-06-06  353  	unsigned long flags;
c19b6d246a35627c Zhao Qiang       2016-06-06  354  	u16 *proto_head;
c19b6d246a35627c Zhao Qiang       2016-06-06  355  
c19b6d246a35627c Zhao Qiang       2016-06-06  356  	switch (dev->type) {
c19b6d246a35627c Zhao Qiang       2016-06-06  357  	case ARPHRD_RAWHDLC:
c19b6d246a35627c Zhao Qiang       2016-06-06  358  		if (skb_headroom(skb) < HDLC_HEAD_LEN) {
c19b6d246a35627c Zhao Qiang       2016-06-06  359  			dev->stats.tx_dropped++;
c19b6d246a35627c Zhao Qiang       2016-06-06  360  			dev_kfree_skb(skb);
c19b6d246a35627c Zhao Qiang       2016-06-06  361  			netdev_err(dev, "No enough space for hdlc head\n");
c19b6d246a35627c Zhao Qiang       2016-06-06  362  			return -ENOMEM;
c19b6d246a35627c Zhao Qiang       2016-06-06  363  		}
c19b6d246a35627c Zhao Qiang       2016-06-06  364  
c19b6d246a35627c Zhao Qiang       2016-06-06  365  		skb_push(skb, HDLC_HEAD_LEN);
c19b6d246a35627c Zhao Qiang       2016-06-06  366  
c19b6d246a35627c Zhao Qiang       2016-06-06  367  		proto_head = (u16 *)skb->data;
c19b6d246a35627c Zhao Qiang       2016-06-06  368  		*proto_head = htons(DEFAULT_HDLC_HEAD);
c19b6d246a35627c Zhao Qiang       2016-06-06  369  
c19b6d246a35627c Zhao Qiang       2016-06-06  370  		dev->stats.tx_bytes += skb->len;
c19b6d246a35627c Zhao Qiang       2016-06-06  371  		break;
c19b6d246a35627c Zhao Qiang       2016-06-06  372  
c19b6d246a35627c Zhao Qiang       2016-06-06  373  	case ARPHRD_PPP:
c19b6d246a35627c Zhao Qiang       2016-06-06  374  		proto_head = (u16 *)skb->data;
c19b6d246a35627c Zhao Qiang       2016-06-06  375  		if (*proto_head != htons(DEFAULT_PPP_HEAD)) {
c19b6d246a35627c Zhao Qiang       2016-06-06  376  			dev->stats.tx_dropped++;
c19b6d246a35627c Zhao Qiang       2016-06-06  377  			dev_kfree_skb(skb);
c19b6d246a35627c Zhao Qiang       2016-06-06  378  			netdev_err(dev, "Wrong ppp header\n");
c19b6d246a35627c Zhao Qiang       2016-06-06  379  			return -ENOMEM;
c19b6d246a35627c Zhao Qiang       2016-06-06  380  		}
c19b6d246a35627c Zhao Qiang       2016-06-06  381  
c19b6d246a35627c Zhao Qiang       2016-06-06  382  		dev->stats.tx_bytes += skb->len;
c19b6d246a35627c Zhao Qiang       2016-06-06  383  		break;
c19b6d246a35627c Zhao Qiang       2016-06-06  384  
8978ca7c8b7b0710 David Gounaris   2018-09-03  385  	case ARPHRD_ETHER:
8978ca7c8b7b0710 David Gounaris   2018-09-03  386  		dev->stats.tx_bytes += skb->len;
8978ca7c8b7b0710 David Gounaris   2018-09-03  387  		break;
8978ca7c8b7b0710 David Gounaris   2018-09-03  388  
c19b6d246a35627c Zhao Qiang       2016-06-06  389  	default:
c19b6d246a35627c Zhao Qiang       2016-06-06  390  		dev->stats.tx_dropped++;
c19b6d246a35627c Zhao Qiang       2016-06-06  391  		dev_kfree_skb(skb);
c19b6d246a35627c Zhao Qiang       2016-06-06  392  		return -ENOMEM;
c19b6d246a35627c Zhao Qiang       2016-06-06  393  	}
2e7ad56aa54778de Mathias Thore    2018-11-07  394  	netdev_sent_queue(dev, skb->len);
c19b6d246a35627c Zhao Qiang       2016-06-06  395  	spin_lock_irqsave(&priv->lock, flags);
c19b6d246a35627c Zhao Qiang       2016-06-06  396  
c19b6d246a35627c Zhao Qiang       2016-06-06  397  	/* Start from the next BD that should be filled */
c19b6d246a35627c Zhao Qiang       2016-06-06 @398  	bd = priv->curtx_bd;
c19b6d246a35627c Zhao Qiang       2016-06-06  399  	bd_status = ioread16be(&bd->status);
c19b6d246a35627c Zhao Qiang       2016-06-06  400  	/* Save the skb pointer so we can free it later */
c19b6d246a35627c Zhao Qiang       2016-06-06  401  	priv->tx_skbuff[priv->skb_curtx] = skb;
c19b6d246a35627c Zhao Qiang       2016-06-06  402  
c19b6d246a35627c Zhao Qiang       2016-06-06  403  	/* Update the current skb pointer (wrapping if this was the last) */
c19b6d246a35627c Zhao Qiang       2016-06-06  404  	priv->skb_curtx =
c19b6d246a35627c Zhao Qiang       2016-06-06  405  	    (priv->skb_curtx + 1) & TX_RING_MOD_MASK(TX_BD_RING_LEN);
c19b6d246a35627c Zhao Qiang       2016-06-06  406  
c19b6d246a35627c Zhao Qiang       2016-06-06  407  	/* copy skb data to tx buffer for sdma processing */
c19b6d246a35627c Zhao Qiang       2016-06-06  408  	memcpy(priv->tx_buffer + (be32_to_cpu(bd->buf) - priv->dma_tx_addr),
c19b6d246a35627c Zhao Qiang       2016-06-06  409  	       skb->data, skb->len);
c19b6d246a35627c Zhao Qiang       2016-06-06  410  
c19b6d246a35627c Zhao Qiang       2016-06-06  411  	/* set bd status and length */
c19b6d246a35627c Zhao Qiang       2016-06-06  412  	bd_status = (bd_status & T_W_S) | T_R_S | T_I_S | T_L_S | T_TC_S;
c19b6d246a35627c Zhao Qiang       2016-06-06  413  
c19b6d246a35627c Zhao Qiang       2016-06-06  414  	iowrite16be(skb->len, &bd->length);
02bb56ddc6711639 Zhao Qiang       2017-03-14  415  	iowrite16be(bd_status, &bd->status);
c19b6d246a35627c Zhao Qiang       2016-06-06  416  
c19b6d246a35627c Zhao Qiang       2016-06-06  417  	/* Move to next BD in the ring */
c19b6d246a35627c Zhao Qiang       2016-06-06  418  	if (!(bd_status & T_W_S))
c19b6d246a35627c Zhao Qiang       2016-06-06  419  		bd += 1;
c19b6d246a35627c Zhao Qiang       2016-06-06  420  	else
c19b6d246a35627c Zhao Qiang       2016-06-06  421  		bd = priv->tx_bd_base;
c19b6d246a35627c Zhao Qiang       2016-06-06  422  
c19b6d246a35627c Zhao Qiang       2016-06-06  423  	if (bd == priv->dirty_tx) {
c19b6d246a35627c Zhao Qiang       2016-06-06  424  		if (!netif_queue_stopped(dev))
c19b6d246a35627c Zhao Qiang       2016-06-06  425  			netif_stop_queue(dev);
c19b6d246a35627c Zhao Qiang       2016-06-06  426  	}
c19b6d246a35627c Zhao Qiang       2016-06-06  427  
c19b6d246a35627c Zhao Qiang       2016-06-06  428  	priv->curtx_bd = bd;
c19b6d246a35627c Zhao Qiang       2016-06-06  429  
c19b6d246a35627c Zhao Qiang       2016-06-06  430  	spin_unlock_irqrestore(&priv->lock, flags);
c19b6d246a35627c Zhao Qiang       2016-06-06  431  
c19b6d246a35627c Zhao Qiang       2016-06-06  432  	return NETDEV_TX_OK;
c19b6d246a35627c Zhao Qiang       2016-06-06  433  }
c19b6d246a35627c Zhao Qiang       2016-06-06  434  
ba59d5705825fb9c Mathias Thore    2018-10-22  435  static int hdlc_tx_restart(struct ucc_hdlc_private *priv)
ba59d5705825fb9c Mathias Thore    2018-10-22  436  {
ba59d5705825fb9c Mathias Thore    2018-10-22  437  	u32 cecr_subblock;
ba59d5705825fb9c Mathias Thore    2018-10-22  438  
ba59d5705825fb9c Mathias Thore    2018-10-22  439  	cecr_subblock =
ba59d5705825fb9c Mathias Thore    2018-10-22  440  		ucc_fast_get_qe_cr_subblock(priv->ut_info->uf_info.ucc_num);
ba59d5705825fb9c Mathias Thore    2018-10-22  441  
ba59d5705825fb9c Mathias Thore    2018-10-22  442  	qe_issue_cmd(QE_RESTART_TX, cecr_subblock,
ba59d5705825fb9c Mathias Thore    2018-10-22  443  		     QE_CR_PROTOCOL_UNSPECIFIED, 0);
ba59d5705825fb9c Mathias Thore    2018-10-22  444  	return 0;
ba59d5705825fb9c Mathias Thore    2018-10-22  445  }
ba59d5705825fb9c Mathias Thore    2018-10-22  446  
c19b6d246a35627c Zhao Qiang       2016-06-06  447  static int hdlc_tx_done(struct ucc_hdlc_private *priv)
c19b6d246a35627c Zhao Qiang       2016-06-06  448  {
c19b6d246a35627c Zhao Qiang       2016-06-06  449  	/* Start from the next BD that should be filled */
c19b6d246a35627c Zhao Qiang       2016-06-06  450  	struct net_device *dev = priv->ndev;
2e7ad56aa54778de Mathias Thore    2018-11-07  451  	unsigned int bytes_sent = 0;
2e7ad56aa54778de Mathias Thore    2018-11-07  452  	int howmany = 0;
c19b6d246a35627c Zhao Qiang       2016-06-06  453  	struct qe_bd *bd;		/* BD pointer */
c19b6d246a35627c Zhao Qiang       2016-06-06  454  	u16 bd_status;
ba59d5705825fb9c Mathias Thore    2018-10-22  455  	int tx_restart = 0;
c19b6d246a35627c Zhao Qiang       2016-06-06  456  
c19b6d246a35627c Zhao Qiang       2016-06-06  457  	bd = priv->dirty_tx;
c19b6d246a35627c Zhao Qiang       2016-06-06 @458  	bd_status = ioread16be(&bd->status);
c19b6d246a35627c Zhao Qiang       2016-06-06  459  
c19b6d246a35627c Zhao Qiang       2016-06-06  460  	/* Normal processing. */
c19b6d246a35627c Zhao Qiang       2016-06-06  461  	while ((bd_status & T_R_S) == 0) {
c19b6d246a35627c Zhao Qiang       2016-06-06  462  		struct sk_buff *skb;
c19b6d246a35627c Zhao Qiang       2016-06-06  463  
ba59d5705825fb9c Mathias Thore    2018-10-22  464  		if (bd_status & T_UN_S) { /* Underrun */
ba59d5705825fb9c Mathias Thore    2018-10-22  465  			dev->stats.tx_fifo_errors++;
ba59d5705825fb9c Mathias Thore    2018-10-22  466  			tx_restart = 1;
ba59d5705825fb9c Mathias Thore    2018-10-22  467  		}
ba59d5705825fb9c Mathias Thore    2018-10-22  468  		if (bd_status & T_CT_S) { /* Carrier lost */
ba59d5705825fb9c Mathias Thore    2018-10-22  469  			dev->stats.tx_carrier_errors++;
ba59d5705825fb9c Mathias Thore    2018-10-22  470  			tx_restart = 1;
ba59d5705825fb9c Mathias Thore    2018-10-22  471  		}
ba59d5705825fb9c Mathias Thore    2018-10-22  472  
c19b6d246a35627c Zhao Qiang       2016-06-06  473  		/* BD contains already transmitted buffer.   */
c19b6d246a35627c Zhao Qiang       2016-06-06  474  		/* Handle the transmitted buffer and release */
c19b6d246a35627c Zhao Qiang       2016-06-06  475  		/* the BD to be used with the current frame  */
c19b6d246a35627c Zhao Qiang       2016-06-06  476  
c19b6d246a35627c Zhao Qiang       2016-06-06  477  		skb = priv->tx_skbuff[priv->skb_dirtytx];
c19b6d246a35627c Zhao Qiang       2016-06-06  478  		if (!skb)
c19b6d246a35627c Zhao Qiang       2016-06-06  479  			break;
2e7ad56aa54778de Mathias Thore    2018-11-07  480  		howmany++;
2e7ad56aa54778de Mathias Thore    2018-11-07  481  		bytes_sent += skb->len;
c19b6d246a35627c Zhao Qiang       2016-06-06  482  		dev->stats.tx_packets++;
c19b6d246a35627c Zhao Qiang       2016-06-06  483  		memset(priv->tx_buffer +
c19b6d246a35627c Zhao Qiang       2016-06-06  484  		       (be32_to_cpu(bd->buf) - priv->dma_tx_addr),
c19b6d246a35627c Zhao Qiang       2016-06-06  485  		       0, skb->len);
7c3850adbcccc2c6 Yang Wei         2019-02-06  486  		dev_consume_skb_irq(skb);
c19b6d246a35627c Zhao Qiang       2016-06-06  487  
c19b6d246a35627c Zhao Qiang       2016-06-06  488  		priv->tx_skbuff[priv->skb_dirtytx] = NULL;
c19b6d246a35627c Zhao Qiang       2016-06-06  489  		priv->skb_dirtytx =
c19b6d246a35627c Zhao Qiang       2016-06-06  490  		    (priv->skb_dirtytx +
c19b6d246a35627c Zhao Qiang       2016-06-06  491  		     1) & TX_RING_MOD_MASK(TX_BD_RING_LEN);
c19b6d246a35627c Zhao Qiang       2016-06-06  492  
c19b6d246a35627c Zhao Qiang       2016-06-06  493  		/* We freed a buffer, so now we can restart transmission */
c19b6d246a35627c Zhao Qiang       2016-06-06  494  		if (netif_queue_stopped(dev))
c19b6d246a35627c Zhao Qiang       2016-06-06  495  			netif_wake_queue(dev);
c19b6d246a35627c Zhao Qiang       2016-06-06  496  
c19b6d246a35627c Zhao Qiang       2016-06-06  497  		/* Advance the confirmation BD pointer */
c19b6d246a35627c Zhao Qiang       2016-06-06  498  		if (!(bd_status & T_W_S))
c19b6d246a35627c Zhao Qiang       2016-06-06  499  			bd += 1;
c19b6d246a35627c Zhao Qiang       2016-06-06  500  		else
c19b6d246a35627c Zhao Qiang       2016-06-06  501  			bd = priv->tx_bd_base;
c19b6d246a35627c Zhao Qiang       2016-06-06  502  		bd_status = ioread16be(&bd->status);
c19b6d246a35627c Zhao Qiang       2016-06-06  503  	}
c19b6d246a35627c Zhao Qiang       2016-06-06  504  	priv->dirty_tx = bd;
c19b6d246a35627c Zhao Qiang       2016-06-06  505  
ba59d5705825fb9c Mathias Thore    2018-10-22  506  	if (tx_restart)
ba59d5705825fb9c Mathias Thore    2018-10-22  507  		hdlc_tx_restart(priv);
ba59d5705825fb9c Mathias Thore    2018-10-22  508  
2e7ad56aa54778de Mathias Thore    2018-11-07  509  	netdev_completed_queue(dev, howmany, bytes_sent);
c19b6d246a35627c Zhao Qiang       2016-06-06  510  	return 0;
c19b6d246a35627c Zhao Qiang       2016-06-06  511  }
c19b6d246a35627c Zhao Qiang       2016-06-06  512  

:::::: The code at line 305 was first introduced by commit
:::::: c19b6d246a35627c3a69b2fa6bdece212b48214b drivers/net: support hdlc function for QE-UCC

:::::: TO: Zhao Qiang <qiang.zhao@nxp.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--y0ulUmNC+osPPQO6
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--y0ulUmNC+osPPQO6--
