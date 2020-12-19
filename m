Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4ED52DED86
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 07:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgLSGb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 01:31:58 -0500
Received: from mga09.intel.com ([134.134.136.24]:60168 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgLSGb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 01:31:57 -0500
IronPort-SDR: seSeiFxSpsUb0m3ShHWsaf89dT+d/SOEjdQ+nw+ao0NWIpieddpr01DA05NxhQ1rdqdvivqBb7
 Gniksm6avBGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9839"; a="175697002"
X-IronPort-AV: E=Sophos;i="5.78,432,1599548400"; 
   d="scan'208";a="175697002"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 22:31:16 -0800
IronPort-SDR: rU1i9a0PQ2X/WrZEPPSYfI0vJl/Y1a3Jab/UygMOAhKmDq8ttEMi4rTNODRKbSFuiij/0gK/A4
 3h+GVfF+mt0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,432,1599548400"; 
   d="scan'208";a="414498293"
Received: from lkp-server02.sh.intel.com (HELO c4fb2a2464e8) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 18 Dec 2020 22:31:15 -0800
Received: from kbuild by c4fb2a2464e8 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kqVlq-0000fS-Tp; Sat, 19 Dec 2020 06:31:14 +0000
Date:   Sat, 19 Dec 2020 14:31:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.12.15b] BUILD SUCCESS
 f895a17eec290b0038a6294d884a9cc92d7d6e80
Message-ID: <5fdd9e25.x6HNDnyVse7N+ia2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.12.15b
branch HEAD: f895a17eec290b0038a6294d884a9cc92d7d6e80  rcu/nocb: Add grace period and task state to show_rcu_nocb_state() output

elapsed time: 721m

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
powerpc                     tqm8541_defconfig
m68k                         apollo_defconfig
arm                        mini2440_defconfig
powerpc                 canyonlands_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                   motionpro_defconfig
powerpc                      ep88xc_defconfig
parisc                           alldefconfig
arm                           omap1_defconfig
mips                            e55_defconfig
powerpc                 mpc836x_rdk_defconfig
m68k                        mvme147_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                        icon_defconfig
arm                         shannon_defconfig
ia64                                defconfig
mips                      maltasmvp_defconfig
um                           x86_64_defconfig
c6x                        evmc6678_defconfig
sh                        edosk7760_defconfig
powerpc                     asp8347_defconfig
alpha                               defconfig
mips                       lemote2f_defconfig
arm                          pxa3xx_defconfig
arm                         at91_dt_defconfig
mips                     cu1000-neo_defconfig
powerpc                     sequoia_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     sbc8548_defconfig
mips                    maltaup_xpa_defconfig
m68k                                defconfig
arm                        spear3xx_defconfig
sh                         apsh4a3a_defconfig
arm                          tango4_defconfig
mips                  decstation_64_defconfig
i386                             alldefconfig
mips                      fuloong2e_defconfig
riscv                               defconfig
arm                            mps2_defconfig
arm                       cns3420vb_defconfig
powerpc                     kilauea_defconfig
sh                          rsk7201_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
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
x86_64               randconfig-a003-20201217
x86_64               randconfig-a006-20201217
x86_64               randconfig-a002-20201217
x86_64               randconfig-a005-20201217
x86_64               randconfig-a004-20201217
x86_64               randconfig-a001-20201217
i386                 randconfig-a001-20201217
i386                 randconfig-a004-20201217
i386                 randconfig-a003-20201217
i386                 randconfig-a002-20201217
i386                 randconfig-a006-20201217
i386                 randconfig-a005-20201217
x86_64               randconfig-a016-20201218
x86_64               randconfig-a013-20201218
x86_64               randconfig-a012-20201218
x86_64               randconfig-a015-20201218
x86_64               randconfig-a014-20201218
x86_64               randconfig-a011-20201218
i386                 randconfig-a014-20201217
i386                 randconfig-a013-20201217
i386                 randconfig-a012-20201217
i386                 randconfig-a011-20201217
i386                 randconfig-a015-20201217
i386                 randconfig-a016-20201217
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a016-20201217
x86_64               randconfig-a012-20201217
x86_64               randconfig-a013-20201217
x86_64               randconfig-a015-20201217
x86_64               randconfig-a014-20201217
x86_64               randconfig-a011-20201217
x86_64               randconfig-a003-20201218
x86_64               randconfig-a006-20201218
x86_64               randconfig-a002-20201218
x86_64               randconfig-a005-20201218
x86_64               randconfig-a001-20201218
x86_64               randconfig-a004-20201218

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
