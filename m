Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03252F91C9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 11:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbhAQKxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 05:53:24 -0500
Received: from mga11.intel.com ([192.55.52.93]:11301 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbhAQKw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 05:52:58 -0500
IronPort-SDR: G4pZUBdsB5RUf+eL8R/voxrhlvmCJ1J0y//UiQsBfI82zEDbg6XV9TTxkfcFUZfOp7o8vXF++e
 4JZWPp0+5xGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9866"; a="175206590"
X-IronPort-AV: E=Sophos;i="5.79,354,1602572400"; 
   d="gz'50?scan'50,208,50";a="175206590"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2021 02:52:08 -0800
IronPort-SDR: xx4Cdbho8JQ/VZb9HCO+pYDVrPS1crN31Py2b6f3yCt+irrUsSDyTEnSW9h24tHGBk7QOeX7w+
 svVvEVQ16zHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,354,1602572400"; 
   d="gz'50?scan'50,208,50";a="466060383"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jan 2021 02:52:05 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l15fA-0001W9-NV; Sun, 17 Jan 2021 10:52:04 +0000
Date:   Sun, 17 Jan 2021 18:51:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: fs/fat/file.c:44:15: sparse: sparse: incorrect type in argument 1
 (different address spaces)
Message-ID: <202101171829.zZfAp61A-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Luc,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0da0a8a0a0e1845f495431c3d8d733d2bbf9e9e5
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   5 months ago
config: sh-randconfig-s031-20210117 (attached as .config)
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
   fs/fat/file.c:44:15: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *user_attr @@
   fs/fat/file.c:44:15: sparse:     expected unsigned int const *__gu_addr
   fs/fat/file.c:44:15: sparse:     got unsigned int [noderef] [usertype] __user *user_attr
>> fs/fat/file.c:44:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   fs/fat/file.c:44:15: sparse:     expected void const volatile [noderef] __user *ptr
   fs/fat/file.c:44:15: sparse:     got unsigned int const *__gu_addr
--
   fs/jfs/ioctl.c:83:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/jfs/ioctl.c:83:21: sparse:     expected int const *__gu_addr
   fs/jfs/ioctl.c:83:21: sparse:     got int [noderef] __user *
>> fs/jfs/ioctl.c:83:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/jfs/ioctl.c:83:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/jfs/ioctl.c:83:21: sparse:     got int const *__gu_addr
--
   fs/xfs/xfs_ioctl.c:2257:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   fs/xfs/xfs_ioctl.c:2257:21: sparse:     expected unsigned int const *__gu_addr
   fs/xfs/xfs_ioctl.c:2257:21: sparse:     got unsigned int [noderef] [usertype] __user *
>> fs/xfs/xfs_ioctl.c:2257:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   fs/xfs/xfs_ioctl.c:2257:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/xfs/xfs_ioctl.c:2257:21: sparse:     got unsigned int const *__gu_addr
--
   fs/nilfs2/ioctl.c:138:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/nilfs2/ioctl.c:138:13: sparse:     expected int const *__gu_addr
   fs/nilfs2/ioctl.c:138:13: sparse:     got int [noderef] __user *
>> fs/nilfs2/ioctl.c:138:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/nilfs2/ioctl.c:138:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/nilfs2/ioctl.c:138:13: sparse:     got int const *__gu_addr
--
>> arch/sh/kernel/process_32.c:42:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/process_32.c:42:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/process_32.c:42:9: sparse:     got unsigned int
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
>> arch/sh/kernel/cpu/sh3/clock-sh7712.c:23:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:23:21: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:23:21: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:35:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:35:21: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:35:21: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:47:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:47:21: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:47:21: sparse:     got unsigned int
--
   fs/exec.c:418:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *const *__gu_addr @@     got char const [noderef] __user *const [noderef] __user * @@
   fs/exec.c:418:13: sparse:     expected char const [noderef] __user *const *__gu_addr
   fs/exec.c:418:13: sparse:     got char const [noderef] __user *const [noderef] __user *
   fs/exec.c:418:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const [noderef] __user *const *__gu_addr @@
   fs/exec.c:418:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/exec.c:418:13: sparse:     got char const [noderef] __user *const *__gu_addr
   fs/exec.c:419:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected char const [noderef] __user * @@     got void * @@
   fs/exec.c:419:31: sparse:     expected char const [noderef] __user *
   fs/exec.c:419:31: sparse:     got void *
   fs/exec.c:1156:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *oldsighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   fs/exec.c:1156:48: sparse:     expected struct sighand_struct *oldsighand
   fs/exec.c:1156:48: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   fs/exec.c:1263:56: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   fs/exec.c:1263:56: sparse:     expected struct task_struct *parent
   fs/exec.c:1263:56: sparse:     got struct task_struct [noderef] __rcu *parent
   fs/exec.c:1298:47: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sighand_struct *oldsighand @@     got struct sighand_struct [noderef] __rcu *sighand @@
   fs/exec.c:1298:47: sparse:     expected struct sighand_struct *oldsighand
   fs/exec.c:1298:47: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   fs/exec.c:1851:70: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *parent @@
   fs/exec.c:1851:70: sparse:     expected struct task_struct *tsk
   fs/exec.c:1851:70: sparse:     got struct task_struct [noderef] __rcu *parent
   fs/exec.c: note: in included file (through arch/sh/include/asm/mmu_context.h):
>> arch/sh/include/asm/mmu_context_32.h:53:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/mmu_context_32.h:53:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/mmu_context_32.h:53:9: sparse:     got unsigned int
--
   block/ioctl.c:66:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   block/ioctl.c:66:13: sparse:     expected int const *__gu_addr
   block/ioctl.c:66:13: sparse:     got int [noderef] __user *
>> block/ioctl.c:66:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   block/ioctl.c:66:13: sparse:     expected void const volatile [noderef] __user *ptr
   block/ioctl.c:66:13: sparse:     got int const *__gu_addr
   block/ioctl.c:66:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __user *const *__gu_addr @@     got void [noderef] __user *[noderef] __user * @@
   block/ioctl.c:66:39: sparse:     expected void [noderef] __user *const *__gu_addr
   block/ioctl.c:66:39: sparse:     got void [noderef] __user *[noderef] __user *
>> block/ioctl.c:66:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got void [noderef] __user *const *__gu_addr @@
   block/ioctl.c:66:39: sparse:     expected void const volatile [noderef] __user *ptr
   block/ioctl.c:66:39: sparse:     got void [noderef] __user *const *__gu_addr
   block/ioctl.c:393:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   block/ioctl.c:393:13: sparse:     expected int const *__gu_addr
   block/ioctl.c:393:13: sparse:     got int [noderef] __user *
   block/ioctl.c:393:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   block/ioctl.c:393:13: sparse:     expected void const volatile [noderef] __user *ptr
   block/ioctl.c:393:13: sparse:     got int const *__gu_addr
   block/ioctl.c:474:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *argp @@
   block/ioctl.c:474:13: sparse:     expected int const *__gu_addr
   block/ioctl.c:474:13: sparse:     got int [noderef] __user *argp
   block/ioctl.c:474:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   block/ioctl.c:474:13: sparse:     expected void const volatile [noderef] __user *ptr
   block/ioctl.c:474:13: sparse:     got int const *__gu_addr
--
   block/scsi_ioctl.c:65:28: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   block/scsi_ioctl.c:65:28: sparse:     expected int const *__gu_addr
   block/scsi_ioctl.c:65:28: sparse:     got int [noderef] __user *p
>> block/scsi_ioctl.c:65:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   block/scsi_ioctl.c:65:28: sparse:     expected void const volatile [noderef] __user *ptr
   block/scsi_ioctl.c:65:28: sparse:     got int const *__gu_addr
   block/scsi_ioctl.c:91:25: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   block/scsi_ioctl.c:91:25: sparse:     expected int const *__gu_addr
   block/scsi_ioctl.c:91:25: sparse:     got int [noderef] __user *p
   block/scsi_ioctl.c:91:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   block/scsi_ioctl.c:91:25: sparse:     expected void const volatile [noderef] __user *ptr
   block/scsi_ioctl.c:91:25: sparse:     got int const *__gu_addr
   block/scsi_ioctl.c:433:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   block/scsi_ioctl.c:433:13: sparse:     expected unsigned int const *__gu_addr
   block/scsi_ioctl.c:433:13: sparse:     got unsigned int [noderef] __user *
>> block/scsi_ioctl.c:433:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   block/scsi_ioctl.c:433:13: sparse:     expected void const volatile [noderef] __user *ptr
   block/scsi_ioctl.c:433:13: sparse:     got unsigned int const *__gu_addr
   block/scsi_ioctl.c:435:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   block/scsi_ioctl.c:435:13: sparse:     expected unsigned int const *__gu_addr
   block/scsi_ioctl.c:435:13: sparse:     got unsigned int [noderef] __user *
   block/scsi_ioctl.c:435:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   block/scsi_ioctl.c:435:13: sparse:     expected void const volatile [noderef] __user *ptr
   block/scsi_ioctl.c:435:13: sparse:     got unsigned int const *__gu_addr
   block/scsi_ioctl.c:439:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] __user * @@
   block/scsi_ioctl.c:439:13: sparse:     expected unsigned char const *__gu_addr
   block/scsi_ioctl.c:439:13: sparse:     got unsigned char [noderef] __user *
