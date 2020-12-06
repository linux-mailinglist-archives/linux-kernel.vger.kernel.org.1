Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172A52D0206
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 09:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbgLFIyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 03:54:39 -0500
Received: from mga11.intel.com ([192.55.52.93]:26980 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgLFIyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 03:54:38 -0500
IronPort-SDR: THQSVgrDWfXFYWP7rVJO4OMdfsBhCJ273tLbpeBSugBQROQp1WFddF1eFtk5Uffw0bs2f455CT
 5EfZdyyv0Gdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9826"; a="170059948"
X-IronPort-AV: E=Sophos;i="5.78,397,1599548400"; 
   d="gz'50?scan'50,208,50";a="170059948"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2020 00:53:57 -0800
IronPort-SDR: ciOUSzWGrWH7Rtco/tAiWZbSYzUI+Ayxk5SisXzjYX/IQrRpOzmuayVcG0wzy+TUZ8do6leQjI
 XN4JsPoE9kug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,397,1599548400"; 
   d="gz'50?scan'50,208,50";a="369409788"
Received: from lkp-server01.sh.intel.com (HELO 47754f1311fc) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 06 Dec 2020 00:53:54 -0800
Received: from kbuild by 47754f1311fc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1klpnm-0000f0-7v; Sun, 06 Dec 2020 08:53:54 +0000
Date:   Sun, 6 Dec 2020 16:53:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>
Subject: drivers/uio/uio_aec.c:50:49: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202012061620.BSh2fmcH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7059c2c00a2196865c2139083cbef47cd18109b6
commit: 8f28ca6bd8211214faf717677bbffe375c2a6072 iomap: constify ioreadX() iomem argument (as in generic implementation)
date:   4 months ago
config: alpha-randconfig-s032-20201206 (attached as .config)
compiler: alpha-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-179-ga00755aa-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8f28ca6bd8211214faf717677bbffe375c2a6072
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8f28ca6bd8211214faf717677bbffe375c2a6072
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=alpha 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
   drivers/uio/uio_aec.c:44:49: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *int_flag @@     got void * @@
   drivers/uio/uio_aec.c:44:49: sparse:     expected void [noderef] __iomem *int_flag
   drivers/uio/uio_aec.c:44:49: sparse:     got void *
>> drivers/uio/uio_aec.c:50:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:50:49: sparse:     expected void const [noderef] __iomem *addr
   drivers/uio/uio_aec.c:50:49: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:59:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:59:9: sparse:     expected void const [noderef] __iomem *addr
   drivers/uio/uio_aec.c:59:9: sparse:     got void *
   drivers/uio/uio_aec.c:88:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *priv @@     got void [noderef] __iomem * @@
   drivers/uio/uio_aec.c:88:20: sparse:     expected void *priv
   drivers/uio/uio_aec.c:88:20: sparse:     got void [noderef] __iomem *
   drivers/uio/uio_aec.c:104:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:104:42: sparse:     expected void [noderef] __iomem *addr
   drivers/uio/uio_aec.c:104:42: sparse:     got void *
   drivers/uio/uio_aec.c:105:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:105:43: sparse:     expected void [noderef] __iomem *addr
   drivers/uio/uio_aec.c:105:43: sparse:     got void *
   drivers/uio/uio_aec.c:106:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:106:34: sparse:     expected void const [noderef] __iomem *addr
   drivers/uio/uio_aec.c:106:34: sparse:     got void *
   drivers/uio/uio_aec.c:115:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got void *priv @@
   drivers/uio/uio_aec.c:115:31: sparse:     expected void [noderef] __iomem *
   drivers/uio/uio_aec.c:115:31: sparse:     got void *priv
   drivers/uio/uio_aec.c:130:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:130:42: sparse:     expected void [noderef] __iomem *addr
   drivers/uio/uio_aec.c:130:42: sparse:     got void *
   drivers/uio/uio_aec.c:131:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:131:43: sparse:     expected void [noderef] __iomem *addr
   drivers/uio/uio_aec.c:131:43: sparse:     got void *
   drivers/uio/uio_aec.c:133:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
   drivers/uio/uio_aec.c:133:28: sparse:     expected void const [noderef] __iomem *addr
   drivers/uio/uio_aec.c:133:28: sparse:     got void *
   drivers/uio/uio_aec.c:138:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *priv @@
   drivers/uio/uio_aec.c:138:21: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/uio/uio_aec.c:138:21: sparse:     got void *priv

vim +50 drivers/uio/uio_aec.c

1bafeb378e915f Brandon Philips 2009-01-27  41  
1bafeb378e915f Brandon Philips 2009-01-27  42  static irqreturn_t aectc_irq(int irq, struct uio_info *dev_info)
1bafeb378e915f Brandon Philips 2009-01-27  43  {
1bafeb378e915f Brandon Philips 2009-01-27  44  	void __iomem *int_flag = dev_info->priv + INTA_DRVR_ADDR;
1bafeb378e915f Brandon Philips 2009-01-27  45  	unsigned char status = ioread8(int_flag);
1bafeb378e915f Brandon Philips 2009-01-27  46  
1bafeb378e915f Brandon Philips 2009-01-27  47  
1bafeb378e915f Brandon Philips 2009-01-27  48  	if ((status & INTA_ENABLED_FLAG) && (status & INTA_FLAG)) {
1bafeb378e915f Brandon Philips 2009-01-27  49  		/* application writes 0x00 to 0x2F to get next interrupt */
1bafeb378e915f Brandon Philips 2009-01-27 @50  		status = ioread8(dev_info->priv + MAILBOX);
1bafeb378e915f Brandon Philips 2009-01-27  51  		return IRQ_HANDLED;
1bafeb378e915f Brandon Philips 2009-01-27  52  	}
1bafeb378e915f Brandon Philips 2009-01-27  53  
1bafeb378e915f Brandon Philips 2009-01-27  54  	return IRQ_NONE;
1bafeb378e915f Brandon Philips 2009-01-27  55  }
1bafeb378e915f Brandon Philips 2009-01-27  56  

:::::: The code at line 50 was first introduced by commit
:::::: 1bafeb378e915f39b1bf44ee0871823d6f402ea5 uio: add the uio_aec driver

:::::: TO: Brandon Philips <brandon@ifup.org>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--+HP7ph2BbKc20aGI
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--+HP7ph2BbKc20aGI--
