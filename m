Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0008F2B7118
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 22:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgKQVuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 16:50:12 -0500
Received: from mga05.intel.com ([192.55.52.43]:7511 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbgKQVuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 16:50:11 -0500
IronPort-SDR: 8g5H/fGvZ2JdJr0b0oLds+D87kbrIVe9GtU6U4O/0pT/6Rirk4TRR23DlCw2wIiwhDaXbZ/w+8
 j9Hbut8DZooQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="255729677"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="255729677"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 13:50:10 -0800
IronPort-SDR: 4eZT3/o42lEFFt5dRsmcKtDVcYsXDg6r70uTcL21EYWPqxAh/HNDMp7uzPJZoMlT/wGQkxjIJs
 1MNzwcNAWIbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="362649565"
Received: from lkp-server01.sh.intel.com (HELO d102174a0e0d) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 17 Nov 2020 13:50:08 -0800
Received: from kbuild by d102174a0e0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kf8rY-00009P-8m; Tue, 17 Nov 2020 21:50:08 +0000
Date:   Wed, 18 Nov 2020 05:49:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 1a371e67dc77125736cc56d3a0893f06b75855b6
Message-ID: <5fb44576.OsnmRNBGl5PeGwhd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: 1a371e67dc77125736cc56d3a0893f06b75855b6  x86/microcode/intel: Check patch signature before saving microcode for early loading

elapsed time: 723m

configs tested: 201
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                           efm32_defconfig
powerpc                    sam440ep_defconfig
arm                       imx_v4_v5_defconfig
mips                         tb0219_defconfig
um                           x86_64_defconfig
powerpc                 mpc8315_rdb_defconfig
h8300                     edosk2674_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                               j2_defconfig
sparc                       sparc64_defconfig
mips                       bmips_be_defconfig
ia64                            zx1_defconfig
sh                          rsk7203_defconfig
arm                       netwinder_defconfig
arm                     am200epdkit_defconfig
nios2                         10m50_defconfig
powerpc                       eiger_defconfig
m68k                        mvme147_defconfig
xtensa                          iss_defconfig
mips                           ci20_defconfig
c6x                        evmc6678_defconfig
m68k                        m5407c3_defconfig
arc                 nsimosci_hs_smp_defconfig
ia64                      gensparse_defconfig
powerpc64                        alldefconfig
mips                malta_kvm_guest_defconfig
powerpc                     redwood_defconfig
arm                        cerfcube_defconfig
arc                              alldefconfig
sh                            hp6xx_defconfig
s390                       zfcpdump_defconfig
openrisc                         alldefconfig
powerpc                 xes_mpc85xx_defconfig
arc                         haps_hs_defconfig
arc                    vdk_hs38_smp_defconfig
arm                          pxa910_defconfig
arm                       mainstone_defconfig
mips                           ip27_defconfig
powerpc                     powernv_defconfig
powerpc                        fsp2_defconfig
arm                        realview_defconfig
sh                          sdk7786_defconfig
powerpc                     tqm8555_defconfig
powerpc                     tqm8560_defconfig
arm                         orion5x_defconfig
mips                             allyesconfig
powerpc                      mgcoge_defconfig
mips                           mtx1_defconfig
m68k                             allmodconfig
arm                      tct_hammer_defconfig
c6x                         dsk6455_defconfig
csky                             alldefconfig
sparc64                             defconfig
arm                           viper_defconfig
arm                         axm55xx_defconfig
arm                         lpc18xx_defconfig
arm                          moxart_defconfig
arm                           u8500_defconfig
m68k                            mac_defconfig
arm                              alldefconfig
arc                      axs103_smp_defconfig
mips                        qi_lb60_defconfig
mips                          ath79_defconfig
sh                         ecovec24_defconfig
m68k                          hp300_defconfig
arm                          gemini_defconfig
mips                        bcm47xx_defconfig
xtensa                       common_defconfig
arm                        neponset_defconfig
sh                      rts7751r2d1_defconfig
mips                     cu1830-neo_defconfig
mips                            gpr_defconfig
powerpc                        icon_defconfig
sh                           se7721_defconfig
mips                          rb532_defconfig
h8300                    h8300h-sim_defconfig
arc                          axs103_defconfig
arm                            zeus_defconfig
arm                        clps711x_defconfig
sh                         ap325rxa_defconfig
mips                     cu1000-neo_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                         ps3_defconfig
powerpc                   bluestone_defconfig
sh                         microdev_defconfig
powerpc                      ppc40x_defconfig
arm                          iop32x_defconfig
mips                      loongson3_defconfig
powerpc                     stx_gp3_defconfig
arc                     nsimosci_hs_defconfig
mips                      bmips_stb_defconfig
powerpc                   lite5200b_defconfig
sh                        apsh4ad0a_defconfig
s390                             alldefconfig
arm                           sunxi_defconfig
s390                          debug_defconfig
sh                          landisk_defconfig
sh                            titan_defconfig
arm                        oxnas_v6_defconfig
mips                        workpad_defconfig
powerpc                     ppa8548_defconfig
mips                         cobalt_defconfig
microblaze                    nommu_defconfig
csky                                defconfig
mips                         mpc30x_defconfig
riscv                               defconfig
powerpc                     skiroot_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
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
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201117
i386                 randconfig-a005-20201117
i386                 randconfig-a001-20201117
i386                 randconfig-a002-20201117
i386                 randconfig-a004-20201117
i386                 randconfig-a003-20201117
i386                 randconfig-a006-20201116
i386                 randconfig-a005-20201116
i386                 randconfig-a001-20201116
i386                 randconfig-a002-20201116
i386                 randconfig-a004-20201116
i386                 randconfig-a003-20201116
x86_64               randconfig-a015-20201115
x86_64               randconfig-a011-20201115
x86_64               randconfig-a014-20201115
x86_64               randconfig-a013-20201115
x86_64               randconfig-a016-20201115
x86_64               randconfig-a012-20201115
x86_64               randconfig-a003-20201116
x86_64               randconfig-a005-20201116
x86_64               randconfig-a004-20201116
x86_64               randconfig-a002-20201116
x86_64               randconfig-a001-20201116
x86_64               randconfig-a006-20201116
i386                 randconfig-a012-20201116
i386                 randconfig-a014-20201116
i386                 randconfig-a016-20201116
i386                 randconfig-a011-20201116
i386                 randconfig-a015-20201116
i386                 randconfig-a013-20201116
i386                 randconfig-a012-20201117
i386                 randconfig-a014-20201117
i386                 randconfig-a016-20201117
i386                 randconfig-a011-20201117
i386                 randconfig-a015-20201117
i386                 randconfig-a013-20201117
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20201117
x86_64               randconfig-a005-20201117
x86_64               randconfig-a004-20201117
x86_64               randconfig-a002-20201117
x86_64               randconfig-a001-20201117
x86_64               randconfig-a006-20201117
x86_64               randconfig-a015-20201116
x86_64               randconfig-a011-20201116
x86_64               randconfig-a014-20201116
x86_64               randconfig-a013-20201116
x86_64               randconfig-a016-20201116
x86_64               randconfig-a012-20201116

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