>> block/scsi_ioctl.c:439:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char const *__gu_addr @@
   block/scsi_ioctl.c:439:13: sparse:     expected void const volatile [noderef] __user *ptr
   block/scsi_ioctl.c:439:13: sparse:     got unsigned char const *__gu_addr
--
   drivers/gpu/drm/drm_crtc.c:708:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/gpu/drm/drm_crtc.c:708:29: sparse:     expected unsigned int const *__gu_addr
   drivers/gpu/drm/drm_crtc.c:708:29: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/gpu/drm/drm_crtc.c:708:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/gpu/drm/drm_crtc.c:708:29: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/gpu/drm/drm_crtc.c:708:29: sparse:     got unsigned int const *__gu_addr
--
   drivers/scsi/scsi_error.c:2341:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *arg @@
   drivers/scsi/scsi_error.c:2341:17: sparse:     expected int const *__gu_addr
   drivers/scsi/scsi_error.c:2341:17: sparse:     got int [noderef] __user *arg
>> drivers/scsi/scsi_error.c:2341:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/scsi_error.c:2341:17: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/scsi_error.c:2341:17: sparse:     got int const *__gu_addr
--
   drivers/scsi/scsi_ioctl.c:48:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/scsi/scsi_ioctl.c:48:21: sparse:     expected unsigned int const *__gu_addr
   drivers/scsi/scsi_ioctl.c:48:21: sparse:     got unsigned int [noderef] __user *
