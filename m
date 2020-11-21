Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161C52BC1A4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 19:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgKUS4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 13:56:36 -0500
Received: from mga11.intel.com ([192.55.52.93]:45212 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727298AbgKUS4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 13:56:35 -0500
IronPort-SDR: J48Lt76TLcuLGkw2PPkCeHkHjsgPKM2Xmm/nENk3P9ZdDq2P21QBNAqHiOZdVLFfBPmndzSYh2
 zet+mljo15Vg==
X-IronPort-AV: E=McAfee;i="6000,8403,9812"; a="168097308"
X-IronPort-AV: E=Sophos;i="5.78,359,1599548400"; 
   d="gz'50?scan'50,208,50";a="168097308"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2020 10:56:34 -0800
IronPort-SDR: zoTBiWi9SyWu0FNB59y5KoC3WWhqEhjlb8zpJyfYR9xrQ6Ht7WXp+K7brlHBn1vm9BBviBJYn4
 ZoVdGuGxSbjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,359,1599548400"; 
   d="gz'50?scan'50,208,50";a="477622635"
Received: from lkp-server01.sh.intel.com (HELO 00bc34107a07) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Nov 2020 10:56:31 -0800
Received: from kbuild by 00bc34107a07 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kgY3j-0000Ot-6R; Sat, 21 Nov 2020 18:56:31 +0000
Date:   Sun, 22 Nov 2020 02:56:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: drivers/tty/serial/ucc_uart.c:661:9: sparse: sparse: incorrect type
 in argument 2 (different address spaces)
Message-ID: <202011220215.UDZkNQVb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   27bba9c532a8d21050b94224ffd310ad0058c353
commit: 4be002f1dec8418d88bbc556a0dfbaa9adc38ab0 serial: ucc_uart: make qe_uart_set_mctrl() static
date:   9 weeks ago
config: alpha-randconfig-s032-20201122 (attached as .config)
compiler: alpha-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-134-gb59dbdaf-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4be002f1dec8418d88bbc556a0dfbaa9adc38ab0
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4be002f1dec8418d88bbc556a0dfbaa9adc38ab0
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=alpha 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:515:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:515:21: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:515:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:515:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:515:21: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:515:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:515:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:515:21: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:515:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:515:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:515:21: sparse:     expected void const [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:515:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:604:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:604:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:604:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:605:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:605:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:605:17: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:606:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:606:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:606:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:612:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:612:9: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:612:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:613:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:613:9: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:613:9: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:614:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:614:9: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:614:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:625:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:625:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:625:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:626:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:626:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:626:17: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:627:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:627:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:627:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:637:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:637:9: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:637:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:638:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
   drivers/tty/serial/ucc_uart.c:638:9: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:638:9: sparse:     got restricted __be32 *
   drivers/tty/serial/ucc_uart.c:639:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:639:9: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:639:9: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:653:46: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct ucc_uart_pram *uccup @@     got struct ucc_uart_pram [noderef] __iomem *uccup @@
   drivers/tty/serial/ucc_uart.c:653:46: sparse:     expected struct ucc_uart_pram *uccup
   drivers/tty/serial/ucc_uart.c:653:46: sparse:     got struct ucc_uart_pram [noderef] __iomem *uccup
>> drivers/tty/serial/ucc_uart.c:661:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned char * @@
   drivers/tty/serial/ucc_uart.c:661:9: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:661:9: sparse:     got unsigned char *
   drivers/tty/serial/ucc_uart.c:662:9: sparse: sparse: too many warnings

vim +661 drivers/tty/serial/ucc_uart.c

d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  641  
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  642  /*
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  643   * Initialize a UCC for UART.
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  644   *
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  645   * This function configures a given UCC to be used as a UART device. Basic
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  646   * UCC initialization is handled in qe_uart_request_port().  This function
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  647   * does all the UART-specific stuff.
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  648   */
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  649  static void qe_uart_init_ucc(struct uart_qe_port *qe_port)
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  650  {
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  651  	u32 cecr_subblock;
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  652  	struct ucc_slow __iomem *uccp = qe_port->uccp;
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  653  	struct ucc_uart_pram *uccup = qe_port->uccup;
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  654  
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  655  	unsigned int i;
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  656  
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  657  	/* First, disable TX and RX in the UCC */
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  658  	ucc_slow_disable(qe_port->us_private, COMM_DIR_RX_AND_TX);
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  659  
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  660  	/* Program the UCC UART parameter RAM */
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28 @661  	qe_iowrite8(UCC_BMR_GBL | UCC_BMR_BO_BE, &uccup->common.rbmr);
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  662  	qe_iowrite8(UCC_BMR_GBL | UCC_BMR_BO_BE, &uccup->common.tbmr);
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  663  	qe_iowrite16be(qe_port->rx_fifosize, &uccup->common.mrblr);
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  664  	qe_iowrite16be(0x10, &uccup->maxidl);
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  665  	qe_iowrite16be(1, &uccup->brkcr);
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  666  	qe_iowrite16be(0, &uccup->parec);
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  667  	qe_iowrite16be(0, &uccup->frmec);
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  668  	qe_iowrite16be(0, &uccup->nosec);
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  669  	qe_iowrite16be(0, &uccup->brkec);
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  670  	qe_iowrite16be(0, &uccup->uaddr[0]);
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  671  	qe_iowrite16be(0, &uccup->uaddr[1]);
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  672  	qe_iowrite16be(0, &uccup->toseq);
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  673  	for (i = 0; i < 8; i++)
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  674  		qe_iowrite16be(0xC000, &uccup->cchars[i]);
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  675  	qe_iowrite16be(0xc0ff, &uccup->rccm);
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  676  
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  677  	/* Configure the GUMR registers for UART */
b45cc9eff72e08 drivers/serial/ucc_uart.c     Dave Liu         2009-06-08  678  	if (soft_uart) {
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  679  		/* Soft-UART requires a 1X multiplier for TX */
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  680  		qe_clrsetbits_be32(&uccp->gumr_l,
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  681  				   UCC_SLOW_GUMR_L_MODE_MASK | UCC_SLOW_GUMR_L_TDCR_MASK | UCC_SLOW_GUMR_L_RDCR_MASK,
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  682  				   UCC_SLOW_GUMR_L_MODE_UART | UCC_SLOW_GUMR_L_TDCR_1 | UCC_SLOW_GUMR_L_RDCR_16);
b45cc9eff72e08 drivers/serial/ucc_uart.c     Dave Liu         2009-06-08  683  
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  684  		qe_clrsetbits_be32(&uccp->gumr_h, UCC_SLOW_GUMR_H_RFW,
b45cc9eff72e08 drivers/serial/ucc_uart.c     Dave Liu         2009-06-08  685  				   UCC_SLOW_GUMR_H_TRX | UCC_SLOW_GUMR_H_TTX);
b45cc9eff72e08 drivers/serial/ucc_uart.c     Dave Liu         2009-06-08  686  	} else {
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  687  		qe_clrsetbits_be32(&uccp->gumr_l,
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  688  				   UCC_SLOW_GUMR_L_MODE_MASK | UCC_SLOW_GUMR_L_TDCR_MASK | UCC_SLOW_GUMR_L_RDCR_MASK,
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  689  				   UCC_SLOW_GUMR_L_MODE_UART | UCC_SLOW_GUMR_L_TDCR_16 | UCC_SLOW_GUMR_L_RDCR_16);
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  690  
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  691  		qe_clrsetbits_be32(&uccp->gumr_h,
b45cc9eff72e08 drivers/serial/ucc_uart.c     Dave Liu         2009-06-08  692  				   UCC_SLOW_GUMR_H_TRX | UCC_SLOW_GUMR_H_TTX,
b45cc9eff72e08 drivers/serial/ucc_uart.c     Dave Liu         2009-06-08  693  				   UCC_SLOW_GUMR_H_RFW);
b45cc9eff72e08 drivers/serial/ucc_uart.c     Dave Liu         2009-06-08  694  	}
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  695  

:::::: The code at line 661 was first introduced by commit
:::::: 8b1cdc4033bd1659c5499c918d4e59bf8253abec serial: ucc_uart: replace ppc-specific IO accessors

:::::: TO: Rasmus Villemoes <linux@rasmusvillemoes.dk>
:::::: CC: Li Yang <leoyang.li@nxp.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ZGiS0Q5IWpPtfppv
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ZGiS0Q5IWpPtfppv--
