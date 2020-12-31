Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB192E8135
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 17:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgLaQRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 11:17:19 -0500
Received: from mga01.intel.com ([192.55.52.88]:4913 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgLaQRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 11:17:19 -0500
IronPort-SDR: Vma6j85AvDnoreMR0JGJeCd6P+IDM9nb4XbyDhruScSnjT4zlYS9Z4TPGZTSfsp1eNLokolMfj
 ghrWJku0Ds+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9851"; a="195228185"
X-IronPort-AV: E=Sophos;i="5.78,464,1599548400"; 
   d="scan'208";a="195228185"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2020 08:16:36 -0800
IronPort-SDR: LGBdUW7uuPWvhE3ofi5hZ+Y5GBuYiV+YfOUVcKc+23pJrM1h3rLkx+0b4A343NJ2i6P/RLpOpW
 6KAGcrMrZK4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,464,1599548400"; 
   d="scan'208";a="348301608"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 31 Dec 2020 08:16:35 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kv0ct-00052m-29; Thu, 31 Dec 2020 16:16:35 +0000
Date:   Fri, 01 Jan 2021 00:16:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS WITH WARNING
 295c99e6b1466988ac66cd710411f11c610b0294
Message-ID: <5fedf95f.va4P9fryO6FtsW1z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: 295c99e6b1466988ac66cd710411f11c610b0294  rcutorture: Add rcutree.use_softirq=0 to RUDE01 and TASKS01

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-randconfig-c002-20201229
    `-- kernel-rcu-rcuscale.c:WARNING-kmalloc-is-used-to-allocate-this-memory-at-line

elapsed time: 723m

configs tested: 117
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                            alldefconfig
powerpc                      pcm030_defconfig
x86_64                              defconfig
sh                  sh7785lcr_32bit_defconfig
mips                        bcm63xx_defconfig
powerpc                  mpc885_ads_defconfig
arm                           corgi_defconfig
powerpc                          allyesconfig
m68k                       m5208evb_defconfig
mips                         tb0226_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                      tqm8xx_defconfig
arm                           u8500_defconfig
powerpc                     skiroot_defconfig
arm                        oxnas_v6_defconfig
arm                        mvebu_v5_defconfig
sh                   sh7724_generic_defconfig
mips                      pic32mzda_defconfig
arm                       aspeed_g5_defconfig
arm                           spitz_defconfig
powerpc                     tqm8540_defconfig
powerpc                      chrp32_defconfig
powerpc                         wii_defconfig
mips                       bmips_be_defconfig
microblaze                          defconfig
sh                           se7722_defconfig
sh                            migor_defconfig
arm                      integrator_defconfig
mips                           ip22_defconfig
powerpc                           allnoconfig
powerpc                    sam440ep_defconfig
arc                     haps_hs_smp_defconfig
ia64                             alldefconfig
sh                     sh7710voipgw_defconfig
powerpc                     tqm8541_defconfig
arm                      tct_hammer_defconfig
powerpc                      walnut_defconfig
arm                           sunxi_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                               tinyconfig
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
i386                 randconfig-a003-20201231
i386                 randconfig-a004-20201231
i386                 randconfig-a002-20201231
i386                 randconfig-a001-20201231
i386                 randconfig-a005-20201231
i386                 randconfig-a006-20201231
x86_64               randconfig-a015-20201231
x86_64               randconfig-a014-20201231
x86_64               randconfig-a011-20201231
x86_64               randconfig-a016-20201231
x86_64               randconfig-a013-20201231
x86_64               randconfig-a012-20201231
i386                 randconfig-a016-20201231
i386                 randconfig-a014-20201231
i386                 randconfig-a012-20201231
i386                 randconfig-a015-20201231
i386                 randconfig-a011-20201231
i386                 randconfig-a013-20201231
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
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20201231
x86_64               randconfig-a006-20201231
x86_64               randconfig-a001-20201231
x86_64               randconfig-a002-20201231
x86_64               randconfig-a004-20201231
x86_64               randconfig-a003-20201231
x86_64               randconfig-a014-20201229
x86_64               randconfig-a015-20201229
x86_64               randconfig-a016-20201229
x86_64               randconfig-a012-20201229
x86_64               randconfig-a011-20201229
x86_64               randconfig-a013-20201229

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
