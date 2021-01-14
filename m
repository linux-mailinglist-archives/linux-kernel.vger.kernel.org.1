Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B61F2F5879
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbhANCb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:31:58 -0500
Received: from mga17.intel.com ([192.55.52.151]:7033 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbhANCb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 21:31:56 -0500
IronPort-SDR: 0fU8XCSSqYIIVxr6LIcirtQOyXLoiEeFwuVFPEQuSjoLQ02fIIZBd4KxoAgE8IYDQh7BippI0l
 r4fOmld01HIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="158073550"
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; 
   d="scan'208";a="158073550"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 18:31:26 -0800
IronPort-SDR: qa+Pzlj5S1vB5dUzezDK86BO/aXo3K00IOBEDjxQNKbLnaRo7oJIcxt7F332pecNnPuOH8cr0C
 HDrkUU32ViZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; 
   d="scan'208";a="397909595"
Received: from lkp-server01.sh.intel.com (HELO d5d1a9a2c6bb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jan 2021 18:31:25 -0800
Received: from kbuild by d5d1a9a2c6bb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kzsQ0-0000US-Db; Thu, 14 Jan 2021 02:31:24 +0000
Date:   Thu, 14 Jan 2021 10:31:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 ed7518a9941318df412cd70c9405b2f63f8beb57
Message-ID: <5fffacf3.KnzdF+THFCb1fxTM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: ed7518a9941318df412cd70c9405b2f63f8beb57  Merge branch 'irq/urgent'

elapsed time: 721m

configs tested: 167
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                          hp300_defconfig
powerpc64                           defconfig
ia64                             allyesconfig
m68k                          multi_defconfig
powerpc                      pasemi_defconfig
mips                         bigsur_defconfig
mips                       rbtx49xx_defconfig
c6x                              alldefconfig
powerpc                 mpc8560_ads_defconfig
arm                         vf610m4_defconfig
h8300                               defconfig
ia64                      gensparse_defconfig
arm                          pxa910_defconfig
powerpc                         ps3_defconfig
powerpc                 mpc832x_rdb_defconfig
nios2                         10m50_defconfig
arm                           sama5_defconfig
sh                           se7619_defconfig
powerpc                     ksi8560_defconfig
arm                       imx_v4_v5_defconfig
powerpc                      ppc64e_defconfig
powerpc                    gamecube_defconfig
mips                          ath25_defconfig
c6x                        evmc6457_defconfig
arm                            hisi_defconfig
arc                           tb10x_defconfig
arm                        mvebu_v7_defconfig
mips                      pistachio_defconfig
sh                         ap325rxa_defconfig
sh                           se7751_defconfig
arm                       versatile_defconfig
mips                          ath79_defconfig
arc                     nsimosci_hs_defconfig
powerpc                 mpc834x_itx_defconfig
arm                       imx_v6_v7_defconfig
sh                               allmodconfig
arm                        magician_defconfig
mips                       lemote2f_defconfig
mips                malta_kvm_guest_defconfig
arm                         lpc18xx_defconfig
sh                          polaris_defconfig
ia64                          tiger_defconfig
arm                          ep93xx_defconfig
powerpc                        icon_defconfig
arm                        clps711x_defconfig
arm                        neponset_defconfig
mips                           ci20_defconfig
mips                        bcm63xx_defconfig
powerpc                      walnut_defconfig
c6x                         dsk6455_defconfig
m68k                          sun3x_defconfig
arm                          collie_defconfig
sh                      rts7751r2d1_defconfig
mips                           ip28_defconfig
sh                           se7206_defconfig
powerpc                     skiroot_defconfig
mips                 decstation_r4k_defconfig
arm                          simpad_defconfig
parisc                              defconfig
mips                           xway_defconfig
arm                           u8500_defconfig
sh                           se7343_defconfig
sh                     sh7710voipgw_defconfig
sh                        sh7785lcr_defconfig
m68k                        m5307c3_defconfig
arc                      axs103_smp_defconfig
m68k                        mvme16x_defconfig
arm                        vexpress_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                 mpc832x_mds_defconfig
arm                          exynos_defconfig
c6x                        evmc6472_defconfig
ia64                            zx1_defconfig
powerpc                     kmeter1_defconfig
mips                        qi_lb60_defconfig
microblaze                          defconfig
sh                         ecovec24_defconfig
powerpc                      chrp32_defconfig
nios2                            alldefconfig
arm                         s3c6400_defconfig
mips                           jazz_defconfig
powerpc                       holly_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                      tqm8xx_defconfig
mips                      pic32mzda_defconfig
arm                     am200epdkit_defconfig
arc                        nsimosci_defconfig
powerpc                 mpc8313_rdb_defconfig
arc                    vdk_hs38_smp_defconfig
arc                              alldefconfig
riscv                             allnoconfig
m68k                        m5272c3_defconfig
powerpc                           allnoconfig
arm                             ezx_defconfig
arm                         assabet_defconfig
arm                        spear3xx_defconfig
ia64                             allmodconfig
ia64                                defconfig
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
