Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61482D44F8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 16:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733241AbgLIPAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 10:00:06 -0500
Received: from mga04.intel.com ([192.55.52.120]:46536 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727526AbgLIPAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 10:00:05 -0500
IronPort-SDR: SnK3FUTBBD9SHTYG7XjyJTgpTe3/bYeBhVas+o5c8ppmJ5uy9SdhZf/utSrnaUAeHAOHb9CkYz
 BIcLUYJGxfKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="171513307"
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="171513307"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 06:59:24 -0800
IronPort-SDR: EgEYMgnuMPLnRHJfMIpLNggT6PvcguBHoIGK5ujC9UHoL/33wsveGvAfSKDfmVMpRe+Crlnw/z
 UKE4MF9O+BXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="484028762"
Received: from lkp-server01.sh.intel.com (HELO 2bbb63443648) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 09 Dec 2020 06:59:23 -0800
Received: from kbuild by 2bbb63443648 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kn0w6-0000Jg-RF; Wed, 09 Dec 2020 14:59:22 +0000
Date:   Wed, 09 Dec 2020 22:59:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.12.08c] BUILD REGRESSION
 0168e03a513cd576ca6ab24f428ce85cec1e3ff3
Message-ID: <5fd0e63a.1sEIPXB5dPdf3baw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.12.08c
branch HEAD: 0168e03a513cd576ca6ab24f428ce85cec1e3ff3  mm: Make mem_dump_obj() handle vmalloc() memory

Error/Warning reports:

https://lore.kernel.org/lkml/202012091335.NDbOo3w7-lkp@intel.com
https://lore.kernel.org/lkml/202012091536.JlLLyMbA-lkp@intel.com

Error/Warning in current branch:

arc-elf-ld: slab_common.c:(.text+0xba): undefined reference to `kmem_provenance'
nds32le-linux-ld: slab_common.c:(.text+0x838): undefined reference to `kmem_provenance'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-defconfig
|   `-- arc-elf-ld:slab_common.c:(.text):undefined-reference-to-kmem_provenance
|-- arc-haps_hs_defconfig
|   `-- arc-elf-ld:slab_common.c:(.text):undefined-reference-to-kmem_provenance
`-- nds32-randconfig-r014-20201208
    `-- nds32le-linux-ld:slab_common.c:(.text):undefined-reference-to-kmem_provenance

elapsed time: 722m

configs tested: 130
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          r7785rp_defconfig
powerpc                    sam440ep_defconfig
alpha                            alldefconfig
powerpc                     mpc512x_defconfig
arc                         haps_hs_defconfig
powerpc                mpc7448_hpc2_defconfig
microblaze                          defconfig
sh                         ecovec24_defconfig
arm                        trizeps4_defconfig
sh                        edosk7705_defconfig
h8300                       h8s-sim_defconfig
arm                         lpc18xx_defconfig
sh                          rsk7203_defconfig
arm                            qcom_defconfig
arm                     eseries_pxa_defconfig
mips                     loongson1b_defconfig
powerpc                   motionpro_defconfig
mips                           ip28_defconfig
m68k                        m5407c3_defconfig
arc                           tb10x_defconfig
powerpc                      ppc44x_defconfig
powerpc                     tqm5200_defconfig
powerpc                     sequoia_defconfig
c6x                              alldefconfig
arm                          ixp4xx_defconfig
sh                          lboxre2_defconfig
sh                           se7751_defconfig
arm                            mmp2_defconfig
powerpc                       holly_defconfig
arm                           h5000_defconfig
sh                            migor_defconfig
mips                        bcm63xx_defconfig
sh                           se7724_defconfig
powerpc64                           defconfig
arm                           omap1_defconfig
h8300                               defconfig
powerpc                 xes_mpc85xx_defconfig
m68k                       bvme6000_defconfig
sh                           se7619_defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201208
x86_64               randconfig-a006-20201208
x86_64               randconfig-a005-20201208
x86_64               randconfig-a001-20201208
x86_64               randconfig-a002-20201208
x86_64               randconfig-a003-20201208
i386                 randconfig-a004-20201209
i386                 randconfig-a005-20201209
i386                 randconfig-a001-20201209
i386                 randconfig-a002-20201209
i386                 randconfig-a006-20201209
i386                 randconfig-a003-20201209
i386                 randconfig-a004-20201208
i386                 randconfig-a005-20201208
i386                 randconfig-a001-20201208
i386                 randconfig-a002-20201208
x86_64               randconfig-a016-20201209
x86_64               randconfig-a012-20201209
x86_64               randconfig-a013-20201209
x86_64               randconfig-a014-20201209
x86_64               randconfig-a015-20201209
x86_64               randconfig-a011-20201209
i386                 randconfig-a013-20201209
i386                 randconfig-a014-20201209
i386                 randconfig-a011-20201209
i386                 randconfig-a015-20201209
i386                 randconfig-a012-20201209
i386                 randconfig-a016-20201209
i386                 randconfig-a013-20201208
i386                 randconfig-a014-20201208
i386                 randconfig-a011-20201208
i386                 randconfig-a015-20201208
i386                 randconfig-a012-20201208
i386                 randconfig-a016-20201208
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
x86_64               randconfig-a004-20201209
x86_64               randconfig-a006-20201209
x86_64               randconfig-a005-20201209
x86_64               randconfig-a001-20201209
x86_64               randconfig-a002-20201209
x86_64               randconfig-a003-20201209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
