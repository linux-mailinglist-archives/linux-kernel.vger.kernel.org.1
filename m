Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED112967F3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 02:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373813AbgJWAco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 20:32:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:1579 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S373773AbgJWAco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 20:32:44 -0400
IronPort-SDR: trf3Z1iiRpq16Y1Tux73lrD2Ucbc0klQca1y00zvLnkdOjY8fe7fNHstELOiwI5ucWegE0vM/3
 SxtDOJt/cudA==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="167734550"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="167734550"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 17:32:43 -0700
IronPort-SDR: Mqe/477i9lrzbLxp/Bjhs8wEONigVbZAPuXGHyNdMHgyCU9mZ2NGSeadjnhiZogwBECWEbm+kS
 piKcP3u2jghw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="321556032"
Received: from lkp-server01.sh.intel.com (HELO 56e21eaf2661) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Oct 2020 17:32:42 -0700
Received: from kbuild by 56e21eaf2661 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kVl0b-00008g-Ed; Fri, 23 Oct 2020 00:32:41 +0000
Date:   Fri, 23 Oct 2020 08:31:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 abee7c494d8c41bb388839bccc47e06247f0d7de
Message-ID: <5f92246c.vqCdr2GI9e+50jut%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: abee7c494d8c41bb388839bccc47e06247f0d7de  x86/alternative: Don't call text_poke() in lazy TLB mode

elapsed time: 724m

configs tested: 178
configs skipped: 68

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
arm                    vt8500_v6_v7_defconfig
riscv                    nommu_k210_defconfig
powerpc                    klondike_defconfig
arm                          pcm027_defconfig
arm                      pxa255-idp_defconfig
m68k                        stmark2_defconfig
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
arc                                 defconfig
sh                               allmodconfig
mips                          rb532_defconfig
m68k                             alldefconfig
um                           x86_64_defconfig
parisc                              defconfig
arm                      footbridge_defconfig
sh                             shx3_defconfig
powerpc                     redwood_defconfig
sh                             sh03_defconfig
mips                      bmips_stb_defconfig
sparc64                          alldefconfig
sh                     magicpanelr2_defconfig
xtensa                generic_kc705_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                     asp8347_defconfig
m68k                          sun3x_defconfig
powerpc                       eiger_defconfig
arm                         s3c6400_defconfig
arm                       imx_v6_v7_defconfig
arm                        mvebu_v5_defconfig
c6x                         dsk6455_defconfig
arm                         s5pv210_defconfig
m68k                          hp300_defconfig
arc                         haps_hs_defconfig
mips                        qi_lb60_defconfig
arm                            hisi_defconfig
arm                        multi_v5_defconfig
xtensa                              defconfig
um                             i386_defconfig
arm                        realview_defconfig
powerpc                      ppc6xx_defconfig
m68k                       bvme6000_defconfig
powerpc                     tqm8555_defconfig
arm                        keystone_defconfig
arc                              allyesconfig
sh                          sdk7780_defconfig
powerpc                     rainier_defconfig
mips                           ip22_defconfig
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
