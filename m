Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED5C2D8AED
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 03:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgLMCiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 21:38:03 -0500
Received: from mga06.intel.com ([134.134.136.31]:23119 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbgLMCiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 21:38:02 -0500
IronPort-SDR: YEKud/dI2EGz7uVOvHFNqJZei5OSdDDr+cC1YgmBMzchj3AS5EC9X6O1TRLbs0dG/yd0gZAYvd
 zkF0hts0LjbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9833"; a="236172984"
X-IronPort-AV: E=Sophos;i="5.78,415,1599548400"; 
   d="scan'208";a="236172984"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2020 18:37:21 -0800
IronPort-SDR: bPUbW5sOlg0IojSw6fgc43C7cG+gGvZzM+yGCYVhYxER0H4qgba0q0rGU6i96dxqc5BS4S7Zqi
 67svt4Gk5HrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,415,1599548400"; 
   d="scan'208";a="350448479"
Received: from lkp-server01.sh.intel.com (HELO ecc0cebe68d1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 12 Dec 2020 18:37:20 -0800
Received: from kbuild by ecc0cebe68d1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1koHGC-0001d1-4L; Sun, 13 Dec 2020 02:37:20 +0000
Date:   Sun, 13 Dec 2020 10:36:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 0d07c0ec4381f630c801539c79ad8dcc627f6e4a
Message-ID: <5fd57e27.xTCkPQzsz3i9agMK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: 0d07c0ec4381f630c801539c79ad8dcc627f6e4a  x86/kprobes: Fix optprobe to detect INT3 padding correctly

elapsed time: 722m

configs tested: 91
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                        spear6xx_defconfig
arm                          iop32x_defconfig
sh                          lboxre2_defconfig
arm                         socfpga_defconfig
arm                          moxart_defconfig
arc                                 defconfig
arm                         s3c6400_defconfig
mips                     cu1000-neo_defconfig
nios2                         10m50_defconfig
parisc                generic-64bit_defconfig
arm                        mvebu_v5_defconfig
powerpc                      bamboo_defconfig
powerpc                     ppa8548_defconfig
xtensa                         virt_defconfig
xtensa                generic_kc705_defconfig
powerpc                          g5_defconfig
m68k                       bvme6000_defconfig
xtensa                           allyesconfig
arm                         mv78xx0_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                          simpad_defconfig
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
i386                 randconfig-a001-20201212
i386                 randconfig-a004-20201212
i386                 randconfig-a003-20201212
i386                 randconfig-a002-20201212
i386                 randconfig-a005-20201212
i386                 randconfig-a006-20201212
x86_64               randconfig-a016-20201212
x86_64               randconfig-a013-20201212
x86_64               randconfig-a015-20201212
x86_64               randconfig-a014-20201212
x86_64               randconfig-a011-20201212
i386                 randconfig-a014-20201212
i386                 randconfig-a013-20201212
i386                 randconfig-a012-20201212
i386                 randconfig-a011-20201212
i386                 randconfig-a016-20201212
i386                 randconfig-a015-20201212
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
x86_64               randconfig-a003-20201212
x86_64               randconfig-a006-20201212
x86_64               randconfig-a002-20201212
x86_64               randconfig-a005-20201212
x86_64               randconfig-a004-20201212
x86_64               randconfig-a001-20201212

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
