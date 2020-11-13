Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33C52B1989
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 12:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgKMLEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 06:04:45 -0500
Received: from mga18.intel.com ([134.134.136.126]:21003 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbgKMLCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:02:46 -0500
IronPort-SDR: hgufqrldWk4D43Cgk0T9g6J+WltwjvSoKhY/SHpQ/G0M54Fj4Z7OAPbuhABENbJAh3fIzB9sH2
 7GBiKh2N/ykw==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="158234400"
X-IronPort-AV: E=Sophos;i="5.77,475,1596524400"; 
   d="scan'208";a="158234400"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 03:02:25 -0800
IronPort-SDR: MjXQlZxnjehpPECnvVTu880aFRzRCi/SAsSTltnhVJQJUHYF3XYTVyJ8l9KO94EktAhT0b59nw
 +epVx4qtAvgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,475,1596524400"; 
   d="scan'208";a="474623029"
Received: from lkp-server02.sh.intel.com (HELO 697932c29306) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 13 Nov 2020 03:02:23 -0800
Received: from kbuild by 697932c29306 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kdWqV-0000Es-3N; Fri, 13 Nov 2020 11:02:23 +0000
Date:   Fri, 13 Nov 2020 19:02:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 77c7e1bc060deab6430f1dff5922ccd3093d9776
Message-ID: <5fae67b3.L1jEXA08vwsNrtxP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: 77c7e1bc060deab6430f1dff5922ccd3093d9776  x86/platform/uv: Fix copied UV5 output archtype

elapsed time: 720m

configs tested: 170
configs skipped: 61

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     sbc8548_defconfig
arm                         lubbock_defconfig
powerpc                      acadia_defconfig
powerpc                    ge_imp3a_defconfig
arm                        shmobile_defconfig
sparc                               defconfig
sparc64                          alldefconfig
sh                        dreamcast_defconfig
m68k                          hp300_defconfig
sh                           se7722_defconfig
arm                          ep93xx_defconfig
mips                        nlm_xlr_defconfig
c6x                        evmc6474_defconfig
arm                       aspeed_g4_defconfig
m68k                          atari_defconfig
powerpc                     pseries_defconfig
arm                   milbeaut_m10v_defconfig
arm                        multi_v5_defconfig
mips                     loongson1c_defconfig
parisc                generic-32bit_defconfig
arm                          tango4_defconfig
arm                         s3c2410_defconfig
xtensa                              defconfig
sh                          lboxre2_defconfig
m68k                         apollo_defconfig
powerpc                        warp_defconfig
arm                  colibri_pxa270_defconfig
arm                              alldefconfig
sh                          rsk7203_defconfig
mips                     loongson1b_defconfig
arm                             mxs_defconfig
powerpc                    mvme5100_defconfig
sh                          sdk7786_defconfig
mips                       bmips_be_defconfig
sparc                       sparc32_defconfig
powerpc                     tqm8548_defconfig
um                            kunit_defconfig
arc                          axs103_defconfig
sh                           se7750_defconfig
arc                           tb10x_defconfig
c6x                              alldefconfig
arc                     nsimosci_hs_defconfig
c6x                        evmc6457_defconfig
sh                         ap325rxa_defconfig
powerpc                      ep88xc_defconfig
powerpc                     asp8347_defconfig
ia64                          tiger_defconfig
powerpc                       ppc64_defconfig
powerpc                    adder875_defconfig
powerpc                       ebony_defconfig
xtensa                    smp_lx200_defconfig
microblaze                      mmu_defconfig
arm                        trizeps4_defconfig
powerpc                  mpc885_ads_defconfig
sh                      rts7751r2d1_defconfig
h8300                     edosk2674_defconfig
mips                             allyesconfig
powerpc                 mpc836x_rdk_defconfig
nios2                            allyesconfig
arm                       imx_v6_v7_defconfig
sh                  sh7785lcr_32bit_defconfig
x86_64                           alldefconfig
m68k                       m5208evb_defconfig
mips                           xway_defconfig
mips                        jmr3927_defconfig
powerpc                     sequoia_defconfig
mips                          rb532_defconfig
powerpc                          allmodconfig
s390                          debug_defconfig
arm                         hackkit_defconfig
x86_64                           allyesconfig
arc                 nsimosci_hs_smp_defconfig
arm                            pleb_defconfig
mips                        omega2p_defconfig
arm                         assabet_defconfig
arm                            u300_defconfig
openrisc                 simple_smp_defconfig
arm                     davinci_all_defconfig
nds32                               defconfig
mips                      fuloong2e_defconfig
arc                            hsdk_defconfig
mips                      pistachio_defconfig
powerpc                       maple_defconfig
sh                               allmodconfig
arm                           spitz_defconfig
powerpc                      pmac32_defconfig
arm                           viper_defconfig
arm                       omap2plus_defconfig
mips                        qi_lb60_defconfig
powerpc                       holly_defconfig
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
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201111
i386                 randconfig-a005-20201111
i386                 randconfig-a002-20201111
i386                 randconfig-a001-20201111
i386                 randconfig-a003-20201111
i386                 randconfig-a004-20201111
i386                 randconfig-a006-20201113
i386                 randconfig-a005-20201113
i386                 randconfig-a002-20201113
i386                 randconfig-a001-20201113
i386                 randconfig-a003-20201113
i386                 randconfig-a004-20201113
x86_64               randconfig-a015-20201113
x86_64               randconfig-a011-20201113
x86_64               randconfig-a014-20201113
x86_64               randconfig-a013-20201113
x86_64               randconfig-a016-20201113
x86_64               randconfig-a012-20201113
x86_64               randconfig-a015-20201111
x86_64               randconfig-a011-20201111
x86_64               randconfig-a014-20201111
x86_64               randconfig-a013-20201111
x86_64               randconfig-a016-20201111
x86_64               randconfig-a012-20201111
i386                 randconfig-a012-20201113
i386                 randconfig-a014-20201113
i386                 randconfig-a016-20201113
i386                 randconfig-a011-20201113
i386                 randconfig-a015-20201113
i386                 randconfig-a013-20201113
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20201113
x86_64               randconfig-a005-20201113
x86_64               randconfig-a004-20201113
x86_64               randconfig-a002-20201113
x86_64               randconfig-a006-20201113
x86_64               randconfig-a001-20201113

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
