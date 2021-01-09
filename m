Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DF12EFDA3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 05:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbhAIEDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 23:03:33 -0500
Received: from mga17.intel.com ([192.55.52.151]:13744 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbhAIEDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 23:03:32 -0500
IronPort-SDR: MSvf2OI0enDA9tyETRfJ8hA/OssMjs8xASoWP0US2vS4qKEsfJ091vP/e3SkT/PMSeQqlxJEJt
 Gj3G1w6ENnSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9858"; a="157465840"
X-IronPort-AV: E=Sophos;i="5.79,333,1602572400"; 
   d="scan'208";a="157465840"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 20:02:51 -0800
IronPort-SDR: yFI6PMjfU0pGH+OOFBHL/dW3yGBz92VlSqLOn9XFMJP7b8YgAiGTVDkJdMZIbYs+zrWkH5Thun
 FyitF11OMAag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,333,1602572400"; 
   d="scan'208";a="463591263"
Received: from lkp-server01.sh.intel.com (HELO 412602b27703) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 08 Jan 2021 20:02:47 -0800
Received: from kbuild by 412602b27703 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ky5Sg-0000sV-KX; Sat, 09 Jan 2021 04:02:46 +0000
Date:   Sat, 09 Jan 2021 12:02:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/test] BUILD SUCCESS
 2ced10737a8b96d41e0c9d9e43d42b545552649c
Message-ID: <5ff92ac9.n11CI7RPaAbkrfOB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/test
branch HEAD: 2ced10737a8b96d41e0c9d9e43d42b545552649c  Merge branch 'dev.2021.01.05a' into HEAD

elapsed time: 1581m

configs tested: 126
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                            allyesconfig
powerpc                    mvme5100_defconfig
mips                          ath25_defconfig
sh                             shx3_defconfig
m68k                          multi_defconfig
sh                          lboxre2_defconfig
arc                     haps_hs_smp_defconfig
um                           x86_64_defconfig
sparc64                          alldefconfig
arm                        oxnas_v6_defconfig
sh                           se7721_defconfig
openrisc                            defconfig
sh                               j2_defconfig
mips                        omega2p_defconfig
mips                      bmips_stb_defconfig
mips                           ip32_defconfig
mips                      loongson3_defconfig
mips                         cobalt_defconfig
arm                           h3600_defconfig
m68k                          atari_defconfig
sparc                       sparc64_defconfig
c6x                        evmc6472_defconfig
xtensa                generic_kc705_defconfig
mips                  decstation_64_defconfig
sh                        sh7785lcr_defconfig
nds32                            alldefconfig
sh                         microdev_defconfig
powerpc                      arches_defconfig
mips                        workpad_defconfig
sh                            titan_defconfig
powerpc                      ppc64e_defconfig
sh                        dreamcast_defconfig
powerpc                  mpc885_ads_defconfig
mips                malta_kvm_guest_defconfig
i386                             allyesconfig
powerpc                       ppc64_defconfig
powerpc                     tqm8560_defconfig
nios2                         3c120_defconfig
mips                         bigsur_defconfig
powerpc                  storcenter_defconfig
powerpc                mpc7448_hpc2_defconfig
m68k                        m5272c3_defconfig
sh                         ecovec24_defconfig
arm                     eseries_pxa_defconfig
sh                          r7780mp_defconfig
powerpc                      acadia_defconfig
arc                          axs103_defconfig
arm                        vexpress_defconfig
mips                            gpr_defconfig
sh                            hp6xx_defconfig
arm                      integrator_defconfig
sh                   rts7751r2dplus_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210108
x86_64               randconfig-a006-20210108
x86_64               randconfig-a001-20210108
x86_64               randconfig-a002-20210108
x86_64               randconfig-a003-20210108
x86_64               randconfig-a005-20210108
i386                 randconfig-a005-20210108
i386                 randconfig-a002-20210108
i386                 randconfig-a001-20210108
i386                 randconfig-a003-20210108
i386                 randconfig-a006-20210108
i386                 randconfig-a004-20210108
i386                 randconfig-a016-20210108
i386                 randconfig-a011-20210108
i386                 randconfig-a014-20210108
i386                 randconfig-a015-20210108
i386                 randconfig-a013-20210108
i386                 randconfig-a012-20210108
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

clang tested configs:
x86_64               randconfig-a013-20210108
x86_64               randconfig-a011-20210108
x86_64               randconfig-a012-20210108
x86_64               randconfig-a016-20210108
x86_64               randconfig-a014-20210108
x86_64               randconfig-a015-20210108

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
