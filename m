Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7952FED14
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 15:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbhAUOjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 09:39:05 -0500
Received: from mga17.intel.com ([192.55.52.151]:22505 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728953AbhAUOJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 09:09:28 -0500
IronPort-SDR: So5Zi5R9G8k6fRtZ8kyEg0zpzcGqWL0g/IRLDnrn+Cwzspes8pEp8e8bsbzicQn8zd1lvqM4R3
 KAcFVo4Dh9Tw==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="159051632"
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="159051632"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 06:08:19 -0800
IronPort-SDR: +xG+24tK8coSIk9M+piF01Vc8Mc4rbSE6ohtF0M/vFCY3fIl6mT+i3luQWX18BLu+jpKNwRzM+
 oZs6gK7hLXPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="407284058"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Jan 2021 06:08:17 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l2adF-0006YT-5R; Thu, 21 Jan 2021 14:08:17 +0000
Date:   Thu, 21 Jan 2021 22:08:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 d36101e9c3d6f8a5fddeb258d49e4834227585de
Message-ID: <60098ac3.lkz1Ev2uehg4GWhx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: d36101e9c3d6f8a5fddeb258d49e4834227585de  kcsan: Add missing license and copyright headers

elapsed time: 725m

configs tested: 138
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                          axs101_defconfig
sh                   sh7770_generic_defconfig
c6x                              alldefconfig
arm                     davinci_all_defconfig
mips                        omega2p_defconfig
sh                        dreamcast_defconfig
powerpc                     ppa8548_defconfig
sh                           se7780_defconfig
sh                            titan_defconfig
mips                        nlm_xlr_defconfig
powerpc                 mpc834x_mds_defconfig
xtensa                  cadence_csp_defconfig
sh                 kfr2r09-romimage_defconfig
mips                    maltaup_xpa_defconfig
arc                           tb10x_defconfig
powerpc                         wii_defconfig
mips                        vocore2_defconfig
arm                          moxart_defconfig
powerpc                      acadia_defconfig
powerpc                       eiger_defconfig
arm                          pxa910_defconfig
m68k                        stmark2_defconfig
arm                        multi_v7_defconfig
arm                       imx_v4_v5_defconfig
mips                malta_qemu_32r6_defconfig
mips                            e55_defconfig
arm                          pcm027_defconfig
arc                        nsim_700_defconfig
m68k                           sun3_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                       lemote2f_defconfig
mips                   sb1250_swarm_defconfig
arm                    vt8500_v6_v7_defconfig
sh                           se7724_defconfig
mips                     decstation_defconfig
mips                         bigsur_defconfig
arm                        mini2440_defconfig
xtensa                              defconfig
sh                   secureedge5410_defconfig
sparc                       sparc64_defconfig
arm                       multi_v4t_defconfig
sh                        sh7757lcr_defconfig
mips                           ip27_defconfig
arm                       spear13xx_defconfig
m68k                          multi_defconfig
xtensa                  nommu_kc705_defconfig
c6x                         dsk6455_defconfig
powerpc                     pseries_defconfig
mips                           rs90_defconfig
mips                       bmips_be_defconfig
sh                        edosk7705_defconfig
xtensa                         virt_defconfig
i386                             alldefconfig
powerpc                  storcenter_defconfig
arm                           sunxi_defconfig
sh                      rts7751r2d1_defconfig
powerpc                      arches_defconfig
powerpc                       ppc64_defconfig
mips                      pistachio_defconfig
powerpc                 mpc837x_mds_defconfig
arm                        oxnas_v6_defconfig
mips                malta_kvm_guest_defconfig
arc                         haps_hs_defconfig
mips                           gcw0_defconfig
xtensa                generic_kc705_defconfig
sh                        sh7763rdp_defconfig
powerpc                      ppc6xx_defconfig
mips                           ip22_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
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
