Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7781C273470
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 22:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgIUU7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 16:59:22 -0400
Received: from mga07.intel.com ([134.134.136.100]:31567 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgIUU7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 16:59:22 -0400
IronPort-SDR: ZhEE+6mmdrKEnfUEuKoi5OMzn/EfTKkJrecddiuDqgcOjxdVGT9Gg2PLkoRHYmdqdsewTL+fVP
 4IMjlekZVRJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="224623605"
X-IronPort-AV: E=Sophos;i="5.77,288,1596524400"; 
   d="scan'208";a="224623605"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 13:59:22 -0700
IronPort-SDR: AG1nGtBKa+HfQqt1Z5jKF7BVi4yZWAFRjq4Vh3wi5Hm3PIMTIRGgZQzxFacc+vgtGFONiIpuoA
 +R3crp2LUNwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,288,1596524400"; 
   d="scan'208";a="485665537"
Received: from lkp-server01.sh.intel.com (HELO 928d8e596b58) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 21 Sep 2020 13:59:20 -0700
Received: from kbuild by 928d8e596b58 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kKSu8-0000Cb-7Z; Mon, 21 Sep 2020 20:59:20 +0000
Date:   Tue, 22 Sep 2020 04:59:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 45c1c667ec05586335a6eaecbcb95733ff196274
Message-ID: <5f691421.x2WA/kCKpQnrujDJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 45c1c667ec05586335a6eaecbcb95733ff196274  Merge branch 'efi/core'

elapsed time: 726m

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
arm                           corgi_defconfig
arm                          pcm027_defconfig
powerpc                      bamboo_defconfig
c6x                              alldefconfig
arc                          axs103_defconfig
arm                     eseries_pxa_defconfig
arm                            xcep_defconfig
powerpc                      acadia_defconfig
arc                     nsimosci_hs_defconfig
powerpc                    adder875_defconfig
powerpc                    klondike_defconfig
arc                    vdk_hs38_smp_defconfig
arm                         orion5x_defconfig
mips                malta_qemu_32r6_defconfig
mips                     loongson1c_defconfig
mips                       rbtx49xx_defconfig
m68k                        m5272c3_defconfig
sh                            migor_defconfig
h8300                     edosk2674_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                      arches_defconfig
powerpc                     pseries_defconfig
xtensa                  cadence_csp_defconfig
arm                  colibri_pxa300_defconfig
mips                      malta_kvm_defconfig
mips                            ar7_defconfig
arc                        nsim_700_defconfig
sh                            hp6xx_defconfig
powerpc                 mpc8540_ads_defconfig
arm                         assabet_defconfig
arm                  colibri_pxa270_defconfig
arm                       multi_v4t_defconfig
powerpc                      makalu_defconfig
sh                     magicpanelr2_defconfig
arc                           tb10x_defconfig
arm                      integrator_defconfig
mips                           gcw0_defconfig
powerpc                    socrates_defconfig
powerpc                     ep8248e_defconfig
h8300                               defconfig
sh                          landisk_defconfig
mips                     loongson1b_defconfig
c6x                        evmc6474_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                ecovec24-romimage_defconfig
openrisc                            defconfig
mips                        vocore2_defconfig
riscv                            allmodconfig
mips                       bmips_be_defconfig
arm                          exynos_defconfig
powerpc                     tqm8548_defconfig
arm                           sunxi_defconfig
mips                     cu1830-neo_defconfig
sh                          urquell_defconfig
c6x                        evmc6678_defconfig
powerpc                  iss476-smp_defconfig
sparc                            allyesconfig
m68k                          atari_defconfig
sh                          sdk7786_defconfig
arm                         palmz72_defconfig
mips                          ath79_defconfig
sh                        edosk7760_defconfig
powerpc                       eiger_defconfig
arm                          pxa910_defconfig
mips                 decstation_r4k_defconfig
powerpc                       maple_defconfig
arm                         bcm2835_defconfig
powerpc                   lite5200b_defconfig
powerpc                     mpc83xx_defconfig
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
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20200920
i386                 randconfig-a006-20200920
i386                 randconfig-a003-20200920
i386                 randconfig-a004-20200920
i386                 randconfig-a005-20200920
i386                 randconfig-a001-20200920
i386                 randconfig-a002-20200921
i386                 randconfig-a006-20200921
i386                 randconfig-a003-20200921
i386                 randconfig-a004-20200921
i386                 randconfig-a005-20200921
i386                 randconfig-a001-20200921
x86_64               randconfig-a011-20200921
x86_64               randconfig-a013-20200921
x86_64               randconfig-a014-20200921
x86_64               randconfig-a015-20200921
x86_64               randconfig-a012-20200921
x86_64               randconfig-a016-20200921
i386                 randconfig-a012-20200921
i386                 randconfig-a014-20200921
i386                 randconfig-a016-20200921
i386                 randconfig-a013-20200921
i386                 randconfig-a011-20200921
i386                 randconfig-a015-20200921
x86_64               randconfig-a005-20200920
x86_64               randconfig-a003-20200920
x86_64               randconfig-a004-20200920
x86_64               randconfig-a002-20200920
x86_64               randconfig-a006-20200920
x86_64               randconfig-a001-20200920
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20200921
x86_64               randconfig-a003-20200921
x86_64               randconfig-a004-20200921
x86_64               randconfig-a002-20200921
x86_64               randconfig-a006-20200921
x86_64               randconfig-a001-20200921
x86_64               randconfig-a011-20200920
x86_64               randconfig-a013-20200920
x86_64               randconfig-a014-20200920
x86_64               randconfig-a015-20200920
x86_64               randconfig-a012-20200920
x86_64               randconfig-a016-20200920

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
