Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C861E2B8C27
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 08:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgKSHP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 02:15:28 -0500
Received: from mga18.intel.com ([134.134.136.126]:64002 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbgKSHP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 02:15:27 -0500
IronPort-SDR: v76LVp4wR123Uaq7d7uqokwouHljNyOZg7/PTiY2YJLevzSqv46eHuP31FzsfVLrg/ZOwtGmIp
 pAqgxFS7G2Qw==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="159016477"
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="159016477"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 23:15:17 -0800
IronPort-SDR: m7YVIRjNeHpWFsqVOPq7CL+sf3CUKgBDEpuAt1w+jL66cPD2tP/iZegB6Pd/4M275XIOxvNT+Y
 HRxhQxp91+vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="401424684"
Received: from lkp-server01.sh.intel.com (HELO beb8a34b6883) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 18 Nov 2020 23:15:16 -0800
Received: from kbuild by beb8a34b6883 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kfe9z-00003S-NI; Thu, 19 Nov 2020 07:15:15 +0000
Date:   Thu, 19 Nov 2020 15:14:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sgx] BUILD SUCCESS
 0eaa8d153a1d573e53b8283c90db44057d1376f6
Message-ID: <5fb61b58.v5MBBoB5YOhHTB76%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/sgx
branch HEAD: 0eaa8d153a1d573e53b8283c90db44057d1376f6  selftests/sgx: Use a statically generated 3072-bit RSA key

elapsed time: 723m

configs tested: 169
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                          sun3x_defconfig
arc                        nsim_700_defconfig
mips                      loongson3_defconfig
arm                           sunxi_defconfig
nios2                               defconfig
powerpc                    socrates_defconfig
um                           x86_64_defconfig
powerpc                        fsp2_defconfig
powerpc                      ppc6xx_defconfig
arm                            mps2_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                      arches_defconfig
powerpc                     tqm8555_defconfig
sh                        apsh4ad0a_defconfig
mips                        workpad_defconfig
sh                         ap325rxa_defconfig
powerpc                 mpc8560_ads_defconfig
sh                          polaris_defconfig
arm                       aspeed_g5_defconfig
arm                           stm32_defconfig
powerpc                     sbc8548_defconfig
arm                   milbeaut_m10v_defconfig
arm                         shannon_defconfig
arc                          axs101_defconfig
mips                         db1xxx_defconfig
m68k                          amiga_defconfig
sh                ecovec24-romimage_defconfig
arm                            zeus_defconfig
powerpc                      ep88xc_defconfig
arm                           sama5_defconfig
powerpc                      cm5200_defconfig
arm                        realview_defconfig
sh                           se7206_defconfig
powerpc                   lite5200b_defconfig
powerpc                          g5_defconfig
arm                           omap1_defconfig
arm                       versatile_defconfig
sh                            hp6xx_defconfig
s390                          debug_defconfig
powerpc                     pq2fads_defconfig
parisc                generic-64bit_defconfig
arm                             rpc_defconfig
powerpc                      katmai_defconfig
arm                         hackkit_defconfig
arm                        clps711x_defconfig
xtensa                    xip_kc705_defconfig
mips                malta_qemu_32r6_defconfig
c6x                              allyesconfig
riscv                    nommu_k210_defconfig
powerpc                    ge_imp3a_defconfig
m68k                        mvme16x_defconfig
sh                        sh7757lcr_defconfig
powerpc                      pcm030_defconfig
sparc                            allyesconfig
powerpc                      ppc64e_defconfig
powerpc                     skiroot_defconfig
sh                         ecovec24_defconfig
sh                           se7722_defconfig
arc                        vdk_hs38_defconfig
sh                          kfr2r09_defconfig
arm                     am200epdkit_defconfig
arm                           efm32_defconfig
arm                           corgi_defconfig
sh                   sh7770_generic_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                         axm55xx_defconfig
powerpc                       ebony_defconfig
sparc                       sparc32_defconfig
sh                           se7705_defconfig
arm                         cm_x300_defconfig
sh                          r7780mp_defconfig
arc                              alldefconfig
powerpc                     mpc83xx_defconfig
powerpc                     tqm8540_defconfig
mips                         tb0219_defconfig
nios2                         10m50_defconfig
microblaze                          defconfig
powerpc                   motionpro_defconfig
powerpc                         wii_defconfig
m68k                           sun3_defconfig
powerpc                     kmeter1_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
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
x86_64               randconfig-a005-20201118
x86_64               randconfig-a003-20201118
x86_64               randconfig-a004-20201118
x86_64               randconfig-a002-20201118
x86_64               randconfig-a006-20201118
x86_64               randconfig-a001-20201118
i386                 randconfig-a006-20201119
i386                 randconfig-a005-20201119
i386                 randconfig-a002-20201119
i386                 randconfig-a001-20201119
i386                 randconfig-a003-20201119
i386                 randconfig-a004-20201119
i386                 randconfig-a006-20201118
i386                 randconfig-a005-20201118
i386                 randconfig-a002-20201118
i386                 randconfig-a001-20201118
i386                 randconfig-a003-20201118
i386                 randconfig-a004-20201118
i386                 randconfig-a012-20201119
i386                 randconfig-a014-20201119
i386                 randconfig-a016-20201119
i386                 randconfig-a011-20201119
i386                 randconfig-a013-20201119
i386                 randconfig-a015-20201119
i386                 randconfig-a012-20201118
i386                 randconfig-a014-20201118
i386                 randconfig-a016-20201118
i386                 randconfig-a011-20201118
i386                 randconfig-a013-20201118
i386                 randconfig-a015-20201118
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
x86_64               randconfig-a015-20201118
x86_64               randconfig-a014-20201118
x86_64               randconfig-a011-20201118
x86_64               randconfig-a013-20201118
x86_64               randconfig-a016-20201118
x86_64               randconfig-a012-20201118
x86_64               randconfig-a005-20201119
x86_64               randconfig-a003-20201119
x86_64               randconfig-a004-20201119
x86_64               randconfig-a002-20201119
x86_64               randconfig-a006-20201119
x86_64               randconfig-a001-20201119

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
