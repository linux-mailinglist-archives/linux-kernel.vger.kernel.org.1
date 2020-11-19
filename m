Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C65B2B8C26
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 08:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgKSHPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 02:15:18 -0500
Received: from mga17.intel.com ([192.55.52.151]:8024 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgKSHPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 02:15:18 -0500
IronPort-SDR: 5Hs5hi+dhGeT4cVB+5BmVB9QgUvfnrI8jWUQLGlFCA/Otj2E25ptFxDWGGDzERAHb8UkAqx8fx
 infonHMC+nWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="151092879"
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="151092879"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 23:15:17 -0800
IronPort-SDR: WhTTokhFzNta2fiCakG5D0zwF7dH7VW0PTbXaeLVJrnV5O8IKvl4K9CMk+jQ0cWxHhA1snv9Y2
 meaeGCGyzL4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="341597000"
Received: from lkp-server01.sh.intel.com (HELO beb8a34b6883) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Nov 2020 23:15:16 -0800
Received: from kbuild by beb8a34b6883 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kfe9z-00003O-BM; Thu, 19 Nov 2020 07:15:15 +0000
Date:   Thu, 19 Nov 2020 15:14:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 31d8546033053b98de00846ede8088bdbe38651d
Message-ID: <5fb61b5a.kqyp9D1bbx4+8lxW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cleanups
branch HEAD: 31d8546033053b98de00846ede8088bdbe38651d  x86/head/64: Remove unused GET_CR2_INTO() macro

elapsed time: 723m

configs tested: 200
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                         ap325rxa_defconfig
mips                  maltasmvp_eva_defconfig
mips                      pic32mzda_defconfig
powerpc                      bamboo_defconfig
powerpc                     tqm8560_defconfig
nios2                               defconfig
powerpc                    socrates_defconfig
um                           x86_64_defconfig
powerpc                        fsp2_defconfig
powerpc                      ppc6xx_defconfig
arm                            mps2_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                      arches_defconfig
m68k                          sun3x_defconfig
powerpc                     tqm8555_defconfig
sh                        apsh4ad0a_defconfig
mips                        workpad_defconfig
powerpc                 mpc8560_ads_defconfig
arm                           sunxi_defconfig
powerpc                    adder875_defconfig
sh                ecovec24-romimage_defconfig
m68k                            mac_defconfig
sh                           sh2007_defconfig
sh                          urquell_defconfig
riscv                               defconfig
arm                     davinci_all_defconfig
powerpc                    klondike_defconfig
arm                            mmp2_defconfig
arm                          pcm027_defconfig
parisc                generic-32bit_defconfig
sh                          polaris_defconfig
arm                       aspeed_g5_defconfig
arm                           stm32_defconfig
powerpc                     sbc8548_defconfig
arm                   milbeaut_m10v_defconfig
arm                         shannon_defconfig
arc                          axs101_defconfig
mips                         db1xxx_defconfig
m68k                          amiga_defconfig
powerpc                   motionpro_defconfig
arm                         mv78xx0_defconfig
sh                        dreamcast_defconfig
arm                            zeus_defconfig
powerpc                      ep88xc_defconfig
arm                           sama5_defconfig
powerpc                      cm5200_defconfig
arm                        realview_defconfig
powerpc                     rainier_defconfig
xtensa                           alldefconfig
powerpc                     stx_gp3_defconfig
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
mips                        nlm_xlr_defconfig
sh                           se7712_defconfig
sh                   sh7770_generic_defconfig
powerpc                 mpc85xx_cds_defconfig
riscv                    nommu_k210_defconfig
powerpc                    ge_imp3a_defconfig
m68k                        mvme16x_defconfig
sh                        sh7757lcr_defconfig
powerpc                      pcm030_defconfig
sparc                            allyesconfig
powerpc                      ppc64e_defconfig
mips                      loongson3_defconfig
powerpc                     skiroot_defconfig
sh                         ecovec24_defconfig
sh                           se7722_defconfig
arc                        vdk_hs38_defconfig
sh                          kfr2r09_defconfig
arm                     am200epdkit_defconfig
arm                           efm32_defconfig
arm                           corgi_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                         rt305x_defconfig
sh                               alldefconfig
arm                      tct_hammer_defconfig
sh                             sh03_defconfig
arm                         axm55xx_defconfig
powerpc                       ebony_defconfig
sparc                       sparc32_defconfig
nios2                         10m50_defconfig
arm                       netwinder_defconfig
arm                         s3c2410_defconfig
mips                        bcm63xx_defconfig
sh                           se7705_defconfig
arm                         cm_x300_defconfig
sh                          r7780mp_defconfig
arc                              alldefconfig
powerpc                     mpc83xx_defconfig
powerpc                     tqm8540_defconfig
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
x86_64               randconfig-a015-20201119
x86_64               randconfig-a014-20201119
x86_64               randconfig-a011-20201119
x86_64               randconfig-a013-20201119
x86_64               randconfig-a016-20201119
x86_64               randconfig-a012-20201119
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
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20201119
x86_64               randconfig-a003-20201119
x86_64               randconfig-a004-20201119
x86_64               randconfig-a002-20201119
x86_64               randconfig-a006-20201119
x86_64               randconfig-a001-20201119
x86_64               randconfig-a015-20201118
x86_64               randconfig-a014-20201118
x86_64               randconfig-a011-20201118
x86_64               randconfig-a013-20201118
x86_64               randconfig-a016-20201118
x86_64               randconfig-a012-20201118

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
