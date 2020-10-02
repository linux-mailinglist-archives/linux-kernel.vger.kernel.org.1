Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EC2281DCF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 23:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgJBVt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 17:49:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:15975 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJBVt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 17:49:27 -0400
IronPort-SDR: qkOBWP3L2wu6XXSo/WBlBbtg5fuHQu67gT2Shj2Wwzr3aT4kdOWlLj/bCIYHR4xNh48E8yRy6z
 DbiQAJAoVlCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="160408161"
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="160408161"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 14:49:25 -0700
IronPort-SDR: ZnRwnLcqLV1pI7Pllm15ND0rChr4GNruhvnvIGdS3pmHxU3rX7akgSQ/krYY2v6xJACVqtu7Ad
 eIQuTjOsFxcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="352487641"
Received: from lkp-server02.sh.intel.com (HELO 404f47266ee4) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 02 Oct 2020 14:49:24 -0700
Received: from kbuild by 404f47266ee4 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kOSvc-00008F-3b; Fri, 02 Oct 2020 21:49:24 +0000
Date:   Sat, 03 Oct 2020 05:48:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS WITH WARNING
 d57a69be0c6af3327771a772d6b895bd665f3f25
Message-ID: <5f77a030.kpW69woEcc1rmqJR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: d57a69be0c6af3327771a772d6b895bd665f3f25  Merge branch 'core/debugobjects'

Warning in current branch:

ld.lld: warning: drivers/built-in.a(clocksource/timer-ti-dm-systimer.o):(__timer_of_table) is being placed in '__timer_of_table'

Warning ids grouped by kconfigs:

clang_recent_errors
`-- arm-randconfig-r031-20201002
    `-- ld.lld:warning:drivers-built-in.a(clocksource-timer-ti-dm-systimer.o):(__timer_of_table)-is-being-placed-in-__timer_of_table

elapsed time: 721m

configs tested: 117
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                    socrates_defconfig
mips                         bigsur_defconfig
arm                  colibri_pxa270_defconfig
powerpc64                        alldefconfig
um                           x86_64_defconfig
powerpc                        warp_defconfig
powerpc                         wii_defconfig
mips                        nlm_xlr_defconfig
mips                       lemote2f_defconfig
m68k                       m5475evb_defconfig
sh                   secureedge5410_defconfig
arm                           tegra_defconfig
sh                           se7619_defconfig
mips                 decstation_r4k_defconfig
xtensa                generic_kc705_defconfig
alpha                            alldefconfig
powerpc                    mvme5100_defconfig
sh                            titan_defconfig
riscv                               defconfig
powerpc                     mpc512x_defconfig
arm                            lart_defconfig
mips                           jazz_defconfig
c6x                         dsk6455_defconfig
arm                        mini2440_defconfig
c6x                        evmc6474_defconfig
arm                          imote2_defconfig
nios2                         3c120_defconfig
sparc64                          alldefconfig
mips                         tb0226_defconfig
microblaze                      mmu_defconfig
powerpc                     stx_gp3_defconfig
sh                        sh7757lcr_defconfig
sh                          polaris_defconfig
sh                          kfr2r09_defconfig
m68k                        m5407c3_defconfig
xtensa                       common_defconfig
arm                    vt8500_v6_v7_defconfig
c6x                        evmc6678_defconfig
mips                  cavium_octeon_defconfig
s390                          debug_defconfig
sh                           se7751_defconfig
mips                          malta_defconfig
arm                        mvebu_v7_defconfig
arm                        vexpress_defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201002
x86_64               randconfig-a001-20201002
x86_64               randconfig-a002-20201002
x86_64               randconfig-a005-20201002
x86_64               randconfig-a003-20201002
x86_64               randconfig-a006-20201002
i386                 randconfig-a006-20201002
i386                 randconfig-a005-20201002
i386                 randconfig-a001-20201002
i386                 randconfig-a004-20201002
i386                 randconfig-a003-20201002
i386                 randconfig-a002-20201002
i386                 randconfig-a014-20201002
i386                 randconfig-a013-20201002
i386                 randconfig-a015-20201002
i386                 randconfig-a016-20201002
i386                 randconfig-a011-20201002
i386                 randconfig-a012-20201002
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20201002
x86_64               randconfig-a015-20201002
x86_64               randconfig-a014-20201002
x86_64               randconfig-a013-20201002
x86_64               randconfig-a011-20201002
x86_64               randconfig-a016-20201002

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
