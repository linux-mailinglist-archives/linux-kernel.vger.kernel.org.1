Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F832CCC5B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 03:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgLCCSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 21:18:09 -0500
Received: from mga01.intel.com ([192.55.52.88]:51518 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgLCCSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 21:18:09 -0500
IronPort-SDR: NExNx8e7toH/Z3mQYbW+zno+4mXbYa498TgCwrLtojP1Hw5sjgI2oCRr25LcxzeDL1OFB4s3bS
 rC4iypFGxqzA==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="191344462"
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="191344462"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 18:17:28 -0800
IronPort-SDR: fokjxS6GmeLIeveSkFUO+rbCj5PONTip9SukHXG7KNIn0SAwrP4hFfJ1UqQM2R72B2jZvEN3H+
 77ZVyAhea1rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="365557470"
Received: from lkp-server01.sh.intel.com (HELO 54133fc185c3) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 02 Dec 2020 18:17:27 -0800
Received: from kbuild by 54133fc185c3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kkeBS-0000So-M2; Thu, 03 Dec 2020 02:17:26 +0000
Date:   Thu, 03 Dec 2020 10:16:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/entry] BUILD SUCCESS
 c6156e1da633f241e132eaea3b676d674376d770
Message-ID: <5fc84a83.repQq7B2rJil7Jqa%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  core/entry
branch HEAD: c6156e1da633f241e132eaea3b676d674376d770  entry: Add syscall_exit_to_user_mode_work()

elapsed time: 725m

configs tested: 146
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                        clps711x_defconfig
arm                        shmobile_defconfig
powerpc64                        alldefconfig
mips                 decstation_r4k_defconfig
nios2                         3c120_defconfig
mips                         bigsur_defconfig
mips                malta_qemu_32r6_defconfig
mips                         mpc30x_defconfig
microblaze                      mmu_defconfig
sh                     sh7710voipgw_defconfig
powerpc                     redwood_defconfig
parisc                           alldefconfig
mips                      pic32mzda_defconfig
powerpc                     skiroot_defconfig
sh                          rsk7264_defconfig
powerpc                        fsp2_defconfig
sh                             shx3_defconfig
sh                        sh7785lcr_defconfig
sh                            titan_defconfig
csky                             alldefconfig
m68k                          sun3x_defconfig
arm                          ep93xx_defconfig
sh                           se7724_defconfig
powerpc                     powernv_defconfig
powerpc                      walnut_defconfig
arm                         s3c6400_defconfig
arm                       aspeed_g5_defconfig
sparc                       sparc32_defconfig
mips                         tb0287_defconfig
m68k                          hp300_defconfig
mips                     cu1830-neo_defconfig
sh                           se7343_defconfig
arm                            u300_defconfig
m68k                             alldefconfig
arm                        spear6xx_defconfig
arm                         assabet_defconfig
sh                              ul2_defconfig
xtensa                  nommu_kc705_defconfig
nds32                             allnoconfig
arm                       versatile_defconfig
sh                            hp6xx_defconfig
arm                           sunxi_defconfig
arm                       mainstone_defconfig
m68k                            q40_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                ecovec24-romimage_defconfig
mips                        nlm_xlr_defconfig
arc                     nsimosci_hs_defconfig
powerpc                     mpc5200_defconfig
powerpc                 mpc8272_ads_defconfig
openrisc                            defconfig
powerpc                       holly_defconfig
arm                          prima2_defconfig
arc                           tb10x_defconfig
m68k                                defconfig
arm                        keystone_defconfig
xtensa                              defconfig
powerpc                     stx_gp3_defconfig
arm                       cns3420vb_defconfig
arm                           omap1_defconfig
mips                       rbtx49xx_defconfig
arm                         s3c2410_defconfig
arm                         nhk8815_defconfig
mips                        maltaup_defconfig
mips                           ip32_defconfig
h8300                    h8300h-sim_defconfig
arm                           corgi_defconfig
powerpc                     ep8248e_defconfig
sh                   sh7770_generic_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                          landisk_defconfig
mips                     cu1000-neo_defconfig
arm                        mvebu_v5_defconfig
m68k                       m5275evb_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
x86_64               randconfig-a004-20201202
x86_64               randconfig-a006-20201202
x86_64               randconfig-a001-20201202
x86_64               randconfig-a002-20201202
x86_64               randconfig-a005-20201202
x86_64               randconfig-a003-20201202
i386                 randconfig-a004-20201202
i386                 randconfig-a005-20201202
i386                 randconfig-a001-20201202
i386                 randconfig-a002-20201202
i386                 randconfig-a006-20201202
i386                 randconfig-a003-20201202
i386                 randconfig-a014-20201202
i386                 randconfig-a013-20201202
i386                 randconfig-a011-20201202
i386                 randconfig-a015-20201202
i386                 randconfig-a012-20201202
i386                 randconfig-a016-20201202
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
x86_64               randconfig-a016-20201202
x86_64               randconfig-a012-20201202
x86_64               randconfig-a014-20201202
x86_64               randconfig-a013-20201202
x86_64               randconfig-a015-20201202
x86_64               randconfig-a011-20201202

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
