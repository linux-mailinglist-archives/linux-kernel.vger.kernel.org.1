Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137822E7C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 21:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgL3UNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 15:13:50 -0500
Received: from mga09.intel.com ([134.134.136.24]:48736 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgL3UNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 15:13:50 -0500
IronPort-SDR: UIRHT8VO34YFsfRdVaoU99hNWwY3mI1I1NoY8cfo0T73plB1HKvFjBZATN9jLFoH7YWLEENrAv
 5LEoWyHCc4iw==
X-IronPort-AV: E=McAfee;i="6000,8403,9850"; a="176792379"
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; 
   d="scan'208";a="176792379"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2020 12:13:08 -0800
IronPort-SDR: ySILRMf0V23YGIB14jogy/l9U3Qx8cniJUUcVP9czBmim6/mAgB2q3eCBGPsi+rO5jaD2zyidR
 Rvdq/kvCZK5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; 
   d="scan'208";a="359319564"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 30 Dec 2020 12:13:06 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kuhqE-0004UG-9u; Wed, 30 Dec 2020 20:13:06 +0000
Date:   Thu, 31 Dec 2020 04:12:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 3052636aa9aa2492ccac973449be63cae5b93a67
Message-ID: <5fecdf31.BMoFvsn+vWIjKjK5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cleanups
branch HEAD: 3052636aa9aa2492ccac973449be63cae5b93a67  x86/mtrr: Convert comma to semicolon

elapsed time: 725m

configs tested: 125
configs skipped: 31

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc834x_itx_defconfig
arm                          gemini_defconfig
arm                         bcm2835_defconfig
mips                         bigsur_defconfig
powerpc                      cm5200_defconfig
powerpc                  mpc885_ads_defconfig
riscv                            allyesconfig
arc                        nsim_700_defconfig
riscv                               defconfig
arm                     davinci_all_defconfig
arm                           corgi_defconfig
arm                        mvebu_v5_defconfig
arm                            u300_defconfig
mips                      maltasmvp_defconfig
sh                          polaris_defconfig
sh                             sh03_defconfig
arc                            hsdk_defconfig
powerpc                  storcenter_defconfig
sh                          lboxre2_defconfig
sh                           se7722_defconfig
x86_64                           alldefconfig
powerpc                     ksi8560_defconfig
arm                        trizeps4_defconfig
h8300                       h8s-sim_defconfig
mips                      fuloong2e_defconfig
powerpc                    mvme5100_defconfig
mips                          malta_defconfig
mips                     loongson1b_defconfig
mips                     loongson1c_defconfig
m68k                           sun3_defconfig
mips                           ip22_defconfig
powerpc                      ppc44x_defconfig
arm                          exynos_defconfig
powerpc                     tqm8548_defconfig
arm                         lpc18xx_defconfig
sh                         microdev_defconfig
arm                         s5pv210_defconfig
mips                         tb0226_defconfig
arm                          pxa910_defconfig
c6x                        evmc6474_defconfig
arm                        shmobile_defconfig
powerpc                    socrates_defconfig
mips                        qi_lb60_defconfig
sparc                       sparc32_defconfig
arc                     nsimosci_hs_defconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                                defconfig
parisc                           allyesconfig
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
i386                 randconfig-a005-20201230
i386                 randconfig-a006-20201230
i386                 randconfig-a004-20201230
i386                 randconfig-a003-20201230
i386                 randconfig-a002-20201230
i386                 randconfig-a001-20201230
i386                 randconfig-a016-20201230
i386                 randconfig-a014-20201230
i386                 randconfig-a012-20201230
i386                 randconfig-a015-20201230
i386                 randconfig-a011-20201230
i386                 randconfig-a013-20201230
x86_64               randconfig-a005-20201230
x86_64               randconfig-a001-20201230
x86_64               randconfig-a006-20201230
x86_64               randconfig-a002-20201230
x86_64               randconfig-a004-20201230
x86_64               randconfig-a003-20201230
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20201230
x86_64               randconfig-a014-20201230
x86_64               randconfig-a016-20201230
x86_64               randconfig-a011-20201230
x86_64               randconfig-a013-20201230
x86_64               randconfig-a012-20201230
x86_64               randconfig-a014-20201229
x86_64               randconfig-a015-20201229
x86_64               randconfig-a016-20201229
x86_64               randconfig-a012-20201229
x86_64               randconfig-a011-20201229
x86_64               randconfig-a013-20201229

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
