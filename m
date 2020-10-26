Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7492F29995C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 23:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392249AbgJZWK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 18:10:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:2453 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392164AbgJZWK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 18:10:59 -0400
IronPort-SDR: n/d/nAkDPgJqE8neiJFEuAr2MgMHhrkC4mzqS5lgmg0C6IEGE1J4AYEhnKF+qWaiexSdrMiLo/
 7dgmLK1aGaqA==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="168095025"
X-IronPort-AV: E=Sophos;i="5.77,421,1596524400"; 
   d="scan'208";a="168095025"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 15:10:52 -0700
IronPort-SDR: ruNj9OxSbZ+XHHvhPqgzhkO8FzHq0grk/ImGMTA3fTxEenO7rD4w7la4PoflosF42ERB32lDxT
 FLwxzp0Sxsrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,421,1596524400"; 
   d="scan'208";a="303682370"
Received: from lkp-server01.sh.intel.com (HELO ca9e3ad0a302) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 26 Oct 2020 15:10:51 -0700
Received: from kbuild by ca9e3ad0a302 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kXAhW-0000B3-CR; Mon, 26 Oct 2020 22:10:50 +0000
Date:   Tue, 27 Oct 2020 06:10:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 1a2b85f1e2a93a3f84243e654d225e4088735336
Message-ID: <5f974953.C2uwrk0jLvjctvaY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  timers/core
branch HEAD: 1a2b85f1e2a93a3f84243e654d225e4088735336  timekeeping: Convert jiffies_seq to seqcount_raw_spinlock_t

elapsed time: 720m

configs tested: 178
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                            zeus_defconfig
arm                         ebsa110_defconfig
arm                        shmobile_defconfig
sparc                            allyesconfig
powerpc                     sequoia_defconfig
arm                          moxart_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                        fsp2_defconfig
arm                     davinci_all_defconfig
powerpc                       maple_defconfig
arm                           omap1_defconfig
powerpc                       holly_defconfig
m68k                        mvme147_defconfig
powerpc                     mpc83xx_defconfig
mips                           gcw0_defconfig
arm                          ixp4xx_defconfig
mips                         cobalt_defconfig
sh                           se7705_defconfig
arm                        spear6xx_defconfig
arm                              zx_defconfig
mips                          malta_defconfig
alpha                               defconfig
arm                         mv78xx0_defconfig
m68k                          atari_defconfig
arm                           stm32_defconfig
alpha                            allyesconfig
arm                            dove_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                        bcm63xx_defconfig
sh                   secureedge5410_defconfig
mips                       rbtx49xx_defconfig
sh                     sh7710voipgw_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                         hackkit_defconfig
c6x                        evmc6457_defconfig
powerpc               mpc834x_itxgp_defconfig
ia64                        generic_defconfig
xtensa                generic_kc705_defconfig
arm                            qcom_defconfig
arm                           h3600_defconfig
arm                           sama5_defconfig
arm                         s3c2410_defconfig
mips                         tb0287_defconfig
mips                        workpad_defconfig
m68k                         amcore_defconfig
arm                          badge4_defconfig
powerpc                     stx_gp3_defconfig
sh                          rsk7264_defconfig
riscv                            allyesconfig
powerpc                     sbc8548_defconfig
arm                          exynos_defconfig
mips                         db1xxx_defconfig
mips                       bmips_be_defconfig
h8300                    h8300h-sim_defconfig
powerpc                      pmac32_defconfig
nios2                         10m50_defconfig
mips                     decstation_defconfig
arm                       aspeed_g5_defconfig
arm                        realview_defconfig
mips                          ath79_defconfig
xtensa                         virt_defconfig
mips                      bmips_stb_defconfig
parisc                generic-32bit_defconfig
arm                      integrator_defconfig
arm                          simpad_defconfig
powerpc                 linkstation_defconfig
arm                         shannon_defconfig
nds32                               defconfig
arm                         s3c6400_defconfig
arm                         assabet_defconfig
sh                            shmin_defconfig
m68k                         apollo_defconfig
sh                             shx3_defconfig
powerpc                      makalu_defconfig
mips                           ip28_defconfig
c6x                        evmc6678_defconfig
m68k                       m5275evb_defconfig
ia64                                defconfig
sh                             espt_defconfig
arm                          iop32x_defconfig
xtensa                              defconfig
arm                        multi_v7_defconfig
xtensa                  nommu_kc705_defconfig
arc                          axs101_defconfig
c6x                                 defconfig
sh                               j2_defconfig
mips                            gpr_defconfig
sh                            migor_defconfig
x86_64                           allyesconfig
powerpc                      walnut_defconfig
c6x                        evmc6472_defconfig
mips                        nlm_xlp_defconfig
arc                        nsimosci_defconfig
sh                           se7780_defconfig
sh                   sh7724_generic_defconfig
arm                          collie_defconfig
sh                          r7780mp_defconfig
m68k                        m5407c3_defconfig
riscv                            alldefconfig
xtensa                          iss_defconfig
mips                           ip22_defconfig
sh                        edosk7705_defconfig
arm                         cm_x300_defconfig
powerpc                     rainier_defconfig
powerpc                     pseries_defconfig
mips                      fuloong2e_defconfig
mips                           mtx1_defconfig
m68k                            mac_defconfig
sh                        dreamcast_defconfig
powerpc                     ppa8548_defconfig
powerpc                 mpc836x_mds_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20201026
i386                 randconfig-a003-20201026
i386                 randconfig-a005-20201026
i386                 randconfig-a001-20201026
i386                 randconfig-a006-20201026
i386                 randconfig-a004-20201026
x86_64               randconfig-a011-20201026
x86_64               randconfig-a013-20201026
x86_64               randconfig-a016-20201026
x86_64               randconfig-a015-20201026
x86_64               randconfig-a012-20201026
x86_64               randconfig-a014-20201026
i386                 randconfig-a016-20201026
i386                 randconfig-a015-20201026
i386                 randconfig-a014-20201026
i386                 randconfig-a012-20201026
i386                 randconfig-a013-20201026
i386                 randconfig-a011-20201026
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20201026
x86_64               randconfig-a003-20201026
x86_64               randconfig-a002-20201026
x86_64               randconfig-a006-20201026
x86_64               randconfig-a004-20201026
x86_64               randconfig-a005-20201026

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
