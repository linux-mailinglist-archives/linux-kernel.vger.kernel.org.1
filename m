Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDAF527E2B4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgI3HgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:36:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:22486 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgI3HgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:36:08 -0400
IronPort-SDR: fgUzeHoyFR5hRfLgOpFE0AQOVgUb+52xivXMjaFYXmVkapwCO7/zJimQpxueRiFURhMn/FEORy
 hD+IgP7q6FVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="162447229"
X-IronPort-AV: E=Sophos;i="5.77,321,1596524400"; 
   d="scan'208";a="162447229"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 00:36:06 -0700
IronPort-SDR: /jKHkbEWRblpLYPvjxw5mQXfTVhS1r2Z3Rfo7M5eV7vgHmSrmk2NciXER9xTXkGxdz+qVzk2Ul
 XWOfSbsWhxTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,321,1596524400"; 
   d="scan'208";a="496137676"
Received: from lkp-server02.sh.intel.com (HELO de448af6ea1b) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 30 Sep 2020 00:36:04 -0700
Received: from kbuild by de448af6ea1b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kNWei-000084-2Q; Wed, 30 Sep 2020 07:36:04 +0000
Date:   Wed, 30 Sep 2020 15:35:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:for-next/kspp] BUILD SUCCESS
 736116436e5b99b46e1a49c17cae6f6ee0a30e84
Message-ID: <5f74354d.kxeTkFBXKh8aMfuB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  for-next/kspp
branch HEAD: 736116436e5b99b46e1a49c17cae6f6ee0a30e84  include: jhash/signal: Fix fall-through warnings for Clang

elapsed time: 725m

configs tested: 172
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      pcm030_defconfig
arm                        shmobile_defconfig
mips                         db1xxx_defconfig
sh                          sdk7780_defconfig
powerpc                 mpc8560_ads_defconfig
csky                                defconfig
ia64                        generic_defconfig
mips                       rbtx49xx_defconfig
powerpc                      pmac32_defconfig
powerpc64                        alldefconfig
sh                        sh7785lcr_defconfig
arm                           efm32_defconfig
sh                           se7750_defconfig
mips                         tb0226_defconfig
sh                             shx3_defconfig
openrisc                 simple_smp_defconfig
xtensa                         virt_defconfig
powerpc                   bluestone_defconfig
arm                         s5pv210_defconfig
m68k                        mvme147_defconfig
riscv                            alldefconfig
arm                           viper_defconfig
powerpc                 mpc834x_mds_defconfig
m68k                       m5275evb_defconfig
powerpc                       eiger_defconfig
powerpc                     mpc512x_defconfig
um                            kunit_defconfig
sh                     magicpanelr2_defconfig
powerpc               mpc834x_itxgp_defconfig
openrisc                            defconfig
xtensa                          iss_defconfig
mips                        nlm_xlr_defconfig
powerpc                     ppa8548_defconfig
arm                      tct_hammer_defconfig
powerpc                        icon_defconfig
mips                           gcw0_defconfig
powerpc                    gamecube_defconfig
arm                             ezx_defconfig
sh                        dreamcast_defconfig
xtensa                           allyesconfig
mips                          rm200_defconfig
m68k                       m5249evb_defconfig
arc                    vdk_hs38_smp_defconfig
mips                        maltaup_defconfig
arm                       versatile_defconfig
arm                       omap2plus_defconfig
powerpc                    socrates_defconfig
parisc                generic-64bit_defconfig
xtensa                  audio_kc705_defconfig
s390                       zfcpdump_defconfig
powerpc                      ep88xc_defconfig
sh                         apsh4a3a_defconfig
s390                             allyesconfig
arm                            u300_defconfig
m68k                          hp300_defconfig
sh                            titan_defconfig
sparc                       sparc32_defconfig
arm                        multi_v5_defconfig
arm                       multi_v4t_defconfig
arm                           sunxi_defconfig
arc                        vdk_hs38_defconfig
mips                             allmodconfig
arm                      pxa255-idp_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                          simpad_defconfig
sh                        edosk7705_defconfig
powerpc                 mpc837x_rdb_defconfig
arc                              allyesconfig
mips                      pic32mzda_defconfig
mips                       lemote2f_defconfig
mips                 decstation_r4k_defconfig
m68k                             alldefconfig
arc                         haps_hs_defconfig
sh                   sh7770_generic_defconfig
arm                           h5000_defconfig
mips                         tb0287_defconfig
nds32                               defconfig
mips                           mtx1_defconfig
arm                            pleb_defconfig
sh                        apsh4ad0a_defconfig
um                           x86_64_defconfig
arm                        multi_v7_defconfig
sparc64                             defconfig
powerpc                      ppc6xx_defconfig
arm                          iop32x_defconfig
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
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20200929
i386                 randconfig-a002-20200929
i386                 randconfig-a003-20200929
i386                 randconfig-a004-20200929
i386                 randconfig-a005-20200929
i386                 randconfig-a001-20200929
x86_64               randconfig-a011-20200929
x86_64               randconfig-a013-20200929
x86_64               randconfig-a015-20200929
x86_64               randconfig-a014-20200929
x86_64               randconfig-a016-20200929
x86_64               randconfig-a012-20200929
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
i386                 randconfig-a012-20200929
i386                 randconfig-a016-20200929
i386                 randconfig-a014-20200929
i386                 randconfig-a013-20200929
i386                 randconfig-a015-20200929
i386                 randconfig-a011-20200929
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
x86_64               randconfig-a005-20200930
x86_64               randconfig-a003-20200930
x86_64               randconfig-a004-20200930
x86_64               randconfig-a002-20200930
x86_64               randconfig-a006-20200930
x86_64               randconfig-a005-20200929
x86_64               randconfig-a003-20200929
x86_64               randconfig-a004-20200929
x86_64               randconfig-a002-20200929
x86_64               randconfig-a006-20200929
x86_64               randconfig-a001-20200929

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