>> drivers/scsi/scsi_ioctl.c:48:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/scsi/scsi_ioctl.c:48:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/scsi_ioctl.c:48:21: sparse:     got unsigned int const *__gu_addr
--
   drivers/video/fbdev/s3c-fb.c:1024:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/video/fbdev/s3c-fb.c:1024:21: sparse:     expected unsigned int const *__gu_addr
   drivers/video/fbdev/s3c-fb.c:1024:21: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/video/fbdev/s3c-fb.c:1024:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/video/fbdev/s3c-fb.c:1024:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/s3c-fb.c:1024:21: sparse:     got unsigned int const *__gu_addr
--
   samples/vfio-mdev/mbochs.c:1270:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   samples/vfio-mdev/mbochs.c:1270:21: sparse:     expected unsigned int const *__gu_addr
   samples/vfio-mdev/mbochs.c:1270:21: sparse:     got unsigned int [noderef] [usertype] __user *
>> samples/vfio-mdev/mbochs.c:1270:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   samples/vfio-mdev/mbochs.c:1270:21: sparse:     expected void const volatile [noderef] __user *ptr
   samples/vfio-mdev/mbochs.c:1270:21: sparse:     got unsigned int const *__gu_addr
   samples/vfio-mdev/mbochs.c:1346:1: sparse: sparse: symbol 'mdev_type_attr_name' was not declared. Should it be static?
   samples/vfio-mdev/mbochs.c:1356:1: sparse: sparse: symbol 'mdev_type_attr_description' was not declared. Should it be static?
   samples/vfio-mdev/mbochs.c:1366:1: sparse: sparse: symbol 'mdev_type_attr_available_instances' was not declared. Should it be static?
   samples/vfio-mdev/mbochs.c:1373:1: sparse: sparse: symbol 'mdev_type_attr_device_api' was not declared. Should it be static?
