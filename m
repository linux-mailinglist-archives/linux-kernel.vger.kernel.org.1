Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1072B3484
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 12:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgKOLDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 06:03:10 -0500
Received: from mga01.intel.com ([192.55.52.88]:37738 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbgKOLDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 06:03:08 -0500
IronPort-SDR: OFmwew/5M1rh0dGUedHjU4vgGdh+m1g5xemwKyIEOt8QuxRenbw6sqffqOId4pjs7Ip+tCFRNH
 FupTefeXYKFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9805"; a="188678406"
X-IronPort-AV: E=Sophos;i="5.77,480,1596524400"; 
   d="scan'208";a="188678406"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2020 03:03:07 -0800
IronPort-SDR: irn2lGz+k3j+isQoiPrxsgnvIT3pdrZnl5LxxwHLvFHvvPjvKbYk28furQvgoITYjV5d6W6gSC
 WZ6AR/qCmXAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,480,1596524400"; 
   d="scan'208";a="329388615"
Received: from lkp-server01.sh.intel.com (HELO 2e68b9ba5db3) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 15 Nov 2020 03:03:06 -0800
Received: from kbuild by 2e68b9ba5db3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1keFoH-00009h-RK; Sun, 15 Nov 2020 11:03:05 +0000
Date:   Sun, 15 Nov 2020 19:02:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 f296dcd629aa412a80a53215e46087f53af87f08
Message-ID: <5fb10abf.ezzrvcF9hUzwowiF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  irq/core
branch HEAD: f296dcd629aa412a80a53215e46087f53af87f08  genirq: Remove GENERIC_IRQ_LEGACY_ALLOC_HWIRQ

elapsed time: 721m

configs tested: 119
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                    nommu_k210_defconfig
ia64                                defconfig
arm                          tango4_defconfig
powerpc                      ppc40x_defconfig
mips                            gpr_defconfig
c6x                              alldefconfig
xtensa                           allyesconfig
nios2                         3c120_defconfig
sh                          r7780mp_defconfig
mips                           ci20_defconfig
sh                          r7785rp_defconfig
powerpc                         wii_defconfig
arm                           h5000_defconfig
mips                      loongson3_defconfig
mips                            ar7_defconfig
m68k                       m5249evb_defconfig
arc                            hsdk_defconfig
sh                        apsh4ad0a_defconfig
powerpc                     ksi8560_defconfig
powerpc                 mpc834x_itx_defconfig
sh                          sdk7780_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                          sdk7786_defconfig
ia64                        generic_defconfig
powerpc                     ep8248e_defconfig
sparc64                          alldefconfig
powerpc                 mpc837x_mds_defconfig
arm                        spear3xx_defconfig
powerpc                 mpc8540_ads_defconfig
mips                         db1xxx_defconfig
sh                             espt_defconfig
mips                        jmr3927_defconfig
mips                        bcm47xx_defconfig
arm                         orion5x_defconfig
mips                  cavium_octeon_defconfig
nds32                             allnoconfig
sparc                       sparc64_defconfig
alpha                            allyesconfig
mips                       rbtx49xx_defconfig
sh                           se7750_defconfig
csky                             alldefconfig
sparc64                             defconfig
powerpc                  storcenter_defconfig
powerpc                     stx_gp3_defconfig
c6x                        evmc6474_defconfig
arm                         axm55xx_defconfig
sh                          landisk_defconfig
m68k                         apollo_defconfig
sh                           se7712_defconfig
mips                        nlm_xlr_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
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
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201115
i386                 randconfig-a005-20201115
i386                 randconfig-a001-20201115
i386                 randconfig-a002-20201115
i386                 randconfig-a004-20201115
i386                 randconfig-a003-20201115
x86_64               randconfig-a015-20201115
x86_64               randconfig-a011-20201115
x86_64               randconfig-a014-20201115
x86_64               randconfig-a013-20201115
x86_64               randconfig-a016-20201115
x86_64               randconfig-a012-20201115
i386                 randconfig-a012-20201115
i386                 randconfig-a014-20201115
i386                 randconfig-a016-20201115
i386                 randconfig-a011-20201115
i386                 randconfig-a015-20201115
i386                 randconfig-a013-20201115
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
x86_64               randconfig-a003-20201115
x86_64               randconfig-a005-20201115
x86_64               randconfig-a004-20201115
x86_64               randconfig-a002-20201115
x86_64               randconfig-a001-20201115
x86_64               randconfig-a006-20201115

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
