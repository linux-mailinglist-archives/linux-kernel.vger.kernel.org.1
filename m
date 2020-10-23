Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34735296855
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 03:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374344AbgJWBh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 21:37:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:46037 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S374337AbgJWBh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 21:37:58 -0400
IronPort-SDR: jF2v6f5ODMDKTyf2FTKMaLERHfFkw0VbxX4af9PYWuaMIxqnUUIFPMBYiBJ0YmuxaagjttM0Kt
 kXxzfuGmRseA==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="167711352"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="167711352"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 18:37:57 -0700
IronPort-SDR: jFGeKbBLprCAs9LwrGCow9eNZdXPuVP7WOphR9RkGhzXIcYVoHrZ7wH98jVpQ94OdRjSkHC1WJ
 cwAjHzbWblFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="534204728"
Received: from lkp-server01.sh.intel.com (HELO 56e21eaf2661) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Oct 2020 18:37:56 -0700
Received: from kbuild by 56e21eaf2661 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kVm1j-00009e-CT; Fri, 23 Oct 2020 01:37:55 +0000
Date:   Fri, 23 Oct 2020 09:37:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:auto-latest] BUILD SUCCESS
 65609b26b21a169a05d1482db6c1b52d8a4abe0d
Message-ID: <5f9233ed.aHZs/uoFKWj4Q5vL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  auto-latest
branch HEAD: 65609b26b21a169a05d1482db6c1b52d8a4abe0d  Merge branch 'locking/urgent'

elapsed time: 790m

configs tested: 176
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                 kfr2r09-romimage_defconfig
m68k                       m5208evb_defconfig
m68k                          amiga_defconfig
arm                            dove_defconfig
sh                        sh7785lcr_defconfig
powerpc                 mpc837x_mds_defconfig
mips                          ath79_defconfig
um                            kunit_defconfig
powerpc                     ppa8548_defconfig
sh                           se7206_defconfig
powerpc                     tqm5200_defconfig
arm                           spitz_defconfig
h8300                    h8300h-sim_defconfig
c6x                        evmc6474_defconfig
powerpc                        icon_defconfig
m68k                            q40_defconfig
arm                           sama5_defconfig
sh                        dreamcast_defconfig
arm                        trizeps4_defconfig
arm                         bcm2835_defconfig
ia64                          tiger_defconfig
arm                        mvebu_v7_defconfig
arm                       spear13xx_defconfig
powerpc                 mpc836x_mds_defconfig
xtensa                    xip_kc705_defconfig
powerpc                      obs600_defconfig
arm                        cerfcube_defconfig
powerpc                      ppc40x_defconfig
sh                           se7751_defconfig
powerpc                 mpc8560_ads_defconfig
sh                   sh7770_generic_defconfig
powerpc                      acadia_defconfig
mips                           ip27_defconfig
powerpc                      pasemi_defconfig
arm                       aspeed_g5_defconfig
arm                       netwinder_defconfig
arm                        oxnas_v6_defconfig
xtensa                  cadence_csp_defconfig
arm                       mainstone_defconfig
powerpc                      walnut_defconfig
powerpc                     sbc8548_defconfig
powerpc                     taishan_defconfig
sh                           se7721_defconfig
arm                     davinci_all_defconfig
arm                        spear6xx_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                        magician_defconfig
mips                  decstation_64_defconfig
arm                       omap2plus_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                     loongson1c_defconfig
ia64                            zx1_defconfig
arc                                 defconfig
sh                               allmodconfig
mips                          rb532_defconfig
m68k                             alldefconfig
um                           x86_64_defconfig
parisc                              defconfig
arm                      footbridge_defconfig
sh                             shx3_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     redwood_defconfig
sh                             sh03_defconfig
mips                      bmips_stb_defconfig
sparc64                          alldefconfig
sh                     magicpanelr2_defconfig
xtensa                generic_kc705_defconfig
powerpc                     asp8347_defconfig
m68k                          sun3x_defconfig
powerpc                       eiger_defconfig
arm                         s3c6400_defconfig
arm                       imx_v6_v7_defconfig
arm                        mvebu_v5_defconfig
c6x                         dsk6455_defconfig
arm                      pxa255-idp_defconfig
arm                         s5pv210_defconfig
m68k                          hp300_defconfig
arc                         haps_hs_defconfig
mips                        qi_lb60_defconfig
arm                            hisi_defconfig
arm                        multi_v5_defconfig
xtensa                              defconfig
mips                  cavium_octeon_defconfig
m68k                        m5407c3_defconfig
sh                             espt_defconfig
arm                        realview_defconfig
sh                          sdk7780_defconfig
powerpc                     rainier_defconfig
mips                           ip22_defconfig
arc                              allyesconfig
powerpc                     mpc5200_defconfig
arm                         cm_x300_defconfig
sparc                            allyesconfig
powerpc                    socrates_defconfig
c6x                        evmc6678_defconfig
mips                        omega2p_defconfig
ia64                      gensparse_defconfig
arm                         ebsa110_defconfig
powerpc                    mvme5100_defconfig
arm                             rpc_defconfig
powerpc                      ppc64e_defconfig
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
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20201022
i386                 randconfig-a005-20201022
i386                 randconfig-a003-20201022
i386                 randconfig-a001-20201022
i386                 randconfig-a006-20201022
i386                 randconfig-a004-20201022
i386                 randconfig-a002-20201023
i386                 randconfig-a005-20201023
i386                 randconfig-a003-20201023
i386                 randconfig-a001-20201023
i386                 randconfig-a006-20201023
i386                 randconfig-a004-20201023
x86_64               randconfig-a011-20201022
x86_64               randconfig-a013-20201022
x86_64               randconfig-a016-20201022
x86_64               randconfig-a015-20201022
x86_64               randconfig-a012-20201022
x86_64               randconfig-a014-20201022
i386                 randconfig-a016-20201022
i386                 randconfig-a014-20201022
i386                 randconfig-a015-20201022
i386                 randconfig-a012-20201022
i386                 randconfig-a013-20201022
i386                 randconfig-a011-20201022
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
x86_64               randconfig-a001-20201022
x86_64               randconfig-a002-20201022
x86_64               randconfig-a003-20201022
x86_64               randconfig-a006-20201022
x86_64               randconfig-a004-20201022
x86_64               randconfig-a005-20201022

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
