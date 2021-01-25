Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCC7302611
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 15:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbhAYOD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 09:03:56 -0500
Received: from mga09.intel.com ([134.134.136.24]:64533 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729192AbhAYOAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:00:01 -0500
IronPort-SDR: k6KD8fCgv/QgWm5s0WgIgU9S2hi/UNWqUmpgDczFta4jLZ8K4dBcRr3dnka5OAeHzsVtsZ5+W4
 DyiMtWc3UAmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="179875209"
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; 
   d="scan'208";a="179875209"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 05:58:25 -0800
IronPort-SDR: RPOGy6mxQTQt4HRnf6xsTWetw250rDz5bANkE5fC6RoSHdOzk51z5UEXNEqoO+gizQ8bz6Kqz2
 5wWUZQKUmCYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; 
   d="scan'208";a="406246136"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jan 2021 05:58:24 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l42Nr-000098-DJ; Mon, 25 Jan 2021 13:58:23 +0000
Date:   Mon, 25 Jan 2021 21:58:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 22840ddac02152c3853c9a59dada585fc85be3c9
Message-ID: <600ece69.P19aU1/jzWWyQ4FW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 22840ddac02152c3853c9a59dada585fc85be3c9  Merge branch 'linus'

elapsed time: 721m

configs tested: 124
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                         3c120_defconfig
sh                          rsk7264_defconfig
mips                           jazz_defconfig
powerpc                   currituck_defconfig
powerpc                      ppc44x_defconfig
h8300                     edosk2674_defconfig
arm                         axm55xx_defconfig
c6x                                 defconfig
powerpc                 mpc832x_mds_defconfig
arm                  colibri_pxa300_defconfig
ia64                          tiger_defconfig
arm                         lpc32xx_defconfig
h8300                    h8300h-sim_defconfig
s390                       zfcpdump_defconfig
arm                        spear6xx_defconfig
x86_64                           alldefconfig
powerpc                     ksi8560_defconfig
arc                     nsimosci_hs_defconfig
mips                         tb0287_defconfig
sh                      rts7751r2d1_defconfig
mips                         tb0219_defconfig
mips                           ip27_defconfig
m68k                         apollo_defconfig
arc                        nsimosci_defconfig
sh                               j2_defconfig
sh                   sh7770_generic_defconfig
sh                         ecovec24_defconfig
nios2                            allyesconfig
powerpc                      mgcoge_defconfig
powerpc                     ep8248e_defconfig
sh                        sh7763rdp_defconfig
arm                        mini2440_defconfig
arm                            mps2_defconfig
sh                        sh7757lcr_defconfig
um                           x86_64_defconfig
sh                           se7712_defconfig
sparc                       sparc32_defconfig
arm                          ixp4xx_defconfig
arm                         hackkit_defconfig
m68k                       m5475evb_defconfig
c6x                        evmc6678_defconfig
powerpc                     tqm8560_defconfig
xtensa                  nommu_kc705_defconfig
mips                  cavium_octeon_defconfig
mips                           ip28_defconfig
arm                     eseries_pxa_defconfig
powerpc                 linkstation_defconfig
powerpc64                        alldefconfig
xtensa                  cadence_csp_defconfig
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
i386                 randconfig-a001-20210125
i386                 randconfig-a002-20210125
i386                 randconfig-a004-20210125
i386                 randconfig-a006-20210125
i386                 randconfig-a005-20210125
i386                 randconfig-a003-20210125
i386                 randconfig-a013-20210125
i386                 randconfig-a011-20210125
i386                 randconfig-a012-20210125
i386                 randconfig-a015-20210125
i386                 randconfig-a014-20210125
i386                 randconfig-a016-20210125
x86_64               randconfig-a003-20210125
x86_64               randconfig-a002-20210125
x86_64               randconfig-a001-20210125
x86_64               randconfig-a005-20210125
x86_64               randconfig-a006-20210125
x86_64               randconfig-a004-20210125
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20210125
x86_64               randconfig-a016-20210125
x86_64               randconfig-a015-20210125
x86_64               randconfig-a011-20210125
x86_64               randconfig-a013-20210125
x86_64               randconfig-a014-20210125

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
