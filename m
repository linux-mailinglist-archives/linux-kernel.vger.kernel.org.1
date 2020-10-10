Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A737289EB2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 08:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgJJG16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 02:27:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:6481 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbgJJG1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 02:27:18 -0400
IronPort-SDR: xtfdqlvVmQBzMID0y4O2ibXwe30xpWmRg8uUo5hNYggqycUliAHSe/eXqZ/wRRYYYmGH1bSVYD
 kox0E1/8fCkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="153396977"
X-IronPort-AV: E=Sophos;i="5.77,358,1596524400"; 
   d="scan'208";a="153396977"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 23:27:17 -0700
IronPort-SDR: s42ETAtsqVVX/aqma/5vYaroIcbV1vKMVboUEXchHUBizeBfHCh2okae5c9AB1muX1Hjbia10o
 WF7iRnzzvHbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,358,1596524400"; 
   d="scan'208";a="298652070"
Received: from lkp-server02.sh.intel.com (HELO d5d245f0dec0) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 09 Oct 2020 23:27:16 -0700
Received: from kbuild by d5d245f0dec0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kR8Lb-00001W-E1; Sat, 10 Oct 2020 06:27:15 +0000
Date:   Sat, 10 Oct 2020 14:27:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/next-20201009-clang-ft] BUILD SUCCESS
 WITH WARNING e964f799eda444f3bb28ca19310dfec1fc903f88
Message-ID: <5f815437.q1dbhYx2y0VK1WQT%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  testing/next-20201009-clang-ft
branch HEAD: e964f799eda444f3bb28ca19310dfec1fc903f88  treewide: Fix fall-through warnings for Clang

Warning in current branch:

arch/x86/events/core.c:1178:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:382:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
sound/soc/codecs/cs42l52.c:947:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
sound/soc/codecs/cs42l56.c:1011:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]

Warning ids grouped by kconfigs:

clang_recent_errors
|-- arm64-randconfig-r006-20201009
|   |-- drivers-iommu-arm-arm-smmu-v3-arm-smmu-v3.c:warning:unannotated-fall-through-between-switch-labels
|   |-- sound-soc-codecs-cs42l52.c:warning:unannotated-fall-through-between-switch-labels
|   `-- sound-soc-codecs-cs42l56.c:warning:unannotated-fall-through-between-switch-labels
|-- x86_64-randconfig-a001-20201009
|   `-- arch-x86-events-core.c:warning:unannotated-fall-through-between-switch-labels
|-- x86_64-randconfig-a001-20201010
|   |-- arch-x86-events-core.c:warning:unannotated-fall-through-between-switch-labels
|   `-- sound-soc-codecs-cs42l56.c:warning:unannotated-fall-through-between-switch-labels
|-- x86_64-randconfig-a002-20201010
|   `-- arch-x86-events-core.c:warning:unannotated-fall-through-between-switch-labels
|-- x86_64-randconfig-a003-20201009
|   |-- arch-x86-events-core.c:warning:unannotated-fall-through-between-switch-labels
|   `-- sound-soc-codecs-cs42l56.c:warning:unannotated-fall-through-between-switch-labels
|-- x86_64-randconfig-a003-20201010
|   `-- arch-x86-events-core.c:warning:unannotated-fall-through-between-switch-labels
|-- x86_64-randconfig-a004-20201009
|   `-- arch-x86-events-core.c:warning:unannotated-fall-through-between-switch-labels
|-- x86_64-randconfig-a004-20201010
|   `-- arch-x86-events-core.c:warning:unannotated-fall-through-between-switch-labels
|-- x86_64-randconfig-a005-20201009
|   `-- arch-x86-events-core.c:warning:unannotated-fall-through-between-switch-labels
|-- x86_64-randconfig-a005-20201010
|   `-- arch-x86-events-core.c:warning:unannotated-fall-through-between-switch-labels
`-- x86_64-randconfig-a006-20201010
    `-- arch-x86-events-core.c:warning:unannotated-fall-through-between-switch-labels

elapsed time: 723m

configs tested: 109
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     pq2fads_defconfig
arm                        spear6xx_defconfig
arm                          ep93xx_defconfig
ia64                             alldefconfig
powerpc                      tqm8xx_defconfig
mips                      fuloong2e_defconfig
sh                          sdk7780_defconfig
m68k                          atari_defconfig
mips                     loongson1c_defconfig
powerpc                     mpc83xx_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                       ppc64_defconfig
arm                       mainstone_defconfig
powerpc                     tqm5200_defconfig
um                             i386_defconfig
sparc64                             defconfig
openrisc                 simple_smp_defconfig
sh                        edosk7705_defconfig
arc                         haps_hs_defconfig
sh                           se7712_defconfig
mips                        bcm47xx_defconfig
arm                         s3c2410_defconfig
sh                           sh2007_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                           se7705_defconfig
arm                     davinci_all_defconfig
powerpc                      bamboo_defconfig
m68k                         amcore_defconfig
arm                             ezx_defconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201009
i386                 randconfig-a005-20201009
i386                 randconfig-a001-20201009
i386                 randconfig-a004-20201009
i386                 randconfig-a002-20201009
i386                 randconfig-a003-20201009
x86_64               randconfig-a012-20201009
x86_64               randconfig-a015-20201009
x86_64               randconfig-a013-20201009
x86_64               randconfig-a014-20201009
x86_64               randconfig-a011-20201009
x86_64               randconfig-a016-20201009
i386                 randconfig-a015-20201009
i386                 randconfig-a013-20201009
i386                 randconfig-a014-20201009
i386                 randconfig-a016-20201009
i386                 randconfig-a011-20201009
i386                 randconfig-a012-20201009
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
x86_64               randconfig-a004-20201010
x86_64               randconfig-a002-20201010
x86_64               randconfig-a006-20201010
x86_64               randconfig-a001-20201010
x86_64               randconfig-a003-20201010
x86_64               randconfig-a005-20201010
x86_64               randconfig-a004-20201009
x86_64               randconfig-a003-20201009
x86_64               randconfig-a005-20201009
x86_64               randconfig-a001-20201009
x86_64               randconfig-a002-20201009
x86_64               randconfig-a006-20201009

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
