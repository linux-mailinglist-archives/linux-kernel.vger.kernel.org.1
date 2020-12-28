Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154862E33A4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 03:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgL1C3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 21:29:00 -0500
Received: from mga05.intel.com ([192.55.52.43]:33190 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbgL1C3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 21:29:00 -0500
IronPort-SDR: 6hOsHc5rGUR4lzUQTFx+w9kb2TvewBasV24R46lUdSEJ56rwBt7TbXeoOjlXwML1nT1iTyiZqJ
 UeJEw3viGjDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9847"; a="261083633"
X-IronPort-AV: E=Sophos;i="5.78,453,1599548400"; 
   d="gz'50?scan'50,208,50";a="261083633"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2020 18:28:17 -0800
IronPort-SDR: KOc1mP2sxDRZgtoF1mrU9SPD+XNubFNPxA1SpjLfnHPD6oZ9Nhv+63K9qVcguXh7ufSHXBZ9bq
 RHHz/evw0alg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,453,1599548400"; 
   d="gz'50?scan'50,208,50";a="392570776"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 27 Dec 2020 18:28:14 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ktiGc-0002iN-6v; Mon, 28 Dec 2020 02:28:14 +0000
Date:   Mon, 28 Dec 2020 10:27:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: arch/sh/mm/cache-sh7705.c:116:32: sparse: sparse: incorrect type in
 argument 1 (different base types)
Message-ID: <202012281050.mtHzs0yN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Luc,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5c8fe583cce542aa0b84adc939ce85293de36e5e
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   4 months ago
config: sh-randconfig-s031-20201228 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
>> arch/sh/mm/cache-sh7705.c:116:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr @@
   arch/sh/mm/cache-sh7705.c:116:32: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/cache-sh7705.c:116:32: sparse:     got unsigned long [assigned] addr
   arch/sh/mm/cache-sh7705.c:119:33: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr @@
   arch/sh/mm/cache-sh7705.c:119:33: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/cache-sh7705.c:119:33: sparse:     got unsigned long [assigned] addr
   arch/sh/mm/cache-sh7705.c:49:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr @@
   arch/sh/mm/cache-sh7705.c:49:32: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/cache-sh7705.c:49:32: sparse:     got unsigned long [assigned] addr
   arch/sh/mm/cache-sh7705.c:52:33: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr @@
   arch/sh/mm/cache-sh7705.c:52:33: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/cache-sh7705.c:52:33: sparse:     got unsigned long [assigned] addr
--
   drivers/input/joydev.c:528:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int const *__gu_addr @@     got signed int [noderef] [usertype] __user * @@
   drivers/input/joydev.c:528:24: sparse:     expected signed int const *__gu_addr
   drivers/input/joydev.c:528:24: sparse:     got signed int [noderef] [usertype] __user *
   drivers/input/joydev.c:528:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int const *__gu_addr @@
   drivers/input/joydev.c:528:24: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/input/joydev.c:528:24: sparse:     got signed int const *__gu_addr
   drivers/input/joydev.c:680:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long const *__gu_addr @@     got long [noderef] __user * @@
   drivers/input/joydev.c:680:26: sparse:     expected long const *__gu_addr
   drivers/input/joydev.c:680:26: sparse:     got long [noderef] __user *
>> drivers/input/joydev.c:680:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long const *__gu_addr @@
   drivers/input/joydev.c:680:26: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/input/joydev.c:680:26: sparse:     got long const *__gu_addr
--
>> drivers/spi/spi-lp8841-rtc.c:112:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:112:17: sparse:     expected void const volatile [noderef] __iomem *ptr
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
   drivers/vhost/vdpa.c:361:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/vhost/vdpa.c:361:13: sparse:     expected unsigned int const *__gu_addr
   drivers/vhost/vdpa.c:361:13: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/vhost/vdpa.c:361:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/vhost/vdpa.c:361:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/vhost/vdpa.c:361:13: sparse:     got unsigned int const *__gu_addr
--
   drivers/vhost/scsi.c:1697:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *eventsp @@
   drivers/vhost/scsi.c:1697:21: sparse:     expected unsigned int const *__gu_addr
   drivers/vhost/scsi.c:1697:21: sparse:     got unsigned int [noderef] [usertype] __user *eventsp
>> drivers/vhost/scsi.c:1697:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/vhost/scsi.c:1697:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/vhost/scsi.c:1697:21: sparse:     got unsigned int const *__gu_addr
--
   drivers/vhost/vhost.c:1571:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *idxp @@
   drivers/vhost/vhost.c:1571:13: sparse:     expected unsigned int const *__gu_addr
   drivers/vhost/vhost.c:1571:13: sparse:     got unsigned int [noderef] [usertype] __user *idxp
>> drivers/vhost/vhost.c:1571:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/vhost/vhost.c:1571:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/vhost/vhost.c:1571:13: sparse:     got unsigned int const *__gu_addr
   drivers/vhost/vhost.c:1771:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/vhost/vhost.c:1771:21: sparse:     expected int const *__gu_addr
   drivers/vhost/vhost.c:1771:21: sparse:     got int [noderef] __user *
>> drivers/vhost/vhost.c:1771:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/vhost/vhost.c:1771:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/vhost/vhost.c:1771:21: sparse:     got int const *__gu_addr
--
   drivers/watchdog/pcwd_usb.c:375:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   drivers/watchdog/pcwd_usb.c:375:37: sparse:     expected char const *__gu_addr
   drivers/watchdog/pcwd_usb.c:375:37: sparse:     got char const [noderef] __user *
>> drivers/watchdog/pcwd_usb.c:375:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   drivers/watchdog/pcwd_usb.c:375:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/pcwd_usb.c:375:37: sparse:     got char const *__gu_addr
   drivers/watchdog/pcwd_usb.c:423:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/watchdog/pcwd_usb.c:423:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/pcwd_usb.c:423:21: sparse:     got int [noderef] __user *p
   drivers/watchdog/pcwd_usb.c:423:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/watchdog/pcwd_usb.c:423:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/pcwd_usb.c:423:21: sparse:     got int const *__gu_addr
   drivers/watchdog/pcwd_usb.c:447:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/watchdog/pcwd_usb.c:447:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/pcwd_usb.c:447:21: sparse:     got int [noderef] __user *p
   drivers/watchdog/pcwd_usb.c:447:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/watchdog/pcwd_usb.c:447:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/pcwd_usb.c:447:21: sparse:     got int const *__gu_addr
--
   drivers/watchdog/kempld_wdt.c:349:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/watchdog/kempld_wdt.c:349:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/kempld_wdt.c:349:21: sparse:     got int [noderef] __user *p
>> drivers/watchdog/kempld_wdt.c:349:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/watchdog/kempld_wdt.c:349:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/kempld_wdt.c:349:21: sparse:     got int const *__gu_addr
--
   drivers/video/fbdev/tmiofb.c:528:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *argp @@
   drivers/video/fbdev/tmiofb.c:528:21: sparse:     expected unsigned int const *__gu_addr
   drivers/video/fbdev/tmiofb.c:528:21: sparse:     got unsigned int [noderef] [usertype] __user *argp
>> drivers/video/fbdev/tmiofb.c:528:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/video/fbdev/tmiofb.c:528:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/tmiofb.c:528:21: sparse:     got unsigned int const *__gu_addr
--
   drivers/tty/vt/vt_ioctl.c:1004:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] __user * @@
   drivers/tty/vt/vt_ioctl.c:1004:21: sparse:     expected unsigned short const *__gu_addr
   drivers/tty/vt/vt_ioctl.c:1004:21: sparse:     got unsigned short [noderef] __user *
