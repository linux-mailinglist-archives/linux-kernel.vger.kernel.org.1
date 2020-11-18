Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB502B76E2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 08:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgKRHY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 02:24:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:65056 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbgKRHYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 02:24:25 -0500
IronPort-SDR: Le4M6ZW2ZbiHHfT99KFN0S5pI1R256NBevXohQwlLoZUnAaNWifBylyuW9jooWC1mgYyGMaGD1
 1QwR0/yYRqDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="171174579"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="171174579"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 23:24:24 -0800
IronPort-SDR: QWRLdc5zvmrM9Y/sOu4hvJmhR18vp66lb18hYWFteDkxVUMHS1NpTeSeGW+6cUQ3x1/FQri9XD
 ADhPPJvRm8VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="330362868"
Received: from lkp-server01.sh.intel.com (HELO 67f4f491ac3d) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 17 Nov 2020 23:24:23 -0800
Received: from kbuild by 67f4f491ac3d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kfHpG-00001Q-Q4; Wed, 18 Nov 2020 07:24:22 +0000
Date:   Wed, 18 Nov 2020 15:23:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:efi/core] BUILD SUCCESS
 b283477d394ac41ca59ee20eb9293ae9002eb1d7
Message-ID: <5fb4cbfb.rqLTlUwd/vGPJ+fA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  efi/core
branch HEAD: b283477d394ac41ca59ee20eb9293ae9002eb1d7  efi: x86/xen: switch to efi_get_secureboot_mode helper

elapsed time: 725m

configs tested: 163
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          rsk7269_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                        edosk7760_defconfig
sh                         microdev_defconfig
sh                            shmin_defconfig
sh                            migor_defconfig
powerpc                 mpc836x_rdk_defconfig
xtensa                generic_kc705_defconfig
powerpc                     tqm8540_defconfig
sh                          rsk7201_defconfig
powerpc                     mpc5200_defconfig
m68k                            mac_defconfig
arm                          tango4_defconfig
arm                        spear3xx_defconfig
arc                          axs101_defconfig
c6x                        evmc6678_defconfig
sh                        sh7785lcr_defconfig
arm                          pxa910_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                          sdk7786_defconfig
powerpc                     tqm8555_defconfig
powerpc                     tqm8560_defconfig
arm                         orion5x_defconfig
powerpc                      mgcoge_defconfig
mips                           mtx1_defconfig
m68k                             allmodconfig
sh                          landisk_defconfig
sh                         apsh4a3a_defconfig
powerpc                        warp_defconfig
arm                            u300_defconfig
mips                           ci20_defconfig
arm                      tct_hammer_defconfig
c6x                         dsk6455_defconfig
csky                             alldefconfig
sparc64                             defconfig
arm                        cerfcube_defconfig
arm                           viper_defconfig
arm                         axm55xx_defconfig
arm                         lpc18xx_defconfig
arm                          moxart_defconfig
arm                           u8500_defconfig
arm                              alldefconfig
um                           x86_64_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                        edosk7705_defconfig
sh                           se7780_defconfig
arm                         shannon_defconfig
h8300                       h8s-sim_defconfig
sh                   sh7724_generic_defconfig
powerpc                    klondike_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                    gamecube_defconfig
arm                       mainstone_defconfig
mips                       bmips_be_defconfig
xtensa                       common_defconfig
arm                        neponset_defconfig
mips                malta_kvm_guest_defconfig
arc                                 defconfig
powerpc                     redwood_defconfig
mips                          rb532_defconfig
h8300                    h8300h-sim_defconfig
arc                          axs103_defconfig
powerpc                  mpc866_ads_defconfig
arm                              zx_defconfig
powerpc                     mpc83xx_defconfig
sh                             shx3_defconfig
powerpc                     ppa8548_defconfig
nios2                               defconfig
powerpc                    adder875_defconfig
mips                     cu1000-neo_defconfig
m68k                         amcore_defconfig
mips                            e55_defconfig
arm                         socfpga_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                               j2_defconfig
arm                          exynos_defconfig
xtensa                  cadence_csp_defconfig
mips                        workpad_defconfig
mips                         tb0219_defconfig
mips                         cobalt_defconfig
microblaze                    nommu_defconfig
mips                         mpc30x_defconfig
riscv                               defconfig
powerpc                     skiroot_defconfig
mips                      bmips_stb_defconfig
s390                             alldefconfig
arm                           h5000_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
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
i386                 randconfig-a006-20201117
i386                 randconfig-a005-20201117
i386                 randconfig-a001-20201117
i386                 randconfig-a002-20201117
i386                 randconfig-a004-20201117
i386                 randconfig-a003-20201117
x86_64               randconfig-a015-20201115
x86_64               randconfig-a011-20201115
x86_64               randconfig-a014-20201115
x86_64               randconfig-a013-20201115
x86_64               randconfig-a016-20201115
x86_64               randconfig-a012-20201115
i386                 randconfig-a012-20201117
i386                 randconfig-a014-20201117
i386                 randconfig-a016-20201117
i386                 randconfig-a011-20201117
i386                 randconfig-a015-20201117
i386                 randconfig-a013-20201117
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20201117
x86_64               randconfig-a005-20201117
x86_64               randconfig-a004-20201117
x86_64               randconfig-a002-20201117
x86_64               randconfig-a001-20201117
x86_64               randconfig-a006-20201117
x86_64               randconfig-a015-20201116
x86_64               randconfig-a011-20201116
x86_64               randconfig-a014-20201116
x86_64               randconfig-a013-20201116
x86_64               randconfig-a016-20201116
x86_64               randconfig-a012-20201116

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
