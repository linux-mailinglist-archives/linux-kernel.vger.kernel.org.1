Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616EE280967
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgJAV3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 17:29:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:27752 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbgJAV3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 17:29:21 -0400
IronPort-SDR: e7bA3Iedjoqdr5vkQmSD49EB89xjAJiPnxj3Jax3aooDG/8HEF4PGbVvIF9IygT68mchGv3JBQ
 m98w1KNmtHsg==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="162918148"
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="162918148"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 14:29:19 -0700
IronPort-SDR: 22/8/7WsOjeH3ivNR9M3qPrK+L+Kw+lOpBJ3SadXHa1dKXw8uV5m37GGyWSar5fit8LDoDx+h/
 YZyBQjisYoIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="325553135"
Received: from lkp-server02.sh.intel.com (HELO de448af6ea1b) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 01 Oct 2020 14:29:18 -0700
Received: from kbuild by de448af6ea1b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kO68b-0000ks-Eb; Thu, 01 Oct 2020 21:29:17 +0000
Date:   Fri, 02 Oct 2020 05:29:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 0d555b3ac49b40f94c270681b697d45dcae9faa6
Message-ID: <5f764a21.gWAwiuLtXP4tvvHY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  timers/core
branch HEAD: 0d555b3ac49b40f94c270681b697d45dcae9faa6  clocksource/drivers/mps2-timer: Use semicolons rather than commas to separate statements

elapsed time: 724m

configs tested: 162
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                          g5_defconfig
arm                           u8500_defconfig
powerpc                     sbc8548_defconfig
powerpc                    gamecube_defconfig
mips                          rb532_defconfig
arm                         shannon_defconfig
arm                  colibri_pxa300_defconfig
mips                          ath25_defconfig
sh                        edosk7705_defconfig
sh                          landisk_defconfig
sh                             sh03_defconfig
arm64                            alldefconfig
powerpc                 mpc832x_mds_defconfig
m68k                        mvme147_defconfig
mips                malta_qemu_32r6_defconfig
mips                          malta_defconfig
arm                              alldefconfig
arm                          gemini_defconfig
riscv                             allnoconfig
mips                         tb0287_defconfig
arm                       cns3420vb_defconfig
arm                        realview_defconfig
csky                                defconfig
arm                         assabet_defconfig
mips                       rbtx49xx_defconfig
m68k                          hp300_defconfig
arc                      axs103_smp_defconfig
csky                             alldefconfig
sh                            shmin_defconfig
powerpc                        cell_defconfig
c6x                        evmc6457_defconfig
powerpc                     asp8347_defconfig
arm                         mv78xx0_defconfig
arm                           tegra_defconfig
sh                           se7619_defconfig
mips                        bcm63xx_defconfig
nds32                            alldefconfig
nios2                         10m50_defconfig
powerpc                     rainier_defconfig
xtensa                       common_defconfig
sh                           sh2007_defconfig
powerpc                  iss476-smp_defconfig
mips                  cavium_octeon_defconfig
arm                             mxs_defconfig
mips                             allyesconfig
microblaze                          defconfig
powerpc                   motionpro_defconfig
powerpc                 mpc837x_mds_defconfig
xtensa                           alldefconfig
arm                         nhk8815_defconfig
arm                         bcm2835_defconfig
powerpc                      mgcoge_defconfig
powerpc                  storcenter_defconfig
microblaze                      mmu_defconfig
s390                       zfcpdump_defconfig
powerpc                       ppc64_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     taishan_defconfig
arm                           spitz_defconfig
h8300                               defconfig
arm                           efm32_defconfig
arm                   milbeaut_m10v_defconfig
h8300                            alldefconfig
arm                           viper_defconfig
powerpc                      chrp32_defconfig
arm                           stm32_defconfig
x86_64                              defconfig
mips                      loongson3_defconfig
powerpc                      makalu_defconfig
m68k                         apollo_defconfig
sh                         apsh4a3a_defconfig
sh                             shx3_defconfig
mips                          ath79_defconfig
m68k                          multi_defconfig
arm                         axm55xx_defconfig
m68k                        m5307c3_defconfig
xtensa                  audio_kc705_defconfig
powerpc                          allmodconfig
mips                        jmr3927_defconfig
powerpc                      katmai_defconfig
powerpc                           allnoconfig
nios2                               defconfig
riscv                            alldefconfig
arm                         palmz72_defconfig
powerpc                     ksi8560_defconfig
sh                        sh7785lcr_defconfig
sh                          rsk7203_defconfig
sh                   sh7724_generic_defconfig
sh                             espt_defconfig
arm                          iop32x_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                    mvme5100_defconfig
s390                             alldefconfig
arm                          pxa910_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
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
mips                             allmodconfig
powerpc                          allyesconfig
i386                 randconfig-a003-20200930
i386                 randconfig-a002-20200930
i386                 randconfig-a006-20200930
i386                 randconfig-a005-20200930
i386                 randconfig-a004-20200930
i386                 randconfig-a001-20200930
x86_64               randconfig-a015-20200930
x86_64               randconfig-a013-20200930
x86_64               randconfig-a012-20200930
x86_64               randconfig-a016-20200930
x86_64               randconfig-a014-20200930
x86_64               randconfig-a011-20200930
i386                 randconfig-a011-20200930
i386                 randconfig-a015-20200930
i386                 randconfig-a012-20200930
i386                 randconfig-a014-20200930
i386                 randconfig-a016-20200930
i386                 randconfig-a013-20200930
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20200930
x86_64               randconfig-a005-20200930
x86_64               randconfig-a003-20200930
x86_64               randconfig-a004-20200930
x86_64               randconfig-a002-20200930
x86_64               randconfig-a006-20200930

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