>> drivers/tty/vt/vt_ioctl.c:1004:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   drivers/tty/vt/vt_ioctl.c:1004:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/vt/vt_ioctl.c:1004:21: sparse:     got unsigned short const *__gu_addr
   drivers/tty/vt/vt_ioctl.c:1005:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] __user * @@
   drivers/tty/vt/vt_ioctl.c:1005:21: sparse:     expected unsigned short const *__gu_addr
   drivers/tty/vt/vt_ioctl.c:1005:21: sparse:     got unsigned short [noderef] __user *
   drivers/tty/vt/vt_ioctl.c:1005:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   drivers/tty/vt/vt_ioctl.c:1005:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/vt/vt_ioctl.c:1005:21: sparse:     got unsigned short const *__gu_addr
--
   drivers/usb/core/devio.c:937:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:937:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:937:13: sparse:     got unsigned int [noderef] __user *
>> drivers/usb/core/devio.c:937:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:937:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:937:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/core/devio.c:938:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:938:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:938:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:938:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:938:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:938:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/core/devio.c:953:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] __user * @@
   drivers/usb/core/devio.c:953:21: sparse:     expected unsigned char const *__gu_addr
   drivers/usb/core/devio.c:953:21: sparse:     got unsigned char [noderef] __user *
>> drivers/usb/core/devio.c:953:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char const *__gu_addr @@
   drivers/usb/core/devio.c:953:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:953:21: sparse:     got unsigned char const *__gu_addr
   drivers/usb/core/devio.c:1290:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:1290:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:1290:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:1290:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:1290:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:1290:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/core/devio.c:1309:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:1309:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:1309:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:1309:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:1309:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:1309:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/core/devio.c:1441:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/usb/core/devio.c:1441:13: sparse:     expected int const *__gu_addr
   drivers/usb/core/devio.c:1441:13: sparse:     got int [noderef] __user *
