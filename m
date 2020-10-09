Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F40F2897CF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 22:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387622AbgJIUFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 16:05:15 -0400
Received: from mga02.intel.com ([134.134.136.20]:58660 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390420AbgJIUDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 16:03:05 -0400
IronPort-SDR: x5UoKwfqyzP8HQYf4Lb4RTqCMKO2t/4fKcOroQ4O3XO7aNPkxFvkB3dHtYoYWylp9C98ZjEwIb
 z43e/rr6DRiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="152452238"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="152452238"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 13:02:49 -0700
IronPort-SDR: jDNbI4aAbF58jWxQvv/tRI/XpmO1R/hEDt6xCYa5iPpp/OVv59jkW7Jpb1PSb8SPlIQB4DUzLZ
 67A2zN0ZngVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="317149491"
Received: from lkp-server02.sh.intel.com (HELO 80eb06af76cf) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Oct 2020 13:02:47 -0700
Received: from kbuild by 80eb06af76cf with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kQybG-0000he-36; Fri, 09 Oct 2020 20:02:46 +0000
Date:   Sat, 10 Oct 2020 04:02:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 2116d708b0580c0048fc80b82ec4b53f4ddaa166
Message-ID: <5f80c1d3.KGeGVdta+5taYUoF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  locking/core
branch HEAD: 2116d708b0580c0048fc80b82ec4b53f4ddaa166  Merge branch 'lkmm' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into locking/core

elapsed time: 723m

configs tested: 159
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                               defconfig
powerpc                     pq2fads_defconfig
arm                        spear6xx_defconfig
arm                          ep93xx_defconfig
ia64                             alldefconfig
powerpc                       maple_defconfig
arm                           sama5_defconfig
arm                       multi_v4t_defconfig
powerpc                     ksi8560_defconfig
sh                     magicpanelr2_defconfig
m68k                          hp300_defconfig
arc                    vdk_hs38_smp_defconfig
sparc64                          alldefconfig
arm                     am200epdkit_defconfig
arm                        magician_defconfig
powerpc                      ppc44x_defconfig
arm                     davinci_all_defconfig
arm                           corgi_defconfig
powerpc64                           defconfig
powerpc                        fsp2_defconfig
sh                   sh7770_generic_defconfig
arm                           viper_defconfig
i386                             allyesconfig
arc                      axs103_smp_defconfig
arm                         s3c6400_defconfig
arm                           efm32_defconfig
powerpc                 mpc8560_ads_defconfig
arm                             rpc_defconfig
m68k                          sun3x_defconfig
mips                      pistachio_defconfig
arm                         socfpga_defconfig
um                           x86_64_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                          pxa910_defconfig
mips                        bcm63xx_defconfig
powerpc                 mpc836x_rdk_defconfig
m68k                        m5307c3_defconfig
openrisc                 simple_smp_defconfig
alpha                            alldefconfig
arc                         haps_hs_defconfig
ia64                        generic_defconfig
arm                          iop32x_defconfig
arm                         cm_x300_defconfig
powerpc                      walnut_defconfig
mips                     loongson1b_defconfig
arc                             nps_defconfig
arm                       mainstone_defconfig
powerpc                     tqm5200_defconfig
um                             i386_defconfig
sparc64                             defconfig
sh                        edosk7705_defconfig
sh                 kfr2r09-romimage_defconfig
mips                      pic32mzda_defconfig
arc                            hsdk_defconfig
arm                          lpd270_defconfig
arm                             pxa_defconfig
powerpc                    ge_imp3a_defconfig
arm                          prima2_defconfig
arm                           tegra_defconfig
arm                        neponset_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                    sam440ep_defconfig
powerpc                      ppc64e_defconfig
mips                       capcella_defconfig
sh                   sh7724_generic_defconfig
arm                      tct_hammer_defconfig
powerpc                 linkstation_defconfig
m68k                            mac_defconfig
powerpc                   motionpro_defconfig
arc                        vdk_hs38_defconfig
sh                          rsk7203_defconfig
sh                   secureedge5410_defconfig
arm                        trizeps4_defconfig
arm                         nhk8815_defconfig
mips                           ip28_defconfig
powerpc                     powernv_defconfig
m68k                         apollo_defconfig
arm                         mv78xx0_defconfig
h8300                     edosk2674_defconfig
sh                             espt_defconfig
arm                   milbeaut_m10v_defconfig
mips                    maltaup_xpa_defconfig
arm                       spear13xx_defconfig
powerpc                     mpc5200_defconfig
mips                     cu1830-neo_defconfig
openrisc                         alldefconfig
mips                         db1xxx_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201009
i386                 randconfig-a005-20201009
i386                 randconfig-a001-20201009
i386                 randconfig-a004-20201009
i386                 randconfig-a002-20201009
i386                 randconfig-a003-20201009
x86_64               randconfig-a012-20201009
x86_64               randconfig-a015-20201009
x86_64               randconfig-a013-20201009
x86_64               randconfig-a014-20201009
x86_64               randconfig-a011-20201009
x86_64               randconfig-a016-20201009
i386                 randconfig-a015-20201009
i386                 randconfig-a013-20201009
i386                 randconfig-a014-20201009
i386                 randconfig-a016-20201009
i386                 randconfig-a011-20201009
i386                 randconfig-a012-20201009
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
x86_64               randconfig-a004-20201009
x86_64               randconfig-a003-20201009
x86_64               randconfig-a005-20201009
x86_64               randconfig-a001-20201009
x86_64               randconfig-a002-20201009
x86_64               randconfig-a006-20201009

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
