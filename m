Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A982D52AA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 05:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbgLJEM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 23:12:57 -0500
Received: from mga07.intel.com ([134.134.136.100]:20097 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730328AbgLJEM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 23:12:56 -0500
IronPort-SDR: lpSx0sDK/4WPZYIy9CvXShC8g0+bBryyPTfwDDPsdR0RiIzhFMts+rmIj3pPegS8BJFYhT7smo
 JbJLvNMq/r9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="238296970"
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="238296970"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 20:12:15 -0800
IronPort-SDR: FMovkpm51ZeFObQlIV62DdW3cd8/zL0IlciWjMw8XDBASuSv3kmIkDMiOOS4OGfsYaKjd0QWCa
 5zYJg1cfbztw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="484269998"
Received: from lkp-server01.sh.intel.com (HELO ecc0cebe68d1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 Dec 2020 20:12:14 -0800
Received: from kbuild by ecc0cebe68d1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1knDJN-000029-Ve; Thu, 10 Dec 2020 04:12:13 +0000
Date:   Thu, 10 Dec 2020 12:12:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/rwsem] BUILD SUCCESS
 31784cff7ee073b34d6eddabb95e3be2880a425c
Message-ID: <5fd1a014.J8crE/Ov66QuAL4j%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  locking/rwsem
branch HEAD: 31784cff7ee073b34d6eddabb95e3be2880a425c  rwsem: Implement down_read_interruptible

elapsed time: 720m

configs tested: 155
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          kfr2r09_defconfig
x86_64                           alldefconfig
arm                     am200epdkit_defconfig
arm                  colibri_pxa270_defconfig
arm                          lpd270_defconfig
arm                              zx_defconfig
arm                         palmz72_defconfig
arm                            u300_defconfig
powerpc                        cell_defconfig
powerpc                   bluestone_defconfig
powerpc                      pcm030_defconfig
arm                      pxa255-idp_defconfig
mips                       bmips_be_defconfig
sh                           se7722_defconfig
s390                             allyesconfig
riscv                    nommu_virt_defconfig
arm                          ep93xx_defconfig
powerpc                         wii_defconfig
xtensa                  cadence_csp_defconfig
sh                          r7780mp_defconfig
powerpc                   lite5200b_defconfig
mips                           ip32_defconfig
sh                            migor_defconfig
powerpc                    ge_imp3a_defconfig
arc                     haps_hs_smp_defconfig
powerpc                 mpc832x_mds_defconfig
mips                          malta_defconfig
powerpc                       eiger_defconfig
m68k                        mvme147_defconfig
powerpc                      tqm8xx_defconfig
arc                        vdk_hs38_defconfig
ia64                         bigsur_defconfig
nds32                             allnoconfig
ia64                        generic_defconfig
arm                            xcep_defconfig
powerpc                     mpc83xx_defconfig
sh                             shx3_defconfig
arm                        neponset_defconfig
m68k                        mvme16x_defconfig
mips                        omega2p_defconfig
um                             i386_defconfig
mips                           gcw0_defconfig
sh                           se7724_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                           viper_defconfig
arm                         socfpga_defconfig
alpha                            alldefconfig
arm                        vexpress_defconfig
mips                         tb0219_defconfig
mips                  maltasmvp_eva_defconfig
mips                     cu1000-neo_defconfig
powerpc                     rainier_defconfig
m68k                         apollo_defconfig
arm                          pcm027_defconfig
mips                          ath25_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        oxnas_v6_defconfig
s390                                defconfig
powerpc                     tqm8541_defconfig
m68k                             alldefconfig
arm                        cerfcube_defconfig
arm                       multi_v4t_defconfig
powerpc                 mpc8540_ads_defconfig
arm                           tegra_defconfig
powerpc                      pmac32_defconfig
mips                          ath79_defconfig
openrisc                            defconfig
m68k                           sun3_defconfig
arm                        multi_v7_defconfig
powerpc                 mpc85xx_cds_defconfig
nios2                            alldefconfig
arm                       aspeed_g5_defconfig
powerpc                 canyonlands_defconfig
sh                      rts7751r2d1_defconfig
mips                         bigsur_defconfig
mips                           xway_defconfig
mips                         cobalt_defconfig
mips                        nlm_xlp_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
parisc                           allyesconfig
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
i386                 randconfig-a004-20201209
i386                 randconfig-a005-20201209
i386                 randconfig-a001-20201209
i386                 randconfig-a002-20201209
i386                 randconfig-a006-20201209
i386                 randconfig-a003-20201209
x86_64               randconfig-a016-20201209
x86_64               randconfig-a012-20201209
x86_64               randconfig-a013-20201209
x86_64               randconfig-a014-20201209
x86_64               randconfig-a015-20201209
x86_64               randconfig-a011-20201209
i386                 randconfig-a013-20201209
i386                 randconfig-a014-20201209
i386                 randconfig-a011-20201209
i386                 randconfig-a015-20201209
i386                 randconfig-a012-20201209
i386                 randconfig-a016-20201209
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-a004-20201209
x86_64               randconfig-a006-20201209
x86_64               randconfig-a005-20201209
x86_64               randconfig-a001-20201209
x86_64               randconfig-a002-20201209
x86_64               randconfig-a003-20201209
x86_64               randconfig-a003-20201210
x86_64               randconfig-a006-20201210
x86_64               randconfig-a002-20201210
x86_64               randconfig-a005-20201210
x86_64               randconfig-a004-20201210
x86_64               randconfig-a001-20201210

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