>> drivers/usb/core/devio.c:1441:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/usb/core/devio.c:1441:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:1441:13: sparse:     got int const *__gu_addr
   drivers/usb/core/devio.c:2189:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:2189:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:2189:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:2189:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:2189:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:2189:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/core/devio.c:2199:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:2199:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:2199:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:2199:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:2199:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:2199:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/core/devio.c:2315:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:2315:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:2315:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:2315:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:2315:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:2315:13: sparse:     got unsigned int const *__gu_addr
   drivers/usb/core/devio.c:2328:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:2328:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:2328:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:2328:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/usb/core/devio.c:2328:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/core/devio.c:2328:13: sparse:     got unsigned int const *__gu_addr
--
   net/ax25/af_ax25.c:695:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/ax25/af_ax25.c:695:13: sparse:     expected int const *__gu_addr
   net/ax25/af_ax25.c:695:13: sparse:     got int [noderef] __user *optlen
>> net/ax25/af_ax25.c:695:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/ax25/af_ax25.c:695:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ax25/af_ax25.c:695:13: sparse:     got int const *__gu_addr
   net/ax25/af_ax25.c:1742:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected long const *__gu_addr @@     got long [noderef] __user * @@
   net/ax25/af_ax25.c:1742:21: sparse:     expected long const *__gu_addr
   net/ax25/af_ax25.c:1742:21: sparse:     got long [noderef] __user *
>> net/ax25/af_ax25.c:1742:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got long const *__gu_addr @@
   net/ax25/af_ax25.c:1742:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/ax25/af_ax25.c:1742:21: sparse:     got long const *__gu_addr
--
   net/bluetooth/hci_sock.c:1941:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/hci_sock.c:1941:13: sparse:     expected int const *__gu_addr
   net/bluetooth/hci_sock.c:1941:13: sparse:     got int [noderef] __user *optlen
>> net/bluetooth/hci_sock.c:1941:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/bluetooth/hci_sock.c:1941:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/hci_sock.c:1941:13: sparse:     got int const *__gu_addr
--
   net/bluetooth/l2cap_sock.c:428:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/l2cap_sock.c:428:13: sparse:     expected int const *__gu_addr
   net/bluetooth/l2cap_sock.c:428:13: sparse:     got int [noderef] __user *optlen
>> net/bluetooth/l2cap_sock.c:428:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/bluetooth/l2cap_sock.c:428:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/l2cap_sock.c:428:13: sparse:     got int const *__gu_addr
   net/bluetooth/l2cap_sock.c:553:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/l2cap_sock.c:553:13: sparse:     expected int const *__gu_addr
   net/bluetooth/l2cap_sock.c:553:13: sparse:     got int [noderef] __user *optlen
   net/bluetooth/l2cap_sock.c:553:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/bluetooth/l2cap_sock.c:553:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/l2cap_sock.c:553:13: sparse:     got int const *__gu_addr
--
   net/bluetooth/hci_core.c:2099:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] [usertype] __user * @@
   net/bluetooth/hci_core.c:2099:13: sparse:     expected unsigned short const *__gu_addr
   net/bluetooth/hci_core.c:2099:13: sparse:     got unsigned short [noderef] [usertype] __user *
>> net/bluetooth/hci_core.c:2099:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   net/bluetooth/hci_core.c:2099:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/hci_core.c:2099:13: sparse:     got unsigned short const *__gu_addr
--
   net/bluetooth/sco.c:892:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/sco.c:892:13: sparse:     expected int const *__gu_addr
   net/bluetooth/sco.c:892:13: sparse:     got int [noderef] __user *optlen
