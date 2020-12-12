Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9742D8A41
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 23:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408054AbgLLWNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 17:13:41 -0500
Received: from mga09.intel.com ([134.134.136.24]:41152 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbgLLWNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 17:13:41 -0500
IronPort-SDR: sJ3McmOAORO0hinkFxAHEI7PLSBiSAmXDSIBtX0uihE8sYEcxYUaV/hXJBvYVwVhffvGtHilh2
 /JVatlVO/9yQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9833"; a="174715985"
X-IronPort-AV: E=Sophos;i="5.78,414,1599548400"; 
   d="gz'50?scan'50,208,50";a="174715985"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2020 14:12:56 -0800
IronPort-SDR: wn93tCzhQl/XnB5GMStpnHemyFrm4+B9ORgJRmQO4l5N7PrnMvs+ZK8iU1edQDdD3RMHjKkrRV
 KbFnHQyupKlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,414,1599548400"; 
   d="gz'50?scan'50,208,50";a="366283195"
Received: from lkp-server01.sh.intel.com (HELO ecc0cebe68d1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 12 Dec 2020 14:12:54 -0800
Received: from kbuild by ecc0cebe68d1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1koD8I-0001Y8-3X; Sat, 12 Dec 2020 22:12:54 +0000
Date:   Sun, 13 Dec 2020 06:12:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: arch/sh/kernel/dwarf.c:411:24: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202012130601.csR6EBv0-lkp@intel.com>
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

Hi Luc,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7b1b868e1d9156484ccce9bf11122c053de82617
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   4 months ago
config: sh-randconfig-s032-20201213 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-179-ga00755aa-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
   arch/sh/kernel/dwarf.c:248:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long *val @@
   arch/sh/kernel/dwarf.c:248:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/dwarf.c:248:17: sparse:     got unsigned long *val
   arch/sh/kernel/dwarf.c:347:18: sparse: sparse: symbol 'dwarf_lookup_fde' was not declared. Should it be static?
>> arch/sh/kernel/dwarf.c:411:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned char * @@
   arch/sh/kernel/dwarf.c:411:24: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/dwarf.c:411:24: sparse:     got unsigned char *
>> arch/sh/kernel/dwarf.c:676:38: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr @@
   arch/sh/kernel/dwarf.c:676:38: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/dwarf.c:676:38: sparse:     got unsigned long [assigned] addr
   arch/sh/kernel/dwarf.c:708:30: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr @@
   arch/sh/kernel/dwarf.c:708:30: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/dwarf.c:708:30: sparse:     got unsigned long [assigned] addr
   arch/sh/kernel/dwarf.c:775:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *[assigned] p @@
   arch/sh/kernel/dwarf.c:775:43: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/dwarf.c:775:43: sparse:     got void *[assigned] p
>> arch/sh/kernel/dwarf.c:156:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got char *addr @@
   arch/sh/kernel/dwarf.c:156:24: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/dwarf.c:156:24: sparse:     got char *addr
>> arch/sh/kernel/dwarf.c:156:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got char *addr @@
   arch/sh/kernel/dwarf.c:156:24: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/dwarf.c:156:24: sparse:     got char *addr
>> arch/sh/kernel/dwarf.c:156:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got char *addr @@
   arch/sh/kernel/dwarf.c:156:24: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/dwarf.c:156:24: sparse:     got char *addr
>> arch/sh/kernel/dwarf.c:156:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got char *addr @@
   arch/sh/kernel/dwarf.c:156:24: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/dwarf.c:156:24: sparse:     got char *addr
>> arch/sh/kernel/dwarf.c:156:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got char *addr @@
   arch/sh/kernel/dwarf.c:156:24: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/dwarf.c:156:24: sparse:     got char *addr
>> arch/sh/kernel/dwarf.c:156:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got char *addr @@
   arch/sh/kernel/dwarf.c:156:24: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/dwarf.c:156:24: sparse:     got char *addr
>> arch/sh/kernel/dwarf.c:156:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got char *addr @@
   arch/sh/kernel/dwarf.c:156:24: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/dwarf.c:156:24: sparse:     got char *addr
>> arch/sh/kernel/dwarf.c:156:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got char *addr @@
   arch/sh/kernel/dwarf.c:156:24: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/dwarf.c:156:24: sparse:     got char *addr
>> arch/sh/kernel/dwarf.c:156:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got char *addr @@
   arch/sh/kernel/dwarf.c:156:24: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/dwarf.c:156:24: sparse:     got char *addr
>> arch/sh/kernel/dwarf.c:156:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got char *addr @@
   arch/sh/kernel/dwarf.c:156:24: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/dwarf.c:156:24: sparse:     got char *addr
>> arch/sh/kernel/dwarf.c:156:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got char *addr @@
   arch/sh/kernel/dwarf.c:156:24: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/dwarf.c:156:24: sparse:     got char *addr
   arch/sh/kernel/dwarf.c:192:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got char *addr @@
   arch/sh/kernel/dwarf.c:192:24: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/dwarf.c:192:24: sparse:     got char *addr
>> arch/sh/kernel/dwarf.c:156:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got char *addr @@
   arch/sh/kernel/dwarf.c:156:24: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/dwarf.c:156:24: sparse:     got char *addr
   arch/sh/kernel/dwarf.c:192:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got char *addr @@
   arch/sh/kernel/dwarf.c:192:24: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/dwarf.c:192:24: sparse:     got char *addr
>> arch/sh/kernel/dwarf.c:156:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got char *addr @@
   arch/sh/kernel/dwarf.c:156:24: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/dwarf.c:156:24: sparse:     got char *addr
>> arch/sh/kernel/dwarf.c:156:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got char *addr @@
   arch/sh/kernel/dwarf.c:156:24: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/dwarf.c:156:24: sparse:     got char *addr
>> arch/sh/kernel/dwarf.c:156:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got char *addr @@
   arch/sh/kernel/dwarf.c:156:24: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/dwarf.c:156:24: sparse:     got char *addr
>> arch/sh/kernel/dwarf.c:156:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got char *addr @@
   arch/sh/kernel/dwarf.c:156:24: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/dwarf.c:156:24: sparse:     got char *addr
   arch/sh/kernel/dwarf.c:192:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got char *addr @@
   arch/sh/kernel/dwarf.c:192:24: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/dwarf.c:192:24: sparse:     got char *addr
>> arch/sh/kernel/dwarf.c:156:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got char *addr @@
   arch/sh/kernel/dwarf.c:156:24: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/dwarf.c:156:24: sparse:     got char *addr
>> arch/sh/kernel/dwarf.c:156:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got char *addr @@
   arch/sh/kernel/dwarf.c:156:24: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/dwarf.c:156:24: sparse:     got char *addr
>> arch/sh/kernel/dwarf.c:156:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got char *addr @@
   arch/sh/kernel/dwarf.c:156:24: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/dwarf.c:156:24: sparse:     got char *addr
--
>> arch/sh/kernel/cpu/sh2a/setup-sh7206.c:284:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh2a/setup-sh7206.c:284:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/setup-sh7206.c:284:9: sparse:     got unsigned int
>> arch/sh/kernel/cpu/sh2a/setup-sh7206.c:284:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh2a/setup-sh7206.c:284:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/setup-sh7206.c:284:9: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh2a/setup-sh7206.c:287:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh2a/setup-sh7206.c:287:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/setup-sh7206.c:287:9: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh2a/setup-sh7206.c:287:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh2a/setup-sh7206.c:287:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/setup-sh7206.c:287:9: sparse:     got unsigned int
--
>> arch/sh/kernel/cpu/sh2a/clock-sh7206.c:26:44: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh2a/clock-sh7206.c:26:44: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/clock-sh7206.c:26:44: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh2a/clock-sh7206.c:35:20: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh2a/clock-sh7206.c:35:20: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/clock-sh7206.c:35:20: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh2a/clock-sh7206.c:45:46: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh2a/clock-sh7206.c:45:46: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/clock-sh7206.c:45:46: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh2a/clock-sh7206.c:54:20: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh2a/clock-sh7206.c:54:20: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/clock-sh7206.c:54:20: sparse:     got unsigned int
--
   fs/orangefs/file.c:118:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected int open_for_write @@     got restricted fmode_t @@
   fs/orangefs/file.c:118:32: sparse:     expected int open_for_write
   fs/orangefs/file.c:118:32: sparse:     got restricted fmode_t
   fs/orangefs/file.c:119:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected int open_for_read @@     got restricted fmode_t @@
   fs/orangefs/file.c:119:31: sparse:     expected int open_for_read
   fs/orangefs/file.c:119:31: sparse:     got restricted fmode_t
   fs/orangefs/file.c:424:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/orangefs/file.c:424:21: sparse:     expected int const *__gu_addr
   fs/orangefs/file.c:424:21: sparse:     got int [noderef] __user *
>> fs/orangefs/file.c:424:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/orangefs/file.c:424:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/orangefs/file.c:424:21: sparse:     got int const *__gu_addr
--
   fs/ubifs/ioctl.c:162:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/ubifs/ioctl.c:162:21: sparse:     expected int const *__gu_addr
   fs/ubifs/ioctl.c:162:21: sparse:     got int [noderef] __user *
>> fs/ubifs/ioctl.c:162:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/ubifs/ioctl.c:162:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ubifs/ioctl.c:162:21: sparse:     got int const *__gu_addr
--
   ipc/syscall.c:48:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long const *__gu_addr @@     got unsigned long [noderef] __user * @@
   ipc/syscall.c:48:21: sparse:     expected unsigned long const *__gu_addr
   ipc/syscall.c:48:21: sparse:     got unsigned long [noderef] __user *
>> ipc/syscall.c:48:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long const *__gu_addr @@
   ipc/syscall.c:48:21: sparse:     expected void const volatile [noderef] __user *ptr
   ipc/syscall.c:48:21: sparse:     got unsigned long const *__gu_addr
--
   drivers/spi/spidev.c:401:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:401:34: sparse:     expected unsigned char const *__gu_addr
   drivers/spi/spidev.c:401:34: sparse:     got unsigned char [noderef] [usertype] __user *
>> drivers/spi/spidev.c:401:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char const *__gu_addr @@
   drivers/spi/spidev.c:401:34: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/spi/spidev.c:401:34: sparse:     got unsigned char const *__gu_addr
   drivers/spi/spidev.c:403:34: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:403:34: sparse:     expected unsigned int const *__gu_addr
   drivers/spi/spidev.c:403:34: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/spi/spidev.c:403:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/spi/spidev.c:403:34: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/spi/spidev.c:403:34: sparse:     got unsigned int const *__gu_addr
   drivers/spi/spidev.c:427:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:427:26: sparse:     expected unsigned char const *__gu_addr
   drivers/spi/spidev.c:427:26: sparse:     got unsigned char [noderef] [usertype] __user *
   drivers/spi/spidev.c:427:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char const *__gu_addr @@
   drivers/spi/spidev.c:427:26: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/spi/spidev.c:427:26: sparse:     got unsigned char const *__gu_addr
   drivers/spi/spidev.c:444:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:444:26: sparse:     expected unsigned char const *__gu_addr
   drivers/spi/spidev.c:444:26: sparse:     got unsigned char [noderef] [usertype] __user *
   drivers/spi/spidev.c:444:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char const *__gu_addr @@
   drivers/spi/spidev.c:444:26: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/spi/spidev.c:444:26: sparse:     got unsigned char const *__gu_addr
   drivers/spi/spidev.c:457:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/spi/spidev.c:457:26: sparse:     expected unsigned int const *__gu_addr
   drivers/spi/spidev.c:457:26: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/spi/spidev.c:457:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/spi/spidev.c:457:26: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/spi/spidev.c:457:26: sparse:     got unsigned int const *__gu_addr
--
   drivers/usb/core/devio.c:937:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/core/devio.c:937:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/core/devio.c:937:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/core/devio.c:937:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
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
   drivers/usb/core/devio.c:1441:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
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
   drivers/video/fbdev/tmiofb.c:528:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *argp @@
   drivers/video/fbdev/tmiofb.c:528:21: sparse:     expected unsigned int const *__gu_addr
   drivers/video/fbdev/tmiofb.c:528:21: sparse:     got unsigned int [noderef] [usertype] __user *argp
>> drivers/video/fbdev/tmiofb.c:528:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/video/fbdev/tmiofb.c:528:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/tmiofb.c:528:21: sparse:     got unsigned int const *__gu_addr
--
   drivers/watchdog/mv64x60_wdt.c:163:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   drivers/watchdog/mv64x60_wdt.c:163:37: sparse:     expected char const *__gu_addr
   drivers/watchdog/mv64x60_wdt.c:163:37: sparse:     got char const [noderef] __user *
>> drivers/watchdog/mv64x60_wdt.c:163:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   drivers/watchdog/mv64x60_wdt.c:163:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/mv64x60_wdt.c:163:37: sparse:     got char const *__gu_addr
   drivers/watchdog/mv64x60_wdt.c:206:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/watchdog/mv64x60_wdt.c:206:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/mv64x60_wdt.c:206:21: sparse:     got int [noderef] __user *
>> drivers/watchdog/mv64x60_wdt.c:206:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/watchdog/mv64x60_wdt.c:206:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/mv64x60_wdt.c:206:21: sparse:     got int const *__gu_addr
   drivers/watchdog/mv64x60_wdt.c:222:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/watchdog/mv64x60_wdt.c:222:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/mv64x60_wdt.c:222:21: sparse:     got int [noderef] __user *
   drivers/watchdog/mv64x60_wdt.c:222:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/watchdog/mv64x60_wdt.c:222:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/mv64x60_wdt.c:222:21: sparse:     got int const *__gu_addr
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
>> drivers/watchdog/pcwd_usb.c:423:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/watchdog/pcwd_usb.c:423:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/pcwd_usb.c:423:21: sparse:     got int const *__gu_addr
   drivers/watchdog/pcwd_usb.c:447:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/watchdog/pcwd_usb.c:447:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/pcwd_usb.c:447:21: sparse:     got int [noderef] __user *p
   drivers/watchdog/pcwd_usb.c:447:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/watchdog/pcwd_usb.c:447:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/pcwd_usb.c:447:21: sparse:     got int const *__gu_addr
--
   drivers/watchdog/shwdt.c: note: in included file:
   arch/sh/include/asm/watchdog.h:144:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:144:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:144:16: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:156:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:156:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:156:9: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:134:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:134:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:134:9: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:144:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:144:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:144:16: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:156:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:156:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:156:9: sparse:     got unsigned int
   drivers/watchdog/shwdt.c: note: in included file (through arch/sh/include/cpu-sh2a/cpu/watchdog.h, arch/sh/include/asm/watchdog.h):
>> arch/sh/include/cpu-sh2/cpu/watchdog.h:44:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/cpu-sh2/cpu/watchdog.h:44:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/cpu-sh2/cpu/watchdog.h:44:16: sparse:     got unsigned int
   arch/sh/include/cpu-sh2/cpu/watchdog.h:62:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/cpu-sh2/cpu/watchdog.h:62:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/cpu-sh2/cpu/watchdog.h:62:9: sparse:     got unsigned int
   drivers/watchdog/shwdt.c: note: in included file:
   arch/sh/include/asm/watchdog.h:144:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:144:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:144:16: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:156:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:156:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:156:9: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:144:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:144:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:144:16: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:156:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:156:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:156:9: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:134:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:134:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:134:9: sparse:     got unsigned int

vim +411 arch/sh/kernel/dwarf.c

bd353861c735b22 Matt Fleming 2009-08-14  381  
bd353861c735b22 Matt Fleming 2009-08-14  382  /**
bd353861c735b22 Matt Fleming 2009-08-14  383   *	dwarf_cfa_execute_insns - execute instructions to calculate a CFA
bd353861c735b22 Matt Fleming 2009-08-14  384   *	@insn_start: address of the first instruction
bd353861c735b22 Matt Fleming 2009-08-14  385   *	@insn_end: address of the last instruction
bd353861c735b22 Matt Fleming 2009-08-14  386   *	@cie: the CIE for this function
bd353861c735b22 Matt Fleming 2009-08-14  387   *	@fde: the FDE for this function
bd353861c735b22 Matt Fleming 2009-08-14  388   *	@frame: the instructions calculate the CFA for this frame
bd353861c735b22 Matt Fleming 2009-08-14  389   *	@pc: the program counter of the address we're interested in
bd353861c735b22 Matt Fleming 2009-08-14  390   *
bd353861c735b22 Matt Fleming 2009-08-14  391   *	Execute the Call Frame instruction sequence starting at
bd353861c735b22 Matt Fleming 2009-08-14  392   *	@insn_start and ending at @insn_end. The instructions describe
bd353861c735b22 Matt Fleming 2009-08-14  393   *	how to calculate the Canonical Frame Address of a stackframe.
bd353861c735b22 Matt Fleming 2009-08-14  394   *	Store the results in @frame.
bd353861c735b22 Matt Fleming 2009-08-14  395   */
bd353861c735b22 Matt Fleming 2009-08-14  396  static int dwarf_cfa_execute_insns(unsigned char *insn_start,
bd353861c735b22 Matt Fleming 2009-08-14  397  				   unsigned char *insn_end,
bd353861c735b22 Matt Fleming 2009-08-14  398  				   struct dwarf_cie *cie,
bd353861c735b22 Matt Fleming 2009-08-14  399  				   struct dwarf_fde *fde,
bd353861c735b22 Matt Fleming 2009-08-14  400  				   struct dwarf_frame *frame,
b955873bf530ee4 Matt Fleming 2009-08-15  401  				   unsigned long pc)
bd353861c735b22 Matt Fleming 2009-08-14  402  {
bd353861c735b22 Matt Fleming 2009-08-14  403  	unsigned char insn;
bd353861c735b22 Matt Fleming 2009-08-14  404  	unsigned char *current_insn;
bd353861c735b22 Matt Fleming 2009-08-14  405  	unsigned int count, delta, reg, expr_len, offset;
fb3f3e7fc6d4afb Matt Fleming 2009-08-16  406  	struct dwarf_reg *regp;
bd353861c735b22 Matt Fleming 2009-08-14  407  
bd353861c735b22 Matt Fleming 2009-08-14  408  	current_insn = insn_start;
bd353861c735b22 Matt Fleming 2009-08-14  409  
b955873bf530ee4 Matt Fleming 2009-08-15  410  	while (current_insn < insn_end && frame->pc <= pc) {
bd353861c735b22 Matt Fleming 2009-08-14 @411  		insn = __raw_readb(current_insn++);
bd353861c735b22 Matt Fleming 2009-08-14  412  
bd353861c735b22 Matt Fleming 2009-08-14  413  		/*
bd353861c735b22 Matt Fleming 2009-08-14  414  		 * Firstly, handle the opcodes that embed their operands
bd353861c735b22 Matt Fleming 2009-08-14  415  		 * in the instructions.
bd353861c735b22 Matt Fleming 2009-08-14  416  		 */
bd353861c735b22 Matt Fleming 2009-08-14  417  		switch (DW_CFA_opcode(insn)) {
bd353861c735b22 Matt Fleming 2009-08-14  418  		case DW_CFA_advance_loc:
bd353861c735b22 Matt Fleming 2009-08-14  419  			delta = DW_CFA_operand(insn);
bd353861c735b22 Matt Fleming 2009-08-14  420  			delta *= cie->code_alignment_factor;
bd353861c735b22 Matt Fleming 2009-08-14  421  			frame->pc += delta;
bd353861c735b22 Matt Fleming 2009-08-14  422  			continue;
bd353861c735b22 Matt Fleming 2009-08-14  423  			/* NOTREACHED */
bd353861c735b22 Matt Fleming 2009-08-14  424  		case DW_CFA_offset:
bd353861c735b22 Matt Fleming 2009-08-14  425  			reg = DW_CFA_operand(insn);
bd353861c735b22 Matt Fleming 2009-08-14  426  			count = dwarf_read_uleb128(current_insn, &offset);
bd353861c735b22 Matt Fleming 2009-08-14  427  			current_insn += count;
bd353861c735b22 Matt Fleming 2009-08-14  428  			offset *= cie->data_alignment_factor;
fb3f3e7fc6d4afb Matt Fleming 2009-08-16  429  			regp = dwarf_frame_alloc_reg(frame, reg);
fb3f3e7fc6d4afb Matt Fleming 2009-08-16  430  			regp->addr = offset;
fb3f3e7fc6d4afb Matt Fleming 2009-08-16  431  			regp->flags |= DWARF_REG_OFFSET;
bd353861c735b22 Matt Fleming 2009-08-14  432  			continue;
bd353861c735b22 Matt Fleming 2009-08-14  433  			/* NOTREACHED */
bd353861c735b22 Matt Fleming 2009-08-14  434  		case DW_CFA_restore:
bd353861c735b22 Matt Fleming 2009-08-14  435  			reg = DW_CFA_operand(insn);
bd353861c735b22 Matt Fleming 2009-08-14  436  			continue;
bd353861c735b22 Matt Fleming 2009-08-14  437  			/* NOTREACHED */
bd353861c735b22 Matt Fleming 2009-08-14  438  		}
bd353861c735b22 Matt Fleming 2009-08-14  439  
bd353861c735b22 Matt Fleming 2009-08-14  440  		/*
bd353861c735b22 Matt Fleming 2009-08-14  441  		 * Secondly, handle the opcodes that don't embed their
bd353861c735b22 Matt Fleming 2009-08-14  442  		 * operands in the instruction.
bd353861c735b22 Matt Fleming 2009-08-14  443  		 */
bd353861c735b22 Matt Fleming 2009-08-14  444  		switch (insn) {
bd353861c735b22 Matt Fleming 2009-08-14  445  		case DW_CFA_nop:
bd353861c735b22 Matt Fleming 2009-08-14  446  			continue;
bd353861c735b22 Matt Fleming 2009-08-14  447  		case DW_CFA_advance_loc1:
bd353861c735b22 Matt Fleming 2009-08-14  448  			delta = *current_insn++;
bd353861c735b22 Matt Fleming 2009-08-14  449  			frame->pc += delta * cie->code_alignment_factor;
bd353861c735b22 Matt Fleming 2009-08-14  450  			break;
bd353861c735b22 Matt Fleming 2009-08-14  451  		case DW_CFA_advance_loc2:
3497447f15485b4 Paul Mundt   2009-08-14  452  			delta = get_unaligned((u16 *)current_insn);
bd353861c735b22 Matt Fleming 2009-08-14  453  			current_insn += 2;
bd353861c735b22 Matt Fleming 2009-08-14  454  			frame->pc += delta * cie->code_alignment_factor;
bd353861c735b22 Matt Fleming 2009-08-14  455  			break;
bd353861c735b22 Matt Fleming 2009-08-14  456  		case DW_CFA_advance_loc4:
3497447f15485b4 Paul Mundt   2009-08-14  457  			delta = get_unaligned((u32 *)current_insn);
bd353861c735b22 Matt Fleming 2009-08-14  458  			current_insn += 4;
bd353861c735b22 Matt Fleming 2009-08-14  459  			frame->pc += delta * cie->code_alignment_factor;
bd353861c735b22 Matt Fleming 2009-08-14  460  			break;
bd353861c735b22 Matt Fleming 2009-08-14  461  		case DW_CFA_offset_extended:
bd353861c735b22 Matt Fleming 2009-08-14  462  			count = dwarf_read_uleb128(current_insn, &reg);
bd353861c735b22 Matt Fleming 2009-08-14  463  			current_insn += count;
bd353861c735b22 Matt Fleming 2009-08-14  464  			count = dwarf_read_uleb128(current_insn, &offset);
bd353861c735b22 Matt Fleming 2009-08-14  465  			current_insn += count;
bd353861c735b22 Matt Fleming 2009-08-14  466  			offset *= cie->data_alignment_factor;
bd353861c735b22 Matt Fleming 2009-08-14  467  			break;
bd353861c735b22 Matt Fleming 2009-08-14  468  		case DW_CFA_restore_extended:
bd353861c735b22 Matt Fleming 2009-08-14  469  			count = dwarf_read_uleb128(current_insn, &reg);
bd353861c735b22 Matt Fleming 2009-08-14  470  			current_insn += count;
bd353861c735b22 Matt Fleming 2009-08-14  471  			break;
bd353861c735b22 Matt Fleming 2009-08-14  472  		case DW_CFA_undefined:
bd353861c735b22 Matt Fleming 2009-08-14  473  			count = dwarf_read_uleb128(current_insn, &reg);
bd353861c735b22 Matt Fleming 2009-08-14  474  			current_insn += count;
5580e9044df9c0e Matt Fleming 2009-08-20  475  			regp = dwarf_frame_alloc_reg(frame, reg);
5580e9044df9c0e Matt Fleming 2009-08-20  476  			regp->flags |= DWARF_UNDEFINED;
bd353861c735b22 Matt Fleming 2009-08-14  477  			break;
bd353861c735b22 Matt Fleming 2009-08-14  478  		case DW_CFA_def_cfa:
bd353861c735b22 Matt Fleming 2009-08-14  479  			count = dwarf_read_uleb128(current_insn,
bd353861c735b22 Matt Fleming 2009-08-14  480  						   &frame->cfa_register);
bd353861c735b22 Matt Fleming 2009-08-14  481  			current_insn += count;
bd353861c735b22 Matt Fleming 2009-08-14  482  			count = dwarf_read_uleb128(current_insn,
bd353861c735b22 Matt Fleming 2009-08-14  483  						   &frame->cfa_offset);
bd353861c735b22 Matt Fleming 2009-08-14  484  			current_insn += count;
bd353861c735b22 Matt Fleming 2009-08-14  485  
bd353861c735b22 Matt Fleming 2009-08-14  486  			frame->flags |= DWARF_FRAME_CFA_REG_OFFSET;
bd353861c735b22 Matt Fleming 2009-08-14  487  			break;
bd353861c735b22 Matt Fleming 2009-08-14  488  		case DW_CFA_def_cfa_register:
bd353861c735b22 Matt Fleming 2009-08-14  489  			count = dwarf_read_uleb128(current_insn,
bd353861c735b22 Matt Fleming 2009-08-14  490  						   &frame->cfa_register);
bd353861c735b22 Matt Fleming 2009-08-14  491  			current_insn += count;
bd353861c735b22 Matt Fleming 2009-08-14  492  			frame->flags |= DWARF_FRAME_CFA_REG_OFFSET;
bd353861c735b22 Matt Fleming 2009-08-14  493  			break;
bd353861c735b22 Matt Fleming 2009-08-14  494  		case DW_CFA_def_cfa_offset:
bd353861c735b22 Matt Fleming 2009-08-14  495  			count = dwarf_read_uleb128(current_insn, &offset);
bd353861c735b22 Matt Fleming 2009-08-14  496  			current_insn += count;
bd353861c735b22 Matt Fleming 2009-08-14  497  			frame->cfa_offset = offset;
bd353861c735b22 Matt Fleming 2009-08-14  498  			break;
bd353861c735b22 Matt Fleming 2009-08-14  499  		case DW_CFA_def_cfa_expression:
bd353861c735b22 Matt Fleming 2009-08-14  500  			count = dwarf_read_uleb128(current_insn, &expr_len);
bd353861c735b22 Matt Fleming 2009-08-14  501  			current_insn += count;
bd353861c735b22 Matt Fleming 2009-08-14  502  
bd353861c735b22 Matt Fleming 2009-08-14  503  			frame->cfa_expr = current_insn;
bd353861c735b22 Matt Fleming 2009-08-14  504  			frame->cfa_expr_len = expr_len;
bd353861c735b22 Matt Fleming 2009-08-14  505  			current_insn += expr_len;
bd353861c735b22 Matt Fleming 2009-08-14  506  
bd353861c735b22 Matt Fleming 2009-08-14  507  			frame->flags |= DWARF_FRAME_CFA_REG_EXP;
bd353861c735b22 Matt Fleming 2009-08-14  508  			break;
bd353861c735b22 Matt Fleming 2009-08-14  509  		case DW_CFA_offset_extended_sf:
bd353861c735b22 Matt Fleming 2009-08-14  510  			count = dwarf_read_uleb128(current_insn, &reg);
bd353861c735b22 Matt Fleming 2009-08-14  511  			current_insn += count;
bd353861c735b22 Matt Fleming 2009-08-14  512  			count = dwarf_read_leb128(current_insn, &offset);
bd353861c735b22 Matt Fleming 2009-08-14  513  			current_insn += count;
bd353861c735b22 Matt Fleming 2009-08-14  514  			offset *= cie->data_alignment_factor;
fb3f3e7fc6d4afb Matt Fleming 2009-08-16  515  			regp = dwarf_frame_alloc_reg(frame, reg);
fb3f3e7fc6d4afb Matt Fleming 2009-08-16  516  			regp->flags |= DWARF_REG_OFFSET;
fb3f3e7fc6d4afb Matt Fleming 2009-08-16  517  			regp->addr = offset;
bd353861c735b22 Matt Fleming 2009-08-14  518  			break;
bd353861c735b22 Matt Fleming 2009-08-14  519  		case DW_CFA_val_offset:
bd353861c735b22 Matt Fleming 2009-08-14  520  			count = dwarf_read_uleb128(current_insn, &reg);
bd353861c735b22 Matt Fleming 2009-08-14  521  			current_insn += count;
bd353861c735b22 Matt Fleming 2009-08-14  522  			count = dwarf_read_leb128(current_insn, &offset);
bd353861c735b22 Matt Fleming 2009-08-14  523  			offset *= cie->data_alignment_factor;
fb3f3e7fc6d4afb Matt Fleming 2009-08-16  524  			regp = dwarf_frame_alloc_reg(frame, reg);
97efbbd5886e27b Matt Fleming 2009-08-16  525  			regp->flags |= DWARF_VAL_OFFSET;
fb3f3e7fc6d4afb Matt Fleming 2009-08-16  526  			regp->addr = offset;
bd353861c735b22 Matt Fleming 2009-08-14  527  			break;
cd7246f0e2747bd Matt Fleming 2009-08-16  528  		case DW_CFA_GNU_args_size:
cd7246f0e2747bd Matt Fleming 2009-08-16  529  			count = dwarf_read_uleb128(current_insn, &offset);
cd7246f0e2747bd Matt Fleming 2009-08-16  530  			current_insn += count;
cd7246f0e2747bd Matt Fleming 2009-08-16  531  			break;
cd7246f0e2747bd Matt Fleming 2009-08-16  532  		case DW_CFA_GNU_negative_offset_extended:
cd7246f0e2747bd Matt Fleming 2009-08-16  533  			count = dwarf_read_uleb128(current_insn, &reg);
cd7246f0e2747bd Matt Fleming 2009-08-16  534  			current_insn += count;
cd7246f0e2747bd Matt Fleming 2009-08-16  535  			count = dwarf_read_uleb128(current_insn, &offset);
cd7246f0e2747bd Matt Fleming 2009-08-16  536  			offset *= cie->data_alignment_factor;
fb3f3e7fc6d4afb Matt Fleming 2009-08-16  537  
fb3f3e7fc6d4afb Matt Fleming 2009-08-16  538  			regp = dwarf_frame_alloc_reg(frame, reg);
fb3f3e7fc6d4afb Matt Fleming 2009-08-16  539  			regp->flags |= DWARF_REG_OFFSET;
fb3f3e7fc6d4afb Matt Fleming 2009-08-16  540  			regp->addr = -offset;
cd7246f0e2747bd Matt Fleming 2009-08-16  541  			break;
bd353861c735b22 Matt Fleming 2009-08-14  542  		default:
bd353861c735b22 Matt Fleming 2009-08-14  543  			pr_debug("unhandled DWARF instruction 0x%x\n", insn);
b344e24a8e8ceda Matt Fleming 2009-08-16  544  			UNWINDER_BUG();
bd353861c735b22 Matt Fleming 2009-08-14  545  			break;
bd353861c735b22 Matt Fleming 2009-08-14  546  		}
bd353861c735b22 Matt Fleming 2009-08-14  547  	}
bd353861c735b22 Matt Fleming 2009-08-14  548  
bd353861c735b22 Matt Fleming 2009-08-14  549  	return 0;
bd353861c735b22 Matt Fleming 2009-08-14  550  }
bd353861c735b22 Matt Fleming 2009-08-14  551  

:::::: The code at line 411 was first introduced by commit
:::::: bd353861c735b2265c9d8b2559960c693e7c68ab sh: dwarf unwinder support.

:::::: TO: Matt Fleming <matt@console-pimps.org>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--9amGYk9869ThD9tj
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AkZije3HRbSAPrgD+F9zlBf2y88BAA==

--9amGYk9869ThD9tj--
