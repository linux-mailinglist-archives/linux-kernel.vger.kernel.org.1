Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD062CEF9A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 15:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388315AbgLDOQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 09:16:04 -0500
Received: from mga18.intel.com ([134.134.136.126]:55357 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgLDOQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 09:16:03 -0500
IronPort-SDR: pGoWr45lbzNuDVgvQNUYBtAA3GFM6h+yPQSE+SY9dPA4qjiQegooaMFhD0LDfZPEusbyOPolYw
 /RsXL7b5E6og==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="161150031"
X-IronPort-AV: E=Sophos;i="5.78,392,1599548400"; 
   d="scan'208";a="161150031"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 06:15:23 -0800
IronPort-SDR: asDqsh8GKHebSyCwOwd7dwytjAOGvHbUscUF5nEk/MrFmJ/s6vZzVUPCvK/o8/GR8J4ssvZhjs
 2v/11QCtMjgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,392,1599548400"; 
   d="scan'208";a="346615034"
Received: from lkp-server02.sh.intel.com (HELO f74a175f0d75) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 04 Dec 2020 06:15:21 -0800
Received: from kbuild by f74a175f0d75 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1klBrl-00008K-Ax; Fri, 04 Dec 2020 14:15:21 +0000
Date:   Fri, 04 Dec 2020 22:14:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.12.02a] BUILD REGRESSION
 078e84bbcc794263adc2e5d94415447455773c25
Message-ID: <5fca4441.n7Aq+6E80UOCnVL6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.12.02a
branch HEAD: 078e84bbcc794263adc2e5d94415447455773c25  EXP rcuscale: Crude tests for kmem_last_alloc() percpu_ref code

Error/Warning reports:

https://lore.kernel.org/lkml/202012041303.mGqyuwN1-lkp@intel.com

Error/Warning in current branch:

(.text+0x204): undefined reference to `kmem_cache_last_alloc'
(.text+0xbb8): undefined reference to `kmem_cache_last_alloc'
(.text+0xf0): undefined reference to `kmem_cache_last_alloc'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-imote2_defconfig
|   `-- (.text):undefined-reference-to-kmem_cache_last_alloc
|-- openrisc-randconfig-r004-20201204
|   `-- (.text):undefined-reference-to-kmem_cache_last_alloc
`-- parisc-defconfig
    `-- (.text):undefined-reference-to-kmem_cache_last_alloc

elapsed time: 720m

configs tested: 114
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         shannon_defconfig
mips                     decstation_defconfig
mips                         mpc30x_defconfig
mips                           ci20_defconfig
arm                        realview_defconfig
sparc                       sparc64_defconfig
xtensa                              defconfig
ia64                             alldefconfig
arm                          imote2_defconfig
powerpc                    amigaone_defconfig
powerpc                    gamecube_defconfig
arm                          simpad_defconfig
powerpc                  mpc866_ads_defconfig
m68k                          atari_defconfig
mips                      bmips_stb_defconfig
powerpc                     skiroot_defconfig
arm                        clps711x_defconfig
sh                          urquell_defconfig
sh                             sh03_defconfig
powerpc                   lite5200b_defconfig
microblaze                          defconfig
powerpc                         ps3_defconfig
powerpc                    socrates_defconfig
arm                           omap1_defconfig
nios2                         3c120_defconfig
arm                       netwinder_defconfig
xtensa                       common_defconfig
sh                        dreamcast_defconfig
sh                            migor_defconfig
mips                          ath79_defconfig
arm                       omap2plus_defconfig
c6x                         dsk6455_defconfig
sh                        sh7785lcr_defconfig
arc                     nsimosci_hs_defconfig
openrisc                    or1ksim_defconfig
arm                    vt8500_v6_v7_defconfig
arm                        keystone_defconfig
sh                           se7343_defconfig
powerpc                     tqm8540_defconfig
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
