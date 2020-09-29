Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67EE27BB1D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 04:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbgI2CpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 22:45:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:35280 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727268AbgI2CpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 22:45:10 -0400
IronPort-SDR: nMXL4art+XnkjchRrgQkqn7eBhRtJE/yNo2XLP7X52k/roPJoftHrmAo+3NCtHkkKR4/IoNmSB
 t9saboyXs03g==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="159433353"
X-IronPort-AV: E=Sophos;i="5.77,316,1596524400"; 
   d="scan'208";a="159433353"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 19:10:02 -0700
IronPort-SDR: ccBO/CbTE+G6frgD5MXpKmp00FLtPci/LQJEQBrqOqvsUmteMA6ayTyZAhwGzghN98Uf+xz0W9
 RSGUweq0G+vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,316,1596524400"; 
   d="scan'208";a="307579653"
Received: from lkp-server01.sh.intel.com (HELO 0e0978ea3297) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Sep 2020 19:10:01 -0700
Received: from kbuild by 0e0978ea3297 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kN55c-0000TS-HH; Tue, 29 Sep 2020 02:10:00 +0000
Date:   Tue, 29 Sep 2020 10:09:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/irq] BUILD SUCCESS
 981aa1d366bf46bdc1c9259a5ab818a8d522724e
Message-ID: <5f729745.5g/siu70VaUd/Bgm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/irq
branch HEAD: 981aa1d366bf46bdc1c9259a5ab818a8d522724e  PCI: MSI: Fix Kconfig dependencies for PCI_MSI_ARCH_FALLBACKS

elapsed time: 722m

configs tested: 162
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7750_defconfig
sh                           se7722_defconfig
sh                        sh7763rdp_defconfig
powerpc                mpc7448_hpc2_defconfig
ia64                         bigsur_defconfig
powerpc                      arches_defconfig
powerpc                      cm5200_defconfig
sparc                       sparc32_defconfig
arm                          badge4_defconfig
powerpc                        cell_defconfig
powerpc                     tqm8541_defconfig
powerpc64                           defconfig
csky                             alldefconfig
sh                             shx3_defconfig
riscv                          rv32_defconfig
sh                          rsk7201_defconfig
openrisc                         alldefconfig
mips                      pic32mzda_defconfig
arm                   milbeaut_m10v_defconfig
m68k                          multi_defconfig
sh                        edosk7705_defconfig
nios2                         3c120_defconfig
powerpc                     rainier_defconfig
powerpc                     mpc512x_defconfig
mips                       lemote2f_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                      mgcoge_defconfig
mips                        maltaup_defconfig
alpha                            allyesconfig
powerpc                     tqm8548_defconfig
arm                          simpad_defconfig
sh                        edosk7760_defconfig
mips                      bmips_stb_defconfig
sh                        apsh4ad0a_defconfig
arm                        magician_defconfig
mips                           ip22_defconfig
arm                        spear6xx_defconfig
mips                         db1xxx_defconfig
powerpc                       maple_defconfig
powerpc                   bluestone_defconfig
powerpc                     tqm5200_defconfig
arm                             mxs_defconfig
arm                           omap1_defconfig
microblaze                      mmu_defconfig
powerpc                 mpc836x_rdk_defconfig
arc                      axs103_smp_defconfig
arm                              zx_defconfig
arm                        mvebu_v5_defconfig
c6x                        evmc6472_defconfig
mips                     loongson1b_defconfig
xtensa                    smp_lx200_defconfig
mips                 decstation_r4k_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                  colibri_pxa300_defconfig
powerpc                      ppc40x_defconfig
arm                      integrator_defconfig
arc                          axs103_defconfig
nios2                         10m50_defconfig
mips                     cu1000-neo_defconfig
sh                           se7619_defconfig
powerpc                     stx_gp3_defconfig
sh                      rts7751r2d1_defconfig
m68k                             alldefconfig
mips                     decstation_defconfig
arm                           stm32_defconfig
powerpc                     kilauea_defconfig
powerpc                     pseries_defconfig
arm                         lpc32xx_defconfig
ia64                            zx1_defconfig
sh                          polaris_defconfig
powerpc                      walnut_defconfig
sh                         microdev_defconfig
arm                           sunxi_defconfig
microblaze                    nommu_defconfig
mips                           xway_defconfig
arm                        cerfcube_defconfig
arm                  colibri_pxa270_defconfig
mips                      maltaaprp_defconfig
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
x86_64               randconfig-a005-20200928
x86_64               randconfig-a003-20200928
x86_64               randconfig-a004-20200928
x86_64               randconfig-a002-20200928
x86_64               randconfig-a006-20200928
x86_64               randconfig-a001-20200928
i386                 randconfig-a006-20200928
i386                 randconfig-a002-20200928
i386                 randconfig-a003-20200928
i386                 randconfig-a004-20200928
i386                 randconfig-a005-20200928
i386                 randconfig-a001-20200928
i386                 randconfig-a002-20200927
i386                 randconfig-a006-20200927
i386                 randconfig-a003-20200927
i386                 randconfig-a004-20200927
i386                 randconfig-a005-20200927
i386                 randconfig-a001-20200927
x86_64               randconfig-a011-20200927
x86_64               randconfig-a013-20200927
x86_64               randconfig-a014-20200927
x86_64               randconfig-a015-20200927
x86_64               randconfig-a012-20200927
x86_64               randconfig-a016-20200927
i386                 randconfig-a012-20200928
i386                 randconfig-a013-20200928
i386                 randconfig-a011-20200928
i386                 randconfig-a016-20200928
i386                 randconfig-a014-20200928
i386                 randconfig-a015-20200928
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20200928
x86_64               randconfig-a013-20200928
x86_64               randconfig-a015-20200928
x86_64               randconfig-a014-20200928
x86_64               randconfig-a016-20200928
x86_64               randconfig-a012-20200928

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
