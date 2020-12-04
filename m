Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC082CF3AA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 19:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbgLDSJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 13:09:50 -0500
Received: from mga09.intel.com ([134.134.136.24]:54155 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728712AbgLDSJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 13:09:50 -0500
IronPort-SDR: bUZ/Tw7Bd5Q/XUU01sJr4UGUyX9Z4k8jP/8LvelEp4w/DSjrenGDfOT8G+zrfQ8lCO3T++QOII
 uol50ZPZKJSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9825"; a="173571522"
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; 
   d="scan'208";a="173571522"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 10:09:08 -0800
IronPort-SDR: bF2Q0m2vvf9MIP0Po5otKQu9A8lWEKPi6CFsYvenuAOYi9bNK7uEMMSrK/ndxM3nDUz8d9ixWU
 tfSTxRSQJIsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; 
   d="scan'208";a="373990121"
Received: from lkp-server02.sh.intel.com (HELO f74a175f0d75) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 04 Dec 2020 10:09:07 -0800
Received: from kbuild by f74a175f0d75 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1klFVy-0000HQ-Jh; Fri, 04 Dec 2020 18:09:06 +0000
Date:   Sat, 05 Dec 2020 02:08:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 fef92cd2bc04c64bb3743d40c0b4be47aedf9e23
Message-ID: <5fca7b16.QbOKLdW/RfCztrM9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  timers/core
branch HEAD: fef92cd2bc04c64bb3743d40c0b4be47aedf9e23  Merge tag 'timers-v5.11' of https://git.linaro.org/people/daniel.lezcano/linux into timers/core

elapsed time: 726m

configs tested: 154
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      tqm8xx_defconfig
h8300                       h8s-sim_defconfig
mips                      fuloong2e_defconfig
ia64                          tiger_defconfig
mips                           mtx1_defconfig
mips                        qi_lb60_defconfig
arm                           omap1_defconfig
arm                           h5000_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                           se7724_defconfig
riscv                            allyesconfig
powerpc                     tqm8548_defconfig
arc                        nsimosci_defconfig
powerpc                  mpc866_ads_defconfig
m68k                          atari_defconfig
mips                      bmips_stb_defconfig
powerpc                     skiroot_defconfig
mips                         tb0219_defconfig
m68k                       m5475evb_defconfig
powerpc                     ep8248e_defconfig
powerpc                     mpc512x_defconfig
arm                         orion5x_defconfig
powerpc                    socrates_defconfig
um                             i386_defconfig
powerpc                      ppc64e_defconfig
powerpc                       eiger_defconfig
arm                         axm55xx_defconfig
mips                     loongson1c_defconfig
arm                     am200epdkit_defconfig
powerpc                   currituck_defconfig
nios2                               defconfig
xtensa                generic_kc705_defconfig
sh                        edosk7760_defconfig
arm                        mini2440_defconfig
alpha                               defconfig
arm                  colibri_pxa300_defconfig
powerpc                      chrp32_defconfig
sh                          urquell_defconfig
arm                       netwinder_defconfig
mips                            gpr_defconfig
sh                          rsk7264_defconfig
arm                         bcm2835_defconfig
arm                            pleb_defconfig
powerpc                     kilauea_defconfig
arc                          axs103_defconfig
arm                            zeus_defconfig
arm                             pxa_defconfig
mips                        workpad_defconfig
mips                          ath25_defconfig
arm                           sunxi_defconfig
nds32                            alldefconfig
powerpc                        fsp2_defconfig
arm                          ep93xx_defconfig
xtensa                  audio_kc705_defconfig
sh                            hp6xx_defconfig
arm                         shannon_defconfig
mips                     decstation_defconfig
arm                             ezx_defconfig
arm                         assabet_defconfig
sh                        sh7757lcr_defconfig
sh                        edosk7705_defconfig
arm                    vt8500_v6_v7_defconfig
arm                        keystone_defconfig
sh                           se7343_defconfig
powerpc                     tqm8540_defconfig
parisc                              defconfig
arm                           corgi_defconfig
arm                        vexpress_defconfig
sh                   rts7751r2dplus_defconfig
m68k                            q40_defconfig
mips                           jazz_defconfig
sparc64                             defconfig
powerpc                    adder875_defconfig
m68k                       m5249evb_defconfig
arm                         mv78xx0_defconfig
powerpc                     mpc83xx_defconfig
sh                           se7619_defconfig
mips                         db1xxx_defconfig
powerpc                   lite5200b_defconfig
arm                         s3c2410_defconfig
powerpc64                        alldefconfig
mips                       lemote2f_defconfig
sh                     magicpanelr2_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
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
x86_64               randconfig-a004-20201204
x86_64               randconfig-a006-20201204
x86_64               randconfig-a002-20201204
x86_64               randconfig-a001-20201204
x86_64               randconfig-a005-20201204
x86_64               randconfig-a003-20201204
i386                 randconfig-a005-20201204
i386                 randconfig-a004-20201204
i386                 randconfig-a001-20201204
i386                 randconfig-a002-20201204
i386                 randconfig-a006-20201204
i386                 randconfig-a003-20201204
i386                 randconfig-a014-20201204
i386                 randconfig-a013-20201204
i386                 randconfig-a011-20201204
i386                 randconfig-a015-20201204
i386                 randconfig-a012-20201204
i386                 randconfig-a016-20201204
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
x86_64               randconfig-a016-20201204
x86_64               randconfig-a012-20201204
x86_64               randconfig-a014-20201204
x86_64               randconfig-a013-20201204
x86_64               randconfig-a015-20201204
x86_64               randconfig-a011-20201204

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
