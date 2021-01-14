Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD6B2F6F1F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 00:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731101AbhANXtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 18:49:16 -0500
Received: from mga09.intel.com ([134.134.136.24]:18287 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731066AbhANXtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 18:49:11 -0500
IronPort-SDR: wpDretEZVubvyrCBznOo5RYu+gYKrGvjJfd47EnFxxyWPt2HelJRojTl8aCHtYv/MhePZXzLOZ
 7AUlG3OnrBvA==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="178614797"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="178614797"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 15:48:30 -0800
IronPort-SDR: hn8Es19QOiOtMmc3rG33zyFcR/gXzfMH5MjkmDkdJs8tGuB6PKr2ZQJStnUPjo32u1zQh0B1yl
 7eh5f6Ehu+SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="352646326"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Jan 2021 15:48:28 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l0CLs-00000t-5N; Thu, 14 Jan 2021 23:48:28 +0000
Date:   Fri, 15 Jan 2021 07:48:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 7e923e6a3ceb877497dd9ee70d71fa33b94f332b
Message-ID: <6000d848.FO685ZH0umJ9dFik%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  locking/core
branch HEAD: 7e923e6a3ceb877497dd9ee70d71fa33b94f332b  locking/selftests: Add local_lock inversion tests

elapsed time: 772m

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
powerpc                 mpc836x_rdk_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                        mvebu_v7_defconfig
mips                        bcm47xx_defconfig
sh                          rsk7201_defconfig
powerpc                      tqm8xx_defconfig
powerpc                      katmai_defconfig
powerpc                       eiger_defconfig
arc                              alldefconfig
m68k                        mvme147_defconfig
um                            kunit_defconfig
arm                            zeus_defconfig
mips                        workpad_defconfig
arm                     eseries_pxa_defconfig
mips                     cu1000-neo_defconfig
mips                         mpc30x_defconfig
mips                      maltasmvp_defconfig
arm                           corgi_defconfig
arm                       aspeed_g5_defconfig
arm                        mvebu_v5_defconfig
arm                         assabet_defconfig
arm                        multi_v7_defconfig
arm64                            alldefconfig
powerpc                     pseries_defconfig
mips                        nlm_xlp_defconfig
arm                         cm_x300_defconfig
sh                           se7750_defconfig
sh                           se7206_defconfig
powerpc                     tqm8555_defconfig
arm                         lpc32xx_defconfig
sh                           se7722_defconfig
mips                        maltaup_defconfig
csky                             alldefconfig
arm                          iop32x_defconfig
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
i386                 randconfig-a002-20210114
i386                 randconfig-a005-20210114
i386                 randconfig-a006-20210114
i386                 randconfig-a001-20210114
i386                 randconfig-a003-20210114
i386                 randconfig-a004-20210114
x86_64               randconfig-a015-20210114
x86_64               randconfig-a012-20210114
x86_64               randconfig-a013-20210114
x86_64               randconfig-a016-20210114
x86_64               randconfig-a014-20210114
x86_64               randconfig-a011-20210114
i386                 randconfig-a012-20210114
i386                 randconfig-a011-20210114
i386                 randconfig-a016-20210114
i386                 randconfig-a015-20210114
i386                 randconfig-a013-20210114
i386                 randconfig-a014-20210114
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
x86_64               randconfig-a004-20210114
x86_64               randconfig-a006-20210114
x86_64               randconfig-a001-20210114
x86_64               randconfig-a003-20210114
x86_64               randconfig-a005-20210114
x86_64               randconfig-a002-20210114

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
