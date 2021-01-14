Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6792F5C88
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 09:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbhANIhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 03:37:50 -0500
Received: from mga07.intel.com ([134.134.136.100]:41414 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbhANIht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 03:37:49 -0500
IronPort-SDR: yWt2OUiKCmyeaz4niCBPC5SXBdjfsgZwzupJZnpJ312CRd7ZeqaeQe8OqOTCx2lXGsKHsc1z87
 L+LSqbqpR0Jw==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="242403760"
X-IronPort-AV: E=Sophos;i="5.79,346,1602572400"; 
   d="gz'50?scan'50,208,50";a="242403760"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 00:37:05 -0800
IronPort-SDR: 1gYrgzWAKkpEflYXOywGLAFb952UD5TAOgd5nk+1eh1+wsmChSjUb7CUXJpDG6AmR68Obv4w/W
 iQ3m+Sg5Wmhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,346,1602572400"; 
   d="gz'50?scan'50,208,50";a="405096820"
Received: from lkp-server01.sh.intel.com (HELO d5d1a9a2c6bb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jan 2021 00:37:03 -0800
Received: from kbuild by d5d1a9a2c6bb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kzy7r-0000jJ-6S; Thu, 14 Jan 2021 08:37:03 +0000
Date:   Thu, 14 Jan 2021 16:36:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: arch/sh/kernel/cpu/sh2a/clock-sh7203.c:29:32: sparse: sparse:
 incorrect type in argument 1 (different base types)
Message-ID: <202101141633.YXecM55w-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Luc,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   65f0d2414b7079556fbbcc070b3d1c9f9587606d
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   5 months ago
config: sh-randconfig-s032-20210114 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-208-g46a52ca4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
>> arch/sh/kernel/cpu/sh2a/clock-sh7203.c:29:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh2a/clock-sh7203.c:29:32: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/clock-sh7203.c:29:32: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh2a/clock-sh7203.c:38:20: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh2a/clock-sh7203.c:38:20: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/clock-sh7203.c:38:20: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh2a/clock-sh7203.c:48:20: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh2a/clock-sh7203.c:48:20: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/clock-sh7203.c:48:20: sparse:     got unsigned int
--
>> arch/sh/kernel/cpu/sh2a/setup-sh7203.c:348:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh2a/setup-sh7203.c:348:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/setup-sh7203.c:348:9: sparse:     got unsigned int
>> arch/sh/kernel/cpu/sh2a/setup-sh7203.c:348:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh2a/setup-sh7203.c:348:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/setup-sh7203.c:348:9: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh2a/setup-sh7203.c:351:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh2a/setup-sh7203.c:351:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/setup-sh7203.c:351:9: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh2a/setup-sh7203.c:351:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh2a/setup-sh7203.c:351:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh2a/setup-sh7203.c:351:9: sparse:     got unsigned int
--
>> arch/sh/boards/mach-rsk/devices-rsk7203.c:131:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-rsk/devices-rsk7203.c:131:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-rsk/devices-rsk7203.c:131:9: sparse:     got unsigned int
--
   drivers/hid/hidraw.c:389:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/hid/hidraw.c:389:37: sparse:     expected int const *__gu_addr
   drivers/hid/hidraw.c:389:37: sparse:     got int [noderef] __user *
>> drivers/hid/hidraw.c:389:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/hid/hidraw.c:389:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/hid/hidraw.c:389:37: sparse:     got int const *__gu_addr
--
   drivers/mtd/ubi/cdev.c:467:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int const *__gu_addr @@     got signed int [noderef] [usertype] __user * @@
   drivers/mtd/ubi/cdev.c:467:23: sparse:     expected signed int const *__gu_addr
   drivers/mtd/ubi/cdev.c:467:23: sparse:     got signed int [noderef] [usertype] __user *
>> drivers/mtd/ubi/cdev.c:467:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int const *__gu_addr @@
   drivers/mtd/ubi/cdev.c:467:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/mtd/ubi/cdev.c:467:23: sparse:     got signed int const *__gu_addr
   drivers/mtd/ubi/cdev.c:512:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int const *__gu_addr @@     got signed int [noderef] [usertype] __user * @@
   drivers/mtd/ubi/cdev.c:512:23: sparse:     expected signed int const *__gu_addr
   drivers/mtd/ubi/cdev.c:512:23: sparse:     got signed int [noderef] [usertype] __user *
   drivers/mtd/ubi/cdev.c:512:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int const *__gu_addr @@
   drivers/mtd/ubi/cdev.c:512:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/mtd/ubi/cdev.c:512:23: sparse:     got signed int const *__gu_addr
   drivers/mtd/ubi/cdev.c:526:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int const *__gu_addr @@     got signed int [noderef] [usertype] __user * @@
   drivers/mtd/ubi/cdev.c:526:23: sparse:     expected signed int const *__gu_addr
   drivers/mtd/ubi/cdev.c:526:23: sparse:     got signed int [noderef] [usertype] __user *
   drivers/mtd/ubi/cdev.c:526:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int const *__gu_addr @@
   drivers/mtd/ubi/cdev.c:526:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/mtd/ubi/cdev.c:526:23: sparse:     got signed int const *__gu_addr
   drivers/mtd/ubi/cdev.c:882:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int const *__gu_addr @@     got signed int [noderef] [usertype] __user * @@
   drivers/mtd/ubi/cdev.c:882:23: sparse:     expected signed int const *__gu_addr
   drivers/mtd/ubi/cdev.c:882:23: sparse:     got signed int [noderef] [usertype] __user *
   drivers/mtd/ubi/cdev.c:882:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int const *__gu_addr @@
   drivers/mtd/ubi/cdev.c:882:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/mtd/ubi/cdev.c:882:23: sparse:     got signed int const *__gu_addr
   drivers/mtd/ubi/cdev.c:969:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int const *__gu_addr @@     got signed int [noderef] [usertype] __user * @@
   drivers/mtd/ubi/cdev.c:969:23: sparse:     expected signed int const *__gu_addr
   drivers/mtd/ubi/cdev.c:969:23: sparse:     got signed int [noderef] [usertype] __user *
   drivers/mtd/ubi/cdev.c:969:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int const *__gu_addr @@
   drivers/mtd/ubi/cdev.c:969:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/mtd/ubi/cdev.c:969:23: sparse:     got signed int const *__gu_addr
   drivers/mtd/ubi/cdev.c:984:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int const *__gu_addr @@     got signed int [noderef] [usertype] __user * @@
   drivers/mtd/ubi/cdev.c:984:23: sparse:     expected signed int const *__gu_addr
   drivers/mtd/ubi/cdev.c:984:23: sparse:     got signed int [noderef] [usertype] __user *
   drivers/mtd/ubi/cdev.c:984:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int const *__gu_addr @@
   drivers/mtd/ubi/cdev.c:984:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/mtd/ubi/cdev.c:984:23: sparse:     got signed int const *__gu_addr
   drivers/mtd/ubi/cdev.c:1061:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int const *__gu_addr @@     got signed int [noderef] [usertype] __user * @@
   drivers/mtd/ubi/cdev.c:1061:23: sparse:     expected signed int const *__gu_addr
   drivers/mtd/ubi/cdev.c:1061:23: sparse:     got signed int [noderef] [usertype] __user *
   drivers/mtd/ubi/cdev.c:1061:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int const *__gu_addr @@
   drivers/mtd/ubi/cdev.c:1061:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/mtd/ubi/cdev.c:1061:23: sparse:     got signed int const *__gu_addr
--
   kernel/bpf/cgroup.c:1439:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   kernel/bpf/cgroup.c:1439:21: sparse:     expected int const *__gu_addr
   kernel/bpf/cgroup.c:1439:21: sparse:     got int [noderef] __user *optlen
>> kernel/bpf/cgroup.c:1439:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   kernel/bpf/cgroup.c:1439:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/bpf/cgroup.c:1439:21: sparse:     got int const *__gu_addr
--
   net/socket.c:1126:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/socket.c:1126:29: sparse:     expected int const *__gu_addr
   net/socket.c:1126:29: sparse:     got int [noderef] __user *
>> net/socket.c:1126:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/socket.c:1126:29: sparse:     expected void const volatile [noderef] __user *ptr
   net/socket.c:1126:29: sparse:     got int const *__gu_addr
   net/socket.c:227:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ulen @@
   net/socket.c:227:15: sparse:     expected int const *__gu_addr
   net/socket.c:227:15: sparse:     got int [noderef] __user *ulen
   net/socket.c:227:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/socket.c:227:15: sparse:     expected void const volatile [noderef] __user *ptr
   net/socket.c:227:15: sparse:     got int const *__gu_addr
   net/socket.c:2166:30: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/socket.c:2166:30: sparse:     expected int const *__gu_addr
   net/socket.c:2166:30: sparse:     got int [noderef] __user *optlen
   net/socket.c:2166:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/socket.c:2166:30: sparse:     expected void const volatile [noderef] __user *ptr
   net/socket.c:2166:30: sparse:     got int const *__gu_addr
--
   net/core/sock.c:1313:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/core/sock.c:1313:13: sparse:     expected int const *__gu_addr
   net/core/sock.c:1313:13: sparse:     got int [noderef] __user *optlen
>> net/core/sock.c:1313:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/core/sock.c:1313:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/core/sock.c:1313:13: sparse:     got int const *__gu_addr
   net/core/sock.c:1997:9: sparse: sparse: context imbalance in 'sk_clone_lock' - wrong count at exit
   net/core/sock.c:2001:6: sparse: sparse: context imbalance in 'sk_free_unlock_clone' - unexpected unlock
   net/core/sock.c:3093:6: sparse: sparse: context imbalance in 'lock_sock_fast' - different lock contexts for basic block
   net/core/sock.c:3565:13: sparse: sparse: context imbalance in 'proto_seq_start' - wrong count at exit
   net/core/sock.c:3577:13: sparse: sparse: context imbalance in 'proto_seq_stop' - wrong count at exit
--
   net/llc/af_llc.c:1147:14: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/llc/af_llc.c:1147:14: sparse:     expected int const *__gu_addr
   net/llc/af_llc.c:1147:14: sparse:     got int [noderef] __user *optlen
>> net/llc/af_llc.c:1147:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/llc/af_llc.c:1147:14: sparse:     expected void const volatile [noderef] __user *ptr
   net/llc/af_llc.c:1147:14: sparse:     got int const *__gu_addr
--
   net/netlink/af_netlink.c:1734:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/netlink/af_netlink.c:1734:13: sparse:     expected int const *__gu_addr
   net/netlink/af_netlink.c:1734:13: sparse:     got int [noderef] __user *optlen
>> net/netlink/af_netlink.c:1734:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/netlink/af_netlink.c:1734:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/netlink/af_netlink.c:1734:13: sparse:     got int const *__gu_addr
   net/netlink/af_netlink.c:2535:13: sparse: sparse: context imbalance in 'netlink_walk_start' - wrong count at exit
   net/netlink/af_netlink.c:2541:13: sparse: sparse: context imbalance in 'netlink_walk_stop' - unexpected unlock
   net/netlink/af_netlink.c:2591:9: sparse: sparse: context imbalance in 'netlink_seq_start' - wrong count at exit
--
   net/ethtool/ioctl.c:81:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *[assigned] sizeaddr @@
   net/ethtool/ioctl.c:81:13: sparse:     expected unsigned int const *__gu_addr
   net/ethtool/ioctl.c:81:13: sparse:     got unsigned int [noderef] [usertype] __user *[assigned] sizeaddr
>> net/ethtool/ioctl.c:81:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   net/ethtool/ioctl.c:81:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/ethtool/ioctl.c:81:13: sparse:     got unsigned int const *__gu_addr
--
   net/x25/af_x25.c:470:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/x25/af_x25.c:470:13: sparse:     expected int const *__gu_addr
   net/x25/af_x25.c:470:13: sparse:     got int [noderef] __user *optlen
>> net/x25/af_x25.c:470:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/x25/af_x25.c:470:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/x25/af_x25.c:470:13: sparse:     got int const *__gu_addr
--
   net/netrom/af_netrom.c:359:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/netrom/af_netrom.c:359:13: sparse:     expected int const *__gu_addr
   net/netrom/af_netrom.c:359:13: sparse:     got int [noderef] __user *optlen
>> net/netrom/af_netrom.c:359:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/netrom/af_netrom.c:359:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/netrom/af_netrom.c:359:13: sparse:     got int const *__gu_addr
--
   net/rose/af_rose.c:438:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/rose/af_rose.c:438:13: sparse:     expected int const *__gu_addr
   net/rose/af_rose.c:438:13: sparse:     got int [noderef] __user *optlen
>> net/rose/af_rose.c:438:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/rose/af_rose.c:438:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/rose/af_rose.c:438:13: sparse:     got int const *__gu_addr
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
   net/can/raw.c:659:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/can/raw.c:659:13: sparse:     expected int const *__gu_addr
   net/can/raw.c:659:13: sparse:     got int [noderef] __user *optlen
>> net/can/raw.c:659:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/can/raw.c:659:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/can/raw.c:659:13: sparse:     got int const *__gu_addr
--
   net/can/j1939/socket.c:748:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/can/j1939/socket.c:748:13: sparse:     expected int const *__gu_addr
   net/can/j1939/socket.c:748:13: sparse:     got int [noderef] __user *optlen
>> net/can/j1939/socket.c:748:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/can/j1939/socket.c:748:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/can/j1939/socket.c:748:13: sparse:     got int const *__gu_addr
--
   net/bluetooth/hci_sock.c:1941:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/hci_sock.c:1941:13: sparse:     expected int const *__gu_addr
   net/bluetooth/hci_sock.c:1941:13: sparse:     got int [noderef] __user *optlen
>> net/bluetooth/hci_sock.c:1941:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/bluetooth/hci_sock.c:1941:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/hci_sock.c:1941:13: sparse:     got int const *__gu_addr
--
   net/bluetooth/hci_core.c:2099:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] [usertype] __user * @@
   net/bluetooth/hci_core.c:2099:13: sparse:     expected unsigned short const *__gu_addr
   net/bluetooth/hci_core.c:2099:13: sparse:     got unsigned short [noderef] [usertype] __user *
>> net/bluetooth/hci_core.c:2099:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   net/bluetooth/hci_core.c:2099:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/hci_core.c:2099:13: sparse:     got unsigned short const *__gu_addr
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
   net/atm/svc.c:509:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/atm/svc.c:509:13: sparse:     expected int const *__gu_addr
   net/atm/svc.c:509:13: sparse:     got int [noderef] __user *optlen
>> net/atm/svc.c:509:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/atm/svc.c:509:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/svc.c:509:13: sparse:     got int const *__gu_addr
--
   net/atm/ioctl.c:125:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] [usertype] __user * @@
   net/atm/ioctl.c:125:25: sparse:     expected unsigned short const *__gu_addr
   net/atm/ioctl.c:125:25: sparse:     got unsigned short [noderef] [usertype] __user *
