Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D632E6E84
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 07:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgL2Gbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 01:31:47 -0500
Received: from mga02.intel.com ([134.134.136.20]:9842 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgL2Gbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 01:31:46 -0500
IronPort-SDR: H6EWjSsEZIGx+oT+85mUjQGzmMqWt3/GOSV4vyh28wtMhEJlQjpiK1LwMcUEZzrBOzR2k/iZFu
 iYC98j9gtK0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="163525986"
X-IronPort-AV: E=Sophos;i="5.78,457,1599548400"; 
   d="gz'50?scan'50,208,50";a="163525986"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 22:31:02 -0800
IronPort-SDR: cSq815jIWkCtd5F5/kG/OeqpsaEEUAaEx90Z5bA3jDeWvkiQgnMRs7nfauFflxzftu0co6KjDa
 SJ49KrYFTn0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,457,1599548400"; 
   d="gz'50?scan'50,208,50";a="393002638"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 28 Dec 2020 22:31:00 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ku8X5-0003Ns-UL; Tue, 29 Dec 2020 06:30:59 +0000
Date:   Tue, 29 Dec 2020 14:30:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: drivers/net/wan/fsl_ucc_hdlc.c:305:17: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202012291456.B7dsvt2M-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dea8dcf2a9fa8cc540136a6cd885c3beece16ec3
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   4 months ago
config: arm-randconfig-s031-20201221 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-184-g1b896707-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
>> drivers/net/wan/fsl_ucc_hdlc.c:305:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:305:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/net/wan/fsl_ucc_hdlc.c:305:17: sparse:     got restricted __be16 *
   drivers/net/wan/fsl_ucc_hdlc.c:306:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:306:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wan/fsl_ucc_hdlc.c:306:17: sparse:     got restricted __be32 *
   drivers/net/wan/fsl_ucc_hdlc.c:316:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:316:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/net/wan/fsl_ucc_hdlc.c:316:17: sparse:     got restricted __be16 *
   drivers/net/wan/fsl_ucc_hdlc.c:317:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:317:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wan/fsl_ucc_hdlc.c:317:17: sparse:     got restricted __be32 *
   drivers/net/wan/fsl_ucc_hdlc.c:368:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __be16 [usertype] @@
   drivers/net/wan/fsl_ucc_hdlc.c:368:29: sparse:     expected unsigned short [usertype]
   drivers/net/wan/fsl_ucc_hdlc.c:368:29: sparse:     got restricted __be16 [usertype]
   drivers/net/wan/fsl_ucc_hdlc.c:375:36: sparse: sparse: restricted __be16 degrades to integer
   drivers/net/wan/fsl_ucc_hdlc.c:398:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct qe_bd [noderef] __iomem *bd @@     got struct qe_bd *curtx_bd @@
   drivers/net/wan/fsl_ucc_hdlc.c:398:12: sparse:     expected struct qe_bd [noderef] __iomem *bd
   drivers/net/wan/fsl_ucc_hdlc.c:398:12: sparse:     got struct qe_bd *curtx_bd
   drivers/net/wan/fsl_ucc_hdlc.c:408:35: sparse: sparse: dereference of noderef expression
   drivers/net/wan/fsl_ucc_hdlc.c:421:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct qe_bd [noderef] __iomem *[assigned] bd @@     got struct qe_bd *tx_bd_base @@
   drivers/net/wan/fsl_ucc_hdlc.c:421:20: sparse:     expected struct qe_bd [noderef] __iomem *[assigned] bd
   drivers/net/wan/fsl_ucc_hdlc.c:421:20: sparse:     got struct qe_bd *tx_bd_base
   drivers/net/wan/fsl_ucc_hdlc.c:423:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/net/wan/fsl_ucc_hdlc.c:423:16: sparse:    struct qe_bd [noderef] __iomem *
   drivers/net/wan/fsl_ucc_hdlc.c:423:16: sparse:    struct qe_bd *
   drivers/net/wan/fsl_ucc_hdlc.c:458:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:458:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:458:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:458:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:502:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:502:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:502:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:502:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:524:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:524:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:524:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:524:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:548:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:548:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:548:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:548:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:592:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:607:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:607:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:607:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:607:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __be16 * @@
   drivers/net/wan/fsl_ucc_hdlc.c:408:35: sparse: sparse: dereference of noderef expression
   drivers/net/wan/fsl_ucc_hdlc.c:408:35: sparse: sparse: dereference of noderef expression
   drivers/net/wan/fsl_ucc_hdlc.c:723:29: sparse: sparse: dereference of noderef expression
   drivers/net/wan/fsl_ucc_hdlc.c:814:21: sparse: sparse: dereference of noderef expression

vim +305 drivers/net/wan/fsl_ucc_hdlc.c

c19b6d246a35627 Zhao Qiang       2016-06-06   77  
c19b6d246a35627 Zhao Qiang       2016-06-06   78  static int uhdlc_init(struct ucc_hdlc_private *priv)
c19b6d246a35627 Zhao Qiang       2016-06-06   79  {
c19b6d246a35627 Zhao Qiang       2016-06-06   80  	struct ucc_tdm_info *ut_info;
c19b6d246a35627 Zhao Qiang       2016-06-06   81  	struct ucc_fast_info *uf_info;
c19b6d246a35627 Zhao Qiang       2016-06-06   82  	u32 cecr_subblock;
c19b6d246a35627 Zhao Qiang       2016-06-06   83  	u16 bd_status;
c19b6d246a35627 Zhao Qiang       2016-06-06   84  	int ret, i;
c19b6d246a35627 Zhao Qiang       2016-06-06   85  	void *bd_buffer;
c19b6d246a35627 Zhao Qiang       2016-06-06   86  	dma_addr_t bd_dma_addr;
be2e9415f8b366a Rasmus Villemoes 2019-11-28   87  	s32 riptr;
be2e9415f8b366a Rasmus Villemoes 2019-11-28   88  	s32 tiptr;
c19b6d246a35627 Zhao Qiang       2016-06-06   89  	u32 gumr;
c19b6d246a35627 Zhao Qiang       2016-06-06   90  
c19b6d246a35627 Zhao Qiang       2016-06-06   91  	ut_info = priv->ut_info;
c19b6d246a35627 Zhao Qiang       2016-06-06   92  	uf_info = &ut_info->uf_info;
c19b6d246a35627 Zhao Qiang       2016-06-06   93  
c19b6d246a35627 Zhao Qiang       2016-06-06   94  	if (priv->tsa) {
c19b6d246a35627 Zhao Qiang       2016-06-06   95  		uf_info->tsa = 1;
c19b6d246a35627 Zhao Qiang       2016-06-06   96  		uf_info->ctsp = 1;
040b7c94e4ec585 David Gounaris   2018-09-03   97  		uf_info->cds = 1;
040b7c94e4ec585 David Gounaris   2018-09-03   98  		uf_info->ctss = 1;
040b7c94e4ec585 David Gounaris   2018-09-03   99  	} else {
040b7c94e4ec585 David Gounaris   2018-09-03  100  		uf_info->cds = 0;
040b7c94e4ec585 David Gounaris   2018-09-03  101  		uf_info->ctsp = 0;
040b7c94e4ec585 David Gounaris   2018-09-03  102  		uf_info->ctss = 0;
c19b6d246a35627 Zhao Qiang       2016-06-06  103  	}
067bb938dad61e5 Holger Brunck    2017-05-17  104  
067bb938dad61e5 Holger Brunck    2017-05-17  105  	/* This sets HPM register in CMXUCR register which configures a
067bb938dad61e5 Holger Brunck    2017-05-17  106  	 * open drain connected HDLC bus
067bb938dad61e5 Holger Brunck    2017-05-17  107  	 */
067bb938dad61e5 Holger Brunck    2017-05-17  108  	if (priv->hdlc_bus)
067bb938dad61e5 Holger Brunck    2017-05-17  109  		uf_info->brkpt_support = 1;
067bb938dad61e5 Holger Brunck    2017-05-17  110  
c19b6d246a35627 Zhao Qiang       2016-06-06  111  	uf_info->uccm_mask = ((UCC_HDLC_UCCE_RXB | UCC_HDLC_UCCE_RXF |
c19b6d246a35627 Zhao Qiang       2016-06-06  112  				UCC_HDLC_UCCE_TXB) << 16);
c19b6d246a35627 Zhao Qiang       2016-06-06  113  
c19b6d246a35627 Zhao Qiang       2016-06-06  114  	ret = ucc_fast_init(uf_info, &priv->uccf);
c19b6d246a35627 Zhao Qiang       2016-06-06  115  	if (ret) {
c19b6d246a35627 Zhao Qiang       2016-06-06  116  		dev_err(priv->dev, "Failed to init uccf.");
c19b6d246a35627 Zhao Qiang       2016-06-06  117  		return ret;
c19b6d246a35627 Zhao Qiang       2016-06-06  118  	}
c19b6d246a35627 Zhao Qiang       2016-06-06  119  
c19b6d246a35627 Zhao Qiang       2016-06-06  120  	priv->uf_regs = priv->uccf->uf_regs;
c19b6d246a35627 Zhao Qiang       2016-06-06  121  	ucc_fast_disable(priv->uccf, COMM_DIR_RX | COMM_DIR_TX);
c19b6d246a35627 Zhao Qiang       2016-06-06  122  
c19b6d246a35627 Zhao Qiang       2016-06-06  123  	/* Loopback mode */
c19b6d246a35627 Zhao Qiang       2016-06-06  124  	if (priv->loopback) {
c19b6d246a35627 Zhao Qiang       2016-06-06  125  		dev_info(priv->dev, "Loopback Mode\n");
54e9e0874938ba5 Holger Brunck    2017-05-17  126  		/* use the same clock when work in loopback */
54e9e0874938ba5 Holger Brunck    2017-05-17  127  		qe_setbrg(ut_info->uf_info.rx_clock, 20000000, 1);
54e9e0874938ba5 Holger Brunck    2017-05-17  128  
c19b6d246a35627 Zhao Qiang       2016-06-06  129  		gumr = ioread32be(&priv->uf_regs->gumr);
c19b6d246a35627 Zhao Qiang       2016-06-06  130  		gumr |= (UCC_FAST_GUMR_LOOPBACK | UCC_FAST_GUMR_CDS |
c19b6d246a35627 Zhao Qiang       2016-06-06  131  			 UCC_FAST_GUMR_TCI);
c19b6d246a35627 Zhao Qiang       2016-06-06  132  		gumr &= ~(UCC_FAST_GUMR_CTSP | UCC_FAST_GUMR_RSYN);
c19b6d246a35627 Zhao Qiang       2016-06-06  133  		iowrite32be(gumr, &priv->uf_regs->gumr);
c19b6d246a35627 Zhao Qiang       2016-06-06  134  	}
c19b6d246a35627 Zhao Qiang       2016-06-06  135  
c19b6d246a35627 Zhao Qiang       2016-06-06  136  	/* Initialize SI */
c19b6d246a35627 Zhao Qiang       2016-06-06  137  	if (priv->tsa)
c19b6d246a35627 Zhao Qiang       2016-06-06  138  		ucc_tdm_init(priv->utdm, priv->ut_info);
c19b6d246a35627 Zhao Qiang       2016-06-06  139  
c19b6d246a35627 Zhao Qiang       2016-06-06  140  	/* Write to QE CECR, UCCx channel to Stop Transmission */
c19b6d246a35627 Zhao Qiang       2016-06-06  141  	cecr_subblock = ucc_fast_get_qe_cr_subblock(uf_info->ucc_num);
c19b6d246a35627 Zhao Qiang       2016-06-06  142  	ret = qe_issue_cmd(QE_STOP_TX, cecr_subblock,
c19b6d246a35627 Zhao Qiang       2016-06-06  143  			   QE_CR_PROTOCOL_UNSPECIFIED, 0);
c19b6d246a35627 Zhao Qiang       2016-06-06  144  
c19b6d246a35627 Zhao Qiang       2016-06-06  145  	/* Set UPSMR normal mode (need fixed)*/
c19b6d246a35627 Zhao Qiang       2016-06-06  146  	iowrite32be(0, &priv->uf_regs->upsmr);
c19b6d246a35627 Zhao Qiang       2016-06-06  147  
067bb938dad61e5 Holger Brunck    2017-05-17  148  	/* hdlc_bus mode */
067bb938dad61e5 Holger Brunck    2017-05-17  149  	if (priv->hdlc_bus) {
067bb938dad61e5 Holger Brunck    2017-05-17  150  		u32 upsmr;
067bb938dad61e5 Holger Brunck    2017-05-17  151  
067bb938dad61e5 Holger Brunck    2017-05-17  152  		dev_info(priv->dev, "HDLC bus Mode\n");
067bb938dad61e5 Holger Brunck    2017-05-17  153  		upsmr = ioread32be(&priv->uf_regs->upsmr);
067bb938dad61e5 Holger Brunck    2017-05-17  154  
067bb938dad61e5 Holger Brunck    2017-05-17  155  		/* bus mode and retransmit enable, with collision window
067bb938dad61e5 Holger Brunck    2017-05-17  156  		 * set to 8 bytes
067bb938dad61e5 Holger Brunck    2017-05-17  157  		 */
067bb938dad61e5 Holger Brunck    2017-05-17  158  		upsmr |= UCC_HDLC_UPSMR_RTE | UCC_HDLC_UPSMR_BUS |
067bb938dad61e5 Holger Brunck    2017-05-17  159  				UCC_HDLC_UPSMR_CW8;
067bb938dad61e5 Holger Brunck    2017-05-17  160  		iowrite32be(upsmr, &priv->uf_regs->upsmr);
067bb938dad61e5 Holger Brunck    2017-05-17  161  
067bb938dad61e5 Holger Brunck    2017-05-17  162  		/* explicitly disable CDS & CTSP */
067bb938dad61e5 Holger Brunck    2017-05-17  163  		gumr = ioread32be(&priv->uf_regs->gumr);
067bb938dad61e5 Holger Brunck    2017-05-17  164  		gumr &= ~(UCC_FAST_GUMR_CDS | UCC_FAST_GUMR_CTSP);
067bb938dad61e5 Holger Brunck    2017-05-17  165  		/* set automatic sync to explicitly ignore CD signal */
067bb938dad61e5 Holger Brunck    2017-05-17  166  		gumr |= UCC_FAST_GUMR_SYNL_AUTO;
067bb938dad61e5 Holger Brunck    2017-05-17  167  		iowrite32be(gumr, &priv->uf_regs->gumr);
067bb938dad61e5 Holger Brunck    2017-05-17  168  	}
067bb938dad61e5 Holger Brunck    2017-05-17  169  
c19b6d246a35627 Zhao Qiang       2016-06-06  170  	priv->rx_ring_size = RX_BD_RING_LEN;
c19b6d246a35627 Zhao Qiang       2016-06-06  171  	priv->tx_ring_size = TX_BD_RING_LEN;
c19b6d246a35627 Zhao Qiang       2016-06-06  172  	/* Alloc Rx BD */
c19b6d246a35627 Zhao Qiang       2016-06-06  173  	priv->rx_bd_base = dma_alloc_coherent(priv->dev,
5b8aad93c52bdda Holger Brunck    2017-05-17  174  			RX_BD_RING_LEN * sizeof(struct qe_bd),
c19b6d246a35627 Zhao Qiang       2016-06-06  175  			&priv->dma_rx_bd, GFP_KERNEL);
c19b6d246a35627 Zhao Qiang       2016-06-06  176  
c19b6d246a35627 Zhao Qiang       2016-06-06  177  	if (!priv->rx_bd_base) {
c19b6d246a35627 Zhao Qiang       2016-06-06  178  		dev_err(priv->dev, "Cannot allocate MURAM memory for RxBDs\n");
c19b6d246a35627 Zhao Qiang       2016-06-06  179  		ret = -ENOMEM;
1efb597d8bf56cb Zhao Qiang       2016-07-15  180  		goto free_uccf;
c19b6d246a35627 Zhao Qiang       2016-06-06  181  	}
c19b6d246a35627 Zhao Qiang       2016-06-06  182  
c19b6d246a35627 Zhao Qiang       2016-06-06  183  	/* Alloc Tx BD */
c19b6d246a35627 Zhao Qiang       2016-06-06  184  	priv->tx_bd_base = dma_alloc_coherent(priv->dev,
5b8aad93c52bdda Holger Brunck    2017-05-17  185  			TX_BD_RING_LEN * sizeof(struct qe_bd),
c19b6d246a35627 Zhao Qiang       2016-06-06  186  			&priv->dma_tx_bd, GFP_KERNEL);
c19b6d246a35627 Zhao Qiang       2016-06-06  187  
c19b6d246a35627 Zhao Qiang       2016-06-06  188  	if (!priv->tx_bd_base) {
c19b6d246a35627 Zhao Qiang       2016-06-06  189  		dev_err(priv->dev, "Cannot allocate MURAM memory for TxBDs\n");
c19b6d246a35627 Zhao Qiang       2016-06-06  190  		ret = -ENOMEM;
1efb597d8bf56cb Zhao Qiang       2016-07-15  191  		goto free_rx_bd;
c19b6d246a35627 Zhao Qiang       2016-06-06  192  	}
c19b6d246a35627 Zhao Qiang       2016-06-06  193  
c19b6d246a35627 Zhao Qiang       2016-06-06  194  	/* Alloc parameter ram for ucc hdlc */
85deed56032b6c9 Holger Brunck    2017-05-22  195  	priv->ucc_pram_offset = qe_muram_alloc(sizeof(struct ucc_hdlc_param),
c19b6d246a35627 Zhao Qiang       2016-06-06  196  				ALIGNMENT_OF_UCC_HDLC_PRAM);
c19b6d246a35627 Zhao Qiang       2016-06-06  197  
be2e9415f8b366a Rasmus Villemoes 2019-11-28  198  	if (priv->ucc_pram_offset < 0) {
24a24d07d688a46 Colin Ian King   2016-08-28  199  		dev_err(priv->dev, "Can not allocate MURAM for hdlc parameter.\n");
c19b6d246a35627 Zhao Qiang       2016-06-06  200  		ret = -ENOMEM;
1efb597d8bf56cb Zhao Qiang       2016-07-15  201  		goto free_tx_bd;
c19b6d246a35627 Zhao Qiang       2016-06-06  202  	}
c19b6d246a35627 Zhao Qiang       2016-06-06  203  
6396bb221514d28 Kees Cook        2018-06-12  204  	priv->rx_skbuff = kcalloc(priv->rx_ring_size,
6396bb221514d28 Kees Cook        2018-06-12  205  				  sizeof(*priv->rx_skbuff),
c19b6d246a35627 Zhao Qiang       2016-06-06  206  				  GFP_KERNEL);
c19b6d246a35627 Zhao Qiang       2016-06-06  207  	if (!priv->rx_skbuff)
1efb597d8bf56cb Zhao Qiang       2016-07-15  208  		goto free_ucc_pram;
c19b6d246a35627 Zhao Qiang       2016-06-06  209  
6396bb221514d28 Kees Cook        2018-06-12  210  	priv->tx_skbuff = kcalloc(priv->tx_ring_size,
6396bb221514d28 Kees Cook        2018-06-12  211  				  sizeof(*priv->tx_skbuff),
c19b6d246a35627 Zhao Qiang       2016-06-06  212  				  GFP_KERNEL);
c19b6d246a35627 Zhao Qiang       2016-06-06  213  	if (!priv->tx_skbuff)
1efb597d8bf56cb Zhao Qiang       2016-07-15  214  		goto free_rx_skbuff;
c19b6d246a35627 Zhao Qiang       2016-06-06  215  
c19b6d246a35627 Zhao Qiang       2016-06-06  216  	priv->skb_curtx = 0;
c19b6d246a35627 Zhao Qiang       2016-06-06  217  	priv->skb_dirtytx = 0;
c19b6d246a35627 Zhao Qiang       2016-06-06  218  	priv->curtx_bd = priv->tx_bd_base;
c19b6d246a35627 Zhao Qiang       2016-06-06  219  	priv->dirty_tx = priv->tx_bd_base;
c19b6d246a35627 Zhao Qiang       2016-06-06  220  	priv->currx_bd = priv->rx_bd_base;
c19b6d246a35627 Zhao Qiang       2016-06-06  221  	priv->currx_bdnum = 0;
c19b6d246a35627 Zhao Qiang       2016-06-06  222  
c19b6d246a35627 Zhao Qiang       2016-06-06  223  	/* init parameter base */
c19b6d246a35627 Zhao Qiang       2016-06-06  224  	cecr_subblock = ucc_fast_get_qe_cr_subblock(uf_info->ucc_num);
c19b6d246a35627 Zhao Qiang       2016-06-06  225  	ret = qe_issue_cmd(QE_ASSIGN_PAGE_TO_DEVICE, cecr_subblock,
c19b6d246a35627 Zhao Qiang       2016-06-06  226  			   QE_CR_PROTOCOL_UNSPECIFIED, priv->ucc_pram_offset);
c19b6d246a35627 Zhao Qiang       2016-06-06  227  
c19b6d246a35627 Zhao Qiang       2016-06-06  228  	priv->ucc_pram = (struct ucc_hdlc_param __iomem *)
c19b6d246a35627 Zhao Qiang       2016-06-06  229  					qe_muram_addr(priv->ucc_pram_offset);
c19b6d246a35627 Zhao Qiang       2016-06-06  230  
c19b6d246a35627 Zhao Qiang       2016-06-06  231  	/* Zero out parameter ram */
c19b6d246a35627 Zhao Qiang       2016-06-06  232  	memset_io(priv->ucc_pram, 0, sizeof(struct ucc_hdlc_param));
c19b6d246a35627 Zhao Qiang       2016-06-06  233  
c19b6d246a35627 Zhao Qiang       2016-06-06  234  	/* Alloc riptr, tiptr */
c19b6d246a35627 Zhao Qiang       2016-06-06  235  	riptr = qe_muram_alloc(32, 32);
be2e9415f8b366a Rasmus Villemoes 2019-11-28  236  	if (riptr < 0) {
c19b6d246a35627 Zhao Qiang       2016-06-06  237  		dev_err(priv->dev, "Cannot allocate MURAM mem for Receive internal temp data pointer\n");
c19b6d246a35627 Zhao Qiang       2016-06-06  238  		ret = -ENOMEM;
1efb597d8bf56cb Zhao Qiang       2016-07-15  239  		goto free_tx_skbuff;
c19b6d246a35627 Zhao Qiang       2016-06-06  240  	}
c19b6d246a35627 Zhao Qiang       2016-06-06  241  
c19b6d246a35627 Zhao Qiang       2016-06-06  242  	tiptr = qe_muram_alloc(32, 32);
be2e9415f8b366a Rasmus Villemoes 2019-11-28  243  	if (tiptr < 0) {
c19b6d246a35627 Zhao Qiang       2016-06-06  244  		dev_err(priv->dev, "Cannot allocate MURAM mem for Transmit internal temp data pointer\n");
c19b6d246a35627 Zhao Qiang       2016-06-06  245  		ret = -ENOMEM;
1efb597d8bf56cb Zhao Qiang       2016-07-15  246  		goto free_riptr;
c19b6d246a35627 Zhao Qiang       2016-06-06  247  	}
148587a59f6b858 Rasmus Villemoes 2019-11-28  248  	if (riptr != (u16)riptr || tiptr != (u16)tiptr) {
148587a59f6b858 Rasmus Villemoes 2019-11-28  249  		dev_err(priv->dev, "MURAM allocation out of addressable range\n");
148587a59f6b858 Rasmus Villemoes 2019-11-28  250  		ret = -ENOMEM;
148587a59f6b858 Rasmus Villemoes 2019-11-28  251  		goto free_tiptr;
148587a59f6b858 Rasmus Villemoes 2019-11-28  252  	}
c19b6d246a35627 Zhao Qiang       2016-06-06  253  
c19b6d246a35627 Zhao Qiang       2016-06-06  254  	/* Set RIPTR, TIPTR */
c19b6d246a35627 Zhao Qiang       2016-06-06  255  	iowrite16be(riptr, &priv->ucc_pram->riptr);
c19b6d246a35627 Zhao Qiang       2016-06-06  256  	iowrite16be(tiptr, &priv->ucc_pram->tiptr);
c19b6d246a35627 Zhao Qiang       2016-06-06  257  
c19b6d246a35627 Zhao Qiang       2016-06-06  258  	/* Set MRBLR */
c19b6d246a35627 Zhao Qiang       2016-06-06  259  	iowrite16be(MAX_RX_BUF_LENGTH, &priv->ucc_pram->mrblr);
c19b6d246a35627 Zhao Qiang       2016-06-06  260  
c19b6d246a35627 Zhao Qiang       2016-06-06  261  	/* Set RBASE, TBASE */
c19b6d246a35627 Zhao Qiang       2016-06-06  262  	iowrite32be(priv->dma_rx_bd, &priv->ucc_pram->rbase);
c19b6d246a35627 Zhao Qiang       2016-06-06  263  	iowrite32be(priv->dma_tx_bd, &priv->ucc_pram->tbase);
c19b6d246a35627 Zhao Qiang       2016-06-06  264  
c19b6d246a35627 Zhao Qiang       2016-06-06  265  	/* Set RSTATE, TSTATE */
c19b6d246a35627 Zhao Qiang       2016-06-06  266  	iowrite32be(BMR_GBL | BMR_BIG_ENDIAN, &priv->ucc_pram->rstate);
c19b6d246a35627 Zhao Qiang       2016-06-06  267  	iowrite32be(BMR_GBL | BMR_BIG_ENDIAN, &priv->ucc_pram->tstate);
c19b6d246a35627 Zhao Qiang       2016-06-06  268  
c19b6d246a35627 Zhao Qiang       2016-06-06  269  	/* Set C_MASK, C_PRES for 16bit CRC */
c19b6d246a35627 Zhao Qiang       2016-06-06  270  	iowrite32be(CRC_16BIT_MASK, &priv->ucc_pram->c_mask);
c19b6d246a35627 Zhao Qiang       2016-06-06  271  	iowrite32be(CRC_16BIT_PRES, &priv->ucc_pram->c_pres);
c19b6d246a35627 Zhao Qiang       2016-06-06  272  
c19b6d246a35627 Zhao Qiang       2016-06-06  273  	iowrite16be(MAX_FRAME_LENGTH, &priv->ucc_pram->mflr);
c19b6d246a35627 Zhao Qiang       2016-06-06  274  	iowrite16be(DEFAULT_RFTHR, &priv->ucc_pram->rfthr);
c19b6d246a35627 Zhao Qiang       2016-06-06  275  	iowrite16be(DEFAULT_RFTHR, &priv->ucc_pram->rfcnt);
045f77baf6b429a David Gounaris   2018-09-03  276  	iowrite16be(priv->hmask, &priv->ucc_pram->hmask);
c19b6d246a35627 Zhao Qiang       2016-06-06  277  	iowrite16be(DEFAULT_HDLC_ADDR, &priv->ucc_pram->haddr1);
c19b6d246a35627 Zhao Qiang       2016-06-06  278  	iowrite16be(DEFAULT_HDLC_ADDR, &priv->ucc_pram->haddr2);
c19b6d246a35627 Zhao Qiang       2016-06-06  279  	iowrite16be(DEFAULT_HDLC_ADDR, &priv->ucc_pram->haddr3);
c19b6d246a35627 Zhao Qiang       2016-06-06  280  	iowrite16be(DEFAULT_HDLC_ADDR, &priv->ucc_pram->haddr4);
c19b6d246a35627 Zhao Qiang       2016-06-06  281  
c19b6d246a35627 Zhao Qiang       2016-06-06  282  	/* Get BD buffer */
750afb08ca71310 Luis Chamberlain 2019-01-04  283  	bd_buffer = dma_alloc_coherent(priv->dev,
750afb08ca71310 Luis Chamberlain 2019-01-04  284  				       (RX_BD_RING_LEN + TX_BD_RING_LEN) * MAX_RX_BUF_LENGTH,
c19b6d246a35627 Zhao Qiang       2016-06-06  285  				       &bd_dma_addr, GFP_KERNEL);
c19b6d246a35627 Zhao Qiang       2016-06-06  286  
c19b6d246a35627 Zhao Qiang       2016-06-06  287  	if (!bd_buffer) {
c19b6d246a35627 Zhao Qiang       2016-06-06  288  		dev_err(priv->dev, "Could not allocate buffer descriptors\n");
c19b6d246a35627 Zhao Qiang       2016-06-06  289  		ret = -ENOMEM;
1efb597d8bf56cb Zhao Qiang       2016-07-15  290  		goto free_tiptr;
c19b6d246a35627 Zhao Qiang       2016-06-06  291  	}
c19b6d246a35627 Zhao Qiang       2016-06-06  292  
c19b6d246a35627 Zhao Qiang       2016-06-06  293  	priv->rx_buffer = bd_buffer;
c19b6d246a35627 Zhao Qiang       2016-06-06  294  	priv->tx_buffer = bd_buffer + RX_BD_RING_LEN * MAX_RX_BUF_LENGTH;
c19b6d246a35627 Zhao Qiang       2016-06-06  295  
c19b6d246a35627 Zhao Qiang       2016-06-06  296  	priv->dma_rx_addr = bd_dma_addr;
c19b6d246a35627 Zhao Qiang       2016-06-06  297  	priv->dma_tx_addr = bd_dma_addr + RX_BD_RING_LEN * MAX_RX_BUF_LENGTH;
c19b6d246a35627 Zhao Qiang       2016-06-06  298  
c19b6d246a35627 Zhao Qiang       2016-06-06  299  	for (i = 0; i < RX_BD_RING_LEN; i++) {
c19b6d246a35627 Zhao Qiang       2016-06-06  300  		if (i < (RX_BD_RING_LEN - 1))
c19b6d246a35627 Zhao Qiang       2016-06-06  301  			bd_status = R_E_S | R_I_S;
c19b6d246a35627 Zhao Qiang       2016-06-06  302  		else
c19b6d246a35627 Zhao Qiang       2016-06-06  303  			bd_status = R_E_S | R_I_S | R_W_S;
c19b6d246a35627 Zhao Qiang       2016-06-06  304  
c19b6d246a35627 Zhao Qiang       2016-06-06 @305  		iowrite16be(bd_status, &priv->rx_bd_base[i].status);
c19b6d246a35627 Zhao Qiang       2016-06-06  306  		iowrite32be(priv->dma_rx_addr + i * MAX_RX_BUF_LENGTH,
c19b6d246a35627 Zhao Qiang       2016-06-06  307  			    &priv->rx_bd_base[i].buf);
c19b6d246a35627 Zhao Qiang       2016-06-06  308  	}
c19b6d246a35627 Zhao Qiang       2016-06-06  309  
c19b6d246a35627 Zhao Qiang       2016-06-06  310  	for (i = 0; i < TX_BD_RING_LEN; i++) {
c19b6d246a35627 Zhao Qiang       2016-06-06  311  		if (i < (TX_BD_RING_LEN - 1))
c19b6d246a35627 Zhao Qiang       2016-06-06  312  			bd_status =  T_I_S | T_TC_S;
c19b6d246a35627 Zhao Qiang       2016-06-06  313  		else
c19b6d246a35627 Zhao Qiang       2016-06-06  314  			bd_status =  T_I_S | T_TC_S | T_W_S;
c19b6d246a35627 Zhao Qiang       2016-06-06  315  
c19b6d246a35627 Zhao Qiang       2016-06-06  316  		iowrite16be(bd_status, &priv->tx_bd_base[i].status);
c19b6d246a35627 Zhao Qiang       2016-06-06  317  		iowrite32be(priv->dma_tx_addr + i * MAX_RX_BUF_LENGTH,
c19b6d246a35627 Zhao Qiang       2016-06-06  318  			    &priv->tx_bd_base[i].buf);
c19b6d246a35627 Zhao Qiang       2016-06-06  319  	}
c19b6d246a35627 Zhao Qiang       2016-06-06  320  
c19b6d246a35627 Zhao Qiang       2016-06-06  321  	return 0;
c19b6d246a35627 Zhao Qiang       2016-06-06  322  
1efb597d8bf56cb Zhao Qiang       2016-07-15  323  free_tiptr:
c19b6d246a35627 Zhao Qiang       2016-06-06  324  	qe_muram_free(tiptr);
1efb597d8bf56cb Zhao Qiang       2016-07-15  325  free_riptr:
c19b6d246a35627 Zhao Qiang       2016-06-06  326  	qe_muram_free(riptr);
1efb597d8bf56cb Zhao Qiang       2016-07-15  327  free_tx_skbuff:
c19b6d246a35627 Zhao Qiang       2016-06-06  328  	kfree(priv->tx_skbuff);
1efb597d8bf56cb Zhao Qiang       2016-07-15  329  free_rx_skbuff:
c19b6d246a35627 Zhao Qiang       2016-06-06  330  	kfree(priv->rx_skbuff);
1efb597d8bf56cb Zhao Qiang       2016-07-15  331  free_ucc_pram:
c19b6d246a35627 Zhao Qiang       2016-06-06  332  	qe_muram_free(priv->ucc_pram_offset);
1efb597d8bf56cb Zhao Qiang       2016-07-15  333  free_tx_bd:
c19b6d246a35627 Zhao Qiang       2016-06-06  334  	dma_free_coherent(priv->dev,
5b8aad93c52bdda Holger Brunck    2017-05-17  335  			  TX_BD_RING_LEN * sizeof(struct qe_bd),
c19b6d246a35627 Zhao Qiang       2016-06-06  336  			  priv->tx_bd_base, priv->dma_tx_bd);
1efb597d8bf56cb Zhao Qiang       2016-07-15  337  free_rx_bd:
c19b6d246a35627 Zhao Qiang       2016-06-06  338  	dma_free_coherent(priv->dev,
5b8aad93c52bdda Holger Brunck    2017-05-17  339  			  RX_BD_RING_LEN * sizeof(struct qe_bd),
c19b6d246a35627 Zhao Qiang       2016-06-06  340  			  priv->rx_bd_base, priv->dma_rx_bd);
1efb597d8bf56cb Zhao Qiang       2016-07-15  341  free_uccf:
c19b6d246a35627 Zhao Qiang       2016-06-06  342  	ucc_fast_free(priv->uccf);
c19b6d246a35627 Zhao Qiang       2016-06-06  343  
c19b6d246a35627 Zhao Qiang       2016-06-06  344  	return ret;
c19b6d246a35627 Zhao Qiang       2016-06-06  345  }
c19b6d246a35627 Zhao Qiang       2016-06-06  346  

:::::: The code at line 305 was first introduced by commit
:::::: c19b6d246a35627c3a69b2fa6bdece212b48214b drivers/net: support hdlc function for QE-UCC

:::::: TO: Zhao Qiang <qiang.zhao@nxp.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--1yeeQ81UyVL57Vl7
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
RNsC8WGVAQA=

--1yeeQ81UyVL57Vl7--