>> net/bluetooth/sco.c:892:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/bluetooth/sco.c:892:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/sco.c:892:13: sparse:     got int const *__gu_addr
   net/bluetooth/sco.c:957:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/sco.c:957:13: sparse:     expected int const *__gu_addr
   net/bluetooth/sco.c:957:13: sparse:     got int [noderef] __user *optlen
   net/bluetooth/sco.c:957:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/bluetooth/sco.c:957:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/sco.c:957:13: sparse:     got int const *__gu_addr
--
   net/can/raw.c:659:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/can/raw.c:659:13: sparse:     expected int const *__gu_addr
   net/can/raw.c:659:13: sparse:     got int [noderef] __user *optlen
>> net/can/raw.c:659:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/can/raw.c:659:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/can/raw.c:659:13: sparse:     got int const *__gu_addr
--
   net/bluetooth/rfcomm/sock.c:769:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/rfcomm/sock.c:769:13: sparse:     expected int const *__gu_addr
   net/bluetooth/rfcomm/sock.c:769:13: sparse:     got int [noderef] __user *optlen
>> net/bluetooth/rfcomm/sock.c:769:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/bluetooth/rfcomm/sock.c:769:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/rfcomm/sock.c:769:13: sparse:     got int const *__gu_addr
   net/bluetooth/rfcomm/sock.c:847:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/rfcomm/sock.c:847:13: sparse:     expected int const *__gu_addr
   net/bluetooth/rfcomm/sock.c:847:13: sparse:     got int [noderef] __user *optlen
   net/bluetooth/rfcomm/sock.c:847:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/bluetooth/rfcomm/sock.c:847:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/rfcomm/sock.c:847:13: sparse:     got int const *__gu_addr
--
   net/llc/af_llc.c:1147:14: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/llc/af_llc.c:1147:14: sparse:     expected int const *__gu_addr
   net/llc/af_llc.c:1147:14: sparse:     got int [noderef] __user *optlen
>> net/llc/af_llc.c:1147:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/llc/af_llc.c:1147:14: sparse:     expected void const volatile [noderef] __user *ptr
   net/llc/af_llc.c:1147:14: sparse:     got int const *__gu_addr
--
   net/netrom/af_netrom.c:359:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/netrom/af_netrom.c:359:13: sparse:     expected int const *__gu_addr
   net/netrom/af_netrom.c:359:13: sparse:     got int [noderef] __user *optlen
>> net/netrom/af_netrom.c:359:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/netrom/af_netrom.c:359:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/netrom/af_netrom.c:359:13: sparse:     got int const *__gu_addr

vim +116 arch/sh/mm/cache-sh7705.c