>> net/atm/ioctl.c:125:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   net/atm/ioctl.c:125:25: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/ioctl.c:125:25: sparse:     got unsigned short const *__gu_addr
   net/atm/ioctl.c:180:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __user *const *__gu_addr @@     got void [noderef] __user *[noderef] __user * @@
   net/atm/ioctl.c:180:29: sparse:     expected void [noderef] __user *const *__gu_addr
   net/atm/ioctl.c:180:29: sparse:     got void [noderef] __user *[noderef] __user *
>> net/atm/ioctl.c:180:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got void [noderef] __user *const *__gu_addr @@
   net/atm/ioctl.c:180:29: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/ioctl.c:180:29: sparse:     got void [noderef] __user *const *__gu_addr
   net/atm/ioctl.c:203:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __user *const *__gu_addr @@     got void [noderef] __user *[noderef] __user * @@
   net/atm/ioctl.c:203:29: sparse:     expected void [noderef] __user *const *__gu_addr
   net/atm/ioctl.c:203:29: sparse:     got void [noderef] __user *[noderef] __user *
   net/atm/ioctl.c:203:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got void [noderef] __user *const *__gu_addr @@
   net/atm/ioctl.c:203:29: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/ioctl.c:203:29: sparse:     got void [noderef] __user *const *__gu_addr
   net/atm/ioctl.c:205:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   net/atm/ioctl.c:205:29: sparse:     expected int const *__gu_addr
   net/atm/ioctl.c:205:29: sparse:     got int [noderef] __user *
