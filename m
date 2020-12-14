Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7122D919F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 02:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437769AbgLNBqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 20:46:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:7890 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgLNBqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 20:46:53 -0500
IronPort-SDR: HEffXPGPj2y3d2V2xMmR0J9ZelLbnQ8FXlJrvkWflI++5yeadK29tmzjvhpCWAajtWyabWhbhn
 mmjKC/ecn9rg==
X-IronPort-AV: E=McAfee;i="6000,8403,9834"; a="153873908"
X-IronPort-AV: E=Sophos;i="5.78,417,1599548400"; 
   d="scan'208";a="153873908"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2020 17:46:11 -0800
IronPort-SDR: YWsLJ7zClpv/o4hUTEcUWofZ6xu3Z2XoDlQmvp4pq8O8BLsuj8I6m0PNraRSVTkR3TaTNN9j55
 UqIuPWghf6KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,417,1599548400"; 
   d="scan'208";a="410825542"
Received: from lkp-server02.sh.intel.com (HELO a947d92d0467) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 13 Dec 2020 17:46:09 -0800
Received: from kbuild by a947d92d0467 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kocwD-00004B-8m; Mon, 14 Dec 2020 01:46:09 +0000
Date:   Mon, 14 Dec 2020 09:45:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 68ae68af2ba73b2969f2ce617b09b25bcbd74dd8
Message-ID: <5fd6c3b7.p/Cnger+OK5Hihzw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 68ae68af2ba73b2969f2ce617b09b25bcbd74dd8  Merge branch 'timers/core'

elapsed time: 723m

configs tested: 110
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                          axs101_defconfig
sh                          urquell_defconfig
sh                        dreamcast_defconfig
sh                           se7206_defconfig
mips                     decstation_defconfig
arm                           omap1_defconfig
powerpc                       holly_defconfig
arc                           tb10x_defconfig
powerpc                         ps3_defconfig
i386                             alldefconfig
arm                       imx_v6_v7_defconfig
powerpc                      ppc40x_defconfig
arm                        oxnas_v6_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                   motionpro_defconfig
arm                        shmobile_defconfig
nds32                             allnoconfig
powerpc                      obs600_defconfig
sh                               j2_defconfig
arm                            u300_defconfig
mips                malta_kvm_guest_defconfig
c6x                        evmc6678_defconfig
mips                        bcm63xx_defconfig
h8300                       h8s-sim_defconfig
nios2                            allyesconfig
powerpc                mpc7448_hpc2_defconfig
mips                      loongson3_defconfig
microblaze                      mmu_defconfig
arm                     eseries_pxa_defconfig
m68k                        m5307c3_defconfig
powerpc                         wii_defconfig
sh                           se7780_defconfig
powerpc                       ebony_defconfig
sh                         apsh4a3a_defconfig
m68k                          sun3x_defconfig
m68k                       m5275evb_defconfig
xtensa                  audio_kc705_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
nds32                               defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20201213
x86_64               randconfig-a006-20201213
x86_64               randconfig-a002-20201213
x86_64               randconfig-a005-20201213
x86_64               randconfig-a004-20201213
x86_64               randconfig-a001-20201213
i386                 randconfig-a001-20201213
i386                 randconfig-a004-20201213
i386                 randconfig-a003-20201213
i386                 randconfig-a002-20201213
i386                 randconfig-a005-20201213
i386                 randconfig-a006-20201213
i386                 randconfig-a014-20201213
i386                 randconfig-a013-20201213
i386                 randconfig-a012-20201213
i386                 randconfig-a011-20201213
i386                 randconfig-a016-20201213
i386                 randconfig-a015-20201213
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
x86_64               randconfig-a016-20201213
x86_64               randconfig-a012-20201213
x86_64               randconfig-a013-20201213
x86_64               randconfig-a015-20201213
x86_64               randconfig-a014-20201213
x86_64               randconfig-a011-20201213

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
