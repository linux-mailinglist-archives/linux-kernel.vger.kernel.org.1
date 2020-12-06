Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877332D000B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 02:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgLFBSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 20:18:14 -0500
Received: from mga11.intel.com ([192.55.52.93]:11321 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgLFBSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 20:18:14 -0500
IronPort-SDR: sXTwg9HObXwGBemSUxikYDIpJD5CR5wMQv200zpKrVWJgMqIdz5M37iwiS5dpKbUgbLPsjNzDs
 SuQNEYbJnzvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9826"; a="170041387"
X-IronPort-AV: E=Sophos;i="5.78,396,1599548400"; 
   d="scan'208";a="170041387"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2020 17:17:31 -0800
IronPort-SDR: OAZG+eNtlxZfZKRy7t2mNyfCq3HR+vZfLXs9vw+oyhEouHLvejJdPzLlbwVkWmp0htLcnT5HX2
 ziqSarRxhN/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,396,1599548400"; 
   d="scan'208";a="366755888"
Received: from lkp-server01.sh.intel.com (HELO 47754f1311fc) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 05 Dec 2020 17:17:30 -0800
Received: from kbuild by 47754f1311fc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1klig6-0000Vz-2k; Sun, 06 Dec 2020 01:17:30 +0000
Date:   Sun, 06 Dec 2020 09:16:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 414b3bbad29bf609f6c5a37c6b96e8a371e3e10f
Message-ID: <5fcc30f5.8qr9TYYJq7qDIBy1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 414b3bbad29bf609f6c5a37c6b96e8a371e3e10f  Merge branch 'core/mm'

elapsed time: 723m

configs tested: 106
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                        shmobile_defconfig
um                           x86_64_defconfig
ia64                          tiger_defconfig
arm                         mv78xx0_defconfig
ia64                            zx1_defconfig
arm                         lpc18xx_defconfig
powerpc                     tqm5200_defconfig
mips                             allyesconfig
sh                            titan_defconfig
mips                         tb0226_defconfig
sh                 kfr2r09-romimage_defconfig
mips                       capcella_defconfig
x86_64                              defconfig
mips                       rbtx49xx_defconfig
arm                          ixp4xx_defconfig
mips                        bcm63xx_defconfig
nios2                            allyesconfig
parisc                generic-64bit_defconfig
powerpc                     sbc8548_defconfig
powerpc                     skiroot_defconfig
sh                          lboxre2_defconfig
powerpc                 mpc8272_ads_defconfig
sh                             espt_defconfig
arm                         vf610m4_defconfig
arm                        multi_v5_defconfig
arm                         nhk8815_defconfig
arm                           sama5_defconfig
powerpc                 mpc8560_ads_defconfig
ia64                        generic_defconfig
arm                           omap1_defconfig
arm                        mini2440_defconfig
s390                                defconfig
m68k                            q40_defconfig
mips                           jazz_defconfig
sparc64                             defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20201205
i386                 randconfig-a004-20201205
i386                 randconfig-a001-20201205
i386                 randconfig-a002-20201205
i386                 randconfig-a006-20201205
i386                 randconfig-a003-20201205
x86_64               randconfig-a016-20201205
x86_64               randconfig-a012-20201205
x86_64               randconfig-a014-20201205
x86_64               randconfig-a013-20201205
x86_64               randconfig-a015-20201205
x86_64               randconfig-a011-20201205
i386                 randconfig-a014-20201205
i386                 randconfig-a013-20201205
i386                 randconfig-a011-20201205
i386                 randconfig-a015-20201205
i386                 randconfig-a012-20201205
i386                 randconfig-a016-20201205
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
x86_64               randconfig-a004-20201205
x86_64               randconfig-a006-20201205
x86_64               randconfig-a002-20201205
x86_64               randconfig-a001-20201205
x86_64               randconfig-a005-20201205
x86_64               randconfig-a003-20201205

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
