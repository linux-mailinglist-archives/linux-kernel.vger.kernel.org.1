Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F062D4C23
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 21:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbgLIUp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 15:45:26 -0500
Received: from mga12.intel.com ([192.55.52.136]:7229 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbgLIUp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 15:45:26 -0500
IronPort-SDR: 0sPpmqiMASPTcmj0i3uJdVaSvDwTAn46dHHnp/DBwPeg9Gj6wTqpIsIkLY5jmPmAE4LU91z3UF
 RvgWEgGHGxkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="153385076"
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="153385076"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 12:44:45 -0800
IronPort-SDR: Voihu5TLSvxiKC8qIOCHjdvPrB5Y+X3lWHLDqfYdyvEG2s84LO3Q4zJn8L1rwj5r2eUCQ5qY56
 p9yPj3/Vcdog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="368390218"
Received: from lkp-server01.sh.intel.com (HELO 2bbb63443648) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 09 Dec 2020 12:44:44 -0800
Received: from kbuild by 2bbb63443648 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kn6KJ-0000Rx-UB; Wed, 09 Dec 2020 20:44:43 +0000
Date:   Thu, 10 Dec 2020 04:44:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 e45cdc71d1fa5ac3a57b23acc31eb959e4f60135
Message-ID: <5fd1372b.OWk41utZQq1R/wdb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: e45cdc71d1fa5ac3a57b23acc31eb959e4f60135  membarrier: Execute SYNC_CORE on the calling thread

elapsed time: 724m

configs tested: 165
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
nds32                            alldefconfig
mips                        jmr3927_defconfig
arm                           spitz_defconfig
arm                             ezx_defconfig
m68k                       m5475evb_defconfig
m68k                        m5407c3_defconfig
sh                            titan_defconfig
powerpc                     redwood_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                              ul2_defconfig
ia64                             alldefconfig
sh                          lboxre2_defconfig
sh                          r7785rp_defconfig
powerpc                     mpc512x_defconfig
arm                            mps2_defconfig
powerpc                    sam440ep_defconfig
alpha                            alldefconfig
mips                        bcm63xx_defconfig
m68k                          hp300_defconfig
ia64                             allmodconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                 linkstation_defconfig
arm                            hisi_defconfig
sh                          rsk7201_defconfig
powerpc                      tqm8xx_defconfig
arc                        vdk_hs38_defconfig
powerpc                      walnut_defconfig
ia64                         bigsur_defconfig
powerpc                     rainier_defconfig
powerpc                     tqm8555_defconfig
mips                      loongson3_defconfig
mips                           gcw0_defconfig
sh                          kfr2r09_defconfig
sh                           se7724_defconfig
arm                           viper_defconfig
arm                     davinci_all_defconfig
powerpc                      mgcoge_defconfig
mips                         bigsur_defconfig
powerpc                      ppc64e_defconfig
sh                            shmin_defconfig
mips                         tb0226_defconfig
arm                         socfpga_defconfig
arm                        vexpress_defconfig
powerpc                   motionpro_defconfig
mips                           ip28_defconfig
arc                           tb10x_defconfig
powerpc                      ppc44x_defconfig
mips                         tb0219_defconfig
mips                  maltasmvp_eva_defconfig
mips                     cu1000-neo_defconfig
powerpc                     tqm5200_defconfig
powerpc                     sequoia_defconfig
c6x                              alldefconfig
arm                          ixp4xx_defconfig
m68k                         apollo_defconfig
arm                          pcm027_defconfig
mips                          ath25_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        oxnas_v6_defconfig
s390                                defconfig
arm                        spear6xx_defconfig
arm                         s3c6400_defconfig
mips                         db1xxx_defconfig
mips                            ar7_defconfig
arm                       versatile_defconfig
sh                           se7751_defconfig
arm                            mmp2_defconfig
powerpc                       holly_defconfig
arm                           h5000_defconfig
sh                            migor_defconfig
powerpc                    socrates_defconfig
powerpc                    klondike_defconfig
arm                       imx_v6_v7_defconfig
riscv                             allnoconfig
arm                           tegra_defconfig
powerpc                     tqm8541_defconfig
m68k                             alldefconfig
arm                          ep93xx_defconfig
arm                        cerfcube_defconfig
arm                       multi_v4t_defconfig
arm                          pxa168_defconfig
powerpc                 xes_mpc85xx_defconfig
m68k                       bvme6000_defconfig
sh                           se7619_defconfig
sparc                               defconfig
arm                          prima2_defconfig
arm                            pleb_defconfig
powerpc                     pseries_defconfig
powerpc                        icon_defconfig
arm                              alldefconfig
sh                      rts7751r2d1_defconfig
mips                           xway_defconfig
mips                         cobalt_defconfig
mips                        nlm_xlp_defconfig
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
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201209
i386                 randconfig-a005-20201209
i386                 randconfig-a001-20201209
i386                 randconfig-a002-20201209
i386                 randconfig-a006-20201209
i386                 randconfig-a003-20201209
x86_64               randconfig-a016-20201209
x86_64               randconfig-a012-20201209
x86_64               randconfig-a013-20201209
x86_64               randconfig-a014-20201209
x86_64               randconfig-a015-20201209
x86_64               randconfig-a011-20201209
i386                 randconfig-a013-20201209
i386                 randconfig-a014-20201209
i386                 randconfig-a011-20201209
i386                 randconfig-a015-20201209
i386                 randconfig-a012-20201209
i386                 randconfig-a016-20201209
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
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201209
x86_64               randconfig-a006-20201209
x86_64               randconfig-a005-20201209
x86_64               randconfig-a001-20201209
x86_64               randconfig-a002-20201209
x86_64               randconfig-a003-20201209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
