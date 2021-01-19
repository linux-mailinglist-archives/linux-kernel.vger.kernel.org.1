Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E372FB4A2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 09:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbhASIz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 03:55:57 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:48015 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbhASIzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 03:55:05 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DKjB56BMTz9tyhL;
        Tue, 19 Jan 2021 09:53:49 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id UZL-RsjlqZkC; Tue, 19 Jan 2021 09:53:49 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DKjB54MlNz9tyh3;
        Tue, 19 Jan 2021 09:53:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 941888B7B9;
        Tue, 19 Jan 2021 09:53:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id OJg0kw9FI-GW; Tue, 19 Jan 2021 09:53:50 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9B5738B7AE;
        Tue, 19 Jan 2021 09:53:49 +0100 (CET)
Subject: Re: drivers/net/wan/fsl_ucc_hdlc.c:305:57: sparse: sparse: incorrect
 type in argument 2 (different address spaces)
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <202101091911.UzsdDT9M-lkp@intel.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <c9bf41eb-036a-b913-5fa6-37eba8977719@csgroup.eu>
Date:   Tue, 19 Jan 2021 08:16:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <202101091911.UzsdDT9M-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 09/01/2021 à 12:06, kernel test robot a écrit :
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   996e435fd401de35df62ac943ab9402cfe85c430
> commit: 894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e powerpc: inline iomap accessors

The exact same sparse warning and errors are present with the commit reverted.

