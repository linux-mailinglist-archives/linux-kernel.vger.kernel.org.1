Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8192EFC9B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 02:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbhAIBLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 20:11:18 -0500
Received: from mga11.intel.com ([192.55.52.93]:37603 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbhAIBLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 20:11:18 -0500
IronPort-SDR: O93toY3B9z7HQVYv0aJ7DDSzxo27dImnkQXY31a0ASDuAuP6pUk0nODv7HYsdmgT3mjYBfm6Zj
 rqJXBVXCY+xA==
X-IronPort-AV: E=McAfee;i="6000,8403,9858"; a="174167318"
X-IronPort-AV: E=Sophos;i="5.79,333,1602572400"; 
   d="scan'208";a="174167318"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 17:10:37 -0800
IronPort-SDR: Qj/2WIwr674G4Ek0ZDkZjVs/YJQxpgHkK6NRmxLMM4Mr/sn448lajccnvCAGlPenl3uS+T7/HT
 ZsSHeOyvDMow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,333,1602572400"; 
   d="scan'208";a="362521589"
Received: from lkp-server01.sh.intel.com (HELO 412602b27703) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 08 Jan 2021 17:10:36 -0800
Received: from kbuild by 412602b27703 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ky2m3-0000nN-IE; Sat, 09 Jan 2021 01:10:35 +0000
Date:   Sat, 09 Jan 2021 09:10:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.01.05a] BUILD SUCCESS
 9affdc6963f87b92130cc76a2728e49aaf4beab8
Message-ID: <5ff90269.2LcAdpgEWm84Gi1E%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2021.01.05a
branch HEAD: 9affdc6963f87b92130cc76a2728e49aaf4beab8  squash! x86/mce: Make mce_timed_out() identify holdout CPUs

elapsed time: 1409m

configs tested: 131
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
powerpc                      pcm030_defconfig
powerpc                 mpc832x_rdb_defconfig
m68k                          amiga_defconfig
m68k                       bvme6000_defconfig
xtensa                          iss_defconfig
powerpc                      makalu_defconfig
arm                           h3600_defconfig
m68k                          atari_defconfig
sparc                       sparc64_defconfig
c6x                        evmc6472_defconfig
xtensa                generic_kc705_defconfig
mips                  decstation_64_defconfig
sh                        sh7785lcr_defconfig
mips                        workpad_defconfig
mips                        omega2p_defconfig
sh                            titan_defconfig
powerpc                      ppc64e_defconfig
sh                        dreamcast_defconfig
arm                         socfpga_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                     taishan_defconfig
powerpc                  mpc885_ads_defconfig
mips                malta_kvm_guest_defconfig
i386                             allyesconfig
powerpc                       ppc64_defconfig
powerpc                     tqm8560_defconfig
mips                         cobalt_defconfig
arm                         at91_dt_defconfig
powerpc                    gamecube_defconfig
arm                         orion5x_defconfig
arm                          collie_defconfig
arm                           sunxi_defconfig
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
mips                           ip27_defconfig
m68k                        m5307c3_defconfig
arm                          badge4_defconfig
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
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec
x86_64                                   rhel

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
