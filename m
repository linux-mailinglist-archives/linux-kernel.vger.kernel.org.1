Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7852A5D1E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 04:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbgKDDcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 22:32:55 -0500
Received: from mga11.intel.com ([192.55.52.93]:28681 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728272AbgKDDcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 22:32:55 -0500
IronPort-SDR: 9TXWPoKmy4qYc1L1VofvyLmUdLWsriiCGjg6hLZPL2BdpW/KJIHbfGJ5wr7z1RN8a1IYFJgTmg
 JL4pn6uRSZyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="165653805"
X-IronPort-AV: E=Sophos;i="5.77,449,1596524400"; 
   d="scan'208";a="165653805"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 19:32:54 -0800
IronPort-SDR: WJAid9M5lNg8RsmG/wI6P9Cv3oS9itrmEf8z3t+pvdr69+tFFx1MULMNvK+q13o8tpc4pi5pAa
 tfu73i14izCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,449,1596524400"; 
   d="scan'208";a="353599354"
Received: from lkp-server02.sh.intel.com (HELO e61783667810) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 03 Nov 2020 19:32:53 -0800
Received: from kbuild by e61783667810 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ka9XY-0000d9-Ly; Wed, 04 Nov 2020 03:32:52 +0000
Date:   Wed, 04 Nov 2020 11:32:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 82768a86c64659c7181571ebfbc41ec9f2e52dde
Message-ID: <5fa220d7.voSk9nEGyTnIsvph%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  irq/urgent
branch HEAD: 82768a86c64659c7181571ebfbc41ec9f2e52dde  dt-bindings: irqchip: ti, sci-inta: Fix diagram indentation for unmapped events

elapsed time: 723m

configs tested: 149
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
arm                          moxart_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                       aspeed_g5_defconfig
mips                        jmr3927_defconfig
powerpc                  storcenter_defconfig
sh                            shmin_defconfig
powerpc                    sam440ep_defconfig
openrisc                         alldefconfig
sh                             espt_defconfig
arm                            xcep_defconfig
arm                            zeus_defconfig
powerpc                     tqm5200_defconfig
s390                          debug_defconfig
powerpc64                        alldefconfig
xtensa                  cadence_csp_defconfig
arm                          pxa3xx_defconfig
mips                     cu1830-neo_defconfig
mips                      bmips_stb_defconfig
powerpc                      katmai_defconfig
arm                           spitz_defconfig
powerpc                   currituck_defconfig
mips                          rm200_defconfig
powerpc                    mvme5100_defconfig
mips                             allmodconfig
powerpc                        cell_defconfig
arc                          axs103_defconfig
mips                           gcw0_defconfig
xtensa                    smp_lx200_defconfig
sparc64                             defconfig
powerpc                     tqm8555_defconfig
arm                           h5000_defconfig
arm                         orion5x_defconfig
parisc                generic-64bit_defconfig
sh                   secureedge5410_defconfig
arm                          simpad_defconfig
powerpc                      ppc44x_defconfig
m68k                          hp300_defconfig
powerpc                      walnut_defconfig
arm                         s5pv210_defconfig
arm                            dove_defconfig
mips                            e55_defconfig
openrisc                    or1ksim_defconfig
arm                      tct_hammer_defconfig
powerpc                      acadia_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                  mpc885_ads_defconfig
sh                           se7751_defconfig
sh                   sh7770_generic_defconfig
powerpc                     stx_gp3_defconfig
riscv                            allmodconfig
sh                           se7705_defconfig
sh                          r7780mp_defconfig
arm                       imx_v6_v7_defconfig
mips                            gpr_defconfig
sh                         ecovec24_defconfig
arm                        shmobile_defconfig
mips                        qi_lb60_defconfig
arm                       versatile_defconfig
powerpc                 canyonlands_defconfig
xtensa                    xip_kc705_defconfig
m68k                        mvme16x_defconfig
arc                              alldefconfig
powerpc                     kmeter1_defconfig
xtensa                           allyesconfig
nios2                         3c120_defconfig
m68k                       m5475evb_defconfig
powerpc                          g5_defconfig
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
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
sparc                            allyesconfig
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