--
   fs/reiserfs/ioctl.c:66:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/reiserfs/ioctl.c:66:29: sparse:     expected int const *__gu_addr
   fs/reiserfs/ioctl.c:66:29: sparse:     got int [noderef] __user *
>> fs/reiserfs/ioctl.c:66:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/reiserfs/ioctl.c:66:29: sparse:     expected void const volatile [noderef] __user *ptr
   fs/reiserfs/ioctl.c:66:29: sparse:     got int const *__gu_addr
   fs/reiserfs/ioctl.c:111:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/reiserfs/ioctl.c:111:21: sparse:     expected int const *__gu_addr
   fs/reiserfs/ioctl.c:111:21: sparse:     got int [noderef] __user *
   fs/reiserfs/ioctl.c:111:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/reiserfs/ioctl.c:111:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/reiserfs/ioctl.c:111:21: sparse:     got int const *__gu_addr
--
   fs/ext4/ioctl.c:609:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   fs/ext4/ioctl.c:609:13: sparse:     expected unsigned int const *__gu_addr
   fs/ext4/ioctl.c:609:13: sparse:     got unsigned int [noderef] [usertype] __user *
>> fs/ext4/ioctl.c:609:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   fs/ext4/ioctl.c:609:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ext4/ioctl.c:609:13: sparse:     got unsigned int const *__gu_addr
   fs/ext4/ioctl.c:833:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/ext4/ioctl.c:833:21: sparse:     expected int const *__gu_addr
   fs/ext4/ioctl.c:833:21: sparse:     got int [noderef] __user *
>> fs/ext4/ioctl.c:833:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/ext4/ioctl.c:833:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ext4/ioctl.c:833:21: sparse:     got int const *__gu_addr
   fs/ext4/ioctl.c:884:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/ext4/ioctl.c:884:21: sparse:     expected int const *__gu_addr
   fs/ext4/ioctl.c:884:21: sparse:     got int [noderef] __user *
   fs/ext4/ioctl.c:884:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/ext4/ioctl.c:884:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ext4/ioctl.c:884:21: sparse:     got int const *__gu_addr
   fs/ext4/ioctl.c:917:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   fs/ext4/ioctl.c:917:21: sparse:     expected unsigned int const *__gu_addr
   fs/ext4/ioctl.c:917:21: sparse:     got unsigned int [noderef] [usertype] __user *
   fs/ext4/ioctl.c:917:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   fs/ext4/ioctl.c:917:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ext4/ioctl.c:917:21: sparse:     got unsigned int const *__gu_addr
--
   fs/ext2/ioctl.c:47:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/ext2/ioctl.c:47:21: sparse:     expected int const *__gu_addr
   fs/ext2/ioctl.c:47:21: sparse:     got int [noderef] __user *
>> fs/ext2/ioctl.c:47:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/ext2/ioctl.c:47:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ext2/ioctl.c:47:21: sparse:     got int const *__gu_addr
   fs/ext2/ioctl.c:92:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/ext2/ioctl.c:92:21: sparse:     expected int const *__gu_addr
   fs/ext2/ioctl.c:92:21: sparse:     got int [noderef] __user *
   fs/ext2/ioctl.c:92:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/ext2/ioctl.c:92:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ext2/ioctl.c:92:21: sparse:     got int const *__gu_addr
   fs/ext2/ioctl.c:123:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/ext2/ioctl.c:123:21: sparse:     expected int const *__gu_addr
   fs/ext2/ioctl.c:123:21: sparse:     got int [noderef] __user *
   fs/ext2/ioctl.c:123:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/ext2/ioctl.c:123:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ext2/ioctl.c:123:21: sparse:     got int const *__gu_addr

vim +44 fs/fat/file.c

