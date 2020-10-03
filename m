Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88B8281FDF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 02:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbgJCAxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 20:53:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:53276 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgJCAxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 20:53:55 -0400
IronPort-SDR: 46B1LC4/uT1k4v7ggxzXuqju+9+cZQULgcBYRzrUCO+oG+kFOubQ/atJvghzjWhbhcylioD6F6
 5iYXKsXXYU2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="160434940"
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="160434940"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 17:53:54 -0700
IronPort-SDR: mRASdR68gfRGX7NTizGi/jZ5k7Hze+0zR7LAxscwms79WjVwSWMkGb6vGGsf5uL5H06mGBVXgZ
 PFq4RBS8UbYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="309193823"
Received: from lkp-server02.sh.intel.com (HELO 404f47266ee4) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 02 Oct 2020 17:53:52 -0700
Received: from kbuild by 404f47266ee4 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kOVo7-0000BF-Rs; Sat, 03 Oct 2020 00:53:51 +0000
Date:   Sat, 03 Oct 2020 08:53:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 238c91115cd05c71447ea071624a4c9fe661f970
Message-ID: <5f77cb73.aSVdM1OYbIb3BHiF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/core
branch HEAD: 238c91115cd05c71447ea071624a4c9fe661f970  x86/dumpstack: Fix misleading instruction pointer error message

elapsed time: 723m

configs tested: 172
configs skipped: 63

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                          moxart_defconfig
mips                           ip32_defconfig
arm                       spear13xx_defconfig
powerpc                   motionpro_defconfig
powerpc                    amigaone_defconfig
mips                        maltaup_defconfig
mips                       rbtx49xx_defconfig
powerpc                          allmodconfig
powerpc                      makalu_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      ppc6xx_defconfig
arm                         s3c2410_defconfig
arm                           viper_defconfig
arm                         lpc18xx_defconfig
powerpc                      ep88xc_defconfig
powerpc                      ppc64e_defconfig
arm                   milbeaut_m10v_defconfig
arm                          ep93xx_defconfig
arm                         palmz72_defconfig
m68k                       m5475evb_defconfig
sh                   secureedge5410_defconfig
arm                           tegra_defconfig
sh                           se7619_defconfig
mips                       lemote2f_defconfig
mips                 decstation_r4k_defconfig
s390                       zfcpdump_defconfig
m68k                        m5307c3_defconfig
sh                           se7724_defconfig
um                             i386_defconfig
arm                       multi_v4t_defconfig
sh                        dreamcast_defconfig
arm                            zeus_defconfig
powerpc                     tqm8555_defconfig
sh                           se7343_defconfig
powerpc                        cell_defconfig
m68k                        stmark2_defconfig
arm                         axm55xx_defconfig
powerpc                     tqm5200_defconfig
mips                     loongson1b_defconfig
sh                          sdk7786_defconfig
arm                     am200epdkit_defconfig
xtensa                generic_kc705_defconfig
alpha                            alldefconfig
powerpc                    mvme5100_defconfig
sh                            titan_defconfig
riscv                               defconfig
powerpc                     mpc512x_defconfig
arm                            lart_defconfig
mips                           jazz_defconfig
c6x                         dsk6455_defconfig
arm                        mini2440_defconfig
c6x                        evmc6474_defconfig
arm                          imote2_defconfig
arm                       imx_v4_v5_defconfig
arm                            xcep_defconfig
ia64                            zx1_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                          polaris_defconfig
sh                          kfr2r09_defconfig
m68k                        m5407c3_defconfig
riscv                    nommu_virt_defconfig
xtensa                       common_defconfig
arm                       omap2plus_defconfig
sh                          rsk7264_defconfig
mips                        bcm47xx_defconfig
powerpc                 canyonlands_defconfig
arm                        multi_v7_defconfig
powerpc                 mpc832x_mds_defconfig
sparc64                          alldefconfig
mips                      pistachio_defconfig
arm                        oxnas_v6_defconfig
mips                        bcm63xx_defconfig
powerpc                       maple_defconfig
powerpc                       ebony_defconfig
powerpc                         wii_defconfig
powerpc                     tqm8541_defconfig
m68k                             alldefconfig
arm                            mmp2_defconfig
mips                            gpr_defconfig
powerpc                      ppc44x_defconfig
xtensa                         virt_defconfig
arm                        clps711x_defconfig
mips                          rb532_defconfig
arm                        multi_v5_defconfig
powerpc                     kmeter1_defconfig
arm                        spear6xx_defconfig
powerpc                          g5_defconfig
mips                         mpc30x_defconfig
arm                  colibri_pxa270_defconfig
m68k                           sun3_defconfig
sh                          lboxre2_defconfig
mips                  cavium_octeon_defconfig
s390                          debug_defconfig
sh                           se7751_defconfig
mips                          malta_defconfig
arm                        mvebu_v7_defconfig
arm                        vexpress_defconfig
parisc                              defconfig
mips                            ar7_defconfig
arm                            dove_defconfig
powerpc                     stx_gp3_defconfig
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
powerpc                           allnoconfig
x86_64               randconfig-a004-20201002
x86_64               randconfig-a001-20201002
x86_64               randconfig-a002-20201002
x86_64               randconfig-a005-20201002
x86_64               randconfig-a003-20201002
x86_64               randconfig-a006-20201002
i386                 randconfig-a006-20201002
i386                 randconfig-a005-20201002
i386                 randconfig-a001-20201002
i386                 randconfig-a004-20201002
i386                 randconfig-a003-20201002
i386                 randconfig-a002-20201002
i386                 randconfig-a014-20201002
i386                 randconfig-a013-20201002
i386                 randconfig-a015-20201002
i386                 randconfig-a016-20201002
i386                 randconfig-a011-20201002
i386                 randconfig-a012-20201002
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
x86_64               randconfig-a012-20201002
x86_64               randconfig-a015-20201002
x86_64               randconfig-a014-20201002
x86_64               randconfig-a013-20201002
x86_64               randconfig-a011-20201002
x86_64               randconfig-a016-20201002

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