> date:   5 weeks ago
> config: powerpc-randconfig-s032-20210109 (attached as .config)
> compiler: powerpc-linux-gcc (GCC) 9.3.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # apt-get install sparse
>          # sparse version: v0.6.3-208-g46a52ca4-dirty
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout 894fa235eb4ca0bfa692dbe4932c2f940cdc8c1e
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> "sparse warnings: (new ones prefixed by >>)"
>>> drivers/net/wan/fsl_ucc_hdlc.c:305:57: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
>     drivers/net/wan/fsl_ucc_hdlc.c:305:57: sparse:     expected void [noderef] __iomem *addr
>     drivers/net/wan/fsl_ucc_hdlc.c:305:57: sparse:     got restricted __be16 *
>>> drivers/net/wan/fsl_ucc_hdlc.c:307:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
>     drivers/net/wan/fsl_ucc_hdlc.c:307:46: sparse:     expected void [noderef] __iomem *addr
>     drivers/net/wan/fsl_ucc_hdlc.c:307:46: sparse:     got restricted __be32 *
>     drivers/net/wan/fsl_ucc_hdlc.c:316:57: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
>     drivers/net/wan/fsl_ucc_hdlc.c:316:57: sparse:     expected void [noderef] __iomem *addr
>     drivers/net/wan/fsl_ucc_hdlc.c:316:57: sparse:     got restricted __be16 *
>     drivers/net/wan/fsl_ucc_hdlc.c:318:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
>     drivers/net/wan/fsl_ucc_hdlc.c:318:46: sparse:     expected void [noderef] __iomem *addr
>     drivers/net/wan/fsl_ucc_hdlc.c:318:46: sparse:     got restricted __be32 *
>     drivers/net/wan/fsl_ucc_hdlc.c:368:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __be16 [usertype] @@
>     drivers/net/wan/fsl_ucc_hdlc.c:368:29: sparse:     expected unsigned short [usertype]
>     drivers/net/wan/fsl_ucc_hdlc.c:368:29: sparse:     got restricted __be16 [usertype]
>     drivers/net/wan/fsl_ucc_hdlc.c:375:36: sparse: sparse: restricted __be16 degrades to integer
>     drivers/net/wan/fsl_ucc_hdlc.c:398:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct qe_bd [noderef] __iomem *bd @@     got struct qe_bd *curtx_bd @@
>     drivers/net/wan/fsl_ucc_hdlc.c:398:12: sparse:     expected struct qe_bd [noderef] __iomem *bd
>     drivers/net/wan/fsl_ucc_hdlc.c:398:12: sparse:     got struct qe_bd *curtx_bd
>     drivers/net/wan/fsl_ucc_hdlc.c:421:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct qe_bd [noderef] __iomem *[assigned] bd @@     got struct qe_bd *tx_bd_base @@
>     drivers/net/wan/fsl_ucc_hdlc.c:421:20: sparse:     expected struct qe_bd [noderef] __iomem *[assigned] bd
>     drivers/net/wan/fsl_ucc_hdlc.c:421:20: sparse:     got struct qe_bd *tx_bd_base
>     drivers/net/wan/fsl_ucc_hdlc.c:423:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
>     drivers/net/wan/fsl_ucc_hdlc.c:423:16: sparse:    struct qe_bd [noderef] __iomem *
>     drivers/net/wan/fsl_ucc_hdlc.c:423:16: sparse:    struct qe_bd *
>>> drivers/net/wan/fsl_ucc_hdlc.c:458:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
>     drivers/net/wan/fsl_ucc_hdlc.c:502:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
>     drivers/net/wan/fsl_ucc_hdlc.c:524:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
>     drivers/net/wan/fsl_ucc_hdlc.c:548:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
>     drivers/net/wan/fsl_ucc_hdlc.c:592:67: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
>     drivers/net/wan/fsl_ucc_hdlc.c:607:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
>     drivers/net/wan/fsl_ucc_hdlc.c:631:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
>     drivers/net/wan/fsl_ucc_hdlc.c:631:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] [usertype] __iomem *p_uccm @@
>     drivers/net/wan/fsl_ucc_hdlc.c:850:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct qe_mux *qe_mux_reg @@     got struct qe_mux [noderef] __iomem * @@
>>> drivers/net/wan/fsl_ucc_hdlc.c:853:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be32 * @@
>     drivers/net/wan/fsl_ucc_hdlc.c:854:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be32 * @@
>     drivers/net/wan/fsl_ucc_hdlc.c:857:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be32 * @@
>     drivers/net/wan/fsl_ucc_hdlc.c:860:37: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *s @@     got restricted __be32 * @@
>     drivers/net/wan/fsl_ucc_hdlc.c:865:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct qe_mux *qe_mux_reg @@     got struct qe_mux [noderef] __iomem * @@
>     drivers/net/wan/fsl_ucc_hdlc.c:867:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got restricted __be32 * @@
>     drivers/net/wan/fsl_ucc_hdlc.c:869:40: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
>     drivers/net/wan/fsl_ucc_hdlc.c:870:40: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
>     drivers/net/wan/fsl_ucc_hdlc.c:872:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
>     drivers/net/wan/fsl_ucc_hdlc.c:992:57: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
>     drivers/net/wan/fsl_ucc_hdlc.c:994:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
>     drivers/net/wan/fsl_ucc_hdlc.c:1003:57: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
>     drivers/net/wan/fsl_ucc_hdlc.c:1005:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
>     drivers/net/wan/fsl_ucc_hdlc.c:408:35: sparse: sparse: dereference of noderef expression
>     drivers/net/wan/fsl_ucc_hdlc.c:723:29: sparse: sparse: dereference of noderef expression
>     drivers/net/wan/fsl_ucc_hdlc.c:814:21: sparse: sparse: dereference of noderef expression
>     drivers/net/wan/fsl_ucc_hdlc.c:1020:29: sparse: sparse: dereference of noderef expression
> 
> vim +305 drivers/net/wan/fsl_ucc_hdlc.c
> 
> c19b6d246a35627c Zhao Qiang       2016-06-06   77
> c19b6d246a35627c Zhao Qiang       2016-06-06   78  static int uhdlc_init(struct ucc_hdlc_private *priv)
> c19b6d246a35627c Zhao Qiang       2016-06-06   79  {
> c19b6d246a35627c Zhao Qiang       2016-06-06   80  	struct ucc_tdm_info *ut_info;
> c19b6d246a35627c Zhao Qiang       2016-06-06   81  	struct ucc_fast_info *uf_info;
> c19b6d246a35627c Zhao Qiang       2016-06-06   82  	u32 cecr_subblock;
> c19b6d246a35627c Zhao Qiang       2016-06-06   83  	u16 bd_status;
> c19b6d246a35627c Zhao Qiang       2016-06-06   84  	int ret, i;
> c19b6d246a35627c Zhao Qiang       2016-06-06   85  	void *bd_buffer;
> c19b6d246a35627c Zhao Qiang       2016-06-06   86  	dma_addr_t bd_dma_addr;
> be2e9415f8b366ab Rasmus Villemoes 2019-11-28   87  	s32 riptr;
> be2e9415f8b366ab Rasmus Villemoes 2019-11-28   88  	s32 tiptr;
> c19b6d246a35627c Zhao Qiang       2016-06-06   89  	u32 gumr;
> c19b6d246a35627c Zhao Qiang       2016-06-06   90
> c19b6d246a35627c Zhao Qiang       2016-06-06   91  	ut_info = priv->ut_info;
> c19b6d246a35627c Zhao Qiang       2016-06-06   92  	uf_info = &ut_info->uf_info;
> c19b6d246a35627c Zhao Qiang       2016-06-06   93
> c19b6d246a35627c Zhao Qiang       2016-06-06   94  	if (priv->tsa) {
> c19b6d246a35627c Zhao Qiang       2016-06-06   95  		uf_info->tsa = 1;
> c19b6d246a35627c Zhao Qiang       2016-06-06   96  		uf_info->ctsp = 1;
> 040b7c94e4ec5851 David Gounaris   2018-09-03   97  		uf_info->cds = 1;
> 040b7c94e4ec5851 David Gounaris   2018-09-03   98  		uf_info->ctss = 1;
> 040b7c94e4ec5851 David Gounaris   2018-09-03   99  	} else {
> 040b7c94e4ec5851 David Gounaris   2018-09-03  100  		uf_info->cds = 0;
> 040b7c94e4ec5851 David Gounaris   2018-09-03  101  		uf_info->ctsp = 0;
> 040b7c94e4ec5851 David Gounaris   2018-09-03  102  		uf_info->ctss = 0;
> c19b6d246a35627c Zhao Qiang       2016-06-06  103  	}
> 067bb938dad61e58 Holger Brunck    2017-05-17  104
> 067bb938dad61e58 Holger Brunck    2017-05-17  105  	/* This sets HPM register in CMXUCR register which configures a
> 067bb938dad61e58 Holger Brunck    2017-05-17  106  	 * open drain connected HDLC bus
> 067bb938dad61e58 Holger Brunck    2017-05-17  107  	 */
> 067bb938dad61e58 Holger Brunck    2017-05-17  108  	if (priv->hdlc_bus)
> 067bb938dad61e58 Holger Brunck    2017-05-17  109  		uf_info->brkpt_support = 1;
> 067bb938dad61e58 Holger Brunck    2017-05-17  110
> c19b6d246a35627c Zhao Qiang       2016-06-06  111  	uf_info->uccm_mask = ((UCC_HDLC_UCCE_RXB | UCC_HDLC_UCCE_RXF |
> c19b6d246a35627c Zhao Qiang       2016-06-06  112  				UCC_HDLC_UCCE_TXB) << 16);
> c19b6d246a35627c Zhao Qiang       2016-06-06  113
> c19b6d246a35627c Zhao Qiang       2016-06-06  114  	ret = ucc_fast_init(uf_info, &priv->uccf);
> c19b6d246a35627c Zhao Qiang       2016-06-06  115  	if (ret) {
> c19b6d246a35627c Zhao Qiang       2016-06-06  116  		dev_err(priv->dev, "Failed to init uccf.");
> c19b6d246a35627c Zhao Qiang       2016-06-06  117  		return ret;
> c19b6d246a35627c Zhao Qiang       2016-06-06  118  	}
> c19b6d246a35627c Zhao Qiang       2016-06-06  119
> c19b6d246a35627c Zhao Qiang       2016-06-06  120  	priv->uf_regs = priv->uccf->uf_regs;
> c19b6d246a35627c Zhao Qiang       2016-06-06  121  	ucc_fast_disable(priv->uccf, COMM_DIR_RX | COMM_DIR_TX);
> c19b6d246a35627c Zhao Qiang       2016-06-06  122
> c19b6d246a35627c Zhao Qiang       2016-06-06  123  	/* Loopback mode */
> c19b6d246a35627c Zhao Qiang       2016-06-06  124  	if (priv->loopback) {
> c19b6d246a35627c Zhao Qiang       2016-06-06  125  		dev_info(priv->dev, "Loopback Mode\n");
> 54e9e0874938ba5b Holger Brunck    2017-05-17  126  		/* use the same clock when work in loopback */
> 54e9e0874938ba5b Holger Brunck    2017-05-17  127  		qe_setbrg(ut_info->uf_info.rx_clock, 20000000, 1);
> 54e9e0874938ba5b Holger Brunck    2017-05-17  128
> c19b6d246a35627c Zhao Qiang       2016-06-06  129  		gumr = ioread32be(&priv->uf_regs->gumr);
> c19b6d246a35627c Zhao Qiang       2016-06-06  130  		gumr |= (UCC_FAST_GUMR_LOOPBACK | UCC_FAST_GUMR_CDS |
> c19b6d246a35627c Zhao Qiang       2016-06-06  131  			 UCC_FAST_GUMR_TCI);
> c19b6d246a35627c Zhao Qiang       2016-06-06  132  		gumr &= ~(UCC_FAST_GUMR_CTSP | UCC_FAST_GUMR_RSYN);
> c19b6d246a35627c Zhao Qiang       2016-06-06  133  		iowrite32be(gumr, &priv->uf_regs->gumr);
> c19b6d246a35627c Zhao Qiang       2016-06-06  134  	}
> c19b6d246a35627c Zhao Qiang       2016-06-06  135
> c19b6d246a35627c Zhao Qiang       2016-06-06  136  	/* Initialize SI */
> c19b6d246a35627c Zhao Qiang       2016-06-06  137  	if (priv->tsa)
> c19b6d246a35627c Zhao Qiang       2016-06-06  138  		ucc_tdm_init(priv->utdm, priv->ut_info);
> c19b6d246a35627c Zhao Qiang       2016-06-06  139
> c19b6d246a35627c Zhao Qiang       2016-06-06  140  	/* Write to QE CECR, UCCx channel to Stop Transmission */
> c19b6d246a35627c Zhao Qiang       2016-06-06  141  	cecr_subblock = ucc_fast_get_qe_cr_subblock(uf_info->ucc_num);
> c19b6d246a35627c Zhao Qiang       2016-06-06  142  	ret = qe_issue_cmd(QE_STOP_TX, cecr_subblock,
> c19b6d246a35627c Zhao Qiang       2016-06-06  143  			   QE_CR_PROTOCOL_UNSPECIFIED, 0);
> c19b6d246a35627c Zhao Qiang       2016-06-06  144
> c19b6d246a35627c Zhao Qiang       2016-06-06  145  	/* Set UPSMR normal mode (need fixed)*/
> c19b6d246a35627c Zhao Qiang       2016-06-06  146  	iowrite32be(0, &priv->uf_regs->upsmr);
> c19b6d246a35627c Zhao Qiang       2016-06-06  147
> 067bb938dad61e58 Holger Brunck    2017-05-17  148  	/* hdlc_bus mode */
> 067bb938dad61e58 Holger Brunck    2017-05-17  149  	if (priv->hdlc_bus) {
> 067bb938dad61e58 Holger Brunck    2017-05-17  150  		u32 upsmr;
> 067bb938dad61e58 Holger Brunck    2017-05-17  151
> 067bb938dad61e58 Holger Brunck    2017-05-17  152  		dev_info(priv->dev, "HDLC bus Mode\n");
> 067bb938dad61e58 Holger Brunck    2017-05-17  153  		upsmr = ioread32be(&priv->uf_regs->upsmr);
> 067bb938dad61e58 Holger Brunck    2017-05-17  154
> 067bb938dad61e58 Holger Brunck    2017-05-17  155  		/* bus mode and retransmit enable, with collision window
> 067bb938dad61e58 Holger Brunck    2017-05-17  156  		 * set to 8 bytes
> 067bb938dad61e58 Holger Brunck    2017-05-17  157  		 */
> 067bb938dad61e58 Holger Brunck    2017-05-17  158  		upsmr |= UCC_HDLC_UPSMR_RTE | UCC_HDLC_UPSMR_BUS |
> 067bb938dad61e58 Holger Brunck    2017-05-17  159  				UCC_HDLC_UPSMR_CW8;
> 067bb938dad61e58 Holger Brunck    2017-05-17  160  		iowrite32be(upsmr, &priv->uf_regs->upsmr);
> 067bb938dad61e58 Holger Brunck    2017-05-17  161
> 067bb938dad61e58 Holger Brunck    2017-05-17  162  		/* explicitly disable CDS & CTSP */
> 067bb938dad61e58 Holger Brunck    2017-05-17  163  		gumr = ioread32be(&priv->uf_regs->gumr);
> 067bb938dad61e58 Holger Brunck    2017-05-17  164  		gumr &= ~(UCC_FAST_GUMR_CDS | UCC_FAST_GUMR_CTSP);
> 067bb938dad61e58 Holger Brunck    2017-05-17  165  		/* set automatic sync to explicitly ignore CD signal */
> 067bb938dad61e58 Holger Brunck    2017-05-17  166  		gumr |= UCC_FAST_GUMR_SYNL_AUTO;
> 067bb938dad61e58 Holger Brunck    2017-05-17  167  		iowrite32be(gumr, &priv->uf_regs->gumr);
> 067bb938dad61e58 Holger Brunck    2017-05-17  168  	}
> 067bb938dad61e58 Holger Brunck    2017-05-17  169
> c19b6d246a35627c Zhao Qiang       2016-06-06  170  	priv->rx_ring_size = RX_BD_RING_LEN;
> c19b6d246a35627c Zhao Qiang       2016-06-06  171  	priv->tx_ring_size = TX_BD_RING_LEN;
> c19b6d246a35627c Zhao Qiang       2016-06-06  172  	/* Alloc Rx BD */
> c19b6d246a35627c Zhao Qiang       2016-06-06  173  	priv->rx_bd_base = dma_alloc_coherent(priv->dev,
> 5b8aad93c52bdda6 Holger Brunck    2017-05-17  174  			RX_BD_RING_LEN * sizeof(struct qe_bd),
> c19b6d246a35627c Zhao Qiang       2016-06-06  175  			&priv->dma_rx_bd, GFP_KERNEL);
> c19b6d246a35627c Zhao Qiang       2016-06-06  176
> c19b6d246a35627c Zhao Qiang       2016-06-06  177  	if (!priv->rx_bd_base) {
> c19b6d246a35627c Zhao Qiang       2016-06-06  178  		dev_err(priv->dev, "Cannot allocate MURAM memory for RxBDs\n");
> c19b6d246a35627c Zhao Qiang       2016-06-06  179  		ret = -ENOMEM;
> 1efb597d8bf56cbe Zhao Qiang       2016-07-15  180  		goto free_uccf;
> c19b6d246a35627c Zhao Qiang       2016-06-06  181  	}
> c19b6d246a35627c Zhao Qiang       2016-06-06  182
> c19b6d246a35627c Zhao Qiang       2016-06-06  183  	/* Alloc Tx BD */
> c19b6d246a35627c Zhao Qiang       2016-06-06  184  	priv->tx_bd_base = dma_alloc_coherent(priv->dev,
> 5b8aad93c52bdda6 Holger Brunck    2017-05-17  185  			TX_BD_RING_LEN * sizeof(struct qe_bd),
> c19b6d246a35627c Zhao Qiang       2016-06-06  186  			&priv->dma_tx_bd, GFP_KERNEL);
> c19b6d246a35627c Zhao Qiang       2016-06-06  187
> c19b6d246a35627c Zhao Qiang       2016-06-06  188  	if (!priv->tx_bd_base) {
> c19b6d246a35627c Zhao Qiang       2016-06-06  189  		dev_err(priv->dev, "Cannot allocate MURAM memory for TxBDs\n");
> c19b6d246a35627c Zhao Qiang       2016-06-06  190  		ret = -ENOMEM;
> 1efb597d8bf56cbe Zhao Qiang       2016-07-15  191  		goto free_rx_bd;
> c19b6d246a35627c Zhao Qiang       2016-06-06  192  	}
> c19b6d246a35627c Zhao Qiang       2016-06-06  193
> c19b6d246a35627c Zhao Qiang       2016-06-06  194  	/* Alloc parameter ram for ucc hdlc */
> 85deed56032b6c98 Holger Brunck    2017-05-22  195  	priv->ucc_pram_offset = qe_muram_alloc(sizeof(struct ucc_hdlc_param),
> c19b6d246a35627c Zhao Qiang       2016-06-06  196  				ALIGNMENT_OF_UCC_HDLC_PRAM);
> c19b6d246a35627c Zhao Qiang       2016-06-06  197
> be2e9415f8b366ab Rasmus Villemoes 2019-11-28  198  	if (priv->ucc_pram_offset < 0) {
> 24a24d07d688a462 Colin Ian King   2016-08-28  199  		dev_err(priv->dev, "Can not allocate MURAM for hdlc parameter.\n");
> c19b6d246a35627c Zhao Qiang       2016-06-06  200  		ret = -ENOMEM;
> 1efb597d8bf56cbe Zhao Qiang       2016-07-15  201  		goto free_tx_bd;
> c19b6d246a35627c Zhao Qiang       2016-06-06  202  	}
> c19b6d246a35627c Zhao Qiang       2016-06-06  203
> 6396bb221514d287 Kees Cook        2018-06-12  204  	priv->rx_skbuff = kcalloc(priv->rx_ring_size,
> 6396bb221514d287 Kees Cook        2018-06-12  205  				  sizeof(*priv->rx_skbuff),
> c19b6d246a35627c Zhao Qiang       2016-06-06  206  				  GFP_KERNEL);
> c19b6d246a35627c Zhao Qiang       2016-06-06  207  	if (!priv->rx_skbuff)
> 1efb597d8bf56cbe Zhao Qiang       2016-07-15  208  		goto free_ucc_pram;
> c19b6d246a35627c Zhao Qiang       2016-06-06  209
> 6396bb221514d287 Kees Cook        2018-06-12  210  	priv->tx_skbuff = kcalloc(priv->tx_ring_size,
> 6396bb221514d287 Kees Cook        2018-06-12  211  				  sizeof(*priv->tx_skbuff),
> c19b6d246a35627c Zhao Qiang       2016-06-06  212  				  GFP_KERNEL);
> c19b6d246a35627c Zhao Qiang       2016-06-06  213  	if (!priv->tx_skbuff)
> 1efb597d8bf56cbe Zhao Qiang       2016-07-15  214  		goto free_rx_skbuff;
> c19b6d246a35627c Zhao Qiang       2016-06-06  215
> c19b6d246a35627c Zhao Qiang       2016-06-06  216  	priv->skb_curtx = 0;
> c19b6d246a35627c Zhao Qiang       2016-06-06  217  	priv->skb_dirtytx = 0;
> c19b6d246a35627c Zhao Qiang       2016-06-06  218  	priv->curtx_bd = priv->tx_bd_base;
> c19b6d246a35627c Zhao Qiang       2016-06-06  219  	priv->dirty_tx = priv->tx_bd_base;
> c19b6d246a35627c Zhao Qiang       2016-06-06  220  	priv->currx_bd = priv->rx_bd_base;
> c19b6d246a35627c Zhao Qiang       2016-06-06  221  	priv->currx_bdnum = 0;
> c19b6d246a35627c Zhao Qiang       2016-06-06  222
> c19b6d246a35627c Zhao Qiang       2016-06-06  223  	/* init parameter base */
> c19b6d246a35627c Zhao Qiang       2016-06-06  224  	cecr_subblock = ucc_fast_get_qe_cr_subblock(uf_info->ucc_num);
> c19b6d246a35627c Zhao Qiang       2016-06-06  225  	ret = qe_issue_cmd(QE_ASSIGN_PAGE_TO_DEVICE, cecr_subblock,
> c19b6d246a35627c Zhao Qiang       2016-06-06  226  			   QE_CR_PROTOCOL_UNSPECIFIED, priv->ucc_pram_offset);
> c19b6d246a35627c Zhao Qiang       2016-06-06  227
> c19b6d246a35627c Zhao Qiang       2016-06-06  228  	priv->ucc_pram = (struct ucc_hdlc_param __iomem *)
> c19b6d246a35627c Zhao Qiang       2016-06-06  229  					qe_muram_addr(priv->ucc_pram_offset);
> c19b6d246a35627c Zhao Qiang       2016-06-06  230
> c19b6d246a35627c Zhao Qiang       2016-06-06  231  	/* Zero out parameter ram */
> c19b6d246a35627c Zhao Qiang       2016-06-06  232  	memset_io(priv->ucc_pram, 0, sizeof(struct ucc_hdlc_param));
> c19b6d246a35627c Zhao Qiang       2016-06-06  233
> c19b6d246a35627c Zhao Qiang       2016-06-06  234  	/* Alloc riptr, tiptr */
> c19b6d246a35627c Zhao Qiang       2016-06-06  235  	riptr = qe_muram_alloc(32, 32);
> be2e9415f8b366ab Rasmus Villemoes 2019-11-28  236  	if (riptr < 0) {
> c19b6d246a35627c Zhao Qiang       2016-06-06  237  		dev_err(priv->dev, "Cannot allocate MURAM mem for Receive internal temp data pointer\n");
> c19b6d246a35627c Zhao Qiang       2016-06-06  238  		ret = -ENOMEM;
> 1efb597d8bf56cbe Zhao Qiang       2016-07-15  239  		goto free_tx_skbuff;
> c19b6d246a35627c Zhao Qiang       2016-06-06  240  	}
> c19b6d246a35627c Zhao Qiang       2016-06-06  241
> c19b6d246a35627c Zhao Qiang       2016-06-06  242  	tiptr = qe_muram_alloc(32, 32);
> be2e9415f8b366ab Rasmus Villemoes 2019-11-28  243  	if (tiptr < 0) {
> c19b6d246a35627c Zhao Qiang       2016-06-06  244  		dev_err(priv->dev, "Cannot allocate MURAM mem for Transmit internal temp data pointer\n");
> c19b6d246a35627c Zhao Qiang       2016-06-06  245  		ret = -ENOMEM;
> 1efb597d8bf56cbe Zhao Qiang       2016-07-15  246  		goto free_riptr;
> c19b6d246a35627c Zhao Qiang       2016-06-06  247  	}
> 148587a59f6b8583 Rasmus Villemoes 2019-11-28  248  	if (riptr != (u16)riptr || tiptr != (u16)tiptr) {
> 148587a59f6b8583 Rasmus Villemoes 2019-11-28  249  		dev_err(priv->dev, "MURAM allocation out of addressable range\n");
> 148587a59f6b8583 Rasmus Villemoes 2019-11-28  250  		ret = -ENOMEM;
> 148587a59f6b8583 Rasmus Villemoes 2019-11-28  251  		goto free_tiptr;
> 148587a59f6b8583 Rasmus Villemoes 2019-11-28  252  	}
> c19b6d246a35627c Zhao Qiang       2016-06-06  253
> c19b6d246a35627c Zhao Qiang       2016-06-06  254  	/* Set RIPTR, TIPTR */
> c19b6d246a35627c Zhao Qiang       2016-06-06  255  	iowrite16be(riptr, &priv->ucc_pram->riptr);
> c19b6d246a35627c Zhao Qiang       2016-06-06  256  	iowrite16be(tiptr, &priv->ucc_pram->tiptr);
> c19b6d246a35627c Zhao Qiang       2016-06-06  257
> c19b6d246a35627c Zhao Qiang       2016-06-06  258  	/* Set MRBLR */
> c19b6d246a35627c Zhao Qiang       2016-06-06  259  	iowrite16be(MAX_RX_BUF_LENGTH, &priv->ucc_pram->mrblr);
> c19b6d246a35627c Zhao Qiang       2016-06-06  260
> c19b6d246a35627c Zhao Qiang       2016-06-06  261  	/* Set RBASE, TBASE */
> c19b6d246a35627c Zhao Qiang       2016-06-06  262  	iowrite32be(priv->dma_rx_bd, &priv->ucc_pram->rbase);
> c19b6d246a35627c Zhao Qiang       2016-06-06  263  	iowrite32be(priv->dma_tx_bd, &priv->ucc_pram->tbase);
> c19b6d246a35627c Zhao Qiang       2016-06-06  264
> c19b6d246a35627c Zhao Qiang       2016-06-06  265  	/* Set RSTATE, TSTATE */
> c19b6d246a35627c Zhao Qiang       2016-06-06  266  	iowrite32be(BMR_GBL | BMR_BIG_ENDIAN, &priv->ucc_pram->rstate);
> c19b6d246a35627c Zhao Qiang       2016-06-06  267  	iowrite32be(BMR_GBL | BMR_BIG_ENDIAN, &priv->ucc_pram->tstate);
> c19b6d246a35627c Zhao Qiang       2016-06-06  268
> c19b6d246a35627c Zhao Qiang       2016-06-06  269  	/* Set C_MASK, C_PRES for 16bit CRC */
> c19b6d246a35627c Zhao Qiang       2016-06-06  270  	iowrite32be(CRC_16BIT_MASK, &priv->ucc_pram->c_mask);
> c19b6d246a35627c Zhao Qiang       2016-06-06  271  	iowrite32be(CRC_16BIT_PRES, &priv->ucc_pram->c_pres);
> c19b6d246a35627c Zhao Qiang       2016-06-06  272
> c19b6d246a35627c Zhao Qiang       2016-06-06  273  	iowrite16be(MAX_FRAME_LENGTH, &priv->ucc_pram->mflr);
> c19b6d246a35627c Zhao Qiang       2016-06-06  274  	iowrite16be(DEFAULT_RFTHR, &priv->ucc_pram->rfthr);
> c19b6d246a35627c Zhao Qiang       2016-06-06  275  	iowrite16be(DEFAULT_RFTHR, &priv->ucc_pram->rfcnt);
> 045f77baf6b429a4 David Gounaris   2018-09-03  276  	iowrite16be(priv->hmask, &priv->ucc_pram->hmask);
> c19b6d246a35627c Zhao Qiang       2016-06-06  277  	iowrite16be(DEFAULT_HDLC_ADDR, &priv->ucc_pram->haddr1);
> c19b6d246a35627c Zhao Qiang       2016-06-06  278  	iowrite16be(DEFAULT_HDLC_ADDR, &priv->ucc_pram->haddr2);
> c19b6d246a35627c Zhao Qiang       2016-06-06  279  	iowrite16be(DEFAULT_HDLC_ADDR, &priv->ucc_pram->haddr3);
> c19b6d246a35627c Zhao Qiang       2016-06-06  280  	iowrite16be(DEFAULT_HDLC_ADDR, &priv->ucc_pram->haddr4);
> c19b6d246a35627c Zhao Qiang       2016-06-06  281
> c19b6d246a35627c Zhao Qiang       2016-06-06  282  	/* Get BD buffer */
> 750afb08ca71310f Luis Chamberlain 2019-01-04  283  	bd_buffer = dma_alloc_coherent(priv->dev,
> 750afb08ca71310f Luis Chamberlain 2019-01-04  284  				       (RX_BD_RING_LEN + TX_BD_RING_LEN) * MAX_RX_BUF_LENGTH,
> c19b6d246a35627c Zhao Qiang       2016-06-06  285  				       &bd_dma_addr, GFP_KERNEL);
> c19b6d246a35627c Zhao Qiang       2016-06-06  286
> c19b6d246a35627c Zhao Qiang       2016-06-06  287  	if (!bd_buffer) {
> c19b6d246a35627c Zhao Qiang       2016-06-06  288  		dev_err(priv->dev, "Could not allocate buffer descriptors\n");
> c19b6d246a35627c Zhao Qiang       2016-06-06  289  		ret = -ENOMEM;
> 1efb597d8bf56cbe Zhao Qiang       2016-07-15  290  		goto free_tiptr;
> c19b6d246a35627c Zhao Qiang       2016-06-06  291  	}
> c19b6d246a35627c Zhao Qiang       2016-06-06  292
> c19b6d246a35627c Zhao Qiang       2016-06-06  293  	priv->rx_buffer = bd_buffer;
> c19b6d246a35627c Zhao Qiang       2016-06-06  294  	priv->tx_buffer = bd_buffer + RX_BD_RING_LEN * MAX_RX_BUF_LENGTH;
> c19b6d246a35627c Zhao Qiang       2016-06-06  295
> c19b6d246a35627c Zhao Qiang       2016-06-06  296  	priv->dma_rx_addr = bd_dma_addr;
> c19b6d246a35627c Zhao Qiang       2016-06-06  297  	priv->dma_tx_addr = bd_dma_addr + RX_BD_RING_LEN * MAX_RX_BUF_LENGTH;
> c19b6d246a35627c Zhao Qiang       2016-06-06  298
> c19b6d246a35627c Zhao Qiang       2016-06-06  299  	for (i = 0; i < RX_BD_RING_LEN; i++) {
> c19b6d246a35627c Zhao Qiang       2016-06-06  300  		if (i < (RX_BD_RING_LEN - 1))
> c19b6d246a35627c Zhao Qiang       2016-06-06  301  			bd_status = R_E_S | R_I_S;
> c19b6d246a35627c Zhao Qiang       2016-06-06  302  		else
> c19b6d246a35627c Zhao Qiang       2016-06-06  303  			bd_status = R_E_S | R_I_S | R_W_S;
> c19b6d246a35627c Zhao Qiang       2016-06-06  304
> c19b6d246a35627c Zhao Qiang       2016-06-06 @305  		iowrite16be(bd_status, &priv->rx_bd_base[i].status);
> c19b6d246a35627c Zhao Qiang       2016-06-06  306  		iowrite32be(priv->dma_rx_addr + i * MAX_RX_BUF_LENGTH,
> c19b6d246a35627c Zhao Qiang       2016-06-06 @307  			    &priv->rx_bd_base[i].buf);
> c19b6d246a35627c Zhao Qiang       2016-06-06  308  	}
> c19b6d246a35627c Zhao Qiang       2016-06-06  309
> c19b6d246a35627c Zhao Qiang       2016-06-06  310  	for (i = 0; i < TX_BD_RING_LEN; i++) {
> c19b6d246a35627c Zhao Qiang       2016-06-06  311  		if (i < (TX_BD_RING_LEN - 1))
> c19b6d246a35627c Zhao Qiang       2016-06-06  312  			bd_status =  T_I_S | T_TC_S;
> c19b6d246a35627c Zhao Qiang       2016-06-06  313  		else
> c19b6d246a35627c Zhao Qiang       2016-06-06  314  			bd_status =  T_I_S | T_TC_S | T_W_S;
> c19b6d246a35627c Zhao Qiang       2016-06-06  315
> c19b6d246a35627c Zhao Qiang       2016-06-06  316  		iowrite16be(bd_status, &priv->tx_bd_base[i].status);
> c19b6d246a35627c Zhao Qiang       2016-06-06  317  		iowrite32be(priv->dma_tx_addr + i * MAX_RX_BUF_LENGTH,
> c19b6d246a35627c Zhao Qiang       2016-06-06  318  			    &priv->tx_bd_base[i].buf);
> c19b6d246a35627c Zhao Qiang       2016-06-06  319  	}
> c19b6d246a35627c Zhao Qiang       2016-06-06  320
> c19b6d246a35627c Zhao Qiang       2016-06-06  321  	return 0;
> c19b6d246a35627c Zhao Qiang       2016-06-06  322
> 1efb597d8bf56cbe Zhao Qiang       2016-07-15  323  free_tiptr:
> c19b6d246a35627c Zhao Qiang       2016-06-06  324  	qe_muram_free(tiptr);
> 1efb597d8bf56cbe Zhao Qiang       2016-07-15  325  free_riptr:
> c19b6d246a35627c Zhao Qiang       2016-06-06  326  	qe_muram_free(riptr);
> 1efb597d8bf56cbe Zhao Qiang       2016-07-15  327  free_tx_skbuff:
> c19b6d246a35627c Zhao Qiang       2016-06-06  328  	kfree(priv->tx_skbuff);
> 1efb597d8bf56cbe Zhao Qiang       2016-07-15  329  free_rx_skbuff:
> c19b6d246a35627c Zhao Qiang       2016-06-06  330  	kfree(priv->rx_skbuff);
> 1efb597d8bf56cbe Zhao Qiang       2016-07-15  331  free_ucc_pram:
> c19b6d246a35627c Zhao Qiang       2016-06-06  332  	qe_muram_free(priv->ucc_pram_offset);
> 1efb597d8bf56cbe Zhao Qiang       2016-07-15  333  free_tx_bd:
> c19b6d246a35627c Zhao Qiang       2016-06-06  334  	dma_free_coherent(priv->dev,
> 5b8aad93c52bdda6 Holger Brunck    2017-05-17  335  			  TX_BD_RING_LEN * sizeof(struct qe_bd),
> c19b6d246a35627c Zhao Qiang       2016-06-06  336  			  priv->tx_bd_base, priv->dma_tx_bd);
> 1efb597d8bf56cbe Zhao Qiang       2016-07-15  337  free_rx_bd:
> c19b6d246a35627c Zhao Qiang       2016-06-06  338  	dma_free_coherent(priv->dev,
> 5b8aad93c52bdda6 Holger Brunck    2017-05-17  339  			  RX_BD_RING_LEN * sizeof(struct qe_bd),
> c19b6d246a35627c Zhao Qiang       2016-06-06  340  			  priv->rx_bd_base, priv->dma_rx_bd);
> 1efb597d8bf56cbe Zhao Qiang       2016-07-15  341  free_uccf:
> c19b6d246a35627c Zhao Qiang       2016-06-06  342  	ucc_fast_free(priv->uccf);
> c19b6d246a35627c Zhao Qiang       2016-06-06  343
> c19b6d246a35627c Zhao Qiang       2016-06-06  344  	return ret;
> c19b6d246a35627c Zhao Qiang       2016-06-06  345  }
> c19b6d246a35627c Zhao Qiang       2016-06-06  346
> c19b6d246a35627c Zhao Qiang       2016-06-06  347  static netdev_tx_t ucc_hdlc_tx(struct sk_buff *skb, struct net_device *dev)
> c19b6d246a35627c Zhao Qiang       2016-06-06  348  {
> c19b6d246a35627c Zhao Qiang       2016-06-06  349  	hdlc_device *hdlc = dev_to_hdlc(dev);
> c19b6d246a35627c Zhao Qiang       2016-06-06  350  	struct ucc_hdlc_private *priv = (struct ucc_hdlc_private *)hdlc->priv;
> c19b6d246a35627c Zhao Qiang       2016-06-06  351  	struct qe_bd __iomem *bd;
> c19b6d246a35627c Zhao Qiang       2016-06-06  352  	u16 bd_status;
> c19b6d246a35627c Zhao Qiang       2016-06-06  353  	unsigned long flags;
> c19b6d246a35627c Zhao Qiang       2016-06-06  354  	u16 *proto_head;
> c19b6d246a35627c Zhao Qiang       2016-06-06  355
> c19b6d246a35627c Zhao Qiang       2016-06-06  356  	switch (dev->type) {
> c19b6d246a35627c Zhao Qiang       2016-06-06  357  	case ARPHRD_RAWHDLC:
> c19b6d246a35627c Zhao Qiang       2016-06-06  358  		if (skb_headroom(skb) < HDLC_HEAD_LEN) {
> c19b6d246a35627c Zhao Qiang       2016-06-06  359  			dev->stats.tx_dropped++;
> c19b6d246a35627c Zhao Qiang       2016-06-06  360  			dev_kfree_skb(skb);
> c19b6d246a35627c Zhao Qiang       2016-06-06  361  			netdev_err(dev, "No enough space for hdlc head\n");
> c19b6d246a35627c Zhao Qiang       2016-06-06  362  			return -ENOMEM;
> c19b6d246a35627c Zhao Qiang       2016-06-06  363  		}
> c19b6d246a35627c Zhao Qiang       2016-06-06  364
> c19b6d246a35627c Zhao Qiang       2016-06-06  365  		skb_push(skb, HDLC_HEAD_LEN);
> c19b6d246a35627c Zhao Qiang       2016-06-06  366
> c19b6d246a35627c Zhao Qiang       2016-06-06  367  		proto_head = (u16 *)skb->data;
> c19b6d246a35627c Zhao Qiang       2016-06-06  368  		*proto_head = htons(DEFAULT_HDLC_HEAD);
> c19b6d246a35627c Zhao Qiang       2016-06-06  369
> c19b6d246a35627c Zhao Qiang       2016-06-06  370  		dev->stats.tx_bytes += skb->len;
> c19b6d246a35627c Zhao Qiang       2016-06-06  371  		break;
> c19b6d246a35627c Zhao Qiang       2016-06-06  372
> c19b6d246a35627c Zhao Qiang       2016-06-06  373  	case ARPHRD_PPP:
> c19b6d246a35627c Zhao Qiang       2016-06-06  374  		proto_head = (u16 *)skb->data;
> c19b6d246a35627c Zhao Qiang       2016-06-06  375  		if (*proto_head != htons(DEFAULT_PPP_HEAD)) {
> c19b6d246a35627c Zhao Qiang       2016-06-06  376  			dev->stats.tx_dropped++;
> c19b6d246a35627c Zhao Qiang       2016-06-06  377  			dev_kfree_skb(skb);
> c19b6d246a35627c Zhao Qiang       2016-06-06  378  			netdev_err(dev, "Wrong ppp header\n");
> c19b6d246a35627c Zhao Qiang       2016-06-06  379  			return -ENOMEM;
> c19b6d246a35627c Zhao Qiang       2016-06-06  380  		}
> c19b6d246a35627c Zhao Qiang       2016-06-06  381
> c19b6d246a35627c Zhao Qiang       2016-06-06  382  		dev->stats.tx_bytes += skb->len;
> c19b6d246a35627c Zhao Qiang       2016-06-06  383  		break;
> c19b6d246a35627c Zhao Qiang       2016-06-06  384
> 8978ca7c8b7b0710 David Gounaris   2018-09-03  385  	case ARPHRD_ETHER:
> 8978ca7c8b7b0710 David Gounaris   2018-09-03  386  		dev->stats.tx_bytes += skb->len;
> 8978ca7c8b7b0710 David Gounaris   2018-09-03  387  		break;
> 8978ca7c8b7b0710 David Gounaris   2018-09-03  388
> c19b6d246a35627c Zhao Qiang       2016-06-06  389  	default:
> c19b6d246a35627c Zhao Qiang       2016-06-06  390  		dev->stats.tx_dropped++;
> c19b6d246a35627c Zhao Qiang       2016-06-06  391  		dev_kfree_skb(skb);
> c19b6d246a35627c Zhao Qiang       2016-06-06  392  		return -ENOMEM;
> c19b6d246a35627c Zhao Qiang       2016-06-06  393  	}
> 2e7ad56aa54778de Mathias Thore    2018-11-07  394  	netdev_sent_queue(dev, skb->len);
> c19b6d246a35627c Zhao Qiang       2016-06-06  395  	spin_lock_irqsave(&priv->lock, flags);
> c19b6d246a35627c Zhao Qiang       2016-06-06  396
> c19b6d246a35627c Zhao Qiang       2016-06-06  397  	/* Start from the next BD that should be filled */
> c19b6d246a35627c Zhao Qiang       2016-06-06 @398  	bd = priv->curtx_bd;
> c19b6d246a35627c Zhao Qiang       2016-06-06  399  	bd_status = ioread16be(&bd->status);
> c19b6d246a35627c Zhao Qiang       2016-06-06  400  	/* Save the skb pointer so we can free it later */
> c19b6d246a35627c Zhao Qiang       2016-06-06  401  	priv->tx_skbuff[priv->skb_curtx] = skb;
> c19b6d246a35627c Zhao Qiang       2016-06-06  402
> c19b6d246a35627c Zhao Qiang       2016-06-06  403  	/* Update the current skb pointer (wrapping if this was the last) */
> c19b6d246a35627c Zhao Qiang       2016-06-06  404  	priv->skb_curtx =
> c19b6d246a35627c Zhao Qiang       2016-06-06  405  	    (priv->skb_curtx + 1) & TX_RING_MOD_MASK(TX_BD_RING_LEN);
> c19b6d246a35627c Zhao Qiang       2016-06-06  406
> c19b6d246a35627c Zhao Qiang       2016-06-06  407  	/* copy skb data to tx buffer for sdma processing */
> c19b6d246a35627c Zhao Qiang       2016-06-06  408  	memcpy(priv->tx_buffer + (be32_to_cpu(bd->buf) - priv->dma_tx_addr),
> c19b6d246a35627c Zhao Qiang       2016-06-06  409  	       skb->data, skb->len);
> c19b6d246a35627c Zhao Qiang       2016-06-06  410
> c19b6d246a35627c Zhao Qiang       2016-06-06  411  	/* set bd status and length */
> c19b6d246a35627c Zhao Qiang       2016-06-06  412  	bd_status = (bd_status & T_W_S) | T_R_S | T_I_S | T_L_S | T_TC_S;
> c19b6d246a35627c Zhao Qiang       2016-06-06  413
> c19b6d246a35627c Zhao Qiang       2016-06-06  414  	iowrite16be(skb->len, &bd->length);
> 02bb56ddc6711639 Zhao Qiang       2017-03-14  415  	iowrite16be(bd_status, &bd->status);
> c19b6d246a35627c Zhao Qiang       2016-06-06  416
> c19b6d246a35627c Zhao Qiang       2016-06-06  417  	/* Move to next BD in the ring */
> c19b6d246a35627c Zhao Qiang       2016-06-06  418  	if (!(bd_status & T_W_S))
> c19b6d246a35627c Zhao Qiang       2016-06-06  419  		bd += 1;
> c19b6d246a35627c Zhao Qiang       2016-06-06  420  	else
> c19b6d246a35627c Zhao Qiang       2016-06-06  421  		bd = priv->tx_bd_base;
> c19b6d246a35627c Zhao Qiang       2016-06-06  422
> c19b6d246a35627c Zhao Qiang       2016-06-06  423  	if (bd == priv->dirty_tx) {
> c19b6d246a35627c Zhao Qiang       2016-06-06  424  		if (!netif_queue_stopped(dev))
> c19b6d246a35627c Zhao Qiang       2016-06-06  425  			netif_stop_queue(dev);
> c19b6d246a35627c Zhao Qiang       2016-06-06  426  	}
> c19b6d246a35627c Zhao Qiang       2016-06-06  427
> c19b6d246a35627c Zhao Qiang       2016-06-06  428  	priv->curtx_bd = bd;
> c19b6d246a35627c Zhao Qiang       2016-06-06  429
> c19b6d246a35627c Zhao Qiang       2016-06-06  430  	spin_unlock_irqrestore(&priv->lock, flags);
> c19b6d246a35627c Zhao Qiang       2016-06-06  431
> c19b6d246a35627c Zhao Qiang       2016-06-06  432  	return NETDEV_TX_OK;
> c19b6d246a35627c Zhao Qiang       2016-06-06  433  }
> c19b6d246a35627c Zhao Qiang       2016-06-06  434
> ba59d5705825fb9c Mathias Thore    2018-10-22  435  static int hdlc_tx_restart(struct ucc_hdlc_private *priv)
> ba59d5705825fb9c Mathias Thore    2018-10-22  436  {
> ba59d5705825fb9c Mathias Thore    2018-10-22  437  	u32 cecr_subblock;
> ba59d5705825fb9c Mathias Thore    2018-10-22  438
> ba59d5705825fb9c Mathias Thore    2018-10-22  439  	cecr_subblock =
> ba59d5705825fb9c Mathias Thore    2018-10-22  440  		ucc_fast_get_qe_cr_subblock(priv->ut_info->uf_info.ucc_num);
> ba59d5705825fb9c Mathias Thore    2018-10-22  441
> ba59d5705825fb9c Mathias Thore    2018-10-22  442  	qe_issue_cmd(QE_RESTART_TX, cecr_subblock,
> ba59d5705825fb9c Mathias Thore    2018-10-22  443  		     QE_CR_PROTOCOL_UNSPECIFIED, 0);
> ba59d5705825fb9c Mathias Thore    2018-10-22  444  	return 0;
> ba59d5705825fb9c Mathias Thore    2018-10-22  445  }
> ba59d5705825fb9c Mathias Thore    2018-10-22  446
> c19b6d246a35627c Zhao Qiang       2016-06-06  447  static int hdlc_tx_done(struct ucc_hdlc_private *priv)
> c19b6d246a35627c Zhao Qiang       2016-06-06  448  {
> c19b6d246a35627c Zhao Qiang       2016-06-06  449  	/* Start from the next BD that should be filled */
> c19b6d246a35627c Zhao Qiang       2016-06-06  450  	struct net_device *dev = priv->ndev;
> 2e7ad56aa54778de Mathias Thore    2018-11-07  451  	unsigned int bytes_sent = 0;
> 2e7ad56aa54778de Mathias Thore    2018-11-07  452  	int howmany = 0;
> c19b6d246a35627c Zhao Qiang       2016-06-06  453  	struct qe_bd *bd;		/* BD pointer */
> c19b6d246a35627c Zhao Qiang       2016-06-06  454  	u16 bd_status;
> ba59d5705825fb9c Mathias Thore    2018-10-22  455  	int tx_restart = 0;
> c19b6d246a35627c Zhao Qiang       2016-06-06  456
> c19b6d246a35627c Zhao Qiang       2016-06-06  457  	bd = priv->dirty_tx;
> c19b6d246a35627c Zhao Qiang       2016-06-06 @458  	bd_status = ioread16be(&bd->status);
> c19b6d246a35627c Zhao Qiang       2016-06-06  459
> c19b6d246a35627c Zhao Qiang       2016-06-06  460  	/* Normal processing. */
> c19b6d246a35627c Zhao Qiang       2016-06-06  461  	while ((bd_status & T_R_S) == 0) {
> c19b6d246a35627c Zhao Qiang       2016-06-06  462  		struct sk_buff *skb;
> c19b6d246a35627c Zhao Qiang       2016-06-06  463
> ba59d5705825fb9c Mathias Thore    2018-10-22  464  		if (bd_status & T_UN_S) { /* Underrun */
> ba59d5705825fb9c Mathias Thore    2018-10-22  465  			dev->stats.tx_fifo_errors++;
> ba59d5705825fb9c Mathias Thore    2018-10-22  466  			tx_restart = 1;
> ba59d5705825fb9c Mathias Thore    2018-10-22  467  		}
> ba59d5705825fb9c Mathias Thore    2018-10-22  468  		if (bd_status & T_CT_S) { /* Carrier lost */
> ba59d5705825fb9c Mathias Thore    2018-10-22  469  			dev->stats.tx_carrier_errors++;
> ba59d5705825fb9c Mathias Thore    2018-10-22  470  			tx_restart = 1;
> ba59d5705825fb9c Mathias Thore    2018-10-22  471  		}
> ba59d5705825fb9c Mathias Thore    2018-10-22  472
> c19b6d246a35627c Zhao Qiang       2016-06-06  473  		/* BD contains already transmitted buffer.   */
> c19b6d246a35627c Zhao Qiang       2016-06-06  474  		/* Handle the transmitted buffer and release */
> c19b6d246a35627c Zhao Qiang       2016-06-06  475  		/* the BD to be used with the current frame  */
> c19b6d246a35627c Zhao Qiang       2016-06-06  476
> c19b6d246a35627c Zhao Qiang       2016-06-06  477  		skb = priv->tx_skbuff[priv->skb_dirtytx];
> c19b6d246a35627c Zhao Qiang       2016-06-06  478  		if (!skb)
> c19b6d246a35627c Zhao Qiang       2016-06-06  479  			break;
> 2e7ad56aa54778de Mathias Thore    2018-11-07  480  		howmany++;
> 2e7ad56aa54778de Mathias Thore    2018-11-07  481  		bytes_sent += skb->len;
> c19b6d246a35627c Zhao Qiang       2016-06-06  482  		dev->stats.tx_packets++;
> c19b6d246a35627c Zhao Qiang       2016-06-06  483  		memset(priv->tx_buffer +
> c19b6d246a35627c Zhao Qiang       2016-06-06  484  		       (be32_to_cpu(bd->buf) - priv->dma_tx_addr),
> c19b6d246a35627c Zhao Qiang       2016-06-06  485  		       0, skb->len);
> 7c3850adbcccc2c6 Yang Wei         2019-02-06  486  		dev_consume_skb_irq(skb);
> c19b6d246a35627c Zhao Qiang       2016-06-06  487
> c19b6d246a35627c Zhao Qiang       2016-06-06  488  		priv->tx_skbuff[priv->skb_dirtytx] = NULL;
> c19b6d246a35627c Zhao Qiang       2016-06-06  489  		priv->skb_dirtytx =
> c19b6d246a35627c Zhao Qiang       2016-06-06  490  		    (priv->skb_dirtytx +
> c19b6d246a35627c Zhao Qiang       2016-06-06  491  		     1) & TX_RING_MOD_MASK(TX_BD_RING_LEN);
> c19b6d246a35627c Zhao Qiang       2016-06-06  492
> c19b6d246a35627c Zhao Qiang       2016-06-06  493  		/* We freed a buffer, so now we can restart transmission */
> c19b6d246a35627c Zhao Qiang       2016-06-06  494  		if (netif_queue_stopped(dev))
> c19b6d246a35627c Zhao Qiang       2016-06-06  495  			netif_wake_queue(dev);
> c19b6d246a35627c Zhao Qiang       2016-06-06  496
> c19b6d246a35627c Zhao Qiang       2016-06-06  497  		/* Advance the confirmation BD pointer */
> c19b6d246a35627c Zhao Qiang       2016-06-06  498  		if (!(bd_status & T_W_S))
> c19b6d246a35627c Zhao Qiang       2016-06-06  499  			bd += 1;
> c19b6d246a35627c Zhao Qiang       2016-06-06  500  		else
> c19b6d246a35627c Zhao Qiang       2016-06-06  501  			bd = priv->tx_bd_base;
> c19b6d246a35627c Zhao Qiang       2016-06-06  502  		bd_status = ioread16be(&bd->status);
> c19b6d246a35627c Zhao Qiang       2016-06-06  503  	}
> c19b6d246a35627c Zhao Qiang       2016-06-06  504  	priv->dirty_tx = bd;
> c19b6d246a35627c Zhao Qiang       2016-06-06  505
> ba59d5705825fb9c Mathias Thore    2018-10-22  506  	if (tx_restart)
> ba59d5705825fb9c Mathias Thore    2018-10-22  507  		hdlc_tx_restart(priv);
> ba59d5705825fb9c Mathias Thore    2018-10-22  508
> 2e7ad56aa54778de Mathias Thore    2018-11-07  509  	netdev_completed_queue(dev, howmany, bytes_sent);
> c19b6d246a35627c Zhao Qiang       2016-06-06  510  	return 0;
> c19b6d246a35627c Zhao Qiang       2016-06-06  511  }
> c19b6d246a35627c Zhao Qiang       2016-06-06  512
> 
> :::::: The code at line 305 was first introduced by commit
> :::::: c19b6d246a35627c3a69b2fa6bdece212b48214b drivers/net: support hdlc function for QE-UCC
> 
> :::::: TO: Zhao Qiang <qiang.zhao@nxp.com>
> :::::: CC: David S. Miller <davem@davemloft.net>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 