>> net/atm/ioctl.c:205:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/atm/ioctl.c:205:29: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/ioctl.c:205:29: sparse:     got int const *__gu_addr
--
   net/decnet/af_decnet.c:1540:12: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/decnet/af_decnet.c:1540:12: sparse:     expected int const *__gu_addr
   net/decnet/af_decnet.c:1540:12: sparse:     got int [noderef] __user *optlen
>> net/decnet/af_decnet.c:1540:12: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/decnet/af_decnet.c:1540:12: sparse:     expected void const volatile [noderef] __user *ptr
   net/decnet/af_decnet.c:1540:12: sparse:     got int const *__gu_addr
   net/decnet/af_decnet.c:250:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int hash @@     got restricted __le16 [usertype] sdn_objnamel @@
   net/decnet/af_decnet.c:250:22: sparse:     expected unsigned int hash
   net/decnet/af_decnet.c:250:22: sparse:     got restricted __le16 [usertype] sdn_objnamel
   net/decnet/af_decnet.c: note: in included file:
   include/net/dn.h:192:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] sport @@     got restricted __le16 [usertype] addrloc @@
   include/net/dn.h:192:24: sparse:     expected restricted __be16 [usertype] sport
   include/net/dn.h:192:24: sparse:     got restricted __le16 [usertype] addrloc
   include/net/dn.h:193:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] dport @@     got restricted __le16 [usertype] addrrem @@
   include/net/dn.h:193:24: sparse:     expected restricted __be16 [usertype] dport
   include/net/dn.h:193:24: sparse:     got restricted __le16 [usertype] addrrem
   net/decnet/af_decnet.c:2167:9: sparse: sparse: context imbalance in 'dn_socket_get_idx' - wrong count at exit
   net/decnet/af_decnet.c:2187:9: sparse: sparse: context imbalance in 'dn_socket_seq_next' - unexpected unlock
   net/decnet/af_decnet.c:2196:17: sparse: sparse: context imbalance in 'dn_socket_seq_stop' - unexpected unlock