21bea495943f9532 Christoph Hellwig 2009-06-08   34  
21bea495943f9532 Christoph Hellwig 2009-06-08   35  static int fat_ioctl_set_attributes(struct file *file, u32 __user *user_attr)
^1da177e4c3f4152 Linus Torvalds    2005-04-16   36  {
496ad9aa8ef44805 Al Viro           2013-01-23   37  	struct inode *inode = file_inode(file);
21bea495943f9532 Christoph Hellwig 2009-06-08   38  	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
21bea495943f9532 Christoph Hellwig 2009-06-08   39  	int is_dir = S_ISDIR(inode->i_mode);
^1da177e4c3f4152 Linus Torvalds    2005-04-16   40  	u32 attr, oldattr;
^1da177e4c3f4152 Linus Torvalds    2005-04-16   41  	struct iattr ia;
21bea495943f9532 Christoph Hellwig 2009-06-08   42  	int err;
^1da177e4c3f4152 Linus Torvalds    2005-04-16   43  
^1da177e4c3f4152 Linus Torvalds    2005-04-16  @44  	err = get_user(attr, user_attr);
^1da177e4c3f4152 Linus Torvalds    2005-04-16   45  	if (err)
21bea495943f9532 Christoph Hellwig 2009-06-08   46  		goto out;
^1da177e4c3f4152 Linus Torvalds    2005-04-16   47  
a561be7100cd610b Al Viro           2011-11-23   48  	err = mnt_want_write_file(file);
42a74f206b914db1 Dave Hansen       2008-02-15   49  	if (err)
e24f17da3560781e Jan Kara          2012-06-12   50  		goto out;
5955102c9984fa08 Al Viro           2016-01-22   51  	inode_lock(inode);
^1da177e4c3f4152 Linus Torvalds    2005-04-16   52  
^1da177e4c3f4152 Linus Torvalds    2005-04-16   53  	/*
^1da177e4c3f4152 Linus Torvalds    2005-04-16   54  	 * ATTR_VOLUME and ATTR_DIR cannot be changed; this also
^1da177e4c3f4152 Linus Torvalds    2005-04-16   55  	 * prevents the user from turning us into a VFAT
^1da177e4c3f4152 Linus Torvalds    2005-04-16   56  	 * longname entry.  Also, we obviously can't set
^1da177e4c3f4152 Linus Torvalds    2005-04-16   57  	 * any of the NTFS attributes in the high 24 bits.
^1da177e4c3f4152 Linus Torvalds    2005-04-16   58  	 */
^1da177e4c3f4152 Linus Torvalds    2005-04-16   59  	attr &= 0xff & ~(ATTR_VOLUME | ATTR_DIR);
^1da177e4c3f4152 Linus Torvalds    2005-04-16   60  	/* Merge in ATTR_VOLUME and ATTR_DIR */
^1da177e4c3f4152 Linus Torvalds    2005-04-16   61  	attr |= (MSDOS_I(inode)->i_attrs & ATTR_VOLUME) |
^1da177e4c3f4152 Linus Torvalds    2005-04-16   62  		(is_dir ? ATTR_DIR : 0);
9c0aa1b87bf541af OGAWA Hirofumi    2008-11-06   63  	oldattr = fat_make_attrs(inode);
^1da177e4c3f4152 Linus Torvalds    2005-04-16   64  
^1da177e4c3f4152 Linus Torvalds    2005-04-16   65  	/* Equivalent to a chmod() */
^1da177e4c3f4152 Linus Torvalds    2005-04-16   66  	ia.ia_valid = ATTR_MODE | ATTR_CTIME;
c2050a454c7f123d Deepa Dinamani    2016-09-14   67  	ia.ia_ctime = current_time(inode);
9c0aa1b87bf541af OGAWA Hirofumi    2008-11-06   68  	if (is_dir)
9c0aa1b87bf541af OGAWA Hirofumi    2008-11-06   69  		ia.ia_mode = fat_make_mode(sbi, attr, S_IRWXUGO);
9c0aa1b87bf541af OGAWA Hirofumi    2008-11-06   70  	else {
9c0aa1b87bf541af OGAWA Hirofumi    2008-11-06   71  		ia.ia_mode = fat_make_mode(sbi, attr,
9c0aa1b87bf541af OGAWA Hirofumi    2008-11-06   72  			S_IRUGO | S_IWUGO | (inode->i_mode & S_IXUGO));
^1da177e4c3f4152 Linus Torvalds    2005-04-16   73  	}
^1da177e4c3f4152 Linus Torvalds    2005-04-16   74  
^1da177e4c3f4152 Linus Torvalds    2005-04-16   75  	/* The root directory has no attributes */
^1da177e4c3f4152 Linus Torvalds    2005-04-16   76  	if (inode->i_ino == MSDOS_ROOT_INO && attr != ATTR_DIR) {
^1da177e4c3f4152 Linus Torvalds    2005-04-16   77  		err = -EINVAL;
e24f17da3560781e Jan Kara          2012-06-12   78  		goto out_unlock_inode;
^1da177e4c3f4152 Linus Torvalds    2005-04-16   79  	}
^1da177e4c3f4152 Linus Torvalds    2005-04-16   80  
21bea495943f9532 Christoph Hellwig 2009-06-08   81  	if (sbi->options.sys_immutable &&
21bea495943f9532 Christoph Hellwig 2009-06-08   82  	    ((attr | oldattr) & ATTR_SYS) &&
21bea495943f9532 Christoph Hellwig 2009-06-08   83  	    !capable(CAP_LINUX_IMMUTABLE)) {
^1da177e4c3f4152 Linus Torvalds    2005-04-16   84  		err = -EPERM;
e24f17da3560781e Jan Kara          2012-06-12   85  		goto out_unlock_inode;
^1da177e4c3f4152 Linus Torvalds    2005-04-16   86  	}
^1da177e4c3f4152 Linus Torvalds    2005-04-16   87  
b1da47e29e467f1e Miklos Szeredi    2008-07-01   88  	/*
b1da47e29e467f1e Miklos Szeredi    2008-07-01   89  	 * The security check is questionable...  We single
b1da47e29e467f1e Miklos Szeredi    2008-07-01   90  	 * out the RO attribute for checking by the security
b1da47e29e467f1e Miklos Szeredi    2008-07-01   91  	 * module, just because it maps to a file mode.
b1da47e29e467f1e Miklos Szeredi    2008-07-01   92  	 */
21bea495943f9532 Christoph Hellwig 2009-06-08   93  	err = security_inode_setattr(file->f_path.dentry, &ia);
b1da47e29e467f1e Miklos Szeredi    2008-07-01   94  	if (err)
e24f17da3560781e Jan Kara          2012-06-12   95  		goto out_unlock_inode;
b1da47e29e467f1e Miklos Szeredi    2008-07-01   96  
^1da177e4c3f4152 Linus Torvalds    2005-04-16   97  	/* This MUST be done before doing anything irreversible... */
21bea495943f9532 Christoph Hellwig 2009-06-08   98  	err = fat_setattr(file->f_path.dentry, &ia);
^1da177e4c3f4152 Linus Torvalds    2005-04-16   99  	if (err)
e24f17da3560781e Jan Kara          2012-06-12  100  		goto out_unlock_inode;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  101  
21bea495943f9532 Christoph Hellwig 2009-06-08  102  	fsnotify_change(file->f_path.dentry, ia.ia_valid);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  103  	if (sbi->options.sys_immutable) {
^1da177e4c3f4152 Linus Torvalds    2005-04-16  104  		if (attr & ATTR_SYS)
^1da177e4c3f4152 Linus Torvalds    2005-04-16  105  			inode->i_flags |= S_IMMUTABLE;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  106  		else
1adffbae22332bb5 OGAWA Hirofumi    2011-05-31  107  			inode->i_flags &= ~S_IMMUTABLE;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  108  	}
^1da177e4c3f4152 Linus Torvalds    2005-04-16  109  
9c0aa1b87bf541af OGAWA Hirofumi    2008-11-06  110  	fat_save_attrs(inode, attr);
^1da177e4c3f4152 Linus Torvalds    2005-04-16  111  	mark_inode_dirty(inode);
21bea495943f9532 Christoph Hellwig 2009-06-08  112  out_unlock_inode:
5955102c9984fa08 Al Viro           2016-01-22  113  	inode_unlock(inode);
e24f17da3560781e Jan Kara          2012-06-12  114  	mnt_drop_write_file(file);
21bea495943f9532 Christoph Hellwig 2009-06-08  115  out:
^1da177e4c3f4152 Linus Torvalds    2005-04-16  116  	return err;
^1da177e4c3f4152 Linus Torvalds    2005-04-16  117  }
21bea495943f9532 Christoph Hellwig 2009-06-08  118  

:::::: The code at line 44 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--h31gzZEtNLTqOjlF
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AQA=

--h31gzZEtNLTqOjlF--
