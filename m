Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91FE92DED00
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 05:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgLSEDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 23:03:46 -0500
Received: from mga01.intel.com ([192.55.52.88]:5408 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgLSEDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 23:03:46 -0500
IronPort-SDR: 5bWG2aOVKXn4zwwrax6tiz8wcuabv8DsuSHXyUjjFz3RMZ3CRYp+Opz7bVHA78h4MpQKsodClN
 dd4c8MGwkySg==
X-IronPort-AV: E=McAfee;i="6000,8403,9839"; a="193959699"
X-IronPort-AV: E=Sophos;i="5.78,432,1599548400"; 
   d="scan'208";a="193959699"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2020 20:03:05 -0800
IronPort-SDR: yTEZ4l5UniSdpb37mGKU+ZEIzKIi2LX88H0yfft+CoR0Pn0mS0oUW/P8cFFagiNVmy0C7cY5g2
 KkXS1VS8Cw3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,432,1599548400"; 
   d="scan'208";a="558867184"
Received: from lkp-server02.sh.intel.com (HELO c4fb2a2464e8) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 18 Dec 2020 20:03:04 -0800
Received: from kbuild by c4fb2a2464e8 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kqTSR-0000bM-CI; Sat, 19 Dec 2020 04:03:03 +0000
Date:   Sat, 19 Dec 2020 12:02:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 91ea62d58bd661827c328a2c6c02a87fa4aae88b
Message-ID: <5fdd7b70.7bC3fyP2vfEsI5+y%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  locking/urgent
branch HEAD: 91ea62d58bd661827c328a2c6c02a87fa4aae88b  softirq: Avoid bad tracing / lockdep interaction

elapsed time: 723m

configs tested: 121
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
sh                          urquell_defconfig
powerpc                 mpc8560_ads_defconfig
mips                           ci20_defconfig
sh                           se7780_defconfig
arm                         shannon_defconfig
mips                      maltasmvp_defconfig
ia64                                defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                     sbc8548_defconfig
mips                    maltaup_xpa_defconfig
m68k                                defconfig
arm                        spear3xx_defconfig
sh                         apsh4a3a_defconfig
arm                          tango4_defconfig
mips                  decstation_64_defconfig
sh                           se7206_defconfig
powerpc                       holly_defconfig
arm                         vf610m4_defconfig
mips                        vocore2_defconfig
i386                             alldefconfig
mips                      fuloong2e_defconfig
riscv                               defconfig
arm                            mps2_defconfig
openrisc                            defconfig
ia64                          tiger_defconfig
parisc                generic-32bit_defconfig
arm                         lpc32xx_defconfig
arm                           viper_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
