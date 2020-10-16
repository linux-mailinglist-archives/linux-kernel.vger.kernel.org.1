Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1CE28FDCB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 07:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390759AbgJPFpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 01:45:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:26452 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387422AbgJPFpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 01:45:02 -0400
IronPort-SDR: SajWX2LZhuc/zx08njxtFwJKSV/TSw5XU4l9AwGvnqs+822lx0D1ElUAtmDsctn5gITc+z33vG
 VkNkcMxF7f7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="230727228"
X-IronPort-AV: E=Sophos;i="5.77,381,1596524400"; 
   d="scan'208";a="230727228"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 22:45:01 -0700
IronPort-SDR: 4v7sLjALilPeeLTvoT99ZmGbGiXLuvaoWp0Kg8U48FoFf7zwTumIIUjpKsjJ5M6fFGDek1TLSB
 hDOpUv7UtrRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,381,1596524400"; 
   d="scan'208";a="531578941"
Received: from lkp-server01.sh.intel.com (HELO 5003fa193bf3) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Oct 2020 22:45:00 -0700
Received: from kbuild by 5003fa193bf3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kTIXz-0000EO-N2; Fri, 16 Oct 2020 05:44:59 +0000
Date:   Fri, 16 Oct 2020 13:44:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.10.14a] BUILD SUCCESS
 87fb0cc38d2583d4084e2ddaa937625fd2d876e0
Message-ID: <5f893333.P+hiL4zllWvX+FWY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.10.14a
branch HEAD: 87fb0cc38d2583d4084e2ddaa937625fd2d876e0  squash! rcu: Prevent lockdep-RCU splats on lock acquisition/release

elapsed time: 723m

configs tested: 134
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                            zeus_defconfig
m68k                        mvme16x_defconfig
arm                       aspeed_g5_defconfig
mips                        maltaup_defconfig
h8300                               defconfig
powerpc                         ps3_defconfig
xtensa                generic_kc705_defconfig
arc                        vdk_hs38_defconfig
powerpc                      katmai_defconfig
sparc                       sparc32_defconfig
sh                           se7780_defconfig
xtensa                         virt_defconfig
arm                         lpc18xx_defconfig
arm                            u300_defconfig
arm                          moxart_defconfig
sh                               alldefconfig
powerpc                     tqm5200_defconfig
mips                      pic32mzda_defconfig
m68k                          multi_defconfig
sh                   sh7724_generic_defconfig
powerpc                 linkstation_defconfig
arm                        vexpress_defconfig
arm                            pleb_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                     sh7710voipgw_defconfig
powerpc                     ppa8548_defconfig
nds32                               defconfig
powerpc                   motionpro_defconfig
arm                      tct_hammer_defconfig
powerpc                     kilauea_defconfig
mips                        nlm_xlp_defconfig
sh                           se7206_defconfig
sh                          r7780mp_defconfig
ia64                                defconfig
nios2                            allyesconfig
ia64                         bigsur_defconfig
powerpc                      ppc44x_defconfig
arm                        mvebu_v5_defconfig
powerpc                     stx_gp3_defconfig
powerpc                           allnoconfig
h8300                       h8s-sim_defconfig
arm                           stm32_defconfig
arm                           spitz_defconfig
sh                  sh7785lcr_32bit_defconfig
arc                        nsimosci_defconfig
arm                       omap2plus_defconfig
arm                            xcep_defconfig
arm                        mini2440_defconfig
xtensa                              defconfig
powerpc                     mpc5200_defconfig
arm                             pxa_defconfig
m68k                          sun3x_defconfig
sh                            shmin_defconfig
arm                           sama5_defconfig
powerpc                 mpc8560_ads_defconfig
arm                        magician_defconfig
sh                            migor_defconfig
arm                           viper_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                 randconfig-a005-20201014
i386                 randconfig-a006-20201014
i386                 randconfig-a001-20201014
i386                 randconfig-a003-20201014
i386                 randconfig-a004-20201014
i386                 randconfig-a002-20201014
x86_64               randconfig-a016-20201014
x86_64               randconfig-a012-20201014
x86_64               randconfig-a015-20201014
x86_64               randconfig-a013-20201014
x86_64               randconfig-a014-20201014
x86_64               randconfig-a011-20201014
i386                 randconfig-a016-20201014
i386                 randconfig-a013-20201014
i386                 randconfig-a015-20201014
i386                 randconfig-a011-20201014
i386                 randconfig-a012-20201014
i386                 randconfig-a014-20201014
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
x86_64               randconfig-a004-20201014
x86_64               randconfig-a002-20201014
x86_64               randconfig-a006-20201014
x86_64               randconfig-a001-20201014
x86_64               randconfig-a005-20201014
x86_64               randconfig-a003-20201014
x86_64               randconfig-a016-20201015
x86_64               randconfig-a012-20201015
x86_64               randconfig-a015-20201015
x86_64               randconfig-a013-20201015
x86_64               randconfig-a014-20201015
x86_64               randconfig-a011-20201015

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
