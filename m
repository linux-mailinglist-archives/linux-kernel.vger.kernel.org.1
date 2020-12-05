Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D042CFB0B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 11:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgLEKqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 05:46:43 -0500
Received: from mga11.intel.com ([192.55.52.93]:4042 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729090AbgLEKmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 05:42:10 -0500
IronPort-SDR: 6rP+u8d4duaRYGN1WkTvmEm2WydZDUvrk1jiSkbs2O9aZXjzh+l6fC08jgGoTb9veIpBGqqdQa
 Nb4NUZC8Tf0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9825"; a="169996210"
X-IronPort-AV: E=Sophos;i="5.78,395,1599548400"; 
   d="scan'208";a="169996210"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2020 02:40:42 -0800
IronPort-SDR: S9Nz+dBtTfm9Gniz5AybPVVt7EPUc0dqYSBQMeQVXJNkg/K7ZlVWALFdIu1XS+q+MKJXmHIQKM
 eqO3jEfqSFpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,395,1599548400"; 
   d="scan'208";a="406501347"
Received: from lkp-server01.sh.intel.com (HELO 47754f1311fc) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 05 Dec 2020 02:40:41 -0800
Received: from kbuild by 47754f1311fc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1klUzY-0000GK-UZ; Sat, 05 Dec 2020 10:40:40 +0000
Date:   Sat, 05 Dec 2020 18:40:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/mm] BUILD SUCCESS
 68061c02bb295da4955f0d309b9459f0a7ba83dd
Message-ID: <5fcb6397.G7JOow53yeTqM5Ld%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  core/mm
branch HEAD: 68061c02bb295da4955f0d309b9459f0a7ba83dd  ARM: highmem: Fix cache_is_vivt() reference

elapsed time: 724m

configs tested: 116
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                            alldefconfig
arc                        vdk_hs38_defconfig
powerpc                      cm5200_defconfig
arm                          tango4_defconfig
mips                 decstation_r4k_defconfig
powerpc                     tqm8555_defconfig
sh                           se7721_defconfig
powerpc                      ep88xc_defconfig
arm                         bcm2835_defconfig
powerpc                      acadia_defconfig
arm                         assabet_defconfig
powerpc                     skiroot_defconfig
powerpc                   motionpro_defconfig
mips                           jazz_defconfig
powerpc                        cell_defconfig
ia64                             alldefconfig
nds32                               defconfig
powerpc                     tqm5200_defconfig
arc                         haps_hs_defconfig
arm                           spitz_defconfig
arm                          exynos_defconfig
arm                          pxa3xx_defconfig
openrisc                         alldefconfig
powerpc                      mgcoge_defconfig
arm                         s3c2410_defconfig
openrisc                    or1ksim_defconfig
arm                         at91_dt_defconfig
powerpc                       ebony_defconfig
mips                         tb0226_defconfig
arm                           sama5_defconfig
powerpc                 mpc8560_ads_defconfig
ia64                        generic_defconfig
arm                           omap1_defconfig
arm                        mini2440_defconfig
s390                                defconfig
m68k                            q40_defconfig
sparc64                             defconfig
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
i386                 randconfig-a005-20201205
i386                 randconfig-a004-20201205
i386                 randconfig-a001-20201205
i386                 randconfig-a002-20201205
i386                 randconfig-a006-20201205
i386                 randconfig-a003-20201205
i386                 randconfig-a014-20201204
i386                 randconfig-a013-20201204
i386                 randconfig-a011-20201204
i386                 randconfig-a015-20201204
i386                 randconfig-a012-20201204
i386                 randconfig-a016-20201204
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
x86_64               randconfig-a016-20201204
x86_64               randconfig-a012-20201204
x86_64               randconfig-a014-20201204
x86_64               randconfig-a013-20201204
x86_64               randconfig-a015-20201204
x86_64               randconfig-a011-20201204

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
