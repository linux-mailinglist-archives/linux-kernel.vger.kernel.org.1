Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995B1286D77
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 06:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgJHEFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 00:05:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:29236 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgJHEFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 00:05:04 -0400
IronPort-SDR: uPCpY+LmMsbO9RYRl+n8Twny8lIOA5G0bf7lRY9pmUS24gC5wM9HBko5pIqYlWGHMNN2wh9dtT
 avBGDvX93xRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="229443990"
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="229443990"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 21:05:03 -0700
IronPort-SDR: bCz5AFMewUovswstgQNFoPUgpOQkrzizvIxLEXfMmxIgzHQhnpDjt+FrOFuTIKb+HA7aLmFxjy
 GF81jr4V1bMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="528318398"
Received: from lkp-server02.sh.intel.com (HELO b5ae2f167493) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 07 Oct 2020 21:05:01 -0700
Received: from kbuild by b5ae2f167493 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kQNAr-0001xS-9S; Thu, 08 Oct 2020 04:05:01 +0000
Date:   Thu, 08 Oct 2020 12:04:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 300638101329e8f1569115f3d7197ef5ef754a3a
Message-ID: <5f7e8fcc.JjrR1MyiceYxNM6v%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  ras/core
branch HEAD: 300638101329e8f1569115f3d7197ef5ef754a3a  x86/mce: Decode a kernel instruction to determine if it is copying from user

elapsed time: 723m

configs tested: 115
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                            q40_defconfig
arm64                            alldefconfig
arm                        realview_defconfig
arm                      pxa255-idp_defconfig
microblaze                      mmu_defconfig
mips                         bigsur_defconfig
powerpc                       eiger_defconfig
mips                       rbtx49xx_defconfig
arm                           tegra_defconfig
powerpc                        icon_defconfig
mips                malta_qemu_32r6_defconfig
arm                        magician_defconfig
powerpc                     tqm8540_defconfig
powerpc                       maple_defconfig
arm                              zx_defconfig
sh                   rts7751r2dplus_defconfig
m68k                        stmark2_defconfig
arm                  colibri_pxa300_defconfig
sh                          rsk7203_defconfig
sh                          urquell_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     asp8347_defconfig
sh                   secureedge5410_defconfig
arm                          tango4_defconfig
powerpc                 canyonlands_defconfig
h8300                               defconfig
h8300                       h8s-sim_defconfig
m68k                       m5249evb_defconfig
xtensa                    smp_lx200_defconfig
arm                        keystone_defconfig
mips                      pic32mzda_defconfig
mips                          rb532_defconfig
arm                         mv78xx0_defconfig
arm                         assabet_defconfig
powerpc                     tqm8548_defconfig
arm                        clps711x_defconfig
arm                          ep93xx_defconfig
sh                              ul2_defconfig
sh                          r7780mp_defconfig
microblaze                          defconfig
mips                           ip22_defconfig
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
x86_64               randconfig-a004-20201008
x86_64               randconfig-a003-20201008
x86_64               randconfig-a005-20201008
x86_64               randconfig-a001-20201008
x86_64               randconfig-a002-20201008
x86_64               randconfig-a006-20201008
i386                 randconfig-a006-20201008
i386                 randconfig-a005-20201008
i386                 randconfig-a001-20201008
i386                 randconfig-a004-20201008
i386                 randconfig-a002-20201008
i386                 randconfig-a003-20201008
i386                 randconfig-a015-20201008
i386                 randconfig-a013-20201008
i386                 randconfig-a014-20201008
i386                 randconfig-a016-20201008
i386                 randconfig-a011-20201008
i386                 randconfig-a012-20201008
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
x86_64               randconfig-a012-20201008
x86_64               randconfig-a015-20201008
x86_64               randconfig-a013-20201008
x86_64               randconfig-a014-20201008
x86_64               randconfig-a011-20201008
x86_64               randconfig-a016-20201008

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
