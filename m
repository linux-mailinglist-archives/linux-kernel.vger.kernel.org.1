Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194472DB627
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 22:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbgLOVzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 16:55:47 -0500
Received: from mga07.intel.com ([134.134.136.100]:25738 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727991AbgLOVze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 16:55:34 -0500
IronPort-SDR: pNcTopXk9JvcAXVakafIDZaPB1zwsgE8MJJp4UfU7Aye6bq8NGUFgjll1DE92mL8SsCRkDzqA/
 5sEvJfAkEZGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="239056433"
X-IronPort-AV: E=Sophos;i="5.78,422,1599548400"; 
   d="scan'208";a="239056433"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 13:54:53 -0800
IronPort-SDR: 3yyRvdGHboivGEnDEWSrLswhBh1EBmuyrLHhzpZ9h92k5AJjFaqlPndIX8o2dSQYBN7WArHDDV
 UO6mATEO+EcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,422,1599548400"; 
   d="scan'208";a="556974799"
Received: from lkp-server02.sh.intel.com (HELO a947d92d0467) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 15 Dec 2020 13:54:52 -0800
Received: from kbuild by a947d92d0467 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kpIHT-0000yi-Rb; Tue, 15 Dec 2020 21:54:51 +0000
Date:   Wed, 16 Dec 2020 05:54:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 3c41e57a1e168d879e923c5583adeae47eec9f64
Message-ID: <5fd93088.wYSkPF6GeAoeDR7q%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  irq/core
branch HEAD: 3c41e57a1e168d879e923c5583adeae47eec9f64  Merge tag 'irqchip-5.11' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

elapsed time: 722m

configs tested: 171
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                 nsimosci_hs_smp_defconfig
mips                      bmips_stb_defconfig
arm                        realview_defconfig
mips                     decstation_defconfig
arm64                            alldefconfig
powerpc                       holly_defconfig
powerpc                 mpc837x_mds_defconfig
arm                        shmobile_defconfig
sh                ecovec24-romimage_defconfig
riscv                    nommu_virt_defconfig
arm                      pxa255-idp_defconfig
sh                         microdev_defconfig
sh                           se7712_defconfig
powerpc                      bamboo_defconfig
m68k                       m5275evb_defconfig
powerpc                  iss476-smp_defconfig
powerpc                           allnoconfig
arm                           efm32_defconfig
powerpc                  mpc885_ads_defconfig
powerpc               mpc834x_itxgp_defconfig
arc                           tb10x_defconfig
powerpc                     ksi8560_defconfig
h8300                       h8s-sim_defconfig
powerpc                     powernv_defconfig
arm                         assabet_defconfig
ia64                      gensparse_defconfig
openrisc                 simple_smp_defconfig
powerpc                 mpc836x_mds_defconfig
arm                    vt8500_v6_v7_defconfig
riscv                    nommu_k210_defconfig
mips                            ar7_defconfig
powerpc                       ppc64_defconfig
arm                          ep93xx_defconfig
powerpc                        warp_defconfig
nios2                         10m50_defconfig
mips                       bmips_be_defconfig
mips                     cu1830-neo_defconfig
powerpc                       ebony_defconfig
riscv                            alldefconfig
powerpc                     tqm8540_defconfig
arm                         shannon_defconfig
m68k                          hp300_defconfig
m68k                         apollo_defconfig
powerpc                      walnut_defconfig
arm                      footbridge_defconfig
arm                        cerfcube_defconfig
xtensa                    xip_kc705_defconfig
sh                           se7724_defconfig
arm                            lart_defconfig
um                             i386_defconfig
ia64                         bigsur_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                            qcom_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                        sh7785lcr_defconfig
xtensa                  cadence_csp_defconfig
powerpc                     asp8347_defconfig
arm                       netwinder_defconfig
parisc                generic-64bit_defconfig
powerpc                       maple_defconfig
mips                           ip27_defconfig
arm                             ezx_defconfig
mips                        bcm47xx_defconfig
sh                           se7722_defconfig
powerpc                      pcm030_defconfig
powerpc                    klondike_defconfig
sh                   secureedge5410_defconfig
powerpc                 mpc834x_mds_defconfig
arm                  colibri_pxa300_defconfig
sh                        edosk7760_defconfig
c6x                                 defconfig
m68k                           sun3_defconfig
arm                     davinci_all_defconfig
powerpc                 linkstation_defconfig
m68k                            mac_defconfig
powerpc64                        alldefconfig
arm                           sunxi_defconfig
arm                            zeus_defconfig
mips                         tb0287_defconfig
powerpc                     sequoia_defconfig
mips                  decstation_64_defconfig
x86_64                           allyesconfig
powerpc                      ppc64e_defconfig
arm                  colibri_pxa270_defconfig
arm                            mps2_defconfig
arm                       mainstone_defconfig
c6x                        evmc6678_defconfig
m68k                          atari_defconfig
m68k                        m5272c3_defconfig
arm                        neponset_defconfig
sh                        dreamcast_defconfig
parisc                              defconfig
s390                             allyesconfig
m68k                        m5407c3_defconfig
sh                               j2_defconfig
parisc                generic-32bit_defconfig
mips                         tb0226_defconfig
arm                           corgi_defconfig
parisc                           alldefconfig
mips                      pic32mzda_defconfig
mips                           xway_defconfig
arm                         mv78xx0_defconfig
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
x86_64               randconfig-a003-20201215
x86_64               randconfig-a006-20201215
x86_64               randconfig-a002-20201215
x86_64               randconfig-a005-20201215
x86_64               randconfig-a004-20201215
x86_64               randconfig-a001-20201215
i386                 randconfig-a001-20201215
i386                 randconfig-a004-20201215
i386                 randconfig-a003-20201215
i386                 randconfig-a002-20201215
i386                 randconfig-a006-20201215
i386                 randconfig-a005-20201215
i386                 randconfig-a014-20201215
i386                 randconfig-a013-20201215
i386                 randconfig-a012-20201215
i386                 randconfig-a011-20201215
i386                 randconfig-a015-20201215
i386                 randconfig-a016-20201215
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a016-20201215
x86_64               randconfig-a012-20201215
x86_64               randconfig-a013-20201215
x86_64               randconfig-a015-20201215
x86_64               randconfig-a014-20201215
x86_64               randconfig-a011-20201215

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