--
   net/phonet/datagram.c:47:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   net/phonet/datagram.c:47:29: sparse:     expected unsigned int const *__gu_addr
   net/phonet/datagram.c:47:29: sparse:     got unsigned int [noderef] [usertype] __user *
>> net/phonet/datagram.c:47:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   net/phonet/datagram.c:47:29: sparse:     expected void const volatile [noderef] __user *ptr
   net/phonet/datagram.c:47:29: sparse:     got unsigned int const *__gu_addr
--
   net/phonet/socket.c:367:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] [usertype] __user * @@
   net/phonet/socket.c:367:21: sparse:     expected unsigned short const *__gu_addr
   net/phonet/socket.c:367:21: sparse:     got unsigned short [noderef] [usertype] __user *
>> net/phonet/socket.c:367:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   net/phonet/socket.c:367:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/phonet/socket.c:367:21: sparse:     got unsigned short const *__gu_addr
   net/phonet/socket.c:623:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/phonet/socket.c:623:14: sparse:    struct sock [noderef] __rcu *
   net/phonet/socket.c:623:14: sparse:    struct sock *
   net/phonet/socket.c:646:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/phonet/socket.c:646:17: sparse:    struct sock [noderef] __rcu *
   net/phonet/socket.c:646:17: sparse:    struct sock *
   net/phonet/socket.c:662:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/phonet/socket.c:662:17: sparse:    struct sock [noderef] __rcu *
   net/phonet/socket.c:662:17: sparse:    struct sock *
   net/phonet/socket.c:681:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   net/phonet/socket.c:681:25: sparse:    struct sock [noderef] __rcu *
   net/phonet/socket.c:681:25: sparse:    struct sock *
   net/phonet/socket.c:730:21: sparse: sparse: context imbalance in 'pn_res_seq_start' - wrong count at exit
   net/phonet/socket.c:745:13: sparse: sparse: context imbalance in 'pn_res_seq_stop' - wrong count at exit
