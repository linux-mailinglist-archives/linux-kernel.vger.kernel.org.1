Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377BF2F7081
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 03:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbhAOCVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 21:21:22 -0500
Received: from mga05.intel.com ([192.55.52.43]:61585 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbhAOCVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 21:21:19 -0500
IronPort-SDR: FdpIR9764QdOFVSCxSamiPdLBA6Vy2ODNks5SctFybMgH8oE1pJOfLKqvIo85pt/cySq5u/+n0
 JANOGS7yx/2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="263275178"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="263275178"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 18:20:38 -0800
IronPort-SDR: ArIj2yw9NE+263rHriltTxwZndOoxG19fwVYovWaX37oiJ6AuhB+VgaN/5axhbPVV1tSmeU1UH
 Za8Od2uzkdUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="364420411"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 14 Jan 2021 18:20:37 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l0Ej6-00005A-HD; Fri, 15 Jan 2021 02:20:36 +0000
Date:   Fri, 15 Jan 2021 10:19:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sgx] BUILD SUCCESS
 745b56b065618aaee7c2ab4ca3c85e2cdbebc1d6
Message-ID: <6000fbca.ooMbw7ur3kzOIAIn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/sgx
branch HEAD: 745b56b065618aaee7c2ab4ca3c85e2cdbebc1d6  x86/sgx: Fix the return type of sgx_init()

elapsed time: 724m

configs tested: 138
configs skipped: 74

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         tb0287_defconfig
s390                          debug_defconfig
openrisc                            defconfig
arc                        nsim_700_defconfig
arm                           sunxi_defconfig
arm                          moxart_defconfig
x86_64                           allyesconfig
m68k                          amiga_defconfig
sparc                       sparc32_defconfig
powerpc                        icon_defconfig
arm                       imx_v4_v5_defconfig
arc                      axs103_smp_defconfig
sh                          r7785rp_defconfig
m68k                        m5272c3_defconfig
arm                        oxnas_v6_defconfig
powerpc                     mpc5200_defconfig
arm                       cns3420vb_defconfig
powerpc                       holly_defconfig
mips                      pistachio_defconfig
mips                        nlm_xlr_defconfig
mips                           gcw0_defconfig
openrisc                         alldefconfig
arm                        multi_v5_defconfig
powerpc                      ppc44x_defconfig
arc                        nsimosci_defconfig
sh                      rts7751r2d1_defconfig
sh                           se7751_defconfig
parisc                generic-32bit_defconfig
arc                     nsimosci_hs_defconfig
riscv                          rv32_defconfig
mips                         cobalt_defconfig
m68k                             alldefconfig
arm                         at91_dt_defconfig
m68k                        m5407c3_defconfig
ia64                             allmodconfig
mips                      bmips_stb_defconfig
powerpc                      ppc6xx_defconfig
arm                             ezx_defconfig
sh                            migor_defconfig
mips                        workpad_defconfig
mips                  decstation_64_defconfig
arm                          pxa168_defconfig
sh                          sdk7786_defconfig
sh                   sh7770_generic_defconfig
arm                            hisi_defconfig
mips                      maltaaprp_defconfig
mips                         bigsur_defconfig
arc                              alldefconfig
um                            kunit_defconfig
powerpc                     kilauea_defconfig
m68k                        stmark2_defconfig
nios2                               defconfig
arm                         cm_x300_defconfig
sh                           se7750_defconfig
sh                           se7206_defconfig
powerpc                     tqm8555_defconfig
arm                         lpc32xx_defconfig
sh                           se7722_defconfig
nds32                             allnoconfig
mips                        maltaup_defconfig
csky                             alldefconfig
arm                          iop32x_defconfig
sh                           se7705_defconfig
c6x                        evmc6457_defconfig
sh                           se7724_defconfig
arm                            mmp2_defconfig
arm                        vexpress_defconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
i386                 randconfig-a002-20210114
i386                 randconfig-a001-20210114
i386                 randconfig-a003-20210114
i386                 randconfig-a005-20210114
i386                 randconfig-a006-20210114
i386                 randconfig-a004-20210114
x86_64               randconfig-a015-20210114
x86_64               randconfig-a012-20210114
x86_64               randconfig-a013-20210114
x86_64               randconfig-a016-20210114
x86_64               randconfig-a014-20210114
x86_64               randconfig-a011-20210114
i386                 randconfig-a012-20210114
i386                 randconfig-a011-20210114
i386                 randconfig-a016-20210114
i386                 randconfig-a015-20210114
i386                 randconfig-a013-20210114
i386                 randconfig-a014-20210114
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210114
x86_64               randconfig-a006-20210114
x86_64               randconfig-a001-20210114
x86_64               randconfig-a003-20210114
x86_64               randconfig-a005-20210114
x86_64               randconfig-a002-20210114

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
