Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD77327EA78
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730469AbgI3N7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:59:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:39031 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729903AbgI3N7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:59:03 -0400
IronPort-SDR: dEmsSVmAdS5kHegjIvE09DgA0ThVpNuxgx0oSEYj91o+KHWhAvHoTSnbImVF+nHDFIJMUUiAYY
 +VFcTZJpLPhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="142462568"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="142462568"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 06:59:03 -0700
IronPort-SDR: 172F7qzqv4ClnB3noJ/CYZ0YD9Pe4nU9S8KbZv9JtgRc2KEweEIX0eeWRTTOapabC/woL1MRFs
 15HfWgiCahdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="294614595"
Received: from lkp-server02.sh.intel.com (HELO de448af6ea1b) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 30 Sep 2020 06:59:01 -0700
Received: from kbuild by de448af6ea1b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kNcdJ-0000Ez-9X; Wed, 30 Sep 2020 13:59:01 +0000
Date:   Wed, 30 Sep 2020 21:58:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:urezki-pcount] BUILD SUCCESS
 6047305006ab5b3a632fe50cfb60147cf567f43e
Message-ID: <5f748f0f.du0///d1aKuTk7G9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  urezki-pcount
branch HEAD: 6047305006ab5b3a632fe50cfb60147cf567f43e  EXP Revert "KVM: Check the allocation of pv cpu mask"

elapsed time: 724m

configs tested: 114
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                           efm32_defconfig
sh                           se7750_defconfig
mips                         tb0226_defconfig
sh                             shx3_defconfig
openrisc                 simple_smp_defconfig
sh                           se7722_defconfig
m68k                       m5475evb_defconfig
mips                          rm200_defconfig
arm                          prima2_defconfig
arm                          iop32x_defconfig
mips                   sb1250_swarm_defconfig
m68k                       m5275evb_defconfig
powerpc                       eiger_defconfig
powerpc                     mpc512x_defconfig
um                            kunit_defconfig
sh                     magicpanelr2_defconfig
powerpc                  mpc885_ads_defconfig
mips                      bmips_stb_defconfig
arm                            hisi_defconfig
arm                         lpc32xx_defconfig
arm                           viper_defconfig
powerpc                      ppc44x_defconfig
arm                             mxs_defconfig
mips                        vocore2_defconfig
arc                          axs103_defconfig
powerpc                    mvme5100_defconfig
sh                            migor_defconfig
arc                              allyesconfig
mips                      pic32mzda_defconfig
mips                       lemote2f_defconfig
mips                 decstation_r4k_defconfig
arm                        mini2440_defconfig
arc                             nps_defconfig
sh                           se7343_defconfig
c6x                              alldefconfig
powerpc                        cell_defconfig
xtensa                         virt_defconfig
sparc64                             defconfig
powerpc                      ppc6xx_defconfig
arm                      pxa255-idp_defconfig
sh                           sh2007_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
i386                 randconfig-a003-20200930
i386                 randconfig-a002-20200930
i386                 randconfig-a006-20200930
i386                 randconfig-a005-20200930
i386                 randconfig-a004-20200930
i386                 randconfig-a001-20200930
x86_64               randconfig-a015-20200930
x86_64               randconfig-a013-20200930
x86_64               randconfig-a012-20200930
x86_64               randconfig-a011-20200930
x86_64               randconfig-a016-20200930
x86_64               randconfig-a014-20200930
i386                 randconfig-a011-20200930
i386                 randconfig-a015-20200930
i386                 randconfig-a012-20200930
i386                 randconfig-a014-20200930
i386                 randconfig-a016-20200930
i386                 randconfig-a013-20200930
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
x86_64               randconfig-a001-20200930
x86_64               randconfig-a003-20200930
x86_64               randconfig-a006-20200930
x86_64               randconfig-a005-20200930
x86_64               randconfig-a004-20200930
x86_64               randconfig-a002-20200930

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
