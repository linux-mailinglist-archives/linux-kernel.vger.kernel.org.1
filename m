Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871052D81B9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 23:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406433AbgLKWOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 17:14:43 -0500
Received: from mga18.intel.com ([134.134.136.126]:40466 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406711AbgLKWOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 17:14:06 -0500
IronPort-SDR: x+BbSPCBoolouRiEJa7Rv7KTNxZewZgqKTtQRcFja1d6iNmq1nyCVoZkU5DxqK5nZ11UnWh3+9
 r1+I3fHY+GwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9832"; a="162260653"
X-IronPort-AV: E=Sophos;i="5.78,412,1599548400"; 
   d="scan'208";a="162260653"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 14:13:19 -0800
IronPort-SDR: 3fAIz24wcOtlMMOJE1WtnK+lNgnFIWFyGEEuHmwVTlzPUjqp+2APyMIaVhBFlekYkywBypj/j+
 xs45Bdc8iWgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,412,1599548400"; 
   d="scan'208";a="365656640"
Received: from lkp-server01.sh.intel.com (HELO ecc0cebe68d1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 11 Dec 2020 14:13:18 -0800
Received: from kbuild by ecc0cebe68d1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1knqf7-00017K-A7; Fri, 11 Dec 2020 22:13:17 +0000
Date:   Sat, 12 Dec 2020 06:12:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 76e87d96b30b5fee91b381fbc444a3eabcd9469a
Message-ID: <5fd3eecb.jyDrbrkXBP9pP0h7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  timers/core
branch HEAD: 76e87d96b30b5fee91b381fbc444a3eabcd9469a  ntp: Consolidate the RTC update implementation

elapsed time: 724m

configs tested: 194
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 linkstation_defconfig
sh                         apsh4a3a_defconfig
arm                           omap1_defconfig
powerpc                     mpc512x_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
openrisc                            defconfig
arm                            pleb_defconfig
arm                          collie_defconfig
arm                           sunxi_defconfig
ia64                             allyesconfig
parisc                generic-32bit_defconfig
m68k                       m5275evb_defconfig
arm                          exynos_defconfig
arm                      integrator_defconfig
sh                           se7343_defconfig
arm                            zeus_defconfig
sh                            migor_defconfig
mips                        vocore2_defconfig
arm                         orion5x_defconfig
powerpc                 mpc836x_mds_defconfig
arm                          gemini_defconfig
sh                          rsk7269_defconfig
sh                        apsh4ad0a_defconfig
m68k                        m5272c3_defconfig
mips                   sb1250_swarm_defconfig
xtensa                    xip_kc705_defconfig
sh                          kfr2r09_defconfig
sparc                            alldefconfig
mips                        bcm47xx_defconfig
microblaze                      mmu_defconfig
arc                          axs103_defconfig
arm                       aspeed_g4_defconfig
arc                         haps_hs_defconfig
powerpc                        warp_defconfig
arm                     eseries_pxa_defconfig
arm                      tct_hammer_defconfig
powerpc                    mvme5100_defconfig
powerpc                      acadia_defconfig
sh                             shx3_defconfig
arm                          imote2_defconfig
mips                malta_kvm_guest_defconfig
sh                          sdk7780_defconfig
powerpc                 mpc8560_ads_defconfig
arm                         lubbock_defconfig
arm                          tango4_defconfig
mips                            ar7_defconfig
mips                     loongson1c_defconfig
powerpc                  storcenter_defconfig
arm                      footbridge_defconfig
arm                          iop32x_defconfig
riscv                    nommu_virt_defconfig
powerpc                      chrp32_defconfig
mips                           gcw0_defconfig
i386                             allyesconfig
m68k                       bvme6000_defconfig
powerpc                   currituck_defconfig
mips                      loongson3_defconfig
arc                            hsdk_defconfig
mips                           rs90_defconfig
openrisc                    or1ksim_defconfig
mips                        bcm63xx_defconfig
nds32                               defconfig
parisc                           alldefconfig
ia64                                defconfig
powerpc                    klondike_defconfig
arm                         assabet_defconfig
alpha                            alldefconfig
sh                         microdev_defconfig
arm                           u8500_defconfig
powerpc                        icon_defconfig
powerpc                  mpc885_ads_defconfig
mips                           xway_defconfig
powerpc                      cm5200_defconfig
mips                      pistachio_defconfig
mips                      maltaaprp_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                             alldefconfig
powerpc64                           defconfig
powerpc                     rainier_defconfig
arm                          badge4_defconfig
sh                             sh03_defconfig
arm                        keystone_defconfig
ia64                            zx1_defconfig
m68k                          multi_defconfig
sh                          lboxre2_defconfig
sh                          urquell_defconfig
sh                          sdk7786_defconfig
powerpc                      ppc64e_defconfig
arm                         palmz72_defconfig
sh                  sh7785lcr_32bit_defconfig
xtensa                         virt_defconfig
xtensa                generic_kc705_defconfig
sparc                            allyesconfig
powerpc                          g5_defconfig
arm                         shannon_defconfig
sh                               j2_defconfig
m68k                       m5249evb_defconfig
arm                       versatile_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                      pasemi_defconfig
mips                     cu1000-neo_defconfig
xtensa                    smp_lx200_defconfig
sh                           se7619_defconfig
sh                               alldefconfig
m68k                          amiga_defconfig
powerpc                      ppc40x_defconfig
arm                         mv78xx0_defconfig
arm                          simpad_defconfig
mips                          rm200_defconfig
arm                             mxs_defconfig
riscv                            alldefconfig
powerpc                      arches_defconfig
powerpc                 mpc837x_rdb_defconfig
ia64                             allmodconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a001-20201210
i386                 randconfig-a004-20201210
i386                 randconfig-a003-20201210
i386                 randconfig-a002-20201210
i386                 randconfig-a005-20201210
i386                 randconfig-a006-20201210
i386                 randconfig-a004-20201209
i386                 randconfig-a005-20201209
i386                 randconfig-a001-20201209
i386                 randconfig-a002-20201209
i386                 randconfig-a006-20201209
i386                 randconfig-a003-20201209
x86_64               randconfig-a016-20201209
x86_64               randconfig-a012-20201209
x86_64               randconfig-a013-20201209
x86_64               randconfig-a014-20201209
x86_64               randconfig-a015-20201209
x86_64               randconfig-a011-20201209
i386                 randconfig-a013-20201209
i386                 randconfig-a014-20201209
i386                 randconfig-a011-20201209
i386                 randconfig-a015-20201209
i386                 randconfig-a012-20201209
i386                 randconfig-a016-20201209
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-a004-20201209
x86_64               randconfig-a006-20201209
x86_64               randconfig-a005-20201209
x86_64               randconfig-a001-20201209
x86_64               randconfig-a002-20201209
x86_64               randconfig-a003-20201209
x86_64               randconfig-a003-20201210
x86_64               randconfig-a006-20201210
x86_64               randconfig-a002-20201210
x86_64               randconfig-a005-20201210
x86_64               randconfig-a004-20201210
x86_64               randconfig-a001-20201210

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
