Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFE82BC157
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 19:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgKUSHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 13:07:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:10068 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbgKUSHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 13:07:53 -0500
IronPort-SDR: kZukyQyKZGXT3qf4lNaEIco+/nUAQHtCqx+22wBwvK7plwn5r6uaU+rh45utU/6hUH+KU0UJ4w
 A4Fn9qFwCzFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9812"; a="150869169"
X-IronPort-AV: E=Sophos;i="5.78,359,1599548400"; 
   d="gz'50?scan'50,208,50";a="150869169"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2020 10:07:51 -0800
IronPort-SDR: QZb+m4aUo8GEKVME1BwIascjvowB5PeCJnvlWxned8Oltb0AWDDssDQz2QrBjlylNfsDV/lYZr
 RTj1h5A6TRpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,359,1599548400"; 
   d="gz'50?scan'50,208,50";a="364151374"
Received: from lkp-server01.sh.intel.com (HELO 00bc34107a07) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 21 Nov 2020 10:07:49 -0800
Received: from kbuild by 00bc34107a07 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kgXIa-0000O7-HA; Sat, 21 Nov 2020 18:07:48 +0000
Date:   Sun, 22 Nov 2020 02:07:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/tty/serial/ucc_uart.c:605:17: sparse: sparse: incorrect type
 in argument 2 (different address spaces)
Message-ID: <202011220212.67mBjHm4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   27bba9c532a8d21050b94224ffd310ad0058c353
commit: bd72866b8da499e60633ff28f8a4f6e09ca78efe alpha: fix annotation of io{read,write}{16,32}be()
date:   3 months ago
config: alpha-randconfig-s032-20201122 (attached as .config)
compiler: alpha-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-134-gb59dbdaf-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bd72866b8da499e60633ff28f8a4f6e09ca78efe
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout bd72866b8da499e60633ff28f8a4f6e09ca78efe
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=alpha 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
   drivers/tty/serial/ucc_uart.c:386:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:386:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:386:21: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:386:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:386:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:386:21: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:386:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:386:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:386:21: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:386:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:474:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:474:26: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:474:26: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:474:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:474:26: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:474:26: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:474:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:474:26: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:474:26: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:474:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:474:26: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:474:26: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:481:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:481:21: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:481:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:481:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:481:21: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:481:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:481:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:481:21: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:481:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:481:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:481:21: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:481:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:512:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:512:17: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:515:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:515:21: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:515:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:515:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:515:21: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:515:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:515:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:515:21: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:515:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:515:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:515:21: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:515:21: sparse:     got restricted __be16 *
   drivers/tty/serial/ucc_uart.c:604:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be16 * @@
   drivers/tty/serial/ucc_uart.c:604:17: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/ucc_uart.c:604:17: sparse:     got restricted __be16 *
>> drivers/tty/serial/ucc_uart.c:605:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got restricted __be32 * @@
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
   drivers/tty/serial/ucc_uart.c:661:9: sparse: sparse: too many warnings

vim +605 drivers/tty/serial/ucc_uart.c

d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  586  
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  587  /* Initialize buffer descriptors
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  588   *
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  589   * This function initializes all of the RX and TX buffer descriptors.
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  590   */
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  591  static void qe_uart_initbd(struct uart_qe_port *qe_port)
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  592  {
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  593  	int i;
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  594  	void *bd_virt;
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  595  	struct qe_bd *bdp;
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  596  
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  597  	/* Set the physical address of the host memory buffers in the buffer
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  598  	 * descriptors, and the virtual address for us to work with.
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  599  	 */
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  600  	bd_virt = qe_port->bd_virt;
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  601  	bdp = qe_port->rx_bd_base;
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  602  	qe_port->rx_cur = qe_port->rx_bd_base;
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  603  	for (i = 0; i < (qe_port->rx_nrfifos - 1); i++) {
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  604  		qe_iowrite16be(BD_SC_EMPTY | BD_SC_INTRPT, &bdp->status);
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28 @605  		qe_iowrite32be(cpu2qe_addr(bd_virt, qe_port), &bdp->buf);
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  606  		qe_iowrite16be(0, &bdp->length);
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  607  		bd_virt += qe_port->rx_fifosize;
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  608  		bdp++;
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  609  	}
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  610  
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  611  	/* */
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  612  	qe_iowrite16be(BD_SC_WRAP | BD_SC_EMPTY | BD_SC_INTRPT, &bdp->status);
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  613  	qe_iowrite32be(cpu2qe_addr(bd_virt, qe_port), &bdp->buf);
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  614  	qe_iowrite16be(0, &bdp->length);
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  615  
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  616  	/* Set the physical address of the host memory
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  617  	 * buffers in the buffer descriptors, and the
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  618  	 * virtual address for us to work with.
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  619  	 */
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  620  	bd_virt = qe_port->bd_virt +
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  621  		L1_CACHE_ALIGN(qe_port->rx_nrfifos * qe_port->rx_fifosize);
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  622  	qe_port->tx_cur = qe_port->tx_bd_base;
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  623  	bdp = qe_port->tx_bd_base;
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  624  	for (i = 0; i < (qe_port->tx_nrfifos - 1); i++) {
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  625  		qe_iowrite16be(BD_SC_INTRPT, &bdp->status);
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  626  		qe_iowrite32be(cpu2qe_addr(bd_virt, qe_port), &bdp->buf);
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  627  		qe_iowrite16be(0, &bdp->length);
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  628  		bd_virt += qe_port->tx_fifosize;
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  629  		bdp++;
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  630  	}
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  631  
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  632  	/* Loopback requires the preamble bit to be set on the first TX BD */
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  633  #ifdef LOOPBACK
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  634  	qe_setbits_be16(&qe_port->tx_cur->status, BD_SC_P);
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  635  #endif
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  636  
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  637  	qe_iowrite16be(BD_SC_WRAP | BD_SC_INTRPT, &bdp->status);
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  638  	qe_iowrite32be(cpu2qe_addr(bd_virt, qe_port), &bdp->buf);
8b1cdc4033bd16 drivers/tty/serial/ucc_uart.c Rasmus Villemoes 2019-11-28  639  	qe_iowrite16be(0, &bdp->length);
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  640  }
d7584ed2b994a5 drivers/serial/ucc_uart.c     Timur Tabi       2008-01-15  641  

:::::: The code at line 605 was first introduced by commit
:::::: 8b1cdc4033bd1659c5499c918d4e59bf8253abec serial: ucc_uart: replace ppc-specific IO accessors

