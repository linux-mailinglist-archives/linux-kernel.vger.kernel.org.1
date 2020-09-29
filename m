Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA57727BCC6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 08:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgI2GHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 02:07:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:41000 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgI2GHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 02:07:42 -0400
IronPort-SDR: 4reFBUk087b8scjRC9CD1oCAyoF1U+51+KIutDzex3eK0JNfNT/TvAcsRN7zzIpYM+9Z27w/Xh
 6gIBO0syulbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="223712617"
X-IronPort-AV: E=Sophos;i="5.77,317,1596524400"; 
   d="scan'208";a="223712617"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 23:07:41 -0700
IronPort-SDR: 9Hv8iqMGdBSjGoOwqMLDX7M3njEoBUOrrQc2y/1GhOwjzxGjObR0vfl9o8UYiyhhjrBUUy3RRR
 4gkHC4b9EbYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,317,1596524400"; 
   d="scan'208";a="307629243"
Received: from lkp-server02.sh.intel.com (HELO 029ab7997206) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 28 Sep 2020 23:07:40 -0700
Received: from kbuild by 029ab7997206 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kN8nb-00009J-Nv; Tue, 29 Sep 2020 06:07:39 +0000
Date:   Tue, 29 Sep 2020 14:07:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:urezki-pcount.2020.09.27a] BUILD SUCCESS
 12e20d125d431ead1a468ed33937924d0109824e
Message-ID: <5f72cf0f.irPa8J0y25eml0ld%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  urezki-pcount.2020.09.27a
branch HEAD: 12e20d125d431ead1a468ed33937924d0109824e  kvfree_rcu(): Fix ifnullfree.cocci warnings

elapsed time: 847m

configs tested: 140
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                     haps_hs_smp_defconfig
m68k                          amiga_defconfig
ia64                         bigsur_defconfig
sh                             shx3_defconfig
m68k                        stmark2_defconfig
nios2                         3c120_defconfig
powerpc                      arches_defconfig
powerpc                      cm5200_defconfig
sparc                       sparc32_defconfig
arm                          badge4_defconfig
powerpc                        cell_defconfig
powerpc                     tqm8541_defconfig
powerpc64                           defconfig
csky                             alldefconfig
sh                          rsk7201_defconfig
openrisc                         alldefconfig
mips                      pic32mzda_defconfig
arm                   milbeaut_m10v_defconfig
m68k                          multi_defconfig
sh                        edosk7705_defconfig
arc                            hsdk_defconfig
m68k                       bvme6000_defconfig
arm                         mv78xx0_defconfig
riscv                               defconfig
powerpc                    ge_imp3a_defconfig
powerpc                      mgcoge_defconfig
mips                        maltaup_defconfig
alpha                            allyesconfig
powerpc                     tqm8548_defconfig
arm                          simpad_defconfig
powerpc                       maple_defconfig
powerpc                   bluestone_defconfig
powerpc                     tqm5200_defconfig
arm                             mxs_defconfig
arm                           omap1_defconfig
microblaze                      mmu_defconfig
powerpc                 mpc836x_rdk_defconfig
arc                      axs103_smp_defconfig
arm                              zx_defconfig
arm                        mvebu_v5_defconfig
c6x                        evmc6472_defconfig
i386                             alldefconfig
sh                           se7724_defconfig
riscv                    nommu_virt_defconfig
powerpc                     kilauea_defconfig
mips                      malta_kvm_defconfig
arm                         s5pv210_defconfig
mips                       bmips_be_defconfig
sh                           se7343_defconfig
arm                           sunxi_defconfig
m68k                          atari_defconfig
arm                         orion5x_defconfig
arm                         bcm2835_defconfig
mips                           xway_defconfig
arm                          pxa910_defconfig
powerpc                     pseries_defconfig
arm                         lpc32xx_defconfig
ia64                            zx1_defconfig
powerpc                    amigaone_defconfig
sh                          rsk7269_defconfig
sh                         microdev_defconfig
powerpc                      pmac32_defconfig
mips                   sb1250_swarm_defconfig
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
x86_64               randconfig-a005-20200928
x86_64               randconfig-a003-20200928
x86_64               randconfig-a004-20200928
x86_64               randconfig-a002-20200928
x86_64               randconfig-a006-20200928
x86_64               randconfig-a001-20200928
i386                 randconfig-a002-20200927
i386                 randconfig-a006-20200927
i386                 randconfig-a003-20200927
i386                 randconfig-a004-20200927
i386                 randconfig-a005-20200927
i386                 randconfig-a001-20200927
i386                 randconfig-a006-20200928
i386                 randconfig-a002-20200928
i386                 randconfig-a003-20200928
i386                 randconfig-a004-20200928
i386                 randconfig-a005-20200928
i386                 randconfig-a001-20200928
i386                 randconfig-a012-20200928
i386                 randconfig-a016-20200928
i386                 randconfig-a014-20200928
i386                 randconfig-a013-20200928
i386                 randconfig-a015-20200928
i386                 randconfig-a011-20200928
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-a011-20200928
x86_64               randconfig-a013-20200928
x86_64               randconfig-a015-20200928
x86_64               randconfig-a014-20200928
x86_64               randconfig-a016-20200928
x86_64               randconfig-a012-20200928

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
