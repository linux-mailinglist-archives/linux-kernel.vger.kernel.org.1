Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB662F4B37
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 13:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbhAMMZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:25:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:14157 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbhAMMZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:25:07 -0500
IronPort-SDR: 4aLmJQZuvBVGMEqF/Y6KtuV9Ppo+yTQHuvykSTjl1S0xNa2/qfm7U/rIETTdOI2B9bbHJWxJkN
 NN6hObQGIdmQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="157376171"
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="157376171"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 04:24:25 -0800
IronPort-SDR: lGMkS6xrfnsygSGb82q0t4ARpCfP7gBKul7YFhdQgwsQIduf6+CD3xHYtmXfAez+2GS6j6lmsD
 fsJV9jcizoYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="464889531"
Received: from lkp-server01.sh.intel.com (HELO d5d1a9a2c6bb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jan 2021 04:24:24 -0800
Received: from kbuild by d5d1a9a2c6bb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kzfCJ-0000DW-Vh; Wed, 13 Jan 2021 12:24:23 +0000
Date:   Wed, 13 Jan 2021 20:24:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.01.12a] BUILD SUCCESS
 752648066a9e2d2412d54c24f99fff2ef7f911c5
Message-ID: <5ffee671.JDiOtk0++NZ0ljfe%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2021.01.12a
branch HEAD: 752648066a9e2d2412d54c24f99fff2ef7f911c5  irq: detect long-running IRQ handlers

elapsed time: 722m

configs tested: 165
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         shannon_defconfig
powerpc                       maple_defconfig
arm                              zx_defconfig
mips                            e55_defconfig
arm                       spear13xx_defconfig
sh                           se7750_defconfig
powerpc                     ep8248e_defconfig
arm                         lubbock_defconfig
sh                        apsh4ad0a_defconfig
sh                           se7343_defconfig
powerpc64                        alldefconfig
arm                  colibri_pxa300_defconfig
sh                           se7206_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                   lite5200b_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                       lemote2f_defconfig
sh                      rts7751r2d1_defconfig
m68k                        m5272c3_defconfig
sh                            migor_defconfig
powerpc                        icon_defconfig
arm                           corgi_defconfig
arm                     eseries_pxa_defconfig
ia64                          tiger_defconfig
powerpc                      pasemi_defconfig
mips                         bigsur_defconfig
mips                       rbtx49xx_defconfig
c6x                              alldefconfig
mips                     decstation_defconfig
sh                   sh7770_generic_defconfig
arm                            hisi_defconfig
c6x                        evmc6472_defconfig
microblaze                          defconfig
xtensa                  cadence_csp_defconfig
powerpc                    mvme5100_defconfig
m68k                         amcore_defconfig
mips                        bcm47xx_defconfig
mips                        workpad_defconfig
h8300                     edosk2674_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                           xway_defconfig
arc                           tb10x_defconfig
sh                           se7721_defconfig
arm                         axm55xx_defconfig
m68k                            q40_defconfig
arm                        mini2440_defconfig
powerpc                     tqm8560_defconfig
sh                         ecovec24_defconfig
c6x                        evmc6457_defconfig
arm                        mvebu_v7_defconfig
mips                      pistachio_defconfig
m68k                          multi_defconfig
s390                       zfcpdump_defconfig
xtensa                    smp_lx200_defconfig
h8300                    h8300h-sim_defconfig
arm                       multi_v4t_defconfig
arm                     davinci_all_defconfig
sh                               alldefconfig
sh                          r7780mp_defconfig
arm                        keystone_defconfig
ia64                            zx1_defconfig
mips                      maltaaprp_defconfig
sh                           se7724_defconfig
sh                          urquell_defconfig
sparc                            alldefconfig
arm                        multi_v5_defconfig
powerpc                      pmac32_defconfig
powerpc                     ksi8560_defconfig
powerpc                    amigaone_defconfig
arc                     haps_hs_smp_defconfig
csky                                defconfig
um                            kunit_defconfig
sh                           se7705_defconfig
parisc                              defconfig
m68k                        m5407c3_defconfig
m68k                          atari_defconfig
powerpc                      ep88xc_defconfig
sh                          rsk7264_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                        fsp2_defconfig
m68k                       m5275evb_defconfig
powerpc                      ppc44x_defconfig
arm                            qcom_defconfig
sh                ecovec24-romimage_defconfig
arm                          tango4_defconfig
mips                          ath25_defconfig
sh                           sh2007_defconfig
arm                         socfpga_defconfig
m68k                       m5249evb_defconfig
ia64                        generic_defconfig
mips                  decstation_64_defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210113
x86_64               randconfig-a004-20210113
x86_64               randconfig-a001-20210113
x86_64               randconfig-a005-20210113
x86_64               randconfig-a003-20210113
x86_64               randconfig-a002-20210113
i386                 randconfig-a002-20210113
i386                 randconfig-a005-20210113
i386                 randconfig-a006-20210113
i386                 randconfig-a003-20210113
i386                 randconfig-a001-20210113
i386                 randconfig-a004-20210113
i386                 randconfig-a012-20210113
i386                 randconfig-a011-20210113
i386                 randconfig-a016-20210113
i386                 randconfig-a013-20210113
i386                 randconfig-a015-20210113
i386                 randconfig-a014-20210113
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210113
x86_64               randconfig-a012-20210113
x86_64               randconfig-a013-20210113
x86_64               randconfig-a016-20210113
x86_64               randconfig-a014-20210113
x86_64               randconfig-a011-20210113

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