:::::: TO: Rasmus Villemoes <linux@rasmusvillemoes.dk>
:::::: CC: Li Yang <leoyang.li@nxp.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--Q68bSM7Ycu6FN28Q
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICNpRuV8AAy5jb25maWcAnDtrb+O2st/7K4QtcNECZ1s/kmyCi3ygKMpiLYqKSPmxXwTX
8e4aJ7FzbKft/vs7pF6kRHkPblG08cxwRA6H8yR//ulnD71fjq+by367eXn57n3dHXanzWX3
7H3Zv+z+1wu4l3DpkYDK34A43h/e//l98/L2bePd/nb/28ib706H3YuHj4cv+6/vMHR/PPz0
80+YJyGdFRgXC5IJypNCkpV8/KCHfnxRbD5+3W69X2YY/+o9/Db9bfTBGERFAYjH7zVo1jJ6
fBhNR6MaEQcNfDK9Gel/Gj4xSmYNemSwj5AokGDFjEvefsRA0CSmCWlRNHsqljybAwQW97M3
02J68c67y/tbu1w/43OSFLBawVJjdEJlQZJFgTKYMWVUPk4nzVc5S2lMQD5CtkNijlFcT/1D
Ixo/p7BigWJpAAMSojyW+jMOcMSFTBAjjx9+ORwPu18/wPwrErFEqbc/e4fjRS3FQKzFgqbY
xFWYJZI4Kp5ykivxNANwxoUoGGE8WxdISoQjx+BckJj67SojtCAgFGCIctAw+CqsOq6FDEL3
zu9/nr+fL7vXVsgzkpCMYr0nacZ9Y5tMlIj40o2hyR8ESyVYJxpHNLV3PuAM0cSGCcpcREVE
SaZWtLaxIRKScNqiYe1JEMMG9yfBBFVjBhHO+WgcZyx3Lyogfj4Lhd6y3eHZO37piLc7CIMG
zsmCJFLU+yH3r7vT2bUlkuI5aD0BmRs6nPAi+qz0m2lRN7oCwBS+wQPqUrByFAXZdDhZLOgs
KjIi4MsMZGjrcLW+3nRrbmlGCEslcNVHXK8Np/nvcnP+t3eBUd4GOJwvm8vZ22y3x/fDZX/4
2lktDCgQxjxPJE1m5txSQZ3z+S8+0dgEYE4Fj1GlpXqKGc494ZJ9si4A10oLfhRkBSI29kJY
FHpMB4TEXOihlQY4UD1QHhAXXGYI14hGLB0U7B4KCuY7RWUvtVHzefmHofjzCLiUh0jLSGy/
7Z7fX3Yn78tuc3k/7c4aXLF1YDu2nyZyPLk3XMIs43lqnNEUzUihd51kLRTsHjam5cfzamSX
U7HMqCQ+wvMeRuCIBC00RDQrbExrbENR+GA+ljSQLjObycLJs/pSSgPRA2YBQz1gCCfls15o
++0SE5AFxcTx7QoPGgynQzpHgiVyDYwInqccdkAdbMkz4/zrdYCPkLwjVfAYIIuAwJHGSNpS
6uKKxcQlKxKjtTlMbR6sTnvTLHB6R59zWZR/uxaCC56CXaKfSRHyTNk6+B9DCbY9ZodMwB8O
btpFplikc+AEBkGxatffHPOGLQOXT8HPZg5eYkYkg2NYtI62I60K4Vx1WHosB9+UC7qqTLFl
CTPYzbljAGiARWcvzzUACZBSrqdcTyeHiLLzE1Tb5EtSbq+lXiudJSgOLW3Rsw8DB7V2gqFx
jEQE5739iSg3GVFe5LBul2agYEFhHZWQLVEBRx9lGXXu21xRr5k1oIYVyLnEBq0lp5Rc0oWl
f34aXt1upUM6gHQLhfkkCEzjUioqjCmaqKHZ3vHoprbQVb6Q7k5fjqfXzWG788hfuwP4QQRG
GitPCF679MnV8Jan01n8lxxbhgtWsqvtuHAdYojKkYSAfm4dkhj57ng5zn2XosXciHbVaNjo
DDxIFZtbvKM8DCEP0B4GNgUSADCCLqZrCCVZESCJVHJDQ4rrOME4eTykcUcLG4nZ2UujnXEa
GS7g7sanRgDhjCxBeaifgXGFBZVmtCL4DKFVYXmUJhgVyEakM4l8WHcMewJnYtpMR2UEOjlo
nLsOB5qcq1msnnj9Aef2lBQoxrZAO/iV+yCUSLD58/E15gsEkWBhpz0dGox8CHtjIq/QBOnk
7uYKnvjjH+DvbtLr0wCSux+g3Vlhhaczck2M8er6DON1srqCZigDRbhGQEHzr+LnSFwjSCCQ
oHEurpFwlTFfF2PCIZZDc3KFBCzfVVGkk/kVbIaWEQ2u8c/AZFCUXKP4wWaIH+HV2byGj1B2
bQ0gIJQhhxWr0CBBy3CV4CWNg5BmrlgD7IcR/5fGpEDa79taurhzgD71v/VEWD44P2EGW7pQ
wdC6jsmKMMCWBWcDx0aNC6iAn5LOwNMXJPmBWJeQoUnHrMDe+xwcOtPRcjs1Gw6p+OPYyren
E+fHADOw+4CBRGgINbm9c0xOjRlNbjqp/ngyGjmJHxWxkZyZ1t0qsm1O22/7y26rMraPz7s3
GADu3Tu+qVrjuc2E9bbw0vU5ikKwPbqsUMhI5Z7dKpRgBeNBVXITluMrZkhGJFNliAwlM9JR
CT0+YRQOSwg2g6UrHM06NEvwDgUFnUlRBvtUV/bsOSwoZG52YUHNvkMFsyx5ipRg5f2NufIg
j4lQsVtB4lDHffZp8XNhnxYeBCpfhJAYdWpiXFUa6Uzk8J3EzCLL0Gg6gfhAh82dpYKUqgqL
qQmqnGSGXZb1Lbcb88XHPzfn3bP37zKkezsdv+xfytpLw0iRFXOSJV0nUQc319h0I6AfqJaR
UDOVXxBDL3RgLZhKo0a2/JXUCp3yyd7WWDF/SQ2UGMIfjtzJZkWVJ9coarW9xkFkuK7Fu3OG
dvbdadcrsjNYA9dhqPcrOOrfEJR/3V28y9E7778evNPuP+/7E2zO61GVYs7e3/vLN++8Pe3f
LuffFclH1Xkwd9z4DrgbdxBm00wmbqvWobp1h0E21fT+5qqsFM3teOIUWYRE9Pjh/G0DBB96
H1AHKSPClX5UFCoNWEJAI4QyBSokEamqn1GW8sxMsfIEjjwc1zXzeWwqqTp2dmFKYEHBMDzl
Vr+hLVkV2VJI1EGpgogvZk6gVdFvqyeSzCA+Wl9BFXI86qNV6hD0wWC0uZRxp9bax8JBWrqL
NmqFLFB9ndIIu2NYRbb03RG6ISSqirMkwesfE2IuXK68nLqfw8ES3eWW0EYUFl+1zzxF7ghZ
EZS9K4gxcLZOlUnvncx0c7rslYXz5Pe3nZ1sowxiMm0jgoUqWbmSfy7CltCw/gyciAvBRMCF
C0FCaoEb+9ydoSke9gSxF7VFBjDlPHUlpuwd8bbaa4QIQEd5WU0MIAawm3wGcr727bJnjfDD
J6fXsb/XSEQkY8P/lhsjUppocw4O0WrzVHhdGC/x13DOsbq8PDTYRNqj2zqvFh75Z7d9v2z+
fNnpLrCn6yoXS098moRMqiDDpdolUuCMQhDwasdZPLfigopWgYc5EXZ/5xgEhtGd70OeT4K8
G45XWzW0Or08tns9nr57bHPYfN29OsPMEE6+VQBUAIh6AqKqeJAgmPXpNIYgKZVa5BDZiccb
K4zqhFy69pMRZdxLQ1drJp1lqEMarSGSC4KskN1SjQ/xFTb0WoeVkqvYzw5rEy4hfjQbGXNh
rKtuIDNYEkwh0Z97vBk93NUUCYEjkUJkrILWObPK2zEB84Hg0Lh3iLmSws8p51ZV+rOfuwzQ
52kI0WmrWZ91HMYxQNqhFaxQ3sw5B50MaJGrrtTcXbONGGwpzTKemcdFFQcWBEsTCnJQYlCf
M5u64AN8sMURQ1UtsVLDYU1rZ5jYpaIyrNr9td/uvOC0/8sybVVSahjGMrC0QN0fVStZ2EBH
ewDAWi393BWuKCwSKeuOULBajZxb0BClfAmxKSzhCveSqBB5WpI6v2Z0Wwa/CAfS1WRQS2ei
I6ChnrvCPeU0m3dkp523DQKjrRWxzPp1G6sjb5n7NkTV5ntAJDvfIhgxG0L5oiMV1YQZEgQo
v6DunCLiMo1zTdUPHwC2PR4up+OL6qU+N5po8UYogwgic7V/9B6sVH16VSTL2F5CKOG/49Go
uw4VNLpshmaWYZRZbEqQvvvigpPU/qiia28qdBG9jrixgK4S1uvCKRsU+0oxHMQuphDjseFN
U0kcOIOB+pGeA4olGRJWuSQZ5UlAVHOSORZcY3sKBuIDT2bfkLHATonXOC11e6aMBBQC6UEt
8TPMhPRNw65mGXOezIQjtA12KoVcbk47rab4CH+I97e34+nSmkrNOVh2phksXZMHaFdZggx9
Wq1csJqBNdcKRdKhNcInVOuzJ5sKrpn+YGxvjmS1TrjoToWylTvl1bxESlA2nq7c1XktdrQG
5cMoHTDTBkF/s4uI2jdjzG8/weHrCQCBHQ9Qce8uMFckMiX4ricjN9XwHqikNC5my94c5jSj
7gK7Rqs1gal2dwW1/yAdNTVHa5s2frjpfbVGXN37hshxrvKEphEdyHEtiitCQbEZsFw7WmXs
fPwTPMH+RaF33aPXOfbcpwtCY628zij9CrOS2+Z5p1q9Gt16I3Xfy3XaMQqIFRSbUNexbZHO
M3iFdEiexR+fJmN7BiXIaTVKDHGnMD9efJNIu31148fJ4fntuD/Y4oJIJdA3cTo2pYJWV1/C
nnkhELaoa6zOOVtfa75//nt/2X5zhxNmhLSEf6nEkSTYqhNcZdFyAJ9vpAspZpii7m9dgi0w
Ne9GwbAya6om/HG7OT17f572z193xhTXJJHI9FEaUHB316VEQkDB3e3FEi9dtrJCcRFR3+yh
B3efJg/mBOj9ZPTguu8EiOndbbt2iSnuSaJzrbaUn2qKquSGWk2vDKU0oLxfzVcV9v22ylM8
3s2i87IXEJE4NRNQCwzxqYysG80LyVKzXFZDwKDkiX2dQqIkQDFPnK4qKz8T0owtUUbKe9X1
Nof70+vfysy9HOGcnYzMf6l1xJwvWUHu2PBRc21m0FDrqzTVkpwb3lK6SsKNsnfnVc9B95ZU
FbQuexglOV1AduOGoKr4GGRgnrMelCwyu4VRwtWZr4ZAssP4wh2aajIk1gmuibWeOfanuV8C
+fQij+EH8iGsltRswAhIqaySRkZmVvGl/F3QiaHgFUzElKmxPbjZGmtgjPYIGaO8/yWzpqb6
0qo7roqGeRja5USFDLXL0Bdih2/p9E+QVlH//ew960KAlXdBwFSV19XdoSJ2pyC+HBcodd1X
0piVdYeO8ZUkrhBERWwF8anZ+YhotSPNIsyJGj28pKviNQfpKvcE0si9eGhOj4cqkJF9r9Pi
4QwAB99VtwCsKt7JjBDzA8Wc+39YgGCdIEatWehqGBxVC2ZpAFcNWMHjhc0cjkdmXZYq7xXQ
WSSbmwUpylS1xXKwJchlzRI7/kuqS7Yq9hRoRvqt1vR0vBy3xxfDHlOBSj61KpSdFVezJclB
ovBjsAOhiJy3BnGQcdb7ho6hhAhg92k6nUBq1Rb2MkhArV+uG9QaXr09qUt5/a/kqmj72oVC
Jpm6obrkqXvVj/ddvG6t8GpsmXhmfuA978+qrgwRwm67eT9DgAa5bxEK73jyqCrmlfJ42W0v
u2fj2VDFVcyD/lTE6t61CbDkIQEX6VziYGHwssCVORLtqmz0Uldt7fIx5erD/cllQifCWgLJ
gpF+rq2g2s04NUkN6a9Cj9EXmXUA8N2CR0urSKNhobpYh0UXagUqGiRRNutev6sslTX9Mp/Z
n7eGla1Pa3A7uV0VEApbx9MAK4/julFkUFh+BhwwW9umI43Ap3NDXcv8lNGgSCU1Az1JQ6bl
64r1sHiYTsTNaNwyUr2LuBDC8Ingh2IucgiDIE5R1/oNQUbg1WLe0mqrjyELwMS8jK3B6o1T
lhpGEqWBeLgfTVBseFoq4snDaDTtQiYjc1mCJIJnopCAu711XSCqKfxo/OnTqOVWw/XHH0Yr
k2vE8N301hUWB2J8dz8xA+EINiH3W4jyEyCbguB0WmVARiySdSuxTbKk3/UZc6jqgyIIiUtL
VE+ryKSwC4uLFCXURY4n2k9URogQMDjMSIEbDiUGdn/ius3QYo3MoALGZIbw2lxBhWBodXf/
6XaY3cMUr+4cAx+mq9WN6wJZhaeBLO4fopSIVW82hIxHoxvNtG7n2WtuBON/Go96hqeEDj5B
abEQpwqIi2V1F6x8/7b7Z3P26OF8Ob2/6gvm528bdZXlctoczurr3sv+sFNeYLt/U3+aj4/+
H6P1cPRy2Z02XpjOkPelzgCej38fVBZQ3aLxfqmu1cAHJvhXw1jpQrBKhtK4VhJ6uOxePIhm
vP/xTrsX/djXoTEL8IB+95Js3e2+wsKI8kiyfHLZJYIjI3jWGq/vZuv21GvvJNhdqwj5KEEF
MkDqqRGxemum5W4HQmxFA0sfOtdry2vmWNBqcL+YpG/PMG5cUMkQGGUVQ5qpCTbbSHpMeee9
/UDF2bt8f4Ptg03/97+8y+Zt9y8PBx9BoX+1uu11LOAMqqKsREpH8GDkcA3dzDyTDdT5YFdP
vfEPhpFVcKzrAdZTDw2P+WxmRWAaKjBKyuzPkoOstf/cETK4SJdYC6GeaA/AY+rD/6wyQI3S
fY3ODV2LJksbtu2d1M4MO8tc6jcLlj5pjH4fph9UXQ2Rp8tiBf9oDRqaVpQKq7CkgTDwYWWX
6TtoJQV7s5AugdkiQxEa305WLujNpPdVhPC1mSKKP63M2L0CqEtXQl8SKN8MGk/fawrIkogs
n5AUTDzeGm/4a5LSKJcdVCPAsLDqadtjbyTk5qreI+W6fI/W0w5F+DAsTUA/3JjtngrQ7fSW
20VLdesJr0Z0G6qWWVmUytuDNZ+yeZY49a526ElJRZazwW8GqQpXeVcF1N0vUOCuDqlmXNab
B4FpTNyVLQbBgzaQCVmCO7hOU0Ya12ngU4PiS+XUIcBUTpSYIFpR7x8fx5N716hr+Emfq2Cq
pfREOwLKQxHhoLf5Jfja1tcU9QNPBwfI0hJx7Y1kQxgscSHxdWYDvbgGL+t2RW+B1T3QPsuy
5ThsyCCWSjvsIL4AZ2EWoDU4jJGI6gZER5nXmfOhXYXrHzzRiZttbMBW0/HDeNCohd1rHya0
iktsjjWOClf/XZPMAkhq7RXXBc8EZ7fT+1GPK03drqREJur+5NDXAIvUdQr7g8J6PFuC1ux2
iu/Bsk0GMfqxTVn3UndtIRCCEzNEW10fk2gmHsd3A1Tq3GmKu5shCmY/sK0E4nwaqVBPWqVU
NtpZRoWAE94XcICnD7f/DPoANZeHTze9Ycvg0/hh0HW4PETK7kejcQfY3F11xRd1u8pqtuk2
TeW/B/qSmqRSR2dHUhMkNPkDlQFrtwv0VJ/NLtNyb27tdz0deXZaW2ZA1Ymt28qE0ZIT6nWr
fR2jeu+q3zkR+0KeQvWeJ2gWqR3xlUG10TDVrw8Ox8NHEYbeYXPZ/7Xz9urB8JfNdmdEpIoX
isz0RINUH1u9XdWX02IKefKoN8RpiDWCsoGHkAqJyWLgEWPkukJkIp94Rp86M50RBpagAwQI
Ht9NVh2wjhVdyxU0ntxYy1DA0HUHmDnu8DOjJMnA39OEoMwCKR9v1YEq2MCjjwrpKg9VuJvb
uw67pq7oHqRt1trIpMpqqMGjhPSLCF2CKmkSg+WGiq7siEGYSoXMei+5a9kFLpdfljPrKkcN
xKyg5cOPVxOmXsWZRkbBUvvgq4K2Kq1XjA2D5Kc1zJBEmAvX84L/Y+xauuPGcfVf8XJm0bf1
fixmoZJUVYollSypqhRvdDyJz3TOJJ2cdGam+99fgKQkPkA5i8Q2PogE3yAIglVZlg+unwYP
fzt++v56h39/N3fSeL/zXsmCL5T5clbcWBcyCOERZFA63ssGod3sl6/bm+JuBH/OnXakIYwl
3/7zw7QGbBu+truaPrrnl+8fmZ2m+vXyoG9uMfSRtEsyD384x1/KB3OVOIFkn+RE+F+Y/yTD
KQKgmXQD7X3AGWCnvM/QZ/Q1Go4Ku5KWhCrC4OFQM2WDEusf6hzdG8JdaqimrBsswct43Vzb
oNqV8NRxMbdavWqNc8qaUj+HW2hzO4QhfUN2ZakpY+uKls3VdR5duYZW7AhqgksuoVTf2uxy
RG/l3fW3l+8vH36gc4x+oDGOSvybG72VvLbVlCZzN76nNVG+eTPwBS2Yke+KZ2bZ6mgxvH7/
9PLZ9PjBVsjqGRaH+n0uH/YIIPFChyTK0X4uq/GW4FOOOmXAjcLQAT0jA5Jq2ZKYjnga80hj
QBoutaqIyBnntGOvkgS5iZIYmrKdm/ygzgYL2PbzNcPLgQGF9nituClXFlKAchrLtiCvfsls
2dDh/Y8bpmVpjrtyOVCF9JlhFXH0koTUqSUmmADcRLY2yeDi2kjnDBuXslX1WjVli2+C0gK0
HUziYE4YhgCXo6wN8mNTUD7xC0iIjQZmFSZWGpECO7/bky+HAsSuu1OBQ9bA5Hgy6k7Qed+Y
A0N4BTe6F2zkfHWfKdMnoro19dcA5QlA/xZlqKuRUoEXac+wE6nMQjDyNko8I2nBIQbyWxns
CXkesJ+iR4M9FVV3k4g7M8m7gbT/cJAdxWIPN1piRXaSHqpjRV7CEXiNUW6ezKRLszfleTt1
BNmNqgEd4lnJrTDRX7ZP6QN2g21Qw4EJHOa/Q9kXmeUCheA65E1kc4VfhiJXgt6N2Qn70k+w
6mxalz9O0RQ5hMh4Gr3/bTMNsLxm/WjUqDhv7oZZwHriDahARupGAfqdGu9lvXyjbYNsM/kL
9DhAV+pIeeGvcmIejdWpykFf6M1Ogm6EOdV7GUANXaPQsIQ+u364xzOMjW/THjGJG+zrZrH4
Gekz8CcEudx3Z3PopzsSVPWhBKVqxn2Y0QIKOvOAAeaCr3KRAi+2G1Vb03PLx75mKjVRG9xz
uC2ynlo2TxeM9gPT6ShvvNvL86VRXF2Y3xnw0M6lPLDo5TqSIfQ4PFSttCk+33LD0VUIzEIb
yP6h6/GRpPZtNB687B+rjVO4TC3T7Obp0jXVEvhXo7KrAxjTTTlOZAi6fvDQKZSPD7LwkzXm
JNQfoaBa2oNSjZwEEz1ZjwxlQZ6LC23e4ELhVcwLaflh+GM+zIdGUbKEuogIYwGY8v3q8gbn
bplN2i3zNA4jgQHlsFMT5zsG7ynUa0Yrkcd/rC5NSfvMboyHLPBdQvCNY7XmEl8bcwrBY7sy
tHHk2a26KvZE6Wsy4uaGi5thZr2wqqfoj+X7YcRYyWR+OQx88uZ0MdbSYMm6rq74JS9xlwJN
yQ8fiH3pNnu8b3NYvB61HdHmu5Bh1Np2xrjvlGPECgeqb1nee8FEznFWqbavoYfZOglAjxom
kD67L1PNZu7MJk4vb6CGhpGSju7qu81zOfyz3C2Fpb5+b/PZMS0Am3B8BPRXWD/Rd2G95MBN
YKBsGdY7xake/oDvoLar9qjGQvVyES6KmicQPMNX5U1NqrlOy+ao+c/nH5++fX79E8RGOfLf
Pn0jzXDwWdYfuEkHEq3rEnZ5lkwhfb5Q6bkCleetkesxD3wnMoEuz9IwcG3An8q0u0BVi0sl
PbUKnr6kBhSiRSmlYebb1FPe1YVsDt2tQjVrcesGzTSW7Adxa2LtGNnnf339/unHb1/+UPoG
KLynCwal+KITu/xIETPFgqsmvGa2mr7wVsHWC8R88gDCAf23r3/82L1PxjOt3NAPdUmAGPkE
cdKJTRGHkUFLXFfrC+dqCs+Fp/eDSjPuydCQn9U0uqqaAj2Flh13kRe8EL1VRZVBd76qSQ3V
EIZpaBAj39EzAGoaUftWBG/y7TlB6PqL3DF47PaHf+L9D94CD3/7Ak3z+a+H1y//fP348fXj
w6+C65evv//yAbrl3/VGwk2TLhhXASyCZWOqtQBSMPLureTBsmGZb8dMGzrZNOklOuApCrrv
m+THS6szm7fU2eyG0fZwprENZljGW/mQjY9wDE/NbqWpO2QNZGXa1lcNlaxMFgYjX2m7pZSi
PNpUFoaePMc2u3NVI9QT1GtEnYOq07nOMPqAbYA0J1VwtBTVnbEgVZfOV80ISH33HMQJpSwg
+Fg2nRxWBml1l3uPKqkZo3DSl4kxjjx9IbhFwWQwToMxlrnKaxHqgr1gUBO54D03LRXbRpJN
IXlGeg6pTA10Yso/koGtUZXdRG1NEeGXBPJK/2I1QFm+6yvVLMvmIT/3AvKEl6FncQRvTl/N
WNKOPxzuya0LQqORFursRzqi4IbHO/jVt/hKMPjaRrCh8u62agE1+OkKe5le7QTMwjwfuqZT
6av1m6TO2vK7RhNRyffGqAYRFMTWT0U4FCWVqe51QpfqI4LFblkuMPwJCurvL59xCfmVr+cv
H1++/aDDzDCpsssAm2OlWzOey4/fuMYj0pFWInWZKevycTSnPaFK2cYDjKhqMLQWUkMxegPl
wcYgc0oXKxe746BLyL1e9bs/BAuqWFZ9Ehm0S5uyxi+l55MmQM3G2lVWfwfEGnwHqde/0DZN
/HCwqx6alz+w6TeHHTPsFXMT54rCXwqtT/1APh9i7uTnONXzFkFG/NjmzsQ+1A5dFAwUjOug
noEt38wwcAvlsheDJu7eDnsUHoBQyQxUDC/xqXs1EppdJzVNYa9WCyyI83kwZEBF5smkVuMh
U0NsIlnEt7CItES/IMu6HEep1E0RMTrPHZ0MLTlhtJtcywBozEPwi5pO2aU+fe4CIDc/o6za
VwiIYlg7A3flPsLUaT0fAK526uZjXU5aShKHsJVKFFBt4OfRGFCWgzJA3mmHKECquyQJ3LmX
70yvZVZOYwXRaDIkmg3JrFL42zHXa40rRNaq4LqRbUIYHzGSvloG1IjmY3UlqKLV5AKzIyn1
SiPSLzl750ojgubkBfo4GStiLCDr7DrOo5ZCjx5aCqmrct8jSPPwpMkKOpM3TXr7LgGyLFXU
Ex11T5VCHNSmKNBO0ZCcuwls9xyLcw1y0DFJOAQTyc7AsJ8dIsgWsmb09LM9xDrLQ0sLOGfF
Tra2Y5oF4237RaVjfwnUBmceQxof6mYa16qN6YvYVFk8zTsRvc51KX+gFfYcmFbQ9V1PeUXR
GGpLQWhnWse+dHldHY94gqgWY5wmYymkgkZJ8IQB8tT0daWP0epOI4xlO2TwA+8wqlI8Q2US
zYPkpptPJpI1m/cQKgiSccu8q4eNstkSkX8JfCA0C02PgH9ayAM2v6xOkSUZi4vVZl1G3uRo
PaXWglRu4wBPG3YHinjkB+hjf6nldBulRhqMUAmzYlMxA6hkvpf9Os/sUtpmoOVOioMcGuqP
xZDGyJ8/4Q1VKbgoXvc7y866XTcof6zO7twa1w1LIkRALuCGXokBeB7ZsYuakICYyxiJCNvt
mpF4s/brd9MoOHYgxtcP/9aB8ncW/7c7v4clkb3F2JYjPvCKcXVZ6wxj1nQYEhYD17++PsBu
ArYiH1lQatifsFT/+D/5gq+Z2Sq7MNeurbhc9xDAbLwyWLWNrOBJ/GjlPV7bXHNuw5TgNzoL
BeAa/ybS2jsXYbKp85yU6J0rA2i80ASBmjtDZK/vhXho3CRxTHqRJegQd+2Ib4osdSLFbLog
wvFrR7wm7zx/cBL1jMJAlalFR6mc++eMUmIk2KOqs39uae/1hQFv0tiCeS4sY3O0XPMQHMKp
bUe+S17W8uusK10JwLpkGDtEiw0pReUGWbIn8dPaE7Xq6TzhXgKWoJVLB8MtkWsLWykzkbuq
tQpZsBZVK1+w/P2pvQ6zMigXTB+GnNZZUmoHTyRjiIgfAbRbjGyAjep+Qcse1uT5cApyS8TC
JTur2XHhAG2VkhOV2PCN70DNM8veDA3Zyt1T4kS7nQQ5koAalVX3FDju3nRV8eQtHydOvJcz
cESOmxAzxdAkUeRQqSKURpTJcuUomjRyQzrVKSZmVpamG1mzi/eHCONJ9wrKOSJapDRNTJGe
8iFwCFHZ1oRpJqiVmAlyfDjY8CGP3cQh6EUTqd5xEpIEtCvXytIkbrg/cIDFe4PFvOJqpoL2
6jfmIrE522kN2Gp1x5yYgRndMrUAiJqB4YS1Dkv4smzKG735k7n6JIv9bK+7LFxxQKwIG+jt
gf4eGNhKwOH91t743pgsN0bLu0Im4+FnGfO9GWBjK93dksbJz6TCzJo2MN1rotTdA0mNZoP9
n5EtJeaIDQzJES3hP1nd2oS7x/jTKe5pCxtb/EYJkp8VLP2pDpOmIV2fwzn2HN8mC6K7a+zK
lO4k4WdvyQhMIIZVwtizdimGvtWjGJN1bkDUpw/qdLYw/omcEntVx+qLNCo6+fvzP5q0hjxN
dpUEZrsilzt+Huml+5lwrmhPNRInl0FELCYcioiJhUFnPn/T2TadG9LnoQvbiG9VsIgvO+KZ
93h0ZK4LYnZZUdDo9+ChLgi9Rv6aaP8NngayeSTZIuqkj+BzyTVAYvD2Oooskb9YYJrXj59e
xtd/P3z79PuHH9+JW3YlRqdrZIfmVeWzEOcbsZ4jvbkot1hkqMv6itggoSHYIUvNTgv2pgHG
QHTLZkxcn9xGIuLt90eUx6WsyBtDFEeW1COYld/4NI2tZd3PNXFjcpwhkuxXUxK65BwF8vip
Vh3ro0SWXmOkjh6imdkIsCeIa2raZEBK9J/y6VrhK+LcoVmAqMIqh1WCwGJM4uX9ua6aavxH
6K43Sy5HTS1ePqn6J/XBEm4B07Vk5jpqBO2SQeMZGEZtsin2nc1jlT/r9OXl27fXjw/M1ckY
eey7ONhim8j01etNIRo2Fok8D1aPKs6Fx962QvWQxqHs+/d4Zjp1mjCru5tJnk6DcJDTMNMX
jnvlWs+QObydE6vfFXc6VjUDS3zXt+vNmiG9sBlyHPGH4zrGN6vJdM9TinP2Fq8+hp7re6FV
ihL6iFFYbJVbrlP1a60L1deODXnXOyTREFP7SA6X7TPMe1piTYdRdSa9F3P/NY04GZ19GjQK
O3mQmkHBJr3jqO80cVKRmcMwa7Kw8GCOuByox7k5Eztu1FIbqstkdL2hxcMDzalaY+noq0kM
G7t5ussRu5e5ImcnwWpKxjtVBOwmtLmGcwxBYvFF4Tjhh6Vy7JzjMfw2JWGoleaeF8JhRk2L
BZqZB+sI1E8AObHujDZ9tvbTDMOuMK9n/XE8ahZdPYwZ9fXPby+/fzRn16zowjBJ9Gm0aDuj
hCd8Qsna+Hx6d4yvGN0Se4l3frwC4L/FEFOKnYCPSRjrNTt2Ve4lrikP9JpU7zWSO5dWWXyp
OhZvVGJfPXNfZzWvQwGCu839Zi8cHuCQgZYZ+i5rn+dxrI2UuQeu7bO6S2Lf7KJcF9lrQNDc
HKMiByAmEUVOXc+s36dmSqigxXz0NInvmpLdDavr1sPNyl8fxTEaRVvP+U0DmyyHMZmISqqn
A+XyuoGePtfXsGyd9Sldvp0gKLCVK+AXVdlcsJKDlge5xQoAy5tru5BlVMd6mL/bd0G9cpnR
X+sLGO6P6kI4yq1V2uS+nySmxtBVw2WgI1/yeRCm+sDxyZIRJVAH3+kEK1Y2yr5RXJhL/niV
1Im7u+z53F/+90n4nm7+DatEd1d4X8KPsb9Q0/HGUgxeIMdDlz6WlQL5A/feUICqlG/04cT9
3ER1ELLLZRo+v/z3VS+O8KU4l2Q8zJVhUB5+WMlYRCe0AYkVYI8wqw9QKByubwHkG2QK4Ck7
PBlKHMoGqXzsO5bsfNeWauBTG0eVI6FTDZ2JBmL5yEYFXBpISvn0SEXcWNYG1D4gbWjZe7DZ
jXySlmEssrCyB97IbKeCmxvaMKAxam/8EVw8wt56M1ra6cpM6smNhuCvo+JJLHPwE/z9MrHL
YuTtbJK9HnMvDS0HQhIfmgxoo4zEtCv8eomYRIUubSkUR/funCtiiBshZEbPkkLVlyxQNwti
Knsk8twk9I0Mh9xT3gPFl0QaLXXls+HadfV7XUBONR4QljHt7ZOuyDguDTCmiMw4PV0VHVwA
jJ0oD3ubS0sLHb5OOMBAl3YiaRQfshFm8Pdzlo9JGoSZieR3z5HPtxc6zgeRNGHJdHkCUehE
zozumfThMJjyc+JaE03WZoJM9vslrcMTNiu1TK5SMCVXTltCXPLVkoUBFA435vfSaYRMlmGG
qqQVFzYO0Fw+fQSxMEFKSepQI3rhQGXbi2UpFsRi+9iSZvVrtkM9+lGoLEqSNG4QxtSRzMJS
lCN7b53zRmpYTykdpuu/VXRgIs8uFxbuotAcDmYhoFcEbjhRuTOIPMSTObwwplON/dCSauiG
+02OPEm6X2wojh9QNbx0rlN2PZV8RQiIIbdEaTGRfgwd36dk70eYHigNZhUKpk6f7BLXfHAd
h9pBroUu0jQNJRVfmx3Zn/OtUoyDnChuTmku9zwcG48BTMQkFM8KFSCw4kwkIQHt4C0zSHrl
Rm9cR748qgIhnRlC1H5U5UgtqfqW7Nw4JoHUC8j3mbJihPqw3JySeOgrnCoHKRIAqiOoAlnc
O1Qe8irVwoH+dFuf2ci5uM9rpjlV8zFrF9fs3bR1o/2KjFNHeyGsr1qN7tzd6IBfnIOFExnL
pjNrrRgij3gRC9+4oroZX8agsnKzIqrwcc6agwkMXdZPoZnYEZ23wiNVcwgl3pG2wm5MoR+H
dARMznFSLvoIYpO7fpz4rBBE1qc6dBNL1LyVw3OGxkz5BApLRqYJPWQvQXbYkLVU+5+rc+T6
+323OjQZeYohMXTlZApcjQkxht/lavhgTgWNr3c9qrOw4NynkgDYAkG0PAeIrAUg/LGNgi6w
5aaczJVSgo45LMhEt0bAc2lBA88jJxUGBXsTBuOILHJ4ETlloMqiGexInsghXY4UFpeY0RkQ
ESsLAuzk2aT7LnfFIRGfnOvxwTftIh/N49OeKQpPsDd2GEdIVDID0tgiHUhuUYK2aaLzHfou
4sJRT/hiEA5c6jnCPAr3lvimbI+ee2hyoYwQC1qu3f9buk8TURrpBlPLFFB9shs3u4sewNQw
bWKiC9VNQnV22E3SGSf7GVNTU92kZH8Dui0I+MqwX2dp6PkBmWHoBdSUwQBS4eryJPZJfy2Z
I/CI0daOOTdSVsOoRrMUeD7C6PWJD3N0LQmp7gIQbJj3xpBw7yeyGzLfc6hEL3k+d4k1uupS
zGMSylF2OhETyqyyxohFRmic3m5XPeD7J8eSSh7Wvzk/Hm0v4yxc7dBde3xAp9tTKqreDz1a
4QNIv55A8HRDGOgR23WmoY4SUFPe6NMe7N73FHu2EsaJdSmN0UJ9utZ4dLCfjJ+4ZF8Xa9Hu
RMeWHIcYQ4B4jn0FASzcnX/ZNJ4QyzYiQRDQq0ISJcTk1U0lrJj0w7Id3l4gna8kltCPYmLB
veZF6jhkugh5tlASgmcqutLdzfq5jrRY2qJA90YsTRogu/EsS4+R73AeXVvE25Vjd3UE3P/T
zB3IOTl2RMCx3TyLpgSNg7JMLBwlaPeBQy44AHkuaceSOCK0RhJSN0MexI1LbG4EkhIqM8cO
fkqsZMM4DnFI10TTRLvaHWgGrpcUCW0hGOLEswExvU+FcidvaGtVm9FXPWUGag0Buu9Re8kx
j4kFdzw3OaXOjU3nOkQdMzrZ3gyhrkRIDAHV2EgnBW660PVN+q3KoiTKqGXyNroeefy+MSSe
T3Sre+LHsX+iyoVQQr9DJ3GkbmFKygDPBhBFY3Ry4ucIzjDomrkvTA2T9Eiu+xyM2v2NPnBF
XnymTnNUlvJ8pFqBH2hQRxmoamXSpVZBwFeQR1DBlIfiF6xsyv5UtviCiThl2t4jdbbMF3Y2
xdrzni9HM4t7X434fOk89lVHiLC8l3e64Fu+ZTffq0EJH0AxHrOqh+k3s8SAoj7BR27QfEP6
Yi4fqGmbwr4pJDJgKCH2365sb8qUd1epUdfvi/J27MunBdrNo2xQH6p220xEERJUFuVnyXWl
YqxBipg0jUl/9M2+yJ5mM1mHrsx6k3u4tkllkpd4MWY66F9J8CMVejchz2PVP94vl8JEisvi
WyFTRbQsqjnYlX2qNQQD3gbYBJaeIsdAbV+Ud4D4w+d5Vz1U7egHzkTwrN4B+3zqk+U6zNI5
fP/68vHD1y9EJkJ0vDweu65ZHeJWOQFwlwHyC9iB0fShlypoldwqnuVR+v9n7EmW20aS/RWd
XnQfJgYLQYIHH0BsrCE2oUCI6gtC7ZbdivFYDtmO9/z3L7MKAGvJoubghZmJ2pfMrFycvRjY
xNtUq+KKubWLMBJSeGNmEb+h1gQioptFZ32yi8hVs/b//R5Ki7Cn/3z/+fUzuVLmyqT77s3K
XKWsYwinWWsu4/ufT19ggqgFtBbspFlK/uMS7Lc7anZW/x73DAiPMuJTKpD/8gk/wF3HOdMy
agNUOZWAhIvIg7+0r1ImsqmTXy9YE4hx1c2vrne6RuJoLM9Ye7OEhcDxvYy/ju0T6XXo1utE
JE434YF9mxBlIdggkm3HfKBE+zUK2ixhpYBNTD3jIv7afKvwGVUzUg+ikpR1kk5p3Rjtd3df
C/0jQjJ9+vn1I0bKWXLRWWdRXWRG6iOE2AYlCJWZ/MpOvu2o5EToRQnH0IsYfS9ta/MTRB2r
VH3sQgR0JNp7qqwjoIuls1EKhsi5UDA96AzCV0+pqwHKCnWo2hQCI7ymGDb0pHLI8SuejHSy
YuOILJS0XbhiVect9PqYzV+0YZzfErVgegt8G+gjI2ChBfMjPQMsQOeDu+oSTi1eJCmTIccA
Tsb7oBjK1A8v5szOQD0MkIqwJ7ILtuI9XZ/IC7Srh6XpnI/6EsAdyA0SheDItiCaLtEwtG8B
FUUXgSI+PmKW94SzVNEdY2ZMpgZ7Q4AWUx7LZfdcS/uLMGGUn9ZtprLBiDDDYiMsjkUiawoY
metf2vZYUMMq/wpVjfKv0H1oDb2wYaIURwI7bMOtWb7wfNRX5vpkcyXN/xAZHDprkyDQUV2f
D2e9ssUOS9GUz5BJO8lW6BzXTKsSBpS2QRMHox1kRTRF2tMbQMtIR0BPMalNEbgmGraqNkpU
yTa77Zq7TSuL1xFpQS9wp8cYVkFgfSNMJ13rOzlcIs9b7gn9w6HuaJF3vjEwpDbw4K72WPam
CB0wvmAYwoYbeHprS1dduN9QSse5lKpW1gK6lPhedNEhked7JmRnzJnio6K3E+GB71r5AyM8
ZRREtHVfHnPRrjVBuceo8BsX2kpinbgPlR/sQnJNVXUYOSwZZYdupvITJC6/HUQajnDiGp99
niigfScsCKtP4sbUA1WIrtaRT77aLUjdLVVC473prW2iXdM1uyX9smH2DS19lawNOjxsYlLN
Nu/CMIA1tURxNLcoIAXKdWmLuHbGYlj9EGdgL1w4uuvyUPPauPjM9ePlIUwd1RXojFR+pSjY
BVPcttUgjWGIQjDd11kmLuTnmrSuvhKjokvouVZyumVwlZYxmX9Fo5nvYKIAZKVj8sFBp5nZ
baqELAr1lUURNfAPdScqJAazfMXYPLeCszlvZd4Ww2sSs3VjQgcmUA9jA+PTw1MkTRRGEX2U
GmQxmXLkSjTf/BZccoZuzBiFZLsZr/ahF9ENx2foYOdTDpNXIjh4t/oFouDg9tvRD0sGEXXS
qSTxLiAnf72+SEwUkZghDaN470Jtd1u6N5TtuYMscrhta1SWATpFFG83e2dzMK7guwXs6fUv
UDtymdvMtYnbu7+LPVd1gAvoMmdBSg9Rr+N3MV0loOJ94BihtPNhiGnTIIWsizY+dfGrJHEc
ueYBcO+cv3V3v9sHjvMXRQ3ykVAn0V3/dFxEXes6SUxu/1XMIQruDiyhrmOFIk3gUnB0yyEB
qQSm1KPgivMfue+6sboRjsl3Vr6goTstUHsapXqmXsHCy6Pv6iP1zRrFkm6sQJ/5YRoNGyeL
0hKjFNQik1mY2S+CwlwlKRtXlcBeusZX8mOHtuV0ilyTcuzz4nAubhXWPbxXkOAep7GuU3o5
cuiNt719FwFNHGzI60Cgdg2FQusdfxs6DpFFKLtZMRIFmhJBx8EhRM6eLc2ZOPoUFjg/JOdW
CmabC7WQKalMYTnd0UAUJhYf/OnvnQ/tGomUHeh9UiUHpvlS5amh/EVI0w6s0KK9IbRjjQWY
8r5HRqb5lyLC5JjxEAnQV7JVVcKiuuMuDAK9CTKjSdLqlLp+WxSY1PzclBOPtOAhAjVQNusS
Y0TvQ6A7Noxs/tx0lULo1Mu3p29/v3wkYuknpRKyCX5MSdUdE0uWHssE0wMQbcUXbdadx9C4
pzM1dyD8wIcDNmUHRkG5IksiNIN2nC9rdlcdJ3yveF4V6HOql3aq+ZyE1IYXhwWlFVccMFf3
+r5PIdsx75OqatMPcDja6CpPRNh/LgMFaAVgJtwJpiYDQbCvzXxFc1fTnNJ5IHIYjEEc+6Qm
ewiUJLzEJBD48EN0HUfFhcPv+BH9kCnsaHSTp8c8+6Bk73z++vH1r+e3u9e3u7+fv3yD/2F+
TuX9Br+SCXx3nhrXYIFzVmnhNxY4pkUaQKzax5cbyJn7UOLXuBokLQX6WksfvRgGKGB90vok
y0lbEEQmdSYTp2qfSCj06+ZXU8pO+tDOcJT7u6E3V8+MLZN+kBtDjz632EHc/Zb8/Ovl9S59
7d5eoTvfX99+x6xon14+/3x7QgWI+sw9Fzzhh9Qb939XoCgxe/n+7cvTr7v86+eXr89WlUaF
6pvaFTYds1RTpcsT4JT3TV5NppZ1buPNitU6mvY85ok2XTMINnaZpI9TOlyog9Uglm+YEQle
zKc+hHYlkqCuz+SxrlN1Z0d2JaUjwnW/YuWRaqzYu2VuHipwEOiQNce7XBb9kBpbd35QK1id
mUtyTtq6CUNodarvEoJw919RwT1xITkQhQRzFi+PyLnc7t9FapbD28tfn/XgL8pnGek2phJw
RvcRPrU2G//55z8IyxHlozKgrDQVAtZ1jvpguF03xUzRt4OprVSwPE2qnA43pDaQuypJ9Nym
4v4uk9Jlri5OSjQdyx5gD9euYRYk1Zhxs+z7C2WqgphDmx4tctSjYji2jor4hwRdAgfGskKW
A6J7+vr8xVjdghBN1bTsplplMwk/8+kPzxumoY66aGqGMIr2tJLn+tWhzacjQ01LsNu7FsOV
dBh9z384ww6vtnQzcPBuFsNZ3VU6czZj8oplyXTKwmjw9ee9K02RswswzSdoBrB7wSEhXyA0
+ke03CwevZ0XbDIWbJPQy6jqWcWG/AT/7DXumiBg+zj2U7qBrGnaCtPae7v9HyklDF5p/5Wx
qRqgYXXuRYase6U6sabMGO/QgveUeftd5tEOPMok5EmGTa2GExR8DP3N9uFmS5QPoCHHzI91
6wBl+mYBosr23sa91+Zige7ghdH9O7OEdOUm2jkmvUGJqoq9TXysHK6nCnE7JtgVsf4d3vwk
9d7z39stbcXq/DJVaYb/bc6wFKnoIcoHPeMY7OM4tQO+b+wTamG1PMM/sKaHIIp3UxQO1oki
KeHvBAQ9lk7jePG9wgs3zY0TT36k+tMM7RmOq7TPcxfLuHzzmDHY53293fl7n26NQhQbB69N
2zaHduoPsNozVdFvryy+zfxt9g5JHh6T4PYKBaJt+C/vQnrUOMjr96qN48QDXpBvoiAvPMe4
qPQJmWVAoc3ZqZ024cNY+CVZOQie3VTdw+rofX5x1inJuBfuxl32QFovENSbcPCrXHUyUU/q
AWaNAcc57Hb/DYlj+2pE8Z6OtKmQtw2GY7psgk1yohS0Nmm0jZJTTdc+dC0IYl4QD7AP3zs8
ZuJNWA+5I4uKQdyVPhkORCHrz9XjfB3vpof7S0keAiPjIPO3F9xN+2DvOH7hxOlyWFqXrvOi
KA12xtOBIXLMHIXGr/QsK3NduJkv+AWjMSVobP726enjs4t3TbNGMKaOQUiPMPkDFI/itaoh
FhqH+V4DUCNCIuloZCYAB1y5oalBaejIOvRSy7oLvsyU+XSII28Mp+JBJ0ZJvBuacLMlLliU
nqeOx0boehfVjRuPM1zpDEq6RcP2XkDpHxes5uMtgcguLXOj61mOrEG3hnQbwkD5wN6Y/Rta
fmSHZBLPiTuH3y9BSD8gEoT0k7oghLum6OhQOTOeN9sI1k1sqFzwyy7zA+7pHr2C628SDDZ+
gf9ctiEZ3MIk22kxyDVs1n2w9DZJNu4i33ciUEP24Ze90+xtorecznstRJ2hSUY2ml2dwTcM
5UVf+rQrLQVPyvoepIH7vKbkD8wkjVTHSxxGO4UXXhDI4QZBRCNCNdiAitjoxl0LqmZw9ob3
dP6+hajPu6Sjg/nNFHB3ROpKUeC7MOqtE7XoW1Mju2RgLC7mgsu4oXSQ6hZTdB2ywjWJva+6
tM7SqDktnLlEo5EZdwJPxsTc7/kF9T5Tga8kOR84dYYDw5k3g1AfT/dn1p/MjrEDsG1NJvwg
xElevD395/nuz5+fPj2/3WWr5nH+pjhMaZ1hAJ1rbQAT7xuPKuhazaJdFrpm7atMNRXFkuFP
waqqh6PfQqRt9wilJBYCpNUyP4AspmH4I6fLQgRZFiLUstapwla1fc7KZsqbjCUUp7zU2Kqp
g7GLeQGcNqwy9eEFiccywSQgKu2qHdOgGGRzVnRzrQgU/bGpsPJLcvL+fnr763+f3ggPBRw5
cSRoNXV1YP6GISxavJXnC1lrwJrWQpuRRxAtAk81n1ahYs5/aWMLRxZ5FmAXS0pgxqaNfWBM
UQt8ED7zUFsKB9zPDEt5XLaol0uMgiTQtPYkKCwLO4KG1HiqdD0bHX1ku40+iDK0tdFaCYRT
taryBoQvVz0L3SMf2P2ZckW9EpXGDM1g2v4V+yCeHIyGSeCtYZwpbimFr1RG6FhcN8OjPGS1
xSSA7w870LlQnJIPEW4cwStImM7+ssFJmuaVMZT0kQ8I7cSXv2Hf4emFubrSghsFIR7tj+oO
DvcDqqKobGO4EPMWDjXd/QLAp8eeUlUAJswKc5EhSHbH/ck8Clob2zZrW1psQvQQ09mwcOcD
fwsXlzYkSX8yzqdQP2SSvsaLSW/7DIXbLoErcyQ5J40mPfOhrY2uPPikPgNbWuueDTNIDpdj
vDC8T3kZNpFxTNpxSMVMCxtc/SjIUYRua305Ys6cwDjiZphwziuts3fBOrf2oW+TjB/z3LhE
OZym3k6H1Ttfv0DQRdY6phG2PJQ7X65WwuaMT9n8Q2hhgEebWMP0K2lF0bXCJy6zaJvI2nJX
fNrCaQs7k/X3IvICHaZJL5J8ytFIRrjA6N6IJwrc7FoQ2Jlis1JYqMiNkuXyzIXR7B40DOyU
qUhPUyecMU8fPLrkKs+7KSkwHQJ2bA3tLvgUpCsOUh0h3sHmR7G7zH6fWovF+z2D4touCbe0
eG7ROmVOm1KRMU2adFFHTNnIbuLFWFNr70oixc1pGG+1SnLvWUcXNmM5rAnKC8igq8ruCBdE
x1flO9EFh9bwRvVuRdpN+lmX5myCrtxXbSXeXTSKyVHdCV0SqQwjJRwZLeHp47+/vHz++8fd
/9xVabZ4XliWSajwT6tEnBQjS7UrB3HVpvC8YBMMZn4UlabmIAeXBZkFQxAMYxh594qTAEKl
LH6xgaEa6RSBQ9YGm9ps2liWwSYMElr3gxRUijgFndQ83O6LUrWMmfsTef6p0LW+iJF6BUdx
LdqSBXqc/Zl304f4l423khZeUdIsdm3GFeFM3nQlEXZ9D5WwGiJKcNoMXkmSDC2sPfp7gSRz
YynNtyyNrzjhvuCRAyZQexLTxZEe2f2KW8xuyRWhjDYdGl+pY4wCb1d1VP2HbOur/IIyHH16
SZuGbtrsIHW72nmilpAit/fw8j3I33hzKwwUCGzAKpPStn6DwumtZdfE35N4/gNhnXwAVCig
Xn+rlzVj0uo8BLpbncBmaOIpceRxZhlQLmXz9tzoIbob6kUfLb3bI7CHqEuo8lnHoX6HFG5e
ra412aJ76Hl+P+V1TQt+M17qsenipkPVpgqvv4KQ92hhYuK1i5h/64xBElQHvToVCjHLAAYQ
/+TZP/Gju+Pr9x9oevXj7fXLF5rxwHJc7CLieAajprdSgKaZ++cYy0ux4l3xnfkZHGLtcZKG
5DZ1NRS12T+JaotZiUnb3a50RH5SgqrAf0MyTsJKU7PqkCdna7znjqOo6vgeb+/pyPWOPxx4
ZhaVVGlLGwKJiWVFDbU5KlEEKL15JPctGy4HPzVaJmQ43Wx47qc95Uzo/rI6SQkUa4AFbjBO
mcRr7bphv47o9LBTnfcQhHI/z+raqCp7MH/T6wbgh+qcFyyv3IsGiKS9laNZaDPFwt0+TsfA
86yKT6HdFmujiOXOCh16xhHb9m3lme3uc8wdfDIjyKhjdW/txiO/NyZ1fq2ymjPHutKBmCqc
2N2XvFGjXyu7EVY4BU/qrZrKQ2yGB80hoc5rjN13omw48we84ZRzBH9J1ki7KlboVMDfR+oW
upLU5wrqa6u2N8o99HinNjmKjQ9o5N6UIs2DOBeBwtYli8+SJvSCaK+pUiWiZzkdHUuiMXqp
g0cWzUnrbRhQvmJXdKQ8tMgu9p7nb3w9k4nA5JUPLErokbocQTGc+55xmMpG1ccJlPDX9yhg
YAO3Gwq41xh3hM5+cjpQd5mVX2NUBrtDCHYwbjMeuL7LrDlw9blamFUVKDK46hyjCndxgyuN
4WEr4It7PvBdpGOZIDL9n2dg6gcb7qmxk2VVD7VVDRkh2lhXWUBHGJcDMoSRHpJFzpV06nQu
nTRBzyijgUOVRnv/Yg/GDXfadWVF/2eU1g7agSsLsoO8CDjjoV9Uob8319yMkJpCY2PffXp9
u/vzy8vXf//m/34HjN9dXx4EHpr5E1N53vFvzx9fnr7cHdl6Gtz9Bj+E/UFZ/66yUHKwgb89
0Q8TAi8DlrjxMm2Ba5zQ+8DoINz20+FxyK3zUYYveWc7KDFN1sEZ3l4+f7aPvQFOy1KTFFSw
jA/hwLVwxh7bwVoWCz5jnLoONJpjDpwvsGPuUm6/g2ikaUeb+WtESTqwkTneTjRK83xw9HKO
3arPhhj2l28/nv788vz97occ++sCbJ5/fHr58gP9ZITrxN1vOEU/nt4+P/+wV986GX3ScHwM
f29U06SWQc0oZJc0LLXX1YrFrGE3lvI6jufMMTxScCBedFaKfkjlLU7b2mBwNVSY2M42gDqc
i7vXb+hooqb/emxSfCvXgw4+CDglL8pyNGMIAQHpF6R1aQrgahuSLf5xzg4gEaxtM/vBYmGj
d2NpVnK+zNZjqty+2ez03MasLjEDFmOofaIFVKGGlKwP+lHypKQlJ3QBRBXWAWMiU7GeVQJN
oFYQLmZtJrn25aw/M51RPGFUrYjpsn5E9RjrFQ4YERm6za0IrbSEdPVDDJywactDvSTxoDQr
4DREkw8Xg7Q/6y8yCKyLbUBlYRgLvaP4GxYVa11+SILAFVlSIGvYETSWoW+aiP1I8SPSa0Od
uNmPA65cypBqzDqNA8bfqOggSFmRjorwM4rgl6wdKiUd2ajHGpU0WLUJ46nuBiShWDvda4FO
+xaYfKnsme2bbIXJy8e31++vn37cHX99e377x3j3+efz9x+KQvwasugd0mv1ZZ8/0oEFgDEs
pTHLsgla9B3Wdo6AONUyK1peK+K0YX/k0+nwIfA28Q0yYMdUSs8grRlPl5VCtOfQkqq1Gas7
A8/ALumFK7cJ53ycskb3xpYYxhNqsZpkuDHda3olwoi0a4/sytIDMN3c307pjVKAwoul6sT8
vkHs/bTDGHc3mzsTwn0YbG5WBoRVcuhSTVVzxQl9jY25PyfC3wLq6Ch8HKiy+RUYkcCJJxb8
JP/VrLnU8aEaKzpCIQZV8ruC+/YszLzUIAYDB1mWEo3lW7yWk0JuLOmJv0jzyde/3l5f/lIZ
pkS4VZOzxUwOfXG4nUtZK2d9/gB/8NJgahDw4mEYRJbfaWiHpJpw8fMP242NT5M+m9FhoJwb
s27vBvNU8qnoygSTU5P4c8NA2MD0jg5bjkI3c4DfU1LWfrDdnOCmNs08CvGusQ03O+oimynw
9WvjHUzzqBW1ow4OhSAKM6tNlqXuDMd3QH8bknDtfVCDR0TTpGUvbbmukTitexaSTex4G74S
bK2GdWkWR5uNBe+TON5FFphvMy9IzMfqGeP7ZNqfhSDvYB8RRR5937MbhoYvgRqJS4EbUck0
DO1JppKEtxqJBJFv12oaOyvweD9acDSSRqbSglc8hlvPgp9Tf+tTwwqIHelStOC7DL7c/T9j
T7bdtq7rr2T16d61us+Oh0wPfZAl2VajKRJlO3nRyk69W69m6ErSc3bv11+Ag0SQoHtemhoA
wVEgCIIAw3Irj0iVsD60QqojVVHDmbgUrYvAKBu2rRSBSVawkSalFkVTcWLyAXm1h8Z8pkyd
zeU9qwpGcv/2ff/OBVxwMCP/XZZj3txWusrys4zGdtB4ekcN1ejrOpb+sr8cgBcb1sD5ywyD
JXE8DRDOTCNwuCT55UJgMGovTikqij17NsCnPEU6OAxQxShYqkjzPMKHTaacdemlElSuK1Hn
HdntNIa1OVYYBnpXTWg2QWXkgZMyZ0ZZb2EQS3nL+MuHGUv+wMtCoXPAUYagcDaWZm8j6ibh
ETqejsG0cEbrLs/kmlDb8+PLw/eT9uXnKxdvXpqZaFoeCambamHHIcqv2yZWqWD8JB+ZE64T
P5trDP8qMUyPk2iTlXHml0yylbpa8IuONNs+qhdHCJZCFM3p5PQISbar57tdsH0yAtK537xq
mwfLNEnkF1Ah+sPtkIGPgiw3AifSNQXqBJYuOGqLq+n5qd8GPXeJChqNwZ+586dxyPfLRyKP
2osjncBQ72Fs3WRFNA32sYSVDBqf0xm8+ISRkS5vtYvUHaozUE3jNT1kR02xuSjQLBy4E1OJ
Dmrp+2l1EYEtr/jp6sxD3HrLus21Oay7wm1qtSujtm/q1h9WmfYnOGoqcUkQrdv0WWXsyPiG
g0xWH3Nc/IagEF0obGSZttAD2BvZlNuGgSgsw0KqhwGjgPmztiM5H9aXM1zhRcO//hvQgef0
Gs+GxlBtwDhe8tmO4D6KFr2b2BDrIoZhnfhfX5HB7iSTTAH+fL6w3++xonYoGGX5oiI5jrFt
BcA4zULvb32xtkKm6yxTM/z8my0st8LhOGTACrDFi3AQOLqYGcRsdg6Cw+W1zs6n09MQJ90d
ZZ8Y03ih+1tUxxjtJSY7RV8nsapiVNHgC4iL5MYBqyD1Rbty2iM/iUBrZL1QpVWnNPrBv5vI
hUV2iG8FGmPjKVVu/7x/PTycKMNhff91L+8TTlrXmdNU0tcrmcPOr95gMEnH79Bj9LcwnRRw
RFsKkAzM2KP373pI6x992h2wsoFh+hEB+ly3svTCaqmovEIFTR7ZlWenWe+ZaE2ZGstsitaa
RQxg0xYFealqYHj3JQdhcYutgj+mlbwEnF2Brhxv/fopCWxCoRbiKjYdHQqp9eiWkGur2T+9
vO9/vL48+NpYkxaVSNERyt4K0eQe95u6g41EoYZpZJipSn48vX1l+NfwWY2s5U/V1hXes4Yx
CDiClQECbfvSSNAWnI1CEWgbueWASdttTQK6I6JpyBtOTPr0P+2vt/f900n1fBJ/O/z435M3
vGb+G5Z34qTOe3p8+Qrg9iVmUi/JsJdxVG4i8n1peH4N/4vajj0IKprVDnNQZeXSUpIVprAx
o/2LaY5qJ3Rg/4VvJqaqU457tu4nXyPjWcaNV2qh2rJiQ9JrknoaqdJ2C/2GjDvk1UQ2JiN+
ogO4XTbeZA0p+2jP7IODPFHIXKOcvgF8dQZBu5UsW8m33NV/Ll/3+7eHexBuNy+v2Q0/qjdd
Fsd9Wq7I6+QOYG1ebQlk/JHUUSRfZ7SVvgDVDfpdteqS+l/FLjzFMnmmzdMjV0Ep4SDzzz88
G33IuSlWlpVHA8uaJI1g2KhLnP2Xw73Yfw98MXoDp1s6rPImipeWnEGozIy1baKagtu4Bu3M
1YuLAoDsvsU2iCYb5OdXCisQpH1rza+CtnbwVhWYN49jByTjYdOCrtQz8g5pQzoKlumV87jL
rJ7WTp1t0RYuSEsRt9ptXLZSyeXTN7KDY4vX2Kj6nLA2SuWqoRmHq+FUFPhW5SEOdEidJwQ+
la7OnROyIZt5ZCGm5FKvk6daJYc8ebM7PB6eA1/HLoOta9dv4s7+ypgSdt13gnzn/93mM+j0
hcnNa/RM/fNk9QKEzy9280wWX5lQWMVtqcokLaKSOD3bZHXa4JEhKtlswYQS5WsbbdIQqyEd
y+8YgY6VSTakP4k72NEYhlEbM+UwOAocnocsNHcsGoawTzf4xpfJeywRprayitmwTxxtXVOd
khINX0Gy5Eyo6U7E0rVXxen85/3h5Vk/EPOHQxF7ic00mMu84VHMZvY1o4bXojxz0gRqzBC2
X95Ghzk3AtNkRB7ntjg7s9/+aTC+7qAepyDfqsZyo1mISZ/DJims67zPd+hZ05cpebSAu4H9
VEaF0l8W8bRPF+QtozHFBF6JZKylt9Q6w/gTzpjcTCImS4RL3G4zEa8Fa5ZGfA2Kel3ZHggI
FVVF1DFJCd9pgIl0NNNX+6PPRZH2vNMDSeAAP9DSYR/TEOQEP0CQNHfZ/UOg1r34WvpF2oC4
HKdZwrQmRoBWYA/CPq2vZmzCPkRq6xnltM4WG+GyARHBXR1p1PTC7ZVM6HjK+7IgHvTiySWm
u4w53z5NId1dyQjiYkWPMdpieUUu0msHunNmRL5mSQrPIog46f58GZoFZTyzABhjltZmLHai
7hyEll9ujeEdXGIxATtlJK8iXCZsvH+FceL9D0AY2UAZqQ/QSkWWxrbuqGHrRjlxW1BlNKeU
d4NDbtbcyAjp/rtcwLjDE8GqzNhrKJ2ltrmxyZU1NmJLmGnJShFjOZK+YUBCE4g1T8Obu2gi
kZyVs51f4s2d7axnTAYi7tw2GpbrS9UWzuTS3IyptaMsSW1zFGZFaG5akRJrPUJLUXTEXmfC
PgM72HwWcLDiNLq8ApmJR+Q6xitEa0MgmEJ7qZnzijuNo70oiq9RWo6jsajQJ0TUcUb835WP
CRSoYmFHyJCxBvBQJxqM1ODkoUNcJNYXV+wcS+yunZySdCQI1fLT46VlaJCbxuOv2PaIUdh1
m1y7MJiMCw8mgyauti48j0qR3fit0lIx2Cpp1PCL6cQh6GITyKqh6PAGy20Ke5ujUMqoXAWc
li2aOpCaVJG0MRuqWyNVJGmnUVJOFfXkzBtR0PzRW8hvLMjSXbgakZkUq09uwaPpaGyCfpV3
qV/x3W3Jacz6KluvF2npt+5kKBLt/UZQ1utbDPr+Jg83o5TUXruYF8RyARiBOvEJQSPY7LPy
wbBYUeQOGVCQNgsDuZ0nGPkrS9tkGiFySktR5AzdGVOueLRbKRxTGnGyE0igA25QHvLlmOrL
mnKIb1dl1zKs8QKkxSyXlovucEuO/ZAD6tbSl63p5Lh9Aqpsp3Igk4azrcrCDVYYicgtKhH4
NIdViMaWYheCNPpJMCi3TeM8imDpcDn8lqiFpd1w4cwIUZRvKjq0qDtKY9mNHN4nyh3zK+Tj
ogyw11ddTHl9N+aMGCFA8YwbnLfmAZXJGO7MSlWSt980uyleynsLRuObuFOFnSvA2cUZwuO8
w6Rl+muk8yg3HLkGwnOtaI4th2IDx4ce6oNWdqLgHeVtwksVWCw41KDC9tPLEtT71t7sCUr3
mPBHZHgWiqKe0a9LQvGK3fuwENqRU5IG7lqPtorTvEJHvyZJW7dJUg840ih9KXkzP51c6bXl
Ym/o5A5wGTWhrNt+mRai6jchmnUrR8xt2ciDPTVabbs8Pd/5A9dE8lrHa7NMaQHCesYI5sE+
Ild80mb+JjCQ+HJ5QInb2o7QjLghK4nyxXNX+pBJBb5xSRDosrHyeN+aMSfgonhiEd7n257V
m+nklMEMu/RxlDN4A0qPDOkgvtLAY9hkBjVCN48I05F0zpASwmw9P73wp14dzQAMP5x5kMey
ydW8r6cdLZREem8fC8hDrtaiqbYAOhC6Cs7cbiolFSUp7wo50rjxQWxVQll1URkqavuGg+oz
Flc0hfLJO4uYbAfwMxRCADB5TTxHG9aSDiM0/+S50BvJXiZNZUe51YAejk4YZIx4VFCcLc2c
UvpB36cPfx3wAeTHb//R//n38xf1vw/Wgder8bgXgevAn2eLcpNkhXUkX+TX2Ia+Luz0TCW+
X7smrraCM8BUS7egZN9fp7d2yOJop1+jEJhliduQDHbyp2srU0B5lM08WgRXcSUsg482YqbL
rk3t9iG50XZTvMsvQljCTqHQlU7VQ+yiphJ653OzRO6cJVH1D629bRLRm3kjZyXLY5c9pBGK
I+qGpnWjRVNVJsUGuvRyDRrEm+qIw3azPAfB5nbb3JubIm6F5QajD6xq9sCkQj9544/pY3c7
fzila5E3IvIzXW9P3l/vHw7PX32TEXSaXGWJAv1mYb9eRC1rBRop0CXNcmNHRNIVxa3Lr626
Jk7NHXOApSYan3Tb3kFSYoo1+/0ynRtL4vmW969lzeYiHa6B4L/kdl/XZoOHacZgInDy3smH
+OrO+efj++HH4/6f/Stz5dzt+ihZXVxNLQOhBraTuf1iCqHO3QRG2SqoxwlX27ChwHKvrTXZ
Zo5HGvyWF1aBgBZtnhXKFDUWAZD6et27Wmu+mtiNmG1DURiFMZdF4U4/RXOxC3wqcjdH0LLx
VQtijI+9ElddySdSLtST1PExNr0dU0HID4/7E7VJE8+QTYQJvUQKiw9fP7ZsBYDLpPv96Iq6
E9PelvIa0O8iQR1CDaKuWsz1EHNzY2jaNO6aTNwStrOeBn3VIJ6hR2VY8rXO3T7MCWen2nmI
ISUKvYOVyGsQ2UKnBhi3vEViqbT4ywutDXr4Io7itWOgylpUUvolb8L7HEbtwqjVsp2GcAvh
V2e2jyxXBa3nRVNJbDdZgtBPg2eiSwzLyAGzM2OQR6ZaksDgxddkwlVJ6WqZlZ/hI8yo9dVw
xoN3gxEg2AAld1WZqn4+WdNF9CSn6cOCwBtJugIVREfWw8QFI48MvVkBTF5jo98CuvPfBvBL
fE4eN7c1TVZMwH2Ur+gkYdzj0FC2bl6JxAVkCqCiwIxVRi7dTVc5hrQGJKIC99uoKTP2+kzh
nQ9EAUWTWjrjzbIQ/WZiEUmAdeaXpcgVetSJatnOyWwqGJ1g6JsCjPLZ0XJGEaviE7DrHVNF
Y24l+pGMUPjEdcB5+HO0/EgZ5dtIpr3IlYcdxxbPIdw1hEWCefNk1wMsihSGrqr9AAXx/cM3
kp6kNYKLAtwplEBcxfTN2gDlcjuYBwKqSlV98gfopn8mm0Ruesyel7XVFRofAzKuS5YeytTD
81Y+OlX75zISf6Y7/LcUTu3DVyCICCrapKJLa+OS4G/jEY5hsWvMeDCfXXD4rMIYJRjU+8Ph
7eXy8uzqj8kHjrATy0tb7riVKgjD9uf735cDx1J4Al6CQlugRDZboqwcGzZ1Y/K2//nl5eRv
fjLRc5v/tiQGjlx50qSW6MM80HZPneOqKGrvJye8FcJTdxQYPp0kPeceoMMRSz7fTImnovoz
jqWxrfg9H/hg7Av5Wdy2IqXPPKsGw+SEN/goCe3h0dK0wSwDuUc4km4A6kg8vJheO6zgd513
7nJZ+O00GLcpjgiOm6hwJLCEqL0zFF2mvemids1WuNmZGkbTVIYpEXnJXXhLf12Hx/ym3M1D
PQXcucdMA0NfUmPqf6IQDC6WJvg8Y0Ff0io0pnbR8PELagX/ChuW1oZMQedUqX73W1AViF7a
cQ0fl09TBXXI3DYc5e2QCJ2RZog24rAHcUi8wWzcxYzz+KMkdvwCgrk8O6UtsjDTYJWXZ2ds
1x0iPoUfJTrnghE6JJNQE8+noW6dz4jQpjhOcDkkZ8Eqz4NVXgWrvJqd/67Kq+BEXNnvtClm
fhVq5sXcbQxoBbjCev7BJCk9mbIhIl0aZ1pkhDMKMnVOeLAzewY846nnPPgs1NHQkBv8Bc/v
KtCFGd/YSaBZNG8kYq6r7LLnn+UOaO6hGCKLKEYJR0OkG0ScYmDdIyXjtBRp11S0pRLTVJHA
yOtPHua2yfKcxh00uFWU5kcrXME55drnmUFLozLxm5GVnZ1Kj/SYbZ3ommuSswgRVOfrygwX
qwfoS/R1z7M7laBweDpp2faIMUm9Fts//Hw9vP/yAxnSGwX8BSeVmy7FKCL0WIDh/TNQZuAI
CGRwFFzZu786rcLWJhk+WQz7ZI2J5hrZXrKHIlIeOrNYIXmVQNsNMA5fK71+RJPFgXeNmjaw
y6NhI4vlwReTFqicBcw6MHr1WHVkO+i1xacP+OT5y8t/nj/+un+6//j4cv/lx+H549v933vg
c/jy8fD8vv+KQ/7xrx9/f1CzcL1/xTQsmGNw/4zG53E29Kujp5fXXyeH58P74f7x8H/3iLU8
NdE0hd5i1zBqJdnRJUpaCkB7CEQIdUiXsMYtSluvDbTDoMPdGN6HuMvNVL6rGqXg2Md3GUuT
ho1XMFDG4/rWhe7sDMcKVN+4kCbKknNYK3G1sVVSWKKVuYiMX3/9eH85eXh53Z+8vJ582z/+
2L+Oo62I0fZC3k0T8NSHp1HCAn3S9jrO6jUJ8EARfpF1ZEegsYA+aUNiAg4wlnBQ47yGB1sS
hRp/Xdc+9bV9m2A4oNXOJwWJCduzz1fDgwWGB9BOWldNtVpOppdFl3uIsst5oF+T/JPQE43q
SifWKRv3VRNoAa2Oyz//ejw8/PF9/+vkQa7Ar5iL5Je38Br76beGJf7sp/aLvQGWrBlgk5BI
fLpTXbNJp2dnkyvzXUQ/37/tn98PD/fve5kvClsJX/HJfw7v306it7eXh4NEJffv916zY9vF
1Qw+A4vXsLtE09O6ym/dKGDDZ7PK2smUV/jMt5LeZFyAqKHT6wgE3sb0bSEjVTy9fLENYKZF
i9hv5XLhw4S/OmNmyaWxXzZvth6sshP/aljNNWbHVAJbKH1calbw2hpYZ1gxeqnoCmbE0YZO
RlNdBd+/fQuNWRH57VwroMt8B30Kz9RGFVKmusPX/du7X1kTz6bMHCHYH6wdKywXeXSdTv0B
V3B/fIG5mJwm2dJf1Cz/YdQ9MZXMGRi37IsMFq103uS9uo18KJLffBtIcc6HIxwppmfcOWPE
YwhEb4Na27noRiDw4mjPJlNmOQCCSwtgsMXMZ4XXB4tqxTATq2ZyxYfy0RTbGprh28IPP76R
e/ZB9PhLAWDOG1yDKLtFFojXqimamM8dN6y+aoux5MLjgQHW4TjjbwlxpAIBFk607BHLPaqy
0OdMsYTNCK2RS/mXKXW9ju4iPj64mcEob0HmH2mQ3hWYz6J1Uja52KYmuW+HdTRneImUc7g2
yG1FI/1R+DjYagW9PP143b+9KU3dH8hlHgnOeGc2hLvKa/PlnPte8rujSwjQ66Py4q4V/kPx
5v75y8vTSfnz6a/9qwqO4xw6hjWOiTNrTqtMmsXKCbFtYwK7gcIF4rhbJNxuiwgP+DnDIJkp
Ol7Wt/6eBDX1Og6Jrf0/Hv56vYezzuvLz/fDM7PD5dmClQYI15uGlVPRm5WR6sgaACK18P3g
8B4JjxqUuN+0ZSQ83hyzjYEWmt2lnybHSI7XaMiOrt2hd6M+eLx9w2bjslpvuWuT9rbA7M9w
9EeTA7paj/NpIetukWuatltQst3Z6VUfp422VqTaG8cyj1zH7SVekW8Qizw0xZNNcWGyI7Dl
L+RJAQtbLnLZqsQoNanyIMCLf2MvGdby/vUdIy+AVv4mk9G8Hb4+37//hIPtw7f9w3c4o1ue
ZFXS5fjsRNpfPn14gMJvf2IJIOvhWPKvH/unwYqvrq960eCDi8QYfsZW+/j20wfLs1bj051o
Inv4Qtabqkyi5tatj6dWrOHzwnwtreCJzc3wfzFEKnNNUCAok4JtajCQfgGnP5BzjXWfk2dl
GjW9vOojRi98qMnfyC0yUHAwtLy17MwTM9B9yri+7ZeNfOFgLxybJE/LALbEl3Qiy51I/E3C
GkIxeGWKicQXKtK9w6yWCRuJx1krMH2wk3YW9J41tgfOCfUuXq+k/0uTEmU6hiNjJsjOHU/O
KYWvgsd9JrqeWCycUwD8tI2jFA6febq4vaQCxMKEtlpJEjXb0ApWFIuM8+kG3PmctIScCOIL
e/Es9GHHJreMw+7pBpZZUhV2jwcUaBODgxSFJqkPv0PpCvtkTtK8gpYy8iBQi8cA390h2P3d
7y6tWdUw+QqhJnuHxmQRe82lsVFTMGUAKtawZnmPOkWDgey5Fa/Ri/gzw9h9COB8DtLqil5e
Y/+k6+gmypXLk7XZYCAjEN4bDFfYkLw7kfTitP31FQhdznryrSFchRPUAPhBndFKDGzWKgTI
hJVYOzhE4EsVJyST/GARFyVJ04v+fL6gEWMlrg4nE2lXuRoOa2lLvz7cxiLRNbZsy6sF/cUs
3zi/60Vk0eG7elASLKNdUctEEvbXs0wsFviyo0FbkrADtLTo/p5ngkBqDFtCR6OsECHtSFaV
aYEcbZe9FkaKzFKNTxatu59q8Tla2VunwN2KvcDxNiF6fWB2dAn98Xp4fv8uc7t/edq/ffWv
eGLlRI+ZkXPYX/LB3HsRpLjpslR8mo/dVTqLx2Fub8fFokL1KW2aEk6r7DYcbOxwljo87v94
PzzpbflNkj4o+KvftbSUNt+iw0MwrrNxeJcNNEK6KZI0NjjqNQaNxgb/f2XX0uO2DYTv/RV7
7KFYNEGRWw9aiVoLlkRHj3iTi+FujE2R7mZR20D778tvRpQ5I9JJbwZJDx8ihx/nKS7DzmQF
xxHt4+k8VgbhL2A95E5NHTOUplMBGEOquabqm2zIg6Ona2h4O9vWwv+BqZQWvg1bk62heVum
mvPA5kfXTAR4nbZScfjj/PQEFU71cjz9fX4+vJxkOufsHsjiY9/FfOyngfaRwffEBbY7tU7L
ZhDbU8sG9vNXOpkITpqvqXK861XabRQgnNAm2i1X3yGqZsK4kBroWFGqOqsdM2viafEIwPOw
ggP9Q+suZww7OBmtiMv12ELN4UxXWODh5DoAblptIK0ooyHx7hggpCeLrXrbMv6X5OcaYpdZ
mzLAV40/mS7mP8LDcfzSsFxdjXOqiLroRRuWfAcnyFA8otjzXDbb2m6dJgKHdfCH75JxZ9kd
Ze8tElzhotXE1zybfaO7ZS3wqNPseTbjWGExtTFtoTkjk/jQLEtICi+1/nNVd7ecvSve3Dus
eJ9IS8gbliKjkd45hopzgjNYXd4+tHuQVQwQxPTC4HKxzRfrsqokp2J9Atrf2G+vx19u6m+P
X8+vzCNX+5en4DLZIE8lVONWYClRDIecMRCIcCW2kB2H338NrkNbDnjtjHgVDe6j2rihAap2
K3hbD1kvPhJr5uequZM3b4NukLbJAY2sCRrSmGLvy1TbaVJz/rbte6ScyVeFDeAKMTaeUcjZ
rq8tG5+4a+nzGXeR5E/eWCBSrb8r5r42ZqMezvxih0rvwlF/Pr7++QI1nxvQ8/l0+OfgfhxO
j7e3tyLRKRMGtB4H82Cu7WCfdCR5uCcS+tR0216Z/nL55AVCQDqa2NMDWTiZuI0D2KwCzm+3
3GmImC/w8X+syEwQSMRx/93YQtLu+Ae/KfWc1syiZlUdff6vfK193p/2N7jPHiFYOS5XG2Ka
5CJuUKu76++Xy8cmQ6mMfsRG212RDRnkG91IPjRR7HR18HIceefWpB2qjAQoLDvPR7Gh/TmR
3+sCL90NgQiIqcck6sV/n+V/O1PuEAvLLAiIZg765HHZBGrN+2tuGnJGcgEcT2BE2hEWXX4V
dolyOANSoIR1VoZgU8sku/u/Xr/sY2tpsq7+yG5H4u514HlldNz6aRKaWPh0Gg7HE04EGFSO
2LP7p0NgCgffv8B0jVwBFykALh6Cuql5oPlF63CylFeh38Z4MNlOeLj5F2NJFkzp1sFr54qX
XFbVDLwW4E62abK18cZ/6VaV9TdRuk0J1pSoFuOc0X0aGTg8kNsPvK93YSiIziEoSCmxrJyo
MVRB1etCeqnz/QU5ce9OWQq5N1VLaZQvn4mKe06S4VmMA1Y8HnBfxZm7O4h8lsefJDK2tgg8
lmABQmikttGEGzVnyAbbVPm7366B4dAiTv+fZrcyD8XYxEKB8ORZUMHWkr1emaHr81DhxhoM
VzyEuVaolA5yqQonsYkekyumHHDJJ9YYhgyhogcvUZOU4BNXuqdjilIHUarKYsLLwiJWSa0q
Yqpjnp4X+Kg9t46FhvCTBNSUK+owOAnQZCmk+jv484X0ywoBRarhooBI9VRWXeOu+GCKiMc3
1FF2xtqUaEWg1FB1PMrC1JFPMNndQjuUPHimyTO3hoqgFpp5cgBQle7d0aDSUEynsdHVm2Bh
4TophkKM5N7fPY5DYfOxodyL//70H9sPmnw4iwEA

--Q68bSM7Ycu6FN28Q--
