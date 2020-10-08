Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5D6287E9C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 00:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgJHWVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 18:21:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:3460 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgJHWVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 18:21:25 -0400
IronPort-SDR: 1y5V51C1V7t0yiFzobEWECI7BzGFY3hOwLNJm/kfJLIAc6XWBCcQzbEWxAoj/Mj4kY0PNdtzwp
 7Wvn5T/u2rPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="153247523"
X-IronPort-AV: E=Sophos;i="5.77,352,1596524400"; 
   d="scan'208";a="153247523"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 15:21:25 -0700
IronPort-SDR: dlHz/Kr8kK0+hzdl9me/pip4fwHm08xckLm1kZrw9SjSy7PvXLuC1duAhUks3BKTJw8K8A0uF+
 jWxd5gn5YRYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,352,1596524400"; 
   d="scan'208";a="316840657"
Received: from lkp-server02.sh.intel.com (HELO b5ae2f167493) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 08 Oct 2020 15:21:23 -0700
Received: from kbuild by b5ae2f167493 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kQeHr-0002Mf-9B; Thu, 08 Oct 2020 22:21:23 +0000
Date:   Fri, 09 Oct 2020 06:21:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 c5cfa92bf59bd3c77180dc619bdeda44ef052c5e
Message-ID: <5f7f90d8.w+q/o2Xyra7B7zUO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: c5cfa92bf59bd3c77180dc619bdeda44ef052c5e  Merge branch 'ras/core'

elapsed time: 722m

configs tested: 126
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         bigsur_defconfig
powerpc                       eiger_defconfig
mips                       rbtx49xx_defconfig
arm                           tegra_defconfig
powerpc                        icon_defconfig
mips                malta_qemu_32r6_defconfig
arm                        magician_defconfig
powerpc                     tqm8540_defconfig
sh                         ap325rxa_defconfig
powerpc                 xes_mpc85xx_defconfig
m68k                        m5307c3_defconfig
arm                             mxs_defconfig
h8300                               defconfig
xtensa                generic_kc705_defconfig
sh                   secureedge5410_defconfig
sh                        apsh4ad0a_defconfig
arm                       multi_v4t_defconfig
m68k                           sun3_defconfig
arm                  colibri_pxa300_defconfig
powerpc                       maple_defconfig
sh                          rsk7203_defconfig
sh                          urquell_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                         ps3_defconfig
sh                 kfr2r09-romimage_defconfig
arm                           h3600_defconfig
arm                          exynos_defconfig
powerpc                     mpc512x_defconfig
i386                             alldefconfig
powerpc                 mpc834x_itx_defconfig
powerpc                     powernv_defconfig
powerpc                      mgcoge_defconfig
sh                         apsh4a3a_defconfig
mips                           mtx1_defconfig
arm                            mmp2_defconfig
sh                           sh2007_defconfig
arm                          ixp4xx_defconfig
mips                        nlm_xlp_defconfig
s390                          debug_defconfig
s390                             alldefconfig
arm                      integrator_defconfig
c6x                        evmc6474_defconfig
mips                           ip28_defconfig
arm                        shmobile_defconfig
powerpc                      arches_defconfig
powerpc                    gamecube_defconfig
powerpc                     ksi8560_defconfig
powerpc                     ppa8548_defconfig
sh                          r7780mp_defconfig
sh                              ul2_defconfig
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
