Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19052820D7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 05:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgJCD40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 23:56:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:54216 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgJCD40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 23:56:26 -0400
IronPort-SDR: S+60jI/ZJ7SYTtxXmUKyeqANPdp0nH2EgdjsKWPIcTnjwFY5YN8dIQm0U6krBF60y8aS7xaJH4
 KXG6Bt8Z26Iw==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="150765309"
X-IronPort-AV: E=Sophos;i="5.77,330,1596524400"; 
   d="scan'208";a="150765309"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 20:56:22 -0700
IronPort-SDR: 75ldbE70ZcuTzpmkVexF8EZreumCIEVcT6hDdV99e7Sj0urA8wNCKbhU66pwAfhMy8QdLM5+CV
 Gf8vLr+pfwyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,330,1596524400"; 
   d="scan'208";a="295543127"
Received: from lkp-server02.sh.intel.com (HELO 404f47266ee4) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 02 Oct 2020 20:56:21 -0700
Received: from kbuild by 404f47266ee4 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kOYei-0000Ej-Pp; Sat, 03 Oct 2020 03:56:20 +0000
Date:   Sat, 03 Oct 2020 11:55:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 1b80043ed21894eca888157145b955df02887995
Message-ID: <5f77f64a.KQY7kM+4BjRI+a7D%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  timers/core
branch HEAD: 1b80043ed21894eca888157145b955df02887995  clocksource/drivers/armada-370-xp: Use semicolons rather than commas to separate statements

elapsed time: 723m

configs tested: 163
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                          moxart_defconfig
mips                           ip32_defconfig
arm                       spear13xx_defconfig
arm                       imx_v4_v5_defconfig
powerpc                    klondike_defconfig
mips                          malta_defconfig
arc                        nsim_700_defconfig
arm                          badge4_defconfig
sh                        sh7763rdp_defconfig
powerpc                      ppc44x_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      ppc6xx_defconfig
csky                                defconfig
arm                         s3c2410_defconfig
arm                           viper_defconfig
arm                         lpc18xx_defconfig
powerpc                      ep88xc_defconfig
powerpc                      ppc64e_defconfig
arm                   milbeaut_m10v_defconfig
arm                          ep93xx_defconfig
arm                         palmz72_defconfig
m68k                       m5475evb_defconfig
sh                   secureedge5410_defconfig
arm                           tegra_defconfig
sh                           se7619_defconfig
mips                       lemote2f_defconfig
mips                 decstation_r4k_defconfig
powerpc                 mpc8540_ads_defconfig
mips                     decstation_defconfig
arm64                            alldefconfig
arm                         lpc32xx_defconfig
arm                         assabet_defconfig
arm                            zeus_defconfig
powerpc                     tqm8555_defconfig
sh                           se7343_defconfig
powerpc                        cell_defconfig
m68k                        stmark2_defconfig
arm                         axm55xx_defconfig
powerpc                     tqm5200_defconfig
mips                     loongson1b_defconfig
sh                          sdk7786_defconfig
arm                     am200epdkit_defconfig
arm                            lart_defconfig
mips                           jazz_defconfig
c6x                         dsk6455_defconfig
arm                        mini2440_defconfig
c6x                        evmc6474_defconfig
arm                          imote2_defconfig
sh                           se7750_defconfig
powerpc                      mgcoge_defconfig
powerpc                       ebony_defconfig
arm                            xcep_defconfig
ia64                            zx1_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                         ebsa110_defconfig
m68k                        m5272c3_defconfig
um                            kunit_defconfig
arc                        nsimosci_defconfig
arm                       omap2plus_defconfig
powerpc                 mpc832x_mds_defconfig
sparc64                          alldefconfig
mips                      pistachio_defconfig
arm                        oxnas_v6_defconfig
mips                        bcm63xx_defconfig
powerpc                     tqm8541_defconfig
m68k                             alldefconfig
arm                            mmp2_defconfig
mips                            gpr_defconfig
arm                        spear6xx_defconfig
powerpc                          g5_defconfig
mips                         mpc30x_defconfig
arm                  colibri_pxa270_defconfig
m68k                           sun3_defconfig
sh                          lboxre2_defconfig
mips                  cavium_octeon_defconfig
s390                          debug_defconfig
sh                           se7751_defconfig
arm                        mvebu_v7_defconfig
arm                        vexpress_defconfig
mips                            ar7_defconfig
arm                            dove_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     mpc512x_defconfig
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
x86_64               randconfig-a004-20201002
x86_64               randconfig-a001-20201002
x86_64               randconfig-a002-20201002
x86_64               randconfig-a005-20201002
x86_64               randconfig-a003-20201002
x86_64               randconfig-a006-20201002
i386                 randconfig-a006-20201002
i386                 randconfig-a005-20201002
i386                 randconfig-a001-20201002
i386                 randconfig-a004-20201002
i386                 randconfig-a003-20201002
i386                 randconfig-a002-20201002
i386                 randconfig-a006-20201003
i386                 randconfig-a005-20201003
i386                 randconfig-a001-20201003
i386                 randconfig-a004-20201003
i386                 randconfig-a003-20201003
i386                 randconfig-a002-20201003
i386                 randconfig-a014-20201002
i386                 randconfig-a013-20201002
i386                 randconfig-a015-20201002
i386                 randconfig-a016-20201002
i386                 randconfig-a011-20201002
i386                 randconfig-a012-20201002
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
x86_64               randconfig-a012-20201002
x86_64               randconfig-a015-20201002
x86_64               randconfig-a014-20201002
x86_64               randconfig-a013-20201002
x86_64               randconfig-a011-20201002
x86_64               randconfig-a016-20201002

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