--
   net/phonet/pep.c:1047:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/phonet/pep.c:1047:13: sparse:     expected int const *__gu_addr
   net/phonet/pep.c:1047:13: sparse:     got int [noderef] __user *optlen
>> net/phonet/pep.c:1047:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/phonet/pep.c:1047:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/phonet/pep.c:1047:13: sparse:     got int const *__gu_addr
--
   net/vmw_vsock/af_vsock.c:1612:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/vmw_vsock/af_vsock.c:1612:15: sparse:     expected int const *__gu_addr
   net/vmw_vsock/af_vsock.c:1612:15: sparse:     got int [noderef] __user *optlen
>> net/vmw_vsock/af_vsock.c:1612:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/vmw_vsock/af_vsock.c:1612:15: sparse:     expected void const volatile [noderef] __user *ptr
   net/vmw_vsock/af_vsock.c:1612:15: sparse:     got int const *__gu_addr

vim +29 arch/sh/kernel/cpu/sh2a/clock-sh7203.c

6d01f51086cf6c47 Paul Mundt 2007-11-26  26  
6d01f51086cf6c47 Paul Mundt 2007-11-26  27  static void master_clk_init(struct clk *clk)
6d01f51086cf6c47 Paul Mundt 2007-11-26  28  {
16b259203c513ed2 Paul Mundt 2010-11-01 @29  	clk->rate *= pll1rate[(__raw_readw(FREQCR) >> 8) & 0x0003] * pll2_mult;
6d01f51086cf6c47 Paul Mundt 2007-11-26  30  }
6d01f51086cf6c47 Paul Mundt 2007-11-26  31  

:::::: The code at line 29 was first introduced by commit
:::::: 16b259203c513ed28bd31cc9a981e0d3ad517943 sh: migrate SH_CLK_MD to mode pin API.

:::::: TO: Paul Mundt <lethal@linux-sh.org>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--OXfL5xGRrasGEqWY
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--OXfL5xGRrasGEqWY--
