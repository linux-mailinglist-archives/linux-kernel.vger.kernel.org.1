Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678F83019A4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 06:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbhAXFNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 00:13:36 -0500
Received: from mga03.intel.com ([134.134.136.65]:32291 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbhAXFN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 00:13:29 -0500
IronPort-SDR: vfTGvKugndwWitljSUoUnqhgkYEfdi+lXn9ZfvjMlrQ5hC5fADjmlIoF8luxZysPnTj3vmKNps
 AuHLM32pD9Eg==
X-IronPort-AV: E=McAfee;i="6000,8403,9873"; a="179677426"
X-IronPort-AV: E=Sophos;i="5.79,370,1602572400"; 
   d="scan'208";a="179677426"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2021 21:12:48 -0800
IronPort-SDR: jlScjw4cGOUFQNXmygpKii58OPCWOnkxKyjHntCSyiRUxFR+k40Fgeib5a2qC+5PjR+Ffu7NOd
 e78NeLgRLpQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,370,1602572400"; 
   d="scan'208";a="352441122"
Received: from lkp-server01.sh.intel.com (HELO 27c4e0a4b6d9) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Jan 2021 21:12:47 -0800
Received: from kbuild by 27c4e0a4b6d9 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l3Xhe-00003X-JG; Sun, 24 Jan 2021 05:12:46 +0000
Date:   Sun, 24 Jan 2021 13:11:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 8ece53ef7f428ee3f8eab936268b1a3fe2725e6b
Message-ID: <600d019b.PhUMmu5TbujIb7bW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 8ece53ef7f428ee3f8eab936268b1a3fe2725e6b  x86/vm86/32: Remove VM86_SCREEN_BITMAP support

i386-tinyconfig vmlinux size:

====================================================================================================================
 TOTAL  TEXT  init.text  check_iommu_entries()                                                                      
====================================================================================================================
     0     0          0                      0  4af0e6e39b7e x86/mm: Remove duplicate definition of _PAGE_PAT_LARGE 
    +1     0          0                      0  11aa1415d8bd x86/entry: Remove now unused do_IRQ() declaration      
   -76   -76        -76                    -76  b86cb29287be x86: Remove definition of DEBUG                        
    +1     0          0                      0  8ece53ef7f42 x86/vm86/32: Remove VM86_SCREEN_BITMAP support         
   -74   -76        -76                    -76  5c8fe583cce5..8ece53ef7f42 (ALL COMMITS)                            
====================================================================================================================

elapsed time: 3273m

configs tested: 78
configs skipped: 71

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                    amigaone_defconfig
mips                malta_qemu_32r6_defconfig
mips                        maltaup_defconfig
powerpc                     tqm8560_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                       holly_defconfig
powerpc                  storcenter_defconfig
powerpc                     taishan_defconfig
sh                           se7712_defconfig
mips                        bcm47xx_defconfig
arm                        spear3xx_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                               tinyconfig
i386                                defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210121
x86_64               randconfig-a003-20210121
x86_64               randconfig-a001-20210121
x86_64               randconfig-a005-20210121
x86_64               randconfig-a006-20210121
x86_64               randconfig-a004-20210121
i386                 randconfig-a001-20210121
i386                 randconfig-a002-20210121
i386                 randconfig-a004-20210121
i386                 randconfig-a006-20210121
i386                 randconfig-a005-20210121
i386                 randconfig-a003-20210121
i386                 randconfig-a013-20210121
i386                 randconfig-a011-20210121
i386                 randconfig-a012-20210121
i386                 randconfig-a014-20210121
i386                 randconfig-a015-20210121
i386                 randconfig-a016-20210121
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
