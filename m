Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B112CD065
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 08:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388199AbgLCH1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 02:27:45 -0500
Received: from mga07.intel.com ([134.134.136.100]:20471 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727848AbgLCH1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 02:27:44 -0500
IronPort-SDR: UHonbk2I3vRbhyDyyhSYx6SWbbRTgtQNfgt1llv/qrbxoo0FzBAFYaUUYtKXMX/kqIAe542LkE
 cZfm7W53LHGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="237268867"
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="237268867"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 23:27:03 -0800
IronPort-SDR: E9oVbaVtOOaoOxdDquwD+b9Gn1H30ESvM2zJis76BEj86Z6Mqx4pRS2jLyH/uf6qTgTOmwOXOz
 y7AC8XbjRX2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="346135270"
Received: from lkp-server01.sh.intel.com (HELO c4fb854e61c6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 Dec 2020 23:27:02 -0800
Received: from kbuild by c4fb854e61c6 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kkj14-00006k-0Q; Thu, 03 Dec 2020 07:27:02 +0000
Date:   Thu, 03 Dec 2020 15:26:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 d14ce74f1fb376ccbbc0b05ded477ada51253729
Message-ID: <5fc89313.kOWN9gl2qGCjBX5h%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  irq/core
branch HEAD: d14ce74f1fb376ccbbc0b05ded477ada51253729  irq: Call tick_irq_enter() inside HARDIRQ_OFFSET

elapsed time: 724m

configs tested: 195
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     tqm8541_defconfig
nios2                         3c120_defconfig
powerpc                     pseries_defconfig
sparc                       sparc64_defconfig
mips                           ip22_defconfig
m68k                          multi_defconfig
sh                           se7705_defconfig
c6x                        evmc6457_defconfig
mips                      malta_kvm_defconfig
arm                           sama5_defconfig
arm                         mv78xx0_defconfig
powerpc                     ksi8560_defconfig
powerpc                    sam440ep_defconfig
mips                       capcella_defconfig
powerpc                   currituck_defconfig
h8300                               defconfig
sh                          rsk7264_defconfig
powerpc                        fsp2_defconfig
sh                             shx3_defconfig
sh                        sh7785lcr_defconfig
powerpc                    adder875_defconfig
powerpc                     powernv_defconfig
powerpc                     ep8248e_defconfig
mips                         tb0226_defconfig
arc                        nsimosci_defconfig
mips                  maltasmvp_eva_defconfig
openrisc                            defconfig
parisc                generic-32bit_defconfig
arm                         orion5x_defconfig
powerpc                           allnoconfig
sh                           se7724_defconfig
sh                            titan_defconfig
csky                             alldefconfig
m68k                          sun3x_defconfig
arm                          ep93xx_defconfig
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
h8300                     edosk2674_defconfig
mips                        bcm47xx_defconfig
arm                        oxnas_v6_defconfig
mips                        nlm_xlp_defconfig
powerpc                          g5_defconfig
powerpc                         wii_defconfig
riscv                             allnoconfig
microblaze                      mmu_defconfig
um                            kunit_defconfig
arm                            mmp2_defconfig
arm                        mvebu_v5_defconfig
sparc                            alldefconfig
xtensa                  audio_kc705_defconfig
sh                           sh2007_defconfig
sh                     sh7710voipgw_defconfig
nios2                            alldefconfig
sparc64                             defconfig
powerpc                     sbc8548_defconfig
powerpc                 mpc8272_ads_defconfig
mips                         bigsur_defconfig
arm                          prima2_defconfig
arc                           tb10x_defconfig
m68k                                defconfig
powerpc                       maple_defconfig
parisc                           alldefconfig
um                             i386_defconfig
powerpc                       ppc64_defconfig
ia64                         bigsur_defconfig
powerpc                     tqm8560_defconfig
arm                        keystone_defconfig
mips                        nlm_xlr_defconfig
xtensa                              defconfig
powerpc                     stx_gp3_defconfig
arm                       cns3420vb_defconfig
mips                         mpc30x_defconfig
mips                       rbtx49xx_defconfig
arm                         s3c2410_defconfig
arm                         nhk8815_defconfig
arm                       mainstone_defconfig
arm                          moxart_defconfig
mips                           mtx1_defconfig
arm                            hisi_defconfig
powerpc                      acadia_defconfig
arm                       omap2plus_defconfig
arc                     haps_hs_smp_defconfig
arm                            lart_defconfig
riscv                    nommu_virt_defconfig
powerpc                    gamecube_defconfig
mips                        maltaup_defconfig
arm                           omap1_defconfig
mips                           ip32_defconfig
h8300                    h8300h-sim_defconfig
arm                           corgi_defconfig
sh                   sh7770_generic_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                          landisk_defconfig
mips                     cu1000-neo_defconfig
m68k                       m5275evb_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
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
i386                 randconfig-a004-20201203
i386                 randconfig-a005-20201203
i386                 randconfig-a001-20201203
i386                 randconfig-a002-20201203
i386                 randconfig-a006-20201203
i386                 randconfig-a003-20201203
x86_64               randconfig-a016-20201203
x86_64               randconfig-a012-20201203
x86_64               randconfig-a014-20201203
x86_64               randconfig-a013-20201203
x86_64               randconfig-a015-20201203
x86_64               randconfig-a011-20201203
i386                 randconfig-a014-20201202
i386                 randconfig-a013-20201202
i386                 randconfig-a011-20201202
i386                 randconfig-a015-20201202
i386                 randconfig-a012-20201202
i386                 randconfig-a016-20201202
i386                 randconfig-a014-20201203
i386                 randconfig-a013-20201203
i386                 randconfig-a011-20201203
i386                 randconfig-a015-20201203
i386                 randconfig-a012-20201203
i386                 randconfig-a016-20201203
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