^1da177e4c3f415 Linus Torvalds 2005-04-16   75  
^1da177e4c3f415 Linus Torvalds 2005-04-16   76  /*
^1da177e4c3f415 Linus Torvalds 2005-04-16   77   * Writeback&Invalidate the D-cache of the page
^1da177e4c3f415 Linus Torvalds 2005-04-16   78   */
2dc2f8e0c46864e Paul Mundt     2010-01-21   79  static void __flush_dcache_page(unsigned long phys)
^1da177e4c3f415 Linus Torvalds 2005-04-16   80  {
^1da177e4c3f415 Linus Torvalds 2005-04-16   81  	unsigned long ways, waysize, addrstart;
983f4c514c4c9dd Paul Mundt     2009-09-01   82  	unsigned long flags;
^1da177e4c3f415 Linus Torvalds 2005-04-16   83  
^1da177e4c3f415 Linus Torvalds 2005-04-16   84  	phys |= SH_CACHE_VALID;
^1da177e4c3f415 Linus Torvalds 2005-04-16   85  
^1da177e4c3f415 Linus Torvalds 2005-04-16   86  	/*
^1da177e4c3f415 Linus Torvalds 2005-04-16   87  	 * Here, phys is the physical address of the page. We check all the
^1da177e4c3f415 Linus Torvalds 2005-04-16   88  	 * tags in the cache for those with the same page number as this page
^1da177e4c3f415 Linus Torvalds 2005-04-16   89  	 * (by masking off the lowest 2 bits of the 19-bit tag; these bits are
^1da177e4c3f415 Linus Torvalds 2005-04-16   90  	 * derived from the offset within in the 4k page). Matching valid
^1da177e4c3f415 Linus Torvalds 2005-04-16   91  	 * entries are invalidated.
^1da177e4c3f415 Linus Torvalds 2005-04-16   92  	 *
^1da177e4c3f415 Linus Torvalds 2005-04-16   93  	 * Since 2 bits of the cache index are derived from the virtual page
^1da177e4c3f415 Linus Torvalds 2005-04-16   94  	 * number, knowing this would reduce the number of cache entries to be
^1da177e4c3f415 Linus Torvalds 2005-04-16   95  	 * searched by a factor of 4. However this function exists to deal with
^1da177e4c3f415 Linus Torvalds 2005-04-16   96  	 * potential cache aliasing, therefore the optimisation is probably not
^1da177e4c3f415 Linus Torvalds 2005-04-16   97  	 * possible.
^1da177e4c3f415 Linus Torvalds 2005-04-16   98  	 */
983f4c514c4c9dd Paul Mundt     2009-09-01   99  	local_irq_save(flags);
cbaa118ecfd99fc Stuart Menefy  2007-11-30  100  	jump_to_uncached();
^1da177e4c3f415 Linus Torvalds 2005-04-16  101  
11c1965687b0a47 Paul Mundt     2006-12-25  102  	ways = current_cpu_data.dcache.ways;
11c1965687b0a47 Paul Mundt     2006-12-25  103  	waysize = current_cpu_data.dcache.sets;
11c1965687b0a47 Paul Mundt     2006-12-25  104  	waysize <<= current_cpu_data.dcache.entry_shift;
^1da177e4c3f415 Linus Torvalds 2005-04-16  105  
^1da177e4c3f415 Linus Torvalds 2005-04-16  106  	addrstart = CACHE_OC_ADDRESS_ARRAY;
^1da177e4c3f415 Linus Torvalds 2005-04-16  107  
^1da177e4c3f415 Linus Torvalds 2005-04-16  108  	do {
^1da177e4c3f415 Linus Torvalds 2005-04-16  109  		unsigned long addr;
^1da177e4c3f415 Linus Torvalds 2005-04-16  110  
^1da177e4c3f415 Linus Torvalds 2005-04-16  111  		for (addr = addrstart;
^1da177e4c3f415 Linus Torvalds 2005-04-16  112  		     addr < addrstart + waysize;
11c1965687b0a47 Paul Mundt     2006-12-25  113  		     addr += current_cpu_data.dcache.linesz) {
^1da177e4c3f415 Linus Torvalds 2005-04-16  114  			unsigned long data;
^1da177e4c3f415 Linus Torvalds 2005-04-16  115  
9d56dd3b083a3be Paul Mundt     2010-01-26 @116  			data = __raw_readl(addr) & (0x1ffffC00 | SH_CACHE_VALID);
^1da177e4c3f415 Linus Torvalds 2005-04-16  117  		        if (data == phys) {
^1da177e4c3f415 Linus Torvalds 2005-04-16  118  				data &= ~(SH_CACHE_VALID | SH_CACHE_UPDATED);
9d56dd3b083a3be Paul Mundt     2010-01-26  119  				__raw_writel(data, addr);
^1da177e4c3f415 Linus Torvalds 2005-04-16  120  			}
^1da177e4c3f415 Linus Torvalds 2005-04-16  121  		}
^1da177e4c3f415 Linus Torvalds 2005-04-16  122  
11c1965687b0a47 Paul Mundt     2006-12-25  123  		addrstart += current_cpu_data.dcache.way_incr;
^1da177e4c3f415 Linus Torvalds 2005-04-16  124  	} while (--ways);
^1da177e4c3f415 Linus Torvalds 2005-04-16  125  
cbaa118ecfd99fc Stuart Menefy  2007-11-30  126  	back_to_cached();
983f4c514c4c9dd Paul Mundt     2009-09-01  127  	local_irq_restore(flags);
^1da177e4c3f415 Linus Torvalds 2005-04-16  128  }
^1da177e4c3f415 Linus Torvalds 2005-04-16  129  

:::::: The code at line 116 was first introduced by commit
:::::: 9d56dd3b083a3bec56e9da35ce07baca81030b03 sh: Mass ctrl_in/outX to __raw_read/writeX conversion.

:::::: TO: Paul Mundt <lethal@linux-sh.org>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--VS++wcV0S1rZb1Fb
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--VS++wcV0S1rZb1Fb--
