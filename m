Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D6B2A50CD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 21:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgKCUUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 15:20:19 -0500
Received: from mga09.intel.com ([134.134.136.24]:4526 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727688AbgKCUUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 15:20:19 -0500
IronPort-SDR: OuJhY0cPXQQW/CJKe4EW7Wnq70W8IIIU+gW8fNm8SyGM0LEljv96cL2Ea0zfkEfSru+XJW4QND
 hE+E8OfHZ7ag==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="169257288"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="169257288"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 12:20:18 -0800
IronPort-SDR: b5diCJNNbaxXaJzHswTs2pEj5Pjq4JUrAEj/555vRSl6QD+3nfJu/x3NvhcthQ/3fabwG41COh
 iYWLbE26thJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="320562243"
Received: from lkp-server02.sh.intel.com (HELO e61783667810) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 03 Nov 2020 12:20:16 -0800
Received: from kbuild by e61783667810 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ka2mt-0000V4-Vh; Tue, 03 Nov 2020 20:20:15 +0000
Date:   Wed, 04 Nov 2020 04:19:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/apic] BUILD SUCCESS
 af2abc92c5ddf5fc5a2036bc106c4d9a80a4d5f7
Message-ID: <5fa1bb6d.TOkMhMI2ArySvrV6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/apic
branch HEAD: af2abc92c5ddf5fc5a2036bc106c4d9a80a4d5f7  x86/hyperv: Enable 15-bit APIC ID if the hypervisor supports it

elapsed time: 722m

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
arm                       aspeed_g4_defconfig
sh                               alldefconfig
arm                         s3c6400_defconfig
powerpc                      cm5200_defconfig
arc                           tb10x_defconfig
m68k                         amcore_defconfig
sh                           sh2007_defconfig
powerpc                     skiroot_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                     kilauea_defconfig
mips                        nlm_xlp_defconfig
mips                  cavium_octeon_defconfig
mips                     loongson1b_defconfig
arm                           h3600_defconfig
powerpc                     sequoia_defconfig
sh                        sh7757lcr_defconfig
arm                        spear3xx_defconfig
arm                          moxart_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                       aspeed_g5_defconfig
mips                        jmr3927_defconfig
powerpc                  storcenter_defconfig
sh                            shmin_defconfig
mips                       rbtx49xx_defconfig
arm                          exynos_defconfig
arm                        neponset_defconfig
arm                        oxnas_v6_defconfig
arc                     nsimosci_hs_defconfig
powerpc                    sam440ep_defconfig
openrisc                         alldefconfig
sh                             espt_defconfig
arm                            xcep_defconfig
sh                          rsk7269_defconfig
powerpc                      obs600_defconfig
powerpc                mpc7448_hpc2_defconfig
ia64                             alldefconfig
m68k                          atari_defconfig
powerpc                     taishan_defconfig
arm                         palmz72_defconfig
powerpc                 mpc85xx_cds_defconfig
riscv                            alldefconfig
powerpc                      arches_defconfig
powerpc                    gamecube_defconfig
arm                          pxa3xx_defconfig
mips                     cu1830-neo_defconfig
mips                      bmips_stb_defconfig
powerpc                      katmai_defconfig
arm                           spitz_defconfig
powerpc                   currituck_defconfig
powerpc                     redwood_defconfig
arm                        shmobile_defconfig
arm                         lubbock_defconfig
arm                        vexpress_defconfig
powerpc                     mpc512x_defconfig
mips                          rm200_defconfig
powerpc                    mvme5100_defconfig
mips                             allmodconfig
powerpc                        cell_defconfig
arc                          axs103_defconfig
powerpc                    ge_imp3a_defconfig
sh                          rsk7264_defconfig
powerpc                     asp8347_defconfig
powerpc                        fsp2_defconfig
arm                          ep93xx_defconfig
powerpc                  iss476-smp_defconfig
nios2                            alldefconfig
arm                            mmp2_defconfig
xtensa                    smp_lx200_defconfig
arm                        cerfcube_defconfig
mips                      maltaaprp_defconfig
arm                          imote2_defconfig
arm                            zeus_defconfig
powerpc                      tqm8xx_defconfig
powerpc                      ep88xc_defconfig
mips                     cu1000-neo_defconfig
sh                         apsh4a3a_defconfig
powerpc                      acadia_defconfig
powerpc                     ppa8548_defconfig
nds32                               defconfig
arm                       spear13xx_defconfig
arm                          pxa168_defconfig
xtensa                  nommu_kc705_defconfig
mips                        qi_lb60_defconfig
arm                       versatile_defconfig
powerpc                 canyonlands_defconfig
arc                          axs101_defconfig
powerpc                   motionpro_defconfig
h8300                            alldefconfig
m68k                        stmark2_defconfig
sh                     magicpanelr2_defconfig
arm                         lpc18xx_defconfig
nds32                             allnoconfig
ia64                                defconfig
xtensa                           allyesconfig
nios2                         3c120_defconfig
m68k                       m5475evb_defconfig
sh                           se7751_defconfig
powerpc                          g5_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
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
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201103
x86_64               randconfig-a005-20201103
x86_64               randconfig-a003-20201103
x86_64               randconfig-a002-20201103
x86_64               randconfig-a006-20201103
x86_64               randconfig-a001-20201103
i386                 randconfig-a004-20201103
i386                 randconfig-a006-20201103
i386                 randconfig-a005-20201103
i386                 randconfig-a001-20201103
i386                 randconfig-a002-20201103
i386                 randconfig-a003-20201103
i386                 randconfig-a013-20201103
i386                 randconfig-a015-20201103
i386                 randconfig-a014-20201103
i386                 randconfig-a016-20201103
i386                 randconfig-a011-20201103
i386                 randconfig-a012-20201103
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
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20201103
x86_64               randconfig-a015-20201103
x86_64               randconfig-a011-20201103
x86_64               randconfig-a013-20201103
x86_64               randconfig-a014-20201103
x86_64               randconfig-a016-20201103

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
