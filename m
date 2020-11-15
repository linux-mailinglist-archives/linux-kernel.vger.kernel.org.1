Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1E02B3A90
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 00:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgKOXUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 18:20:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:47622 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgKOXUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 18:20:51 -0500
IronPort-SDR: 4ibWZiP9RMt3eT4VdEAhA0Of7mKYVaxpPxrcwmIG9UYsR8C0Mi60AJQNNb8+LbnBwOupVu9pF9
 U7z4WpAzmSxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="170786139"
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; 
   d="scan'208";a="170786139"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2020 15:20:50 -0800
IronPort-SDR: 5q/S1LyTEJNPJIN/klVL5G7PVx/g3kr56Ohzpke+ztrOrFhG1fs43lZuWxGxb5ykwLZKl87mBn
 p00GwCNffMag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; 
   d="scan'208";a="367325305"
Received: from lkp-server01.sh.intel.com (HELO 2e68b9ba5db3) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Nov 2020 15:20:48 -0800
Received: from kbuild by 2e68b9ba5db3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1keRKC-0000JQ-9I; Sun, 15 Nov 2020 23:20:48 +0000
Date:   Mon, 16 Nov 2020 07:20:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 e906a546bd8653ed2e7a14cb300fd17952d7f862
Message-ID: <5fb1b7b0.TlySjBb1fxdWFrL7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  irq/core
branch HEAD: e906a546bd8653ed2e7a14cb300fd17952d7f862  genirq/irqdomain: Make irq_domain_disassociate() static

elapsed time: 721m

configs tested: 133
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
powerpc                    amigaone_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                      mgcoge_defconfig
arc                        nsim_700_defconfig
arm                           omap1_defconfig
c6x                        evmc6474_defconfig
arm                       omap2plus_defconfig
sh                           se7722_defconfig
m68k                       m5249evb_defconfig
m68k                         amcore_defconfig
powerpc                     tqm8560_defconfig
mips                             allyesconfig
mips                            ar7_defconfig
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
sparc                       sparc64_defconfig
mips                       rbtx49xx_defconfig
arm                       aspeed_g4_defconfig
arc                         haps_hs_defconfig
arm                         vf610m4_defconfig
arm                       versatile_defconfig
sh                           se7619_defconfig
sh                                  defconfig
powerpc                    socrates_defconfig
mips                      pic32mzda_defconfig
mips                        maltaup_defconfig
powerpc                 mpc834x_mds_defconfig
mips                       lemote2f_defconfig
arm                         axm55xx_defconfig
sh                          landisk_defconfig
m68k                         apollo_defconfig
sh                           se7712_defconfig
mips                        nlm_xlr_defconfig
mips                     decstation_defconfig
powerpc                      arches_defconfig
powerpc                        warp_defconfig
mips                          rb532_defconfig
sh                           se7343_defconfig
powerpc                mpc7448_hpc2_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
