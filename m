Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720282BA409
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 08:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgKTH4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 02:56:47 -0500
Received: from mga07.intel.com ([134.134.136.100]:11223 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbgKTH4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 02:56:46 -0500
IronPort-SDR: 66A9j8UTqA3+Lo3jv6aajYBa74ZCkVZ9wOoFdxeJploRFqTRhsXpwBJdJ6BjmRJ/sBRUeElLcw
 clqW035MiCfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="235579662"
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="235579662"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 23:56:45 -0800
IronPort-SDR: wt00aJOmbKechM5KG+8t5ytwzQ7jvKvftF9GanChw3CDJjbT/t213IElcHiqkB8UmEvW+NFfW5
 5gxBvf/38VFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; 
   d="scan'208";a="477138697"
Received: from lkp-server02.sh.intel.com (HELO 6fee5ef4ab3b) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 19 Nov 2020 23:56:44 -0800
Received: from kbuild by 6fee5ef4ab3b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kg1Hf-00000M-HS; Fri, 20 Nov 2020 07:56:43 +0000
Date:   Fri, 20 Nov 2020 15:56:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/mm] BUILD SUCCESS
 a0e169978303ee5873142599c8c9660b2d296243
Message-ID: <5fb776a6.BKNj2svsup2/DArw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  core/mm
branch HEAD: a0e169978303ee5873142599c8c9660b2d296243  microblaze/mm/highmem: Add dropped #ifdef back

elapsed time: 725m

configs tested: 123
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     mpc5200_defconfig
arm                     davinci_all_defconfig
arm                         hackkit_defconfig
sparc                       sparc64_defconfig
m68k                        mvme147_defconfig
xtensa                           alldefconfig
powerpc                      obs600_defconfig
m68k                          atari_defconfig
sh                           se7712_defconfig
arm                       multi_v4t_defconfig
mips                         tb0287_defconfig
m68k                            q40_defconfig
sh                           sh2007_defconfig
powerpc                     ppa8548_defconfig
arc                        nsimosci_defconfig
mips                     cu1830-neo_defconfig
arm                         bcm2835_defconfig
mips                          rm200_defconfig
powerpc                     rainier_defconfig
powerpc                     tqm8540_defconfig
arm                        trizeps4_defconfig
powerpc                     powernv_defconfig
m68k                          sun3x_defconfig
arm                          exynos_defconfig
mips                      pistachio_defconfig
mips                        nlm_xlp_defconfig
powerpc                        fsp2_defconfig
arm                         s5pv210_defconfig
arm                          tango4_defconfig
arm                          badge4_defconfig
arm                              alldefconfig
arm                            zeus_defconfig
parisc                              defconfig
mips                     cu1000-neo_defconfig
arm                          pcm027_defconfig
arm                     am200epdkit_defconfig
sh                           se7721_defconfig
powerpc                 mpc836x_rdk_defconfig
h8300                     edosk2674_defconfig
powerpc                  storcenter_defconfig
mips                      bmips_stb_defconfig
sh                            titan_defconfig
powerpc                 mpc85xx_cds_defconfig
ia64                                defconfig
powerpc                    sam440ep_defconfig
arm                     eseries_pxa_defconfig
m68k                        m5307c3_defconfig
powerpc                     tqm8555_defconfig
mips                         tb0226_defconfig
arc                         haps_hs_defconfig
powerpc                       eiger_defconfig
powerpc                           allnoconfig
ia64                             allmodconfig
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
i386                 randconfig-a006-20201119
i386                 randconfig-a005-20201119
i386                 randconfig-a002-20201119
i386                 randconfig-a001-20201119
i386                 randconfig-a003-20201119
i386                 randconfig-a004-20201119
x86_64               randconfig-a015-20201119
x86_64               randconfig-a014-20201119
x86_64               randconfig-a011-20201119
x86_64               randconfig-a013-20201119
x86_64               randconfig-a016-20201119
x86_64               randconfig-a012-20201119
i386                 randconfig-a012-20201119
i386                 randconfig-a014-20201119
i386                 randconfig-a016-20201119
i386                 randconfig-a011-20201119
i386                 randconfig-a013-20201119
i386                 randconfig-a015-20201119
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
x86_64               randconfig-a005-20201119
x86_64               randconfig-a003-20201119
x86_64               randconfig-a004-20201119
x86_64               randconfig-a002-20201119
x86_64               randconfig-a006-20201119
x86_64               randconfig-a001-20201119

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
