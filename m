Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173642B14B6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 04:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgKMD31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 22:29:27 -0500
Received: from mga11.intel.com ([192.55.52.93]:18267 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgKMD30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 22:29:26 -0500
IronPort-SDR: gF2w81S6p+CS+cXXBaw1fbQfckpKdJT8yigHvYVcdvT+AnfIBin45OpZIdFL/4UEFgzWOpq+Qk
 aoRB+Kkpp4jA==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="166912346"
X-IronPort-AV: E=Sophos;i="5.77,474,1596524400"; 
   d="scan'208";a="166912346"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 19:29:26 -0800
IronPort-SDR: yxM71JzhdhUOwTnqzVfNCBSAJtzsJHy1uDFN1m2mNno/o5OsZ+yeLQSja0/W1hO0WZqkQvZNX+
 uXwsmaAbGkYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,474,1596524400"; 
   d="scan'208";a="366594431"
Received: from lkp-server02.sh.intel.com (HELO 697932c29306) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Nov 2020 19:29:25 -0800
Received: from kbuild by 697932c29306 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kdPm8-000020-Ev; Fri, 13 Nov 2020 03:29:24 +0000
Date:   Fri, 13 Nov 2020 11:29:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 bf6a52d6ce5f1c297fa5c26066739745d51c1b15
Message-ID: <5fadfd91./eIEtnm3Gyr7W1fI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: bf6a52d6ce5f1c297fa5c26066739745d51c1b15  fixup! scftorture: Add debug output for wrong-CPU warning

elapsed time: 725m

configs tested: 128
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                       maple_defconfig
openrisc                            defconfig
powerpc                      acadia_defconfig
sh                          rsk7201_defconfig
arm                          pxa3xx_defconfig
powerpc                     pq2fads_defconfig
arm                           tegra_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                           h3600_defconfig
m68k                        m5407c3_defconfig
m68k                        mvme16x_defconfig
powerpc                     pseries_defconfig
mips                           rs90_defconfig
arm                          exynos_defconfig
m68k                           sun3_defconfig
powerpc                 mpc836x_rdk_defconfig
m68k                         apollo_defconfig
powerpc                          g5_defconfig
parisc                generic-32bit_defconfig
arm                        keystone_defconfig
powerpc                    adder875_defconfig
powerpc                       ebony_defconfig
xtensa                    smp_lx200_defconfig
microblaze                      mmu_defconfig
arm                        trizeps4_defconfig
arm                         shannon_defconfig
powerpc                     asp8347_defconfig
powerpc                         wii_defconfig
sh                           sh2007_defconfig
nios2                            allyesconfig
arm                       imx_v6_v7_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                malta_kvm_guest_defconfig
i386                             alldefconfig
mips                        maltaup_defconfig
powerpc                        warp_defconfig
arm                         mv78xx0_defconfig
c6x                        evmc6457_defconfig
powerpc                    socrates_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                   lite5200b_defconfig
m68k                         amcore_defconfig
mips                       lemote2f_defconfig
powerpc                      obs600_defconfig
arm64                            alldefconfig
powerpc                 mpc832x_mds_defconfig
powerpc                     tqm8548_defconfig
sh                        sh7785lcr_defconfig
arm                         orion5x_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201111
i386                 randconfig-a005-20201111
i386                 randconfig-a002-20201111
i386                 randconfig-a001-20201111
i386                 randconfig-a003-20201111
i386                 randconfig-a004-20201111
i386                 randconfig-a006-20201112
i386                 randconfig-a005-20201112
i386                 randconfig-a002-20201112
i386                 randconfig-a001-20201112
i386                 randconfig-a003-20201112
i386                 randconfig-a004-20201112
x86_64               randconfig-a015-20201111
x86_64               randconfig-a011-20201111
x86_64               randconfig-a014-20201111
x86_64               randconfig-a013-20201111
x86_64               randconfig-a016-20201111
x86_64               randconfig-a012-20201111
i386                 randconfig-a012-20201111
i386                 randconfig-a014-20201111
i386                 randconfig-a016-20201111
i386                 randconfig-a011-20201111
i386                 randconfig-a015-20201111
i386                 randconfig-a013-20201111
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
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20201111
x86_64               randconfig-a005-20201111
x86_64               randconfig-a004-20201111
x86_64               randconfig-a002-20201111
x86_64               randconfig-a006-20201111
x86_64               randconfig-a001-20201111

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
