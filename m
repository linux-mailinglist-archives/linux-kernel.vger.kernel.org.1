Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91EFF28A624
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 09:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgJKHcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 03:32:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:26901 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgJKHcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 03:32:15 -0400
IronPort-SDR: R9LCJUXMh3bScrxclMaIm3arzKRscWa1AJStQfO8Q5P2MNTvXO01bwYO1QNnc9uJQ1lpEZJ2m9
 tnJD01mEfMzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9770"; a="144949470"
X-IronPort-AV: E=Sophos;i="5.77,362,1596524400"; 
   d="scan'208";a="144949470"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 00:32:14 -0700
IronPort-SDR: UalNmMuD9P9X6cEG3PmnhPaDA466463KrE117OCip7abGlSAJeVcfJT1hF5Fdc2AJpGqTtPMtw
 Bq9s5qbRezyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,362,1596524400"; 
   d="scan'208";a="298948776"
Received: from lkp-server02.sh.intel.com (HELO 92b3fbfaed90) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 11 Oct 2020 00:32:14 -0700
Received: from kbuild by 92b3fbfaed90 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kRVq1-0000V5-Fg; Sun, 11 Oct 2020 07:32:13 +0000
Date:   Sun, 11 Oct 2020 15:31:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 75c79a5dd72c1bb59f6bd6c5ec36f3a6516795cd
Message-ID: <5f82b4c1.NQvl8fAEPBBHBWfJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: 75c79a5dd72c1bb59f6bd6c5ec36f3a6516795cd  rcutorture: Don't do need_resched() testing if ->sync is NULL

elapsed time: 721m

configs tested: 102
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                   motionpro_defconfig
sh                               alldefconfig
powerpc                    klondike_defconfig
mips                           jazz_defconfig
mips                            gpr_defconfig
arm                        oxnas_v6_defconfig
m68k                          sun3x_defconfig
m68k                         amcore_defconfig
arm                          ep93xx_defconfig
sh                           se7780_defconfig
x86_64                              defconfig
sh                          urquell_defconfig
m68k                          atari_defconfig
arm                          exynos_defconfig
powerpc                     mpc83xx_defconfig
arm                           tegra_defconfig
arm                  colibri_pxa300_defconfig
powerpc                     tqm8541_defconfig
xtensa                         virt_defconfig
powerpc                          g5_defconfig
powerpc                   currituck_defconfig
mips                        nlm_xlp_defconfig
arm                     am200epdkit_defconfig
mips                          ath25_defconfig
mips                        bcm63xx_defconfig
sh                      rts7751r2d1_defconfig
sh                          rsk7269_defconfig
arm                         assabet_defconfig
powerpc                     kilauea_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
x86_64               randconfig-a004-20201011
x86_64               randconfig-a002-20201011
x86_64               randconfig-a006-20201011
x86_64               randconfig-a001-20201011
x86_64               randconfig-a003-20201011
x86_64               randconfig-a005-20201011
i386                 randconfig-a005-20201011
i386                 randconfig-a006-20201011
i386                 randconfig-a001-20201011
i386                 randconfig-a003-20201011
i386                 randconfig-a004-20201011
i386                 randconfig-a002-20201011
i386                 randconfig-a016-20201011
i386                 randconfig-a015-20201011
i386                 randconfig-a013-20201011
i386                 randconfig-a012-20201011
i386                 randconfig-a011-20201011
i386                 randconfig-a014-20201011
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
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a016-20201011
x86_64               randconfig-a015-20201011
x86_64               randconfig-a012-20201011
x86_64               randconfig-a013-20201011
x86_64               randconfig-a014-20201011
x86_64               randconfig-a011-20201011

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
