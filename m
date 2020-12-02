Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1292CB76D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgLBImw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 03:42:52 -0500
Received: from mga12.intel.com ([192.55.52.136]:24950 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728474AbgLBImv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:42:51 -0500
IronPort-SDR: nQ29Ae9KaNMJ6Zsj/9pb9uIFi24Vx+2RPteGipaST96qXPfDNV0322imunAuPTTZRclH0xKtsg
 6hnUhJI7SSTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="152235502"
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="152235502"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 00:41:53 -0800
IronPort-SDR: GecoSEBtkE/lu8trEm8b+sLbP5vilzQwXClFICO3Tu1ib3tUSzCz55PWen/zl4/ZMd36HtbXlC
 PsdkRK9tkUgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="367919101"
Received: from lkp-server01.sh.intel.com (HELO 54133fc185c3) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 02 Dec 2020 00:41:52 -0800
Received: from kbuild by 54133fc185c3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kkNhv-000028-UM; Wed, 02 Dec 2020 08:41:51 +0000
Date:   Wed, 02 Dec 2020 16:41:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 e1c06d2366e743475b91045ef0c2ce1bbd028cb6
Message-ID: <5fc75334.qQym8WOIstZEIHnM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  ras/core
branch HEAD: e1c06d2366e743475b91045ef0c2ce1bbd028cb6  x86/mce: Rename kill_it to kill_current_task

elapsed time: 723m

configs tested: 157
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                         ps3_defconfig
mips                malta_qemu_32r6_defconfig
x86_64                           alldefconfig
mips                          ath25_defconfig
sh                          rsk7201_defconfig
arm                        clps711x_defconfig
sh                        edosk7760_defconfig
powerpc                        cell_defconfig
sh                            hp6xx_defconfig
mips                          ath79_defconfig
openrisc                         alldefconfig
sh                               j2_defconfig
mips                       capcella_defconfig
arm                           viper_defconfig
c6x                        evmc6474_defconfig
riscv                    nommu_k210_defconfig
arm                          pxa3xx_defconfig
c6x                        evmc6457_defconfig
m68k                            q40_defconfig
arc                        nsim_700_defconfig
sh                           se7705_defconfig
m68k                         apollo_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                        realview_defconfig
microblaze                          defconfig
s390                       zfcpdump_defconfig
xtensa                generic_kc705_defconfig
powerpc                    klondike_defconfig
mips                     loongson1c_defconfig
arc                        nsimosci_defconfig
mips                           gcw0_defconfig
xtensa                         virt_defconfig
c6x                        evmc6678_defconfig
sh                             shx3_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                     tqm5200_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                         ap325rxa_defconfig
m68k                       m5475evb_defconfig
c6x                                 defconfig
powerpc                     ep8248e_defconfig
arm                          pcm027_defconfig
mips                           ip22_defconfig
ia64                        generic_defconfig
sh                        dreamcast_defconfig
arm                            mps2_defconfig
sparc                               defconfig
powerpc                        fsp2_defconfig
powerpc                      ppc40x_defconfig
h8300                               defconfig
powerpc                      ppc44x_defconfig
arm                              alldefconfig
powerpc                 mpc834x_itx_defconfig
mips                          malta_defconfig
ia64                         bigsur_defconfig
powerpc                     tqm8540_defconfig
powerpc                     mpc5200_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                       ebony_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                           se7343_defconfig
arm                          moxart_defconfig
powerpc                    amigaone_defconfig
mips                        maltaup_defconfig
arc                              alldefconfig
microblaze                      mmu_defconfig
arm                     davinci_all_defconfig
powerpc                    mvme5100_defconfig
sh                        apsh4ad0a_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                          imote2_defconfig
mips                      fuloong2e_defconfig
sparc                            allyesconfig
sparc                       sparc64_defconfig
arm                        vexpress_defconfig
powerpc                       eiger_defconfig
powerpc                      pasemi_defconfig
powerpc                  storcenter_defconfig
parisc                generic-32bit_defconfig
mips                    maltaup_xpa_defconfig
mips                            e55_defconfig
mips                           xway_defconfig
xtensa                  audio_kc705_defconfig
arm                            dove_defconfig
powerpc                 canyonlands_defconfig
powerpc                     skiroot_defconfig
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
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201201
i386                 randconfig-a005-20201201
i386                 randconfig-a001-20201201
i386                 randconfig-a002-20201201
i386                 randconfig-a006-20201201
i386                 randconfig-a003-20201201
x86_64               randconfig-a016-20201201
x86_64               randconfig-a012-20201201
x86_64               randconfig-a014-20201201
x86_64               randconfig-a013-20201201
x86_64               randconfig-a015-20201201
x86_64               randconfig-a011-20201201
i386                 randconfig-a014-20201201
i386                 randconfig-a013-20201201
i386                 randconfig-a011-20201201
i386                 randconfig-a015-20201201
i386                 randconfig-a012-20201201
i386                 randconfig-a016-20201201
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
x86_64               randconfig-a004-20201201
x86_64               randconfig-a006-20201201
x86_64               randconfig-a001-20201201
x86_64               randconfig-a002-20201201
x86_64               randconfig-a005-20201201
x86_64               randconfig-a003-20201201

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
