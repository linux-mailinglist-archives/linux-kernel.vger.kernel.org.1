Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4552DBFDB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 12:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbgLPLxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 06:53:17 -0500
Received: from mga03.intel.com ([134.134.136.65]:12001 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgLPLxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 06:53:17 -0500
IronPort-SDR: t2bpyc+WIep2EKljqwoFyj+C14lBBaOtRQJvppD73vJ/PAXaMMaxDVOP1GrOr4R8V2TXE2IcBl
 bJ+LkDtwQfpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="175156065"
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="gz'50?scan'50,208,50";a="175156065"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 03:52:31 -0800
IronPort-SDR: 9v7QIh6Vlu2H9gTsMizfiiuUdic+c1UGqy4IoUctnhYFW3I+89H8AndE+7tJqyWuhBzHt6oSQN
 Fon1q6Zj3LZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="gz'50?scan'50,208,50";a="412559317"
Received: from lkp-server02.sh.intel.com (HELO 070e1a605002) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 16 Dec 2020 03:52:29 -0800
Received: from kbuild by 070e1a605002 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kpVM4-00001R-KT; Wed, 16 Dec 2020 11:52:28 +0000
Date:   Wed, 16 Dec 2020 19:51:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: arch/sh/kernel/process_32.c:42:9: sparse: sparse: incorrect type in
 argument 1 (different base types)
Message-ID: <202012161943.cqimnjOm-lkp@intel.com>
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

Hi Luc,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d01e7f10dae29eba0f9ada82b65d24e035d5b2f9
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   4 months ago
config: sh-randconfig-s032-20201216 (attached as .config)
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
>> arch/sh/kernel/process_32.c:42:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/process_32.c:42:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/process_32.c:42:9: sparse:     got unsigned int
--
   arch/sh/kernel/setup.c: note: in included file:
>> arch/sh/include/asm/mmu_context.h:151:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/mmu_context.h:151:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/mmu_context.h:151:9: sparse:     got unsigned int
--
   arch/sh/kernel/disassemble.c:531:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const [noderef] __user *__gu_addr @@     got unsigned short [usertype] * @@
   arch/sh/kernel/disassemble.c:531:33: sparse:     expected unsigned short const [noderef] __user *__gu_addr
   arch/sh/kernel/disassemble.c:531:33: sparse:     got unsigned short [usertype] *
>> arch/sh/kernel/disassemble.c:531:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short [usertype] * @@
   arch/sh/kernel/disassemble.c:531:33: sparse:     expected void const volatile [noderef] __user *ptr
   arch/sh/kernel/disassemble.c:531:33: sparse:     got unsigned short [usertype] *
   arch/sh/kernel/disassemble.c:533:33: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__gu_addr @@     got unsigned int [usertype] * @@
   arch/sh/kernel/disassemble.c:533:33: sparse:     expected unsigned int const [noderef] __user *__gu_addr
   arch/sh/kernel/disassemble.c:533:33: sparse:     got unsigned int [usertype] *
>> arch/sh/kernel/disassemble.c:533:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int [usertype] * @@
   arch/sh/kernel/disassemble.c:533:33: sparse:     expected void const volatile [noderef] __user *ptr
   arch/sh/kernel/disassemble.c:533:33: sparse:     got unsigned int [usertype] *
   arch/sh/kernel/disassemble.c:560:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const [noderef] __user *__gu_addr @@     got unsigned short * @@
   arch/sh/kernel/disassemble.c:560:21: sparse:     expected unsigned short const [noderef] __user *__gu_addr
   arch/sh/kernel/disassemble.c:560:21: sparse:     got unsigned short *
>> arch/sh/kernel/disassemble.c:560:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short * @@
   arch/sh/kernel/disassemble.c:560:21: sparse:     expected void const volatile [noderef] __user *ptr
   arch/sh/kernel/disassemble.c:560:21: sparse:     got unsigned short *
--
>> arch/sh/kernel/cpu/adc.c:22:15: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/adc.c:22:15: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/adc.c:22:15: sparse:     got unsigned int
   arch/sh/kernel/cpu/adc.c:24:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/adc.c:24:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/adc.c:24:9: sparse:     got unsigned int
   arch/sh/kernel/cpu/adc.c:27:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/adc.c:27:23: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/adc.c:27:23: sparse:     got unsigned int
   arch/sh/kernel/cpu/adc.c:31:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/adc.c:31:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/adc.c:31:9: sparse:     got unsigned int
   arch/sh/kernel/cpu/adc.c:33:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/adc.c:33:19: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/adc.c:33:19: sparse:     got unsigned int
   arch/sh/kernel/cpu/adc.c:34:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/adc.c:34:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/adc.c:34:17: sparse:     got unsigned int
--
   arch/sh/mm/init.c: note: in included file (through arch/sh/include/asm/mmu_context.h):
>> arch/sh/include/asm/mmu_context_32.h:53:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/mmu_context_32.h:53:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/mmu_context_32.h:53:9: sparse:     got unsigned int
--
>> arch/sh/mm/tlbflush_32.c:134:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/mm/tlbflush_32.c:134:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/tlbflush_32.c:134:9: sparse:     got unsigned int
>> arch/sh/mm/tlbflush_32.c:134:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/mm/tlbflush_32.c:134:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/tlbflush_32.c:134:9: sparse:     got unsigned int
--
>> arch/sh/mm/tlb-sh3.c:41:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/mm/tlb-sh3.c:41:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/tlb-sh3.c:41:9: sparse:     got unsigned int
   arch/sh/mm/tlb-sh3.c:48:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/mm/tlb-sh3.c:48:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/tlb-sh3.c:48:9: sparse:     got unsigned int
>> arch/sh/mm/tlb-sh3.c:75:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/mm/tlb-sh3.c:75:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/tlb-sh3.c:75:17: sparse:     got unsigned long
   arch/sh/mm/tlb-sh3.c:90:18: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/mm/tlb-sh3.c:90:18: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/tlb-sh3.c:90:18: sparse:     got unsigned int
   arch/sh/mm/tlb-sh3.c:92:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/mm/tlb-sh3.c:92:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/mm/tlb-sh3.c:92:9: sparse:     got unsigned int
--
>> arch/sh/kernel/cpu/sh3/clock-sh3.c:28:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh3.c:28:21: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh3.c:28:21: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/clock-sh3.c:40:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh3.c:40:21: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh3.c:40:21: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/clock-sh3.c:52:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh3.c:52:21: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh3.c:52:21: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/clock-sh3.c:64:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh3.c:64:21: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh3.c:64:21: sparse:     got unsigned int
--
   fs/hfsplus/ioctl.c:42:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   fs/hfsplus/ioctl.c:42:50: sparse:     expected unsigned int
   fs/hfsplus/ioctl.c:42:50: sparse:     got restricted __be32 [usertype]
   fs/hfsplus/ioctl.c:50:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   fs/hfsplus/ioctl.c:50:50: sparse:     expected unsigned int
   fs/hfsplus/ioctl.c:50:50: sparse:     got restricted __be32 [usertype]
   fs/hfsplus/ioctl.c:53:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   fs/hfsplus/ioctl.c:53:50: sparse:     expected unsigned int
   fs/hfsplus/ioctl.c:53:50: sparse:     got restricted __be32 [usertype]
   fs/hfsplus/ioctl.c:99:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *user_flags @@
   fs/hfsplus/ioctl.c:99:13: sparse:     expected int const *__gu_addr
   fs/hfsplus/ioctl.c:99:13: sparse:     got int [noderef] __user *user_flags
>> fs/hfsplus/ioctl.c:99:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/hfsplus/ioctl.c:99:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/hfsplus/ioctl.c:99:13: sparse:     got int const *__gu_addr
--
   kernel/locking/lockdep_proc.c:448:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/locking/lockdep_proc.c:448:17: sparse:    char const [noderef] __rcu *
   kernel/locking/lockdep_proc.c:448:17: sparse:    char const *
   kernel/locking/lockdep_proc.c:449:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/locking/lockdep_proc.c:449:17: sparse:    struct lockdep_subclass_key const [noderef] __rcu *
   kernel/locking/lockdep_proc.c:449:17: sparse:    struct lockdep_subclass_key const *
   kernel/locking/lockdep_proc.c:649:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user *buf @@
   kernel/locking/lockdep_proc.c:649:21: sparse:     expected char const *__gu_addr
   kernel/locking/lockdep_proc.c:649:21: sparse:     got char const [noderef] __user *buf
>> kernel/locking/lockdep_proc.c:649:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   kernel/locking/lockdep_proc.c:649:21: sparse:     expected void const volatile [noderef] __user *ptr
   kernel/locking/lockdep_proc.c:649:21: sparse:     got char const *__gu_addr
--
   fs/jfs/jfs_debug.c:36:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user *buffer @@
   fs/jfs/jfs_debug.c:36:13: sparse:     expected char const *__gu_addr
   fs/jfs/jfs_debug.c:36:13: sparse:     got char const [noderef] __user *buffer
>> fs/jfs/jfs_debug.c:36:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   fs/jfs/jfs_debug.c:36:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/jfs/jfs_debug.c:36:13: sparse:     got char const *__gu_addr
--
>> drivers/usb/cdns3/drd.c:42:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:42:31: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:42:31: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:44:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:44:25: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:44:25: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:46:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:46:31: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:46:31: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:48:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:48:25: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:48:25: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:70:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:70:14: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:70:14: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:80:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:80:19: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:80:19: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:113:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:113:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:113:9: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:122:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:122:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:122:9: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:138:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:138:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:138:9: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:142:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:142:15: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:142:15: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:142:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:142:15: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:142:15: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:159:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:159:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:159:9: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:164:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:164:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:164:9: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:164:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:164:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:164:9: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:181:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:181:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:181:9: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:185:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:185:15: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:185:15: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:185:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:185:15: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:185:15: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:209:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:209:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:209:9: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:213:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:213:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:213:9: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:213:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:213:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:213:9: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:230:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:230:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:230:9: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:296:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:296:15: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:296:15: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:315:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:315:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:315:9: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:338:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cdns3_otg_legacy_regs *otg_v0_regs @@     got void [noderef] __iomem *[assigned] regs @@
   drivers/usb/cdns3/drd.c:338:27: sparse:     expected struct cdns3_otg_legacy_regs *otg_v0_regs
   drivers/usb/cdns3/drd.c:338:27: sparse:     got void [noderef] __iomem *[assigned] regs
   drivers/usb/cdns3/drd.c:339:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:339:14: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:339:14: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:342:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cdns3_otg_common_regs *otg_regs @@     got void [noderef] __iomem *[assigned] regs @@
   drivers/usb/cdns3/drd.c:342:32: sparse:     expected struct cdns3_otg_common_regs *otg_regs
   drivers/usb/cdns3/drd.c:342:32: sparse:     got void [noderef] __iomem *[assigned] regs
   drivers/usb/cdns3/drd.c:343:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:343:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:343:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:344:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:344:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:344:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:348:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cdns3_otg_regs *otg_v1_regs @@     got void [noderef] __iomem *[assigned] regs @@
   drivers/usb/cdns3/drd.c:348:35: sparse:     expected struct cdns3_otg_regs *otg_v1_regs
   drivers/usb/cdns3/drd.c:348:35: sparse:     got void [noderef] __iomem *[assigned] regs
   drivers/usb/cdns3/drd.c:351:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:351:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:351:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:352:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:352:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:352:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:352:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:352:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:352:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:357:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:357:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/cdns3/drd.c:357:17: sparse:     got restricted __le32 *
   drivers/usb/cdns3/drd.c:379:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/usb/cdns3/drd.c:379:17: sparse:     expected void const volatile [noderef] __iomem *ptr
--
   drivers/usb/gadget/udc/mv_udc_core.c:66:33: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le16 [usertype] wMaxPacketSize @@     got int @@
   drivers/usb/gadget/udc/mv_udc_core.c:66:33: sparse:     expected restricted __le16 [usertype] wMaxPacketSize
   drivers/usb/gadget/udc/mv_udc_core.c:66:33: sparse:     got int
   drivers/usb/gadget/udc/mv_udc_core.c:366:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buff_ptr0 @@     got restricted __le32 [usertype] @@
   drivers/usb/gadget/udc/mv_udc_core.c:366:24: sparse:     expected unsigned int [usertype] buff_ptr0
   drivers/usb/gadget/udc/mv_udc_core.c:366:24: sparse:     got restricted __le32 [usertype]
   drivers/usb/gadget/udc/mv_udc_core.c:368:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buff_ptr1 @@     got restricted __le32 [usertype] @@
   drivers/usb/gadget/udc/mv_udc_core.c:368:24: sparse:     expected unsigned int [usertype] buff_ptr1
   drivers/usb/gadget/udc/mv_udc_core.c:368:24: sparse:     got restricted __le32 [usertype]
   drivers/usb/gadget/udc/mv_udc_core.c:369:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buff_ptr2 @@     got restricted __le32 [usertype] @@
   drivers/usb/gadget/udc/mv_udc_core.c:369:24: sparse:     expected unsigned int [usertype] buff_ptr2
   drivers/usb/gadget/udc/mv_udc_core.c:369:24: sparse:     got restricted __le32 [usertype]
   drivers/usb/gadget/udc/mv_udc_core.c:370:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buff_ptr3 @@     got restricted __le32 [usertype] @@
   drivers/usb/gadget/udc/mv_udc_core.c:370:24: sparse:     expected unsigned int [usertype] buff_ptr3
   drivers/usb/gadget/udc/mv_udc_core.c:370:24: sparse:     got restricted __le32 [usertype]
   drivers/usb/gadget/udc/mv_udc_core.c:371:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buff_ptr4 @@     got restricted __le32 [usertype] @@
   drivers/usb/gadget/udc/mv_udc_core.c:371:24: sparse:     expected unsigned int [usertype] buff_ptr4
   drivers/usb/gadget/udc/mv_udc_core.c:371:24: sparse:     got restricted __le32 [usertype]
>> drivers/usb/gadget/udc/mv_udc_core.c:832:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/usb/gadget/udc/mv_udc_core.c:832:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/gadget/udc/mv_udc_core.c:832:17: sparse:     got unsigned int *
>> drivers/usb/gadget/udc/mv_udc_core.c:832:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/usb/gadget/udc/mv_udc_core.c:832:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/gadget/udc/mv_udc_core.c:832:17: sparse:     got unsigned int *
   drivers/usb/gadget/udc/mv_udc_core.c:1455:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/usb/gadget/udc/mv_udc_core.c:1455:41: sparse:     expected unsigned short [usertype]
   drivers/usb/gadget/udc/mv_udc_core.c:1455:41: sparse:     got restricted __le16 [usertype]
   drivers/usb/gadget/udc/mv_udc_core.c:1515:26: sparse: sparse: cast from restricted __le16
   drivers/usb/gadget/udc/mv_udc_core.c:1545:31: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1546:35: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1567:30: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1578:39: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1579:43: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1615:34: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1624:52: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1610:30: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1610:30: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1633:39: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1634:43: sparse: sparse: restricted __le16 degrades to integer

vim +42 arch/sh/kernel/process_32.c

^1da177e4c3f415 arch/sh/kernel/process.c    Linus Torvalds     2005-04-16  30  
^1da177e4c3f415 arch/sh/kernel/process.c    Linus Torvalds     2005-04-16  31  void show_regs(struct pt_regs * regs)
^1da177e4c3f415 arch/sh/kernel/process.c    Linus Torvalds     2005-04-16  32  {
21afcacb0348edf arch/sh/kernel/process_32.c Geert Uytterhoeven 2020-06-17  33  	pr_info("\n");
a43cb95d547a061 arch/sh/kernel/process_32.c Tejun Heo          2013-04-30  34  	show_regs_print_info(KERN_DEFAULT);
7d96169cb769f45 arch/sh/kernel/process_32.c Paul Mundt         2008-08-08  35  
21afcacb0348edf arch/sh/kernel/process_32.c Geert Uytterhoeven 2020-06-17  36  	pr_info("PC is at %pS\n", (void *)instruction_pointer(regs));
21afcacb0348edf arch/sh/kernel/process_32.c Geert Uytterhoeven 2020-06-17  37  	pr_info("PR is at %pS\n", (void *)regs->pr);
7d96169cb769f45 arch/sh/kernel/process_32.c Paul Mundt         2008-08-08  38  
21afcacb0348edf arch/sh/kernel/process_32.c Geert Uytterhoeven 2020-06-17  39  	pr_info("PC  : %08lx SP  : %08lx SR  : %08lx ", regs->pc,
21afcacb0348edf arch/sh/kernel/process_32.c Geert Uytterhoeven 2020-06-17  40  		regs->regs[15], regs->sr);
^1da177e4c3f415 arch/sh/kernel/process.c    Linus Torvalds     2005-04-16  41  #ifdef CONFIG_MMU
21afcacb0348edf arch/sh/kernel/process_32.c Geert Uytterhoeven 2020-06-17 @42  	pr_cont("TEA : %08x\n", __raw_readl(MMU_TEA));
^1da177e4c3f415 arch/sh/kernel/process.c    Linus Torvalds     2005-04-16  43  #else
21afcacb0348edf arch/sh/kernel/process_32.c Geert Uytterhoeven 2020-06-17  44  	pr_cont("\n");
^1da177e4c3f415 arch/sh/kernel/process.c    Linus Torvalds     2005-04-16  45  #endif
^1da177e4c3f415 arch/sh/kernel/process.c    Linus Torvalds     2005-04-16  46  
21afcacb0348edf arch/sh/kernel/process_32.c Geert Uytterhoeven 2020-06-17  47  	pr_info("R0  : %08lx R1  : %08lx R2  : %08lx R3  : %08lx\n",
21afcacb0348edf arch/sh/kernel/process_32.c Geert Uytterhoeven 2020-06-17  48  		regs->regs[0], regs->regs[1], regs->regs[2], regs->regs[3]);
21afcacb0348edf arch/sh/kernel/process_32.c Geert Uytterhoeven 2020-06-17  49  	pr_info("R4  : %08lx R5  : %08lx R6  : %08lx R7  : %08lx\n",
21afcacb0348edf arch/sh/kernel/process_32.c Geert Uytterhoeven 2020-06-17  50  		regs->regs[4], regs->regs[5], regs->regs[6], regs->regs[7]);
21afcacb0348edf arch/sh/kernel/process_32.c Geert Uytterhoeven 2020-06-17  51  	pr_info("R8  : %08lx R9  : %08lx R10 : %08lx R11 : %08lx\n",
21afcacb0348edf arch/sh/kernel/process_32.c Geert Uytterhoeven 2020-06-17  52  		regs->regs[8], regs->regs[9], regs->regs[10], regs->regs[11]);
21afcacb0348edf arch/sh/kernel/process_32.c Geert Uytterhoeven 2020-06-17  53  	pr_info("R12 : %08lx R13 : %08lx R14 : %08lx\n",
21afcacb0348edf arch/sh/kernel/process_32.c Geert Uytterhoeven 2020-06-17  54  		regs->regs[12], regs->regs[13], regs->regs[14]);
21afcacb0348edf arch/sh/kernel/process_32.c Geert Uytterhoeven 2020-06-17  55  	pr_info("MACH: %08lx MACL: %08lx GBR : %08lx PR  : %08lx\n",
^1da177e4c3f415 arch/sh/kernel/process.c    Linus Torvalds     2005-04-16  56  		regs->mach, regs->macl, regs->gbr, regs->pr);
^1da177e4c3f415 arch/sh/kernel/process.c    Linus Torvalds     2005-04-16  57  
539e786cc37ee5c arch/sh/kernel/process_32.c Dmitry Safonov     2020-06-08  58  	show_trace(NULL, (unsigned long *)regs->regs[15], regs, KERN_DEFAULT);
9cfc9a9b6fff9ea arch/sh/kernel/process_32.c Paul Mundt         2008-11-26  59  	show_code(regs);
^1da177e4c3f415 arch/sh/kernel/process.c    Linus Torvalds     2005-04-16  60  }
^1da177e4c3f415 arch/sh/kernel/process.c    Linus Torvalds     2005-04-16  61  

:::::: The code at line 42 was first introduced by commit
:::::: 21afcacb0348edf8f5d4e6115b5eb0b58f9a049b sh: process: Fix broken lines in register dumps

:::::: TO: Geert Uytterhoeven <geert+renesas@glider.be>
:::::: CC: Rich Felker <dalias@libc.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ZGiS0Q5IWpPtfppv
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
tJ8gg/8/pw/OfPHaAQA=

--ZGiS0Q5IWpPtfppv--
