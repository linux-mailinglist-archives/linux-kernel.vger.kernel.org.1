Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72E02AD561
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 12:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbgKJLga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 06:36:30 -0500
Received: from mga02.intel.com ([134.134.136.20]:62657 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730296AbgKJLg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:36:29 -0500
IronPort-SDR: 40boIIoHVCfirS6gBqYfJqRJYbjrHWVbvk4DH3gDn6vz96UyjsZU9+OXYP+7hQzW7QmYyd9u85
 hnJrnNeXI34w==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="156964234"
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="gz'50?scan'50,208,50";a="156964234"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:36:26 -0800
IronPort-SDR: Uw34lkk8EMm/1PzIc5/LTQr/mLNObVK41iYUZrfChecS2ZekQy8qn49rW5nLEryWqBc2Tjs+8p
 ftj0OL5W8tCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="gz'50?scan'50,208,50";a="428340551"
Received: from lkp-server02.sh.intel.com (HELO c6c5fbb3488a) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 10 Nov 2020 03:36:24 -0800
Received: from kbuild by c6c5fbb3488a with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kcRwl-0000D8-Oa; Tue, 10 Nov 2020 11:36:23 +0000
Date:   Tue, 10 Nov 2020 19:35:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: arch/sh/mm/cache-sh2.c:65:15: sparse: sparse: incorrect type in
 argument 1 (different base types)
Message-ID: <202011101924.im0AvXAY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   407ab579637ced6dc32cfb2295afb7259cca4b22
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   2 months ago
config: sh-randconfig-s032-20201109 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-76-gf680124b-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
   arch/sh/mm/cache-sh2.c:30:47: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/mm/cache-sh2.c:30:47: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/cache-sh2.c:30:47: sparse:     got unsigned long
   arch/sh/mm/cache-sh2.c:33:33: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/mm/cache-sh2.c:33:33: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/cache-sh2.c:33:33: sparse:     got unsigned long
   arch/sh/mm/cache-sh2.c:49:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/mm/cache-sh2.c:49:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/cache-sh2.c:49:17: sparse:     got unsigned long
>> arch/sh/mm/cache-sh2.c:65:15: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/mm/cache-sh2.c:65:15: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/cache-sh2.c:65:15: sparse:     got unsigned int
   arch/sh/mm/cache-sh2.c:67:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/mm/cache-sh2.c:67:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/cache-sh2.c:67:9: sparse:     got unsigned int
--
   drivers/firewire/core-cdev.c:1088:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/firewire/core-cdev.c:1088:21: sparse:     expected unsigned int const *__gu_addr
   drivers/firewire/core-cdev.c:1088:21: sparse:     got unsigned int [noderef] __user *
>> drivers/firewire/core-cdev.c:1088:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
>> drivers/firewire/core-cdev.c:1088:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/firewire/core-cdev.c:1088:21: sparse:     got unsigned int const *__gu_addr
--
   drivers/md/md.c:7693:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/md/md.c:7693:21: sparse:     expected int const *__gu_addr
   drivers/md/md.c:7693:21: sparse:     got int [noderef] __user *
>> drivers/md/md.c:7693:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> drivers/md/md.c:7693:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/md/md.c:7693:21: sparse:     got int const *__gu_addr
--
>> drivers/spi/spi-lp8841-rtc.c:112:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
>> drivers/spi/spi-lp8841-rtc.c:112:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:112:17: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:121:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:121:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:121:17: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:143:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:143:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:143:9: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:147:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:147:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:147:17: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:209:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *iomem @@     got void [noderef] __iomem * @@
   drivers/spi/spi-lp8841-rtc.c:209:21: sparse:     expected void *iomem
   drivers/spi/spi-lp8841-rtc.c:209:21: sparse:     got void [noderef] __iomem *
   drivers/spi/spi-lp8841-rtc.c:57:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:57:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:57:9: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:63:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:63:28: sparse:     expected void const [noderef] __iomem *
   drivers/spi/spi-lp8841-rtc.c:63:28: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:57:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:57:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:57:9: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:63:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:63:28: sparse:     expected void const [noderef] __iomem *
   drivers/spi/spi-lp8841-rtc.c:63:28: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse:     got void *iomem
--
   drivers/tee/tee_core.c:683:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/tee/tee_core.c:683:13: sparse:     expected unsigned int const *__gu_addr
   drivers/tee/tee_core.c:683:13: sparse:     got unsigned int [noderef] __user *
>> drivers/tee/tee_core.c:683:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
>> drivers/tee/tee_core.c:683:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:683:13: sparse:     got unsigned int const *__gu_addr
   drivers/tee/tee_core.c:781:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/tee/tee_core.c:781:13: sparse:     expected unsigned int const *__gu_addr
   drivers/tee/tee_core.c:781:13: sparse:     got unsigned int [noderef] __user *
   drivers/tee/tee_core.c:781:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/tee/tee_core.c:781:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:781:13: sparse:     got unsigned int const *__gu_addr
   drivers/tee/tee_core.c:782:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/tee/tee_core.c:782:13: sparse:     expected unsigned int const *__gu_addr
   drivers/tee/tee_core.c:782:13: sparse:     got unsigned int [noderef] __user *
   drivers/tee/tee_core.c:782:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/tee/tee_core.c:782:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tee/tee_core.c:782:13: sparse:     got unsigned int const *__gu_addr
--
   drivers/video/fbdev/s3c-fb.c:1024:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/video/fbdev/s3c-fb.c:1024:21: sparse:     expected unsigned int const *__gu_addr
   drivers/video/fbdev/s3c-fb.c:1024:21: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/video/fbdev/s3c-fb.c:1024:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
>> drivers/video/fbdev/s3c-fb.c:1024:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/s3c-fb.c:1024:21: sparse:     got unsigned int const *__gu_addr
--
   sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse:     got int [noderef] __user *p
>> sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:97:21: sparse:     got int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse:     got int [noderef] __user *p
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:115:21: sparse:     got int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse:     got int [noderef] __user *p
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:126:21: sparse:     got int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse:     got int [noderef] __user *p
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:132:21: sparse:     got int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse:     got int [noderef] __user *p
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:150:21: sparse:     got int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse:     got int [noderef] __user *p
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_ioctl.c:162:21: sparse:     got int const *__gu_addr
--
   sound/core/seq/oss/seq_oss_timer.c:224:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *arg @@
   sound/core/seq/oss/seq_oss_timer.c:224:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_timer.c:224:21: sparse:     got int [noderef] __user *arg
>> sound/core/seq/oss/seq_oss_timer.c:224:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> sound/core/seq/oss/seq_oss_timer.c:224:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_timer.c:224:21: sparse:     got int const *__gu_addr
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *arg @@
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse:     got int [noderef] __user *arg
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_timer.c:243:21: sparse:     got int const *__gu_addr
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *arg @@
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse:     expected int const *__gu_addr
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse:     got int [noderef] __user *arg
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse:     expected void const volatile [noderef] __user *ptr
   sound/core/seq/oss/seq_oss_timer.c:247:21: sparse:     got int const *__gu_addr
--
   net/xdp/xsk.c:835:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/xdp/xsk.c:835:13: sparse:     expected int const *__gu_addr
   net/xdp/xsk.c:835:13: sparse:     got int [noderef] __user *optlen
>> net/xdp/xsk.c:835:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
>> net/xdp/xsk.c:835:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/xdp/xsk.c:835:13: sparse:     got int const *__gu_addr

vim +65 arch/sh/mm/cache-sh2.c

^1da177e4c3f415 Linus Torvalds     2005-04-16  52  
109b44a82a7a8ae Paul Mundt         2009-08-15  53  static void sh2__flush_invalidate_region(void *start, int size)
9d4436a6fbc8c5e Yoshinori Sato     2006-11-05  54  {
cce2d453e4940d3 Yoshinori Sato     2008-08-04  55  #ifdef CONFIG_CACHE_WRITEBACK
cce2d453e4940d3 Yoshinori Sato     2008-08-04  56  	/*
cce2d453e4940d3 Yoshinori Sato     2008-08-04  57  	 * SH-2 does not support individual line invalidation, only a
cce2d453e4940d3 Yoshinori Sato     2008-08-04  58  	 * global invalidate.
cce2d453e4940d3 Yoshinori Sato     2008-08-04  59  	 */
cce2d453e4940d3 Yoshinori Sato     2008-08-04  60  	unsigned long ccr;
cce2d453e4940d3 Yoshinori Sato     2008-08-04  61  	unsigned long flags;
cce2d453e4940d3 Yoshinori Sato     2008-08-04  62  	local_irq_save(flags);
cce2d453e4940d3 Yoshinori Sato     2008-08-04  63  	jump_to_uncached();
cce2d453e4940d3 Yoshinori Sato     2008-08-04  64  
a5f6ea29f9a9184 Geert Uytterhoeven 2014-03-03 @65  	ccr = __raw_readl(SH_CCR);
cce2d453e4940d3 Yoshinori Sato     2008-08-04  66  	ccr |= CCR_CACHE_INVALIDATE;
a5f6ea29f9a9184 Geert Uytterhoeven 2014-03-03  67  	__raw_writel(ccr, SH_CCR);
cce2d453e4940d3 Yoshinori Sato     2008-08-04  68  
cce2d453e4940d3 Yoshinori Sato     2008-08-04  69  	back_to_cached();
cce2d453e4940d3 Yoshinori Sato     2008-08-04  70  	local_irq_restore(flags);
cce2d453e4940d3 Yoshinori Sato     2008-08-04  71  #else
9d4436a6fbc8c5e Yoshinori Sato     2006-11-05  72  	unsigned long v;
9d4436a6fbc8c5e Yoshinori Sato     2006-11-05  73  	unsigned long begin, end;
^1da177e4c3f415 Linus Torvalds     2005-04-16  74  
9d4436a6fbc8c5e Yoshinori Sato     2006-11-05  75  	begin = (unsigned long)start & ~(L1_CACHE_BYTES-1);
9d4436a6fbc8c5e Yoshinori Sato     2006-11-05  76  	end = ((unsigned long)start + size + L1_CACHE_BYTES-1)
9d4436a6fbc8c5e Yoshinori Sato     2006-11-05  77  		& ~(L1_CACHE_BYTES-1);
^1da177e4c3f415 Linus Torvalds     2005-04-16  78  
cce2d453e4940d3 Yoshinori Sato     2008-08-04  79  	for (v = begin; v < end; v+=L1_CACHE_BYTES)
9d56dd3b083a3be Paul Mundt         2010-01-26  80  		__raw_writel((v & CACHE_PHYSADDR_MASK),
cce2d453e4940d3 Yoshinori Sato     2008-08-04  81  			  CACHE_OC_ADDRESS_ARRAY | (v & 0x00000ff0) | 0x00000008);
cce2d453e4940d3 Yoshinori Sato     2008-08-04  82  #endif
cce2d453e4940d3 Yoshinori Sato     2008-08-04  83  }
109b44a82a7a8ae Paul Mundt         2009-08-15  84  

:::::: The code at line 65 was first introduced by commit
:::::: a5f6ea29f9a918403629f8369ae55fac6b09cb53 sh: prefix sh-specific "CCR" and "CCR2" by "SH_"

:::::: TO: Geert Uytterhoeven <geert@linux-m68k.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--dDRMvlgZJXvWKvBx
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--dDRMvlgZJXvWKvBx--
