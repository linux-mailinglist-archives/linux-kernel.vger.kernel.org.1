Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF652BA034
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 03:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgKTCLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 21:11:10 -0500
Received: from mga11.intel.com ([192.55.52.93]:33809 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgKTCLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 21:11:08 -0500
IronPort-SDR: 4zfvV37PqsKtHUjhfD/BiPa8DCKLxNn3spJX0P/xzg1rfLCdYV/FEh4BOSj4XS5k4NdZDLGK5t
 KiDU8WkjHDBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="167889440"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="167889440"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 18:11:08 -0800
IronPort-SDR: aXz2njaviLAcaIMWdmkepPqHtr9B/P5TTSm7OUVFw0fgr1R+1UJ+JHyyIJzqsoYgeHrfl6UGf0
 pVAFTC1W9wCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="341893898"
Received: from lkp-server01.sh.intel.com (HELO 1b817e3f8ad2) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 19 Nov 2020 18:11:06 -0800
Received: from kbuild by 1b817e3f8ad2 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kfvtB-0000Ho-SN; Fri, 20 Nov 2020 02:11:05 +0000
Date:   Fri, 20 Nov 2020 10:10:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 b023fd5f741f34d2cd90258ccc3f245924d2eadd
Message-ID: <5fb725a2.mLSzjUFhfG+1pSLr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/misc
branch HEAD: b023fd5f741f34d2cd90258ccc3f245924d2eadd  x86/msr: Downgrade unrecognized MSR message

elapsed time: 721m

configs tested: 149
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      ep88xc_defconfig
arm                     eseries_pxa_defconfig
mips                      fuloong2e_defconfig
arm                           spitz_defconfig
arm                          badge4_defconfig
powerpc                     mpc5200_defconfig
arm                     davinci_all_defconfig
arm                         hackkit_defconfig
sparc                       sparc64_defconfig
m68k                        mvme147_defconfig
xtensa                           alldefconfig
arm                         lpc18xx_defconfig
xtensa                  audio_kc705_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                           sh2007_defconfig
powerpc                      obs600_defconfig
m68k                          atari_defconfig
sh                           se7712_defconfig
arm                       multi_v4t_defconfig
mips                        omega2p_defconfig
mips                       bmips_be_defconfig
riscv                             allnoconfig
h8300                               defconfig
arm                          pxa910_defconfig
powerpc                     akebono_defconfig
arm                          moxart_defconfig
arc                        nsim_700_defconfig
mips                       capcella_defconfig
powerpc                     tqm8548_defconfig
powerpc                       maple_defconfig
powerpc                      bamboo_defconfig
arm                          ep93xx_defconfig
powerpc                     mpc83xx_defconfig
mips                     cu1830-neo_defconfig
arm                         bcm2835_defconfig
mips                          rm200_defconfig
powerpc                     rainier_defconfig
powerpc                     tqm8540_defconfig
arm                        trizeps4_defconfig
powerpc                     powernv_defconfig
m68k                          sun3x_defconfig
arm                          exynos_defconfig
mips                      pistachio_defconfig
mips                        nlm_xlp_defconfig
powerpc                        fsp2_defconfig
arm                         s5pv210_defconfig
arm                          tango4_defconfig
arm                              alldefconfig
arm                            zeus_defconfig
parisc                              defconfig
mips                     cu1000-neo_defconfig
arm                          pcm027_defconfig
arm                     am200epdkit_defconfig
sh                           se7721_defconfig
powerpc                 mpc836x_rdk_defconfig
h8300                     edosk2674_defconfig
powerpc                  storcenter_defconfig
mips                           ip27_defconfig
powerpc                    gamecube_defconfig
mips                      bmips_stb_defconfig
sh                            titan_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                           efm32_defconfig
nios2                         3c120_defconfig
m68k                           sun3_defconfig
arm                          lpd270_defconfig
arm                         cm_x300_defconfig
mips                     loongson1b_defconfig
powerpc                     asp8347_defconfig
powerpc                      katmai_defconfig
arm                        magician_defconfig
powerpc                  mpc866_ads_defconfig
s390                                defconfig
xtensa                    smp_lx200_defconfig
arm                         lpc32xx_defconfig
powerpc                 mpc837x_mds_defconfig
arc                         haps_hs_defconfig
powerpc                       eiger_defconfig
powerpc                           allnoconfig
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
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
s390                             allyesconfig
parisc                           allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a006-20201119
i386                 randconfig-a005-20201119
i386                 randconfig-a002-20201119
i386                 randconfig-a001-20201119
i386                 randconfig-a003-20201119
i386                 randconfig-a004-20201119
x86_64               randconfig-a015-20201119
x86_64               randconfig-a014-20201119
x86_64               randconfig-a011-20201119
x86_64               randconfig-a013-20201119
x86_64               randconfig-a016-20201119
x86_64               randconfig-a012-20201119
i386                 randconfig-a012-20201119
i386                 randconfig-a014-20201119
i386                 randconfig-a016-20201119
i386                 randconfig-a011-20201119
i386                 randconfig-a013-20201119
i386                 randconfig-a015-20201119
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-a005-20201119
x86_64               randconfig-a003-20201119
x86_64               randconfig-a004-20201119
x86_64               randconfig-a002-20201119
x86_64               randconfig-a006-20201119
x86_64               randconfig-a001-20201119

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
