Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFB027531C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 10:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgIWIUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 04:20:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:60082 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgIWIUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 04:20:33 -0400
IronPort-SDR: 2T4uErn4/VJ882Rs/jJhaEP4nQLq+wKOAPCpMvr+0M4x1Ivi0EcHQ5YnQ4Dzodec+BvBUQBNzN
 E92VFP+Vk6dQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="161762785"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="161762785"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 01:20:32 -0700
IronPort-SDR: 03JIL9TJjQECF9DWLkZkfp37tKLjbkcopBstn56OH1TIEf8X3ArK3X8oYh5KRl0Uy1jk9WaB0b
 KFgBAsFen/lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="412929157"
Received: from lkp-server01.sh.intel.com (HELO 9f27196b5390) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 Sep 2020 01:20:30 -0700
Received: from kbuild by 9f27196b5390 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kL00r-00004T-Tr; Wed, 23 Sep 2020 08:20:29 +0000
Date:   Wed, 23 Sep 2020 16:20:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 a7b3474cbb2864d5500d5e4f48dd57c903975cab
Message-ID: <5f6b054b.fPo29fJb5o5rdSNB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: a7b3474cbb2864d5500d5e4f48dd57c903975cab  x86/irq: Make run_on_irqstack_cond() typesafe

elapsed time: 723m

configs tested: 145
configs skipped: 61

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
nios2                         3c120_defconfig
powerpc                     tqm8555_defconfig
arm                          iop32x_defconfig
ia64                         bigsur_defconfig
sh                     magicpanelr2_defconfig
h8300                     edosk2674_defconfig
powerpc                 xes_mpc85xx_defconfig
ia64                                defconfig
arm                            lart_defconfig
riscv                    nommu_virt_defconfig
powerpc                        warp_defconfig
powerpc                       maple_defconfig
sh                             sh03_defconfig
mips                          rm200_defconfig
mips                       bmips_be_defconfig
powerpc                   currituck_defconfig
mips                           gcw0_defconfig
sh                           se7722_defconfig
arm                      tct_hammer_defconfig
powerpc                       ebony_defconfig
arm                          tango4_defconfig
powerpc                 mpc834x_mds_defconfig
c6x                        evmc6457_defconfig
arm                           sama5_defconfig
x86_64                           alldefconfig
arm                         s5pv210_defconfig
powerpc                      chrp32_defconfig
arm                         axm55xx_defconfig
um                            kunit_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                       mainstone_defconfig
sh                          rsk7269_defconfig
sh                               alldefconfig
arm                         shannon_defconfig
arc                          axs101_defconfig
nios2                            alldefconfig
powerpc                      mgcoge_defconfig
arm                        multi_v5_defconfig
sh                             shx3_defconfig
arc                     haps_hs_smp_defconfig
powerpc                        fsp2_defconfig
powerpc                      ep88xc_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                       cns3420vb_defconfig
h8300                    h8300h-sim_defconfig
riscv                            allmodconfig
arm                       imx_v4_v5_defconfig
arm                         ebsa110_defconfig
arm                     am200epdkit_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                     rainier_defconfig
mips                            e55_defconfig
powerpc                        icon_defconfig
arm                        multi_v7_defconfig
arc                        nsimosci_defconfig
arm                           efm32_defconfig
m68k                            q40_defconfig
powerpc                 mpc8313_rdb_defconfig
m68k                       m5249evb_defconfig
powerpc                      cm5200_defconfig
mips                   sb1250_swarm_defconfig
ia64                             allmodconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20200923
i386                 randconfig-a006-20200923
i386                 randconfig-a003-20200923
i386                 randconfig-a004-20200923
i386                 randconfig-a005-20200923
i386                 randconfig-a001-20200923
i386                 randconfig-a002-20200921
i386                 randconfig-a006-20200921
i386                 randconfig-a003-20200921
i386                 randconfig-a004-20200921
i386                 randconfig-a005-20200921
i386                 randconfig-a001-20200921
i386                 randconfig-a002-20200922
i386                 randconfig-a006-20200922
i386                 randconfig-a003-20200922
i386                 randconfig-a004-20200922
i386                 randconfig-a005-20200922
i386                 randconfig-a001-20200922
x86_64               randconfig-a011-20200923
x86_64               randconfig-a013-20200923
x86_64               randconfig-a014-20200923
x86_64               randconfig-a015-20200923
x86_64               randconfig-a012-20200923
x86_64               randconfig-a016-20200923
i386                 randconfig-a012-20200923
i386                 randconfig-a014-20200923
i386                 randconfig-a016-20200923
i386                 randconfig-a013-20200923
i386                 randconfig-a011-20200923
i386                 randconfig-a015-20200923
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20200923
x86_64               randconfig-a003-20200923
x86_64               randconfig-a004-20200923
x86_64               randconfig-a002-20200923
x86_64               randconfig-a006-20200923
x86_64               randconfig-a001-20200923
x86_64               randconfig-a011-20200922
x86_64               randconfig-a013-20200922
x86_64               randconfig-a014-20200922
x86_64               randconfig-a015-20200922
x86_64               randconfig-a012-20200922
x86_64               randconfig-a016-20200922

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
