Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613522CFA97
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 09:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgLEIYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 03:24:34 -0500
Received: from mga18.intel.com ([134.134.136.126]:14796 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729071AbgLEITP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 03:19:15 -0500
IronPort-SDR: xEowf2N8LC3r8tr5RlL01M10OUGdaj/WyxV/9hdgLbIlP8KpS8+61qMiY5dLumLCxmrhV8PsKo
 Z7FVGpINpKoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9825"; a="161264951"
X-IronPort-AV: E=Sophos;i="5.78,395,1599548400"; 
   d="scan'208";a="161264951"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2020 00:18:29 -0800
IronPort-SDR: eoSt2iRIkekJR8zkGC3OK5iaHKCu1FLurkJHMrnRVGcTO+L3NqvW5VXJL0HJuIgCt8In99YYDf
 bOtYiXD1hP9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,395,1599548400"; 
   d="scan'208";a="336634924"
Received: from lkp-server01.sh.intel.com (HELO 47754f1311fc) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Dec 2020 00:18:28 -0800
Received: from kbuild by 47754f1311fc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1klSlv-0000D5-Tw; Sat, 05 Dec 2020 08:18:27 +0000
Date:   Sat, 05 Dec 2020 16:18:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.12.03a] BUILD SUCCESS
 8c884f433ec3fb5b009bd14be9cd2a16e960cd40
Message-ID: <5fcb423e.uz98xMF1iSmHyTy0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.12.03a
branch HEAD: 8c884f433ec3fb5b009bd14be9cd2a16e960cd40  squash! percpu_ref: Add kmem_cache_last_alloc() argument for stack trace

elapsed time: 721m

configs tested: 132
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                            alldefconfig
arc                        vdk_hs38_defconfig
powerpc                      cm5200_defconfig
arm                          tango4_defconfig
mips                 decstation_r4k_defconfig
powerpc                     tqm8555_defconfig
s390                                defconfig
sh                           se7721_defconfig
m68k                          amiga_defconfig
sh                          r7785rp_defconfig
sh                         microdev_defconfig
m68k                       m5275evb_defconfig
arm                        shmobile_defconfig
um                           x86_64_defconfig
ia64                          tiger_defconfig
arm                         mv78xx0_defconfig
ia64                            zx1_defconfig
powerpc                      ep88xc_defconfig
arm                         bcm2835_defconfig
powerpc                      acadia_defconfig
arm                         assabet_defconfig
powerpc                     skiroot_defconfig
powerpc                   motionpro_defconfig
nds32                               defconfig
mips                           jazz_defconfig
powerpc                        cell_defconfig
ia64                             alldefconfig
powerpc                     redwood_defconfig
powerpc                          g5_defconfig
powerpc                         wii_defconfig
powerpc                 mpc836x_mds_defconfig
arm                      jornada720_defconfig
arm                          pxa3xx_defconfig
openrisc                         alldefconfig
powerpc                      mgcoge_defconfig
arm                         s3c2410_defconfig
openrisc                    or1ksim_defconfig
powerpc                    amigaone_defconfig
powerpc               mpc834x_itxgp_defconfig
sparc                               defconfig
arm                        spear3xx_defconfig
arm                         at91_dt_defconfig
powerpc                       ebony_defconfig
mips                         tb0226_defconfig
powerpc                 mpc8272_ads_defconfig
sh                             espt_defconfig
arm                         vf610m4_defconfig
arm                        multi_v5_defconfig
arm                         nhk8815_defconfig
m68k                            q40_defconfig
sparc64                             defconfig
m68k                        m5307c3_defconfig
arm                      tct_hammer_defconfig
m68k                       bvme6000_defconfig
arm                        keystone_defconfig
s390                          debug_defconfig
arm                      pxa255-idp_defconfig
powerpc                     tqm8548_defconfig
xtensa                              defconfig
arm                        oxnas_v6_defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
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
