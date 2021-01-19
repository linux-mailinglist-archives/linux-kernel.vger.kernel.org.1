Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6088D2FB813
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391977AbhASLzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 06:55:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:58374 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732083AbhASLkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 06:40:33 -0500
IronPort-SDR: g4/goq39zEqGEyXgnhFNHSGrZDBBOjn4lUTyKKOUCGNx/KqcZF3Ik+LPOgO/Ju4tiUyZ8bN/RH
 zo9jBcMu9ZFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="263721319"
X-IronPort-AV: E=Sophos;i="5.79,358,1602572400"; 
   d="scan'208";a="263721319"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 03:38:48 -0800
IronPort-SDR: JJEb8ECW8FBhOoIOkO7dtW/AqWwS5+g4zo2+y0xiF9oBEHm9i3K+FwUSgQgqrITlVdl6QWnlZr
 b6i614DNzCsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,358,1602572400"; 
   d="scan'208";a="399400548"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jan 2021 03:38:47 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l1pLS-00051J-RG; Tue, 19 Jan 2021 11:38:46 +0000
Date:   Tue, 19 Jan 2021 19:38:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 443121b3ebb9025fd99ff11851d3537cb756d456
Message-ID: <6006c4ba.7njuMq0fAnzkWycl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/misc
branch HEAD: 443121b3ebb9025fd99ff11851d3537cb756d456  selftests/fpu: Fix debugfs_simple_attr.cocci warning

elapsed time: 1430m

configs tested: 138
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     redwood_defconfig
arm                        spear6xx_defconfig
arm                       netwinder_defconfig
mips                            gpr_defconfig
sh                        dreamcast_defconfig
sh                            hp6xx_defconfig
arm                          moxart_defconfig
m68k                        mvme16x_defconfig
parisc                generic-32bit_defconfig
arm                      pxa255-idp_defconfig
arm                          iop32x_defconfig
mips                          rb532_defconfig
xtensa                         virt_defconfig
m68k                        m5307c3_defconfig
arm                           h3600_defconfig
powerpc                 mpc8560_ads_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                  cavium_octeon_defconfig
arm                           corgi_defconfig
ia64                        generic_defconfig
arm                            dove_defconfig
openrisc                 simple_smp_defconfig
powerpc                 mpc834x_itx_defconfig
mips                        jmr3927_defconfig
arc                           tb10x_defconfig
powerpc                   motionpro_defconfig
arm                         at91_dt_defconfig
c6x                                 defconfig
arm                            hisi_defconfig
mips                       bmips_be_defconfig
powerpc                  mpc885_ads_defconfig
arm                         hackkit_defconfig
sh                        apsh4ad0a_defconfig
powerpc                      pmac32_defconfig
mips                        nlm_xlp_defconfig
powerpc                 linkstation_defconfig
m68k                          atari_defconfig
arm                           omap1_defconfig
mips                        bcm63xx_defconfig
arm                     davinci_all_defconfig
arm                         s3c6400_defconfig
powerpc                    mvme5100_defconfig
arm                      integrator_defconfig
mips                           ip22_defconfig
mips                           ip28_defconfig
sh                          urquell_defconfig
m68k                       m5475evb_defconfig
xtensa                  audio_kc705_defconfig
mips                        workpad_defconfig
powerpc                    amigaone_defconfig
sh                         apsh4a3a_defconfig
mips                           ip32_defconfig
microblaze                      mmu_defconfig
mips                      bmips_stb_defconfig
powerpc                        cell_defconfig
powerpc                     stx_gp3_defconfig
m68k                         apollo_defconfig
powerpc                      ppc6xx_defconfig
m68k                       bvme6000_defconfig
powerpc                     tqm8560_defconfig
m68k                        stmark2_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20210118
i386                 randconfig-a005-20210118
i386                 randconfig-a006-20210118
i386                 randconfig-a001-20210118
i386                 randconfig-a003-20210118
i386                 randconfig-a004-20210118
x86_64               randconfig-a015-20210118
x86_64               randconfig-a013-20210118
x86_64               randconfig-a012-20210118
x86_64               randconfig-a016-20210118
x86_64               randconfig-a011-20210118
x86_64               randconfig-a014-20210118
i386                 randconfig-a011-20210118
i386                 randconfig-a012-20210118
i386                 randconfig-a016-20210118
i386                 randconfig-a015-20210118
i386                 randconfig-a013-20210118
i386                 randconfig-a014-20210118
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210118
x86_64               randconfig-a006-20210118
x86_64               randconfig-a001-20210118
x86_64               randconfig-a003-20210118
x86_64               randconfig-a005-20210118
x86_64               randconfig-a002-20210118

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
