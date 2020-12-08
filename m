Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD642D2B54
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 13:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbgLHMpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 07:45:20 -0500
Received: from mga18.intel.com ([134.134.136.126]:10589 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbgLHMpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 07:45:19 -0500
IronPort-SDR: cgeZKVcu8qbtZlqHFO5Qd0zHlNXqnqPTJX3v0J5Tb5aQJ8TWHSanidlm7bzN+bA7Em+ccFFqBG
 kTJ1ifLjgdrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="161645624"
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="161645624"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 04:44:38 -0800
IronPort-SDR: 5FBxhW2gckfg1OgE7QSEx0t/++EE4kuJg0ngnHpx0J4226zJ7VpQlhNhBrWQqa9psbPVBnnlaK
 Z0fPxPMKmYwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="552215817"
Received: from lkp-server01.sh.intel.com (HELO c88bd47c8831) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Dec 2020 04:44:37 -0800
Received: from kbuild by c88bd47c8831 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kmcM8-0000D8-Sa; Tue, 08 Dec 2020 12:44:36 +0000
Date:   Tue, 08 Dec 2020 20:44:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/platform] BUILD SUCCESS
 c9624cb7db1c418cbdc8fd2cde6835f83cd0f8a2
Message-ID: <5fcf752f.h7LKqXs10lT8DWFM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/platform
branch HEAD: c9624cb7db1c418cbdc8fd2cde6835f83cd0f8a2  x86/platform/uv: Update sysfs documentation

elapsed time: 725m

configs tested: 90
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
h8300                     edosk2674_defconfig
sh                        edosk7760_defconfig
powerpc                     pseries_defconfig
powerpc                     ppa8548_defconfig
powerpc                        icon_defconfig
arm                    vt8500_v6_v7_defconfig
arm                           efm32_defconfig
arm                        clps711x_defconfig
m68k                       m5275evb_defconfig
arm                              alldefconfig
mips                         tb0219_defconfig
mips                           ip27_defconfig
powerpc                     tqm8548_defconfig
ia64                      gensparse_defconfig
arm                         cm_x300_defconfig
sh                          rsk7264_defconfig
arm                         palmz72_defconfig
c6x                        evmc6472_defconfig
arm                         s3c2410_defconfig
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
i386                 randconfig-a005-20201208
i386                 randconfig-a006-20201208
i386                 randconfig-a013-20201208
i386                 randconfig-a014-20201208
i386                 randconfig-a011-20201208
i386                 randconfig-a015-20201208
i386                 randconfig-a012-20201208
i386                 randconfig-a016-20201208
x86_64               randconfig-a004-20201208
x86_64               randconfig-a006-20201208
x86_64               randconfig-a005-20201208
x86_64               randconfig-a001-20201208
x86_64               randconfig-a002-20201208
x86_64               randconfig-a003-20201208
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a016-20201208
x86_64               randconfig-a012-20201208
x86_64               randconfig-a013-20201208
x86_64               randconfig-a014-20201208
x86_64               randconfig-a015-20201208
x86_64               randconfig-a011-20201208

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
