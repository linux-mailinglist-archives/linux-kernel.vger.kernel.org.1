Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9532B28F7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 00:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgKMXGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 18:06:46 -0500
Received: from mga12.intel.com ([192.55.52.136]:54049 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgKMXGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 18:06:45 -0500
IronPort-SDR: V3Q1PekFVtwoSWT61tNrugA9CA2jVzDjciU3GLNB4xWahkyUUmuFuDnwlx0x++ZtDlmxC1B3aX
 f2mIXUFve2fg==
X-IronPort-AV: E=McAfee;i="6000,8403,9804"; a="149813670"
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="149813670"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 15:06:40 -0800
IronPort-SDR: CNgr9h+prQGVU9A9HjP0ktCTiX8rojLRWI9hdudF7MYGnYRekViy5nOr7B0KcS141kOajXKjOn
 woDleGTKvPYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,476,1596524400"; 
   d="scan'208";a="474831068"
Received: from lkp-server02.sh.intel.com (HELO 697932c29306) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 13 Nov 2020 15:06:37 -0800
Received: from kbuild by 697932c29306 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kdi9M-0000Zc-Iq; Fri, 13 Nov 2020 23:06:36 +0000
Date:   Sat, 14 Nov 2020 07:05:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 ff828729be446b86957f7c294068758231cd2183
Message-ID: <5faf1142.03YqvSBcDh7OsX8a%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: ff828729be446b86957f7c294068758231cd2183  iommu/vt-d: Cure VF irqdomain hickup

elapsed time: 723m

configs tested: 167
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                  cavium_octeon_defconfig
powerpc                     pq2fads_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                     loongson1b_defconfig
powerpc                     rainier_defconfig
ia64                          tiger_defconfig
powerpc                    sam440ep_defconfig
h8300                    h8300h-sim_defconfig
sh                             shx3_defconfig
xtensa                              defconfig
powerpc                  iss476-smp_defconfig
powerpc                     sequoia_defconfig
powerpc                       eiger_defconfig
arm                        neponset_defconfig
powerpc                     kmeter1_defconfig
m68k                                defconfig
parisc                generic-32bit_defconfig
arm                         orion5x_defconfig
mips                           ci20_defconfig
arm                              alldefconfig
nios2                            alldefconfig
sh                          rsk7203_defconfig
m68k                            q40_defconfig
openrisc                    or1ksim_defconfig
sh                          rsk7269_defconfig
powerpc                     tqm5200_defconfig
sh                            titan_defconfig
arm                         lpc32xx_defconfig
sh                           se7750_defconfig
arc                    vdk_hs38_smp_defconfig
arc                           tb10x_defconfig
mips                        nlm_xlr_defconfig
c6x                              alldefconfig
arc                     nsimosci_hs_defconfig
arm                          gemini_defconfig
m68k                       m5249evb_defconfig
arm                          iop32x_defconfig
arm                          simpad_defconfig
arm                           sunxi_defconfig
mips                         rt305x_defconfig
powerpc                   bluestone_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                      pxa255-idp_defconfig
powerpc                     tqm8560_defconfig
nds32                            alldefconfig
powerpc                      ep88xc_defconfig
sh                  sh7785lcr_32bit_defconfig
h8300                            allyesconfig
powerpc                       maple_defconfig
arm                       aspeed_g5_defconfig
arc                        nsim_700_defconfig
mips                       rbtx49xx_defconfig
microblaze                          defconfig
sh                   sh7724_generic_defconfig
alpha                            alldefconfig
arm                         s3c6400_defconfig
arm                         vf610m4_defconfig
arm                      integrator_defconfig
sh                         ecovec24_defconfig
mips                         tb0287_defconfig
xtensa                generic_kc705_defconfig
arm                              zx_defconfig
mips                            gpr_defconfig
powerpc                     skiroot_defconfig
arm                          lpd270_defconfig
mips                           jazz_defconfig
powerpc                      acadia_defconfig
xtensa                          iss_defconfig
m68k                       m5208evb_defconfig
mips                           xway_defconfig
mips                        jmr3927_defconfig
mips                          rb532_defconfig
arm                       aspeed_g4_defconfig
arm                         assabet_defconfig
um                            kunit_defconfig
m68k                          hp300_defconfig
riscv                            allyesconfig
mips                        maltaup_defconfig
mips                        nlm_xlp_defconfig
arm                            u300_defconfig
openrisc                 simple_smp_defconfig
sh                          polaris_defconfig
sh                          urquell_defconfig
arm                         bcm2835_defconfig
m68k                       m5475evb_defconfig
arm                      tct_hammer_defconfig
powerpc                mpc7448_hpc2_defconfig
um                           x86_64_defconfig
arm                        realview_defconfig
sparc                       sparc32_defconfig
powerpc                     ppa8548_defconfig
arc                     haps_hs_smp_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                          g5_defconfig
sparc                       sparc64_defconfig
mips                      pistachio_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
i386                 randconfig-a006-20201113
i386                 randconfig-a005-20201113
i386                 randconfig-a002-20201113
i386                 randconfig-a001-20201113
i386                 randconfig-a003-20201113
i386                 randconfig-a004-20201113
x86_64               randconfig-a015-20201113
x86_64               randconfig-a011-20201113
x86_64               randconfig-a014-20201113
x86_64               randconfig-a013-20201113
x86_64               randconfig-a016-20201113
x86_64               randconfig-a012-20201113
i386                 randconfig-a012-20201113
i386                 randconfig-a014-20201113
i386                 randconfig-a016-20201113
i386                 randconfig-a011-20201113
i386                 randconfig-a015-20201113
i386                 randconfig-a013-20201113
riscv                    nommu_k210_defconfig
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
x86_64               randconfig-a003-20201113
x86_64               randconfig-a005-20201113
x86_64               randconfig-a004-20201113
x86_64               randconfig-a002-20201113
x86_64               randconfig-a006-20201113
x86_64               randconfig-a001-20201113

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
