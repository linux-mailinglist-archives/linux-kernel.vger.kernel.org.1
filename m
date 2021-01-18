Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A452F9750
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 02:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbhARBW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 20:22:59 -0500
Received: from mga07.intel.com ([134.134.136.100]:26405 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728141AbhARBWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 20:22:55 -0500
IronPort-SDR: P1axrZ/eM7D67uGLN9OkEoh78sBTMCi3P4+c8CBCZvlBxFi5njbsH4/cxCpSdjQuAsA7GcztH/
 GBERORBbZhCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="242815550"
X-IronPort-AV: E=Sophos;i="5.79,355,1602572400"; 
   d="scan'208";a="242815550"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2021 17:22:11 -0800
IronPort-SDR: yzuZYPMti4i9phjL1qNMvyR7d+cvV3R5EFN0zWemezr+xKo5HjzQ8EEBXyIhwo8vvZNTzM1nFH
 8C5NCpAnWNnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,355,1602572400"; 
   d="scan'208";a="350067974"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 17 Jan 2021 17:22:10 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l1JFC-0003q9-0r; Mon, 18 Jan 2021 01:22:10 +0000
Date:   Mon, 18 Jan 2021 09:21:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 b360439c99c53a15c40953d3d09e735ae93542d2
Message-ID: <6004e29f.ZzljAASIKGnlS/oR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: b360439c99c53a15c40953d3d09e735ae93542d2  Merge branch 'x86/cleanups'

elapsed time: 724m

configs tested: 92
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                  cavium_octeon_defconfig
arm                           corgi_defconfig
sh                          rsk7269_defconfig
arm                            mmp2_defconfig
powerpc                     stx_gp3_defconfig
sh                         ecovec24_defconfig
h8300                            allyesconfig
powerpc                       holly_defconfig
arm                      integrator_defconfig
powerpc                  mpc885_ads_defconfig
sh                           se7751_defconfig
powerpc                          g5_defconfig
mips                 decstation_r4k_defconfig
powerpc                      ppc44x_defconfig
powerpc                 mpc8560_ads_defconfig
mips                       bmips_be_defconfig
sh                            hp6xx_defconfig
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
x86_64               randconfig-a006-20210117
x86_64               randconfig-a004-20210117
x86_64               randconfig-a001-20210117
x86_64               randconfig-a005-20210117
x86_64               randconfig-a003-20210117
x86_64               randconfig-a002-20210117
i386                 randconfig-a002-20210117
i386                 randconfig-a005-20210117
i386                 randconfig-a006-20210117
i386                 randconfig-a003-20210117
i386                 randconfig-a001-20210117
i386                 randconfig-a004-20210117
i386                 randconfig-a012-20210117
i386                 randconfig-a011-20210117
i386                 randconfig-a016-20210117
i386                 randconfig-a013-20210117
i386                 randconfig-a015-20210117
i386                 randconfig-a014-20210117
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
x86_64               randconfig-a015-20210117
x86_64               randconfig-a012-20210117
x86_64               randconfig-a013-20210117
x86_64               randconfig-a016-20210117
x86_64               randconfig-a014-20210117
x86_64               randconfig-a011-20210117

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
