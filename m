Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09C42B9BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 20:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgKSTns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 14:43:48 -0500
Received: from mga01.intel.com ([192.55.52.88]:13163 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbgKSTnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 14:43:47 -0500
IronPort-SDR: DKFPaGicrKP+403CGbzCo9u5Djopz6NYL3ZH3EUTMbm848H5cUsxmTCdBNIpeQxxaRTbeRHQgQ
 uTQtIBic+rUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="189446269"
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="189446269"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 11:43:47 -0800
IronPort-SDR: +NesDqHLCKzVXDMjWUuzlhoav1tIvwc4SGES1R6mISNzh9U1p5YVRMsyMJNMochRQQ5uDlX6t7
 O8oR8JKk5S5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,354,1599548400"; 
   d="scan'208";a="476939182"
Received: from lkp-server01.sh.intel.com (HELO 1b817e3f8ad2) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 19 Nov 2020 11:43:45 -0800
Received: from kbuild by 1b817e3f8ad2 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kfpqK-0000BN-Os; Thu, 19 Nov 2020 19:43:44 +0000
Date:   Fri, 20 Nov 2020 03:43:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/apic] BUILD SUCCESS
 d1adcfbb520c43c10fc22fcdccdd4204e014fb53
Message-ID: <5fb6cade.AofB6JhhvOA/DHwI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/apic
branch HEAD: d1adcfbb520c43c10fc22fcdccdd4204e014fb53  iommu/amd: Fix IOMMU interrupt generation in X2APIC mode

elapsed time: 724m

configs tested: 134
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                    ge_imp3a_defconfig
mips                     cu1830-neo_defconfig
powerpc                     powernv_defconfig
mips                        nlm_xlr_defconfig
parisc                           allyesconfig
microblaze                    nommu_defconfig
powerpc                      chrp32_defconfig
arm                         hackkit_defconfig
xtensa                    xip_kc705_defconfig
arm                            lart_defconfig
powerpc                      obs600_defconfig
m68k                          atari_defconfig
sh                           se7712_defconfig
arm                       multi_v4t_defconfig
arm                    vt8500_v6_v7_defconfig
arm                         shannon_defconfig
powerpc                      tqm8xx_defconfig
powerpc                       holly_defconfig
arm                         bcm2835_defconfig
powerpc                     rainier_defconfig
powerpc                     tqm8540_defconfig
arm                        trizeps4_defconfig
arm                     davinci_all_defconfig
m68k                          sun3x_defconfig
arm                          exynos_defconfig
mips                      pistachio_defconfig
mips                        nlm_xlp_defconfig
mips                           ip27_defconfig
powerpc                    gamecube_defconfig
powerpc                  mpc866_ads_defconfig
m68k                        m5407c3_defconfig
powerpc                       eiger_defconfig
um                            kunit_defconfig
mips                      bmips_stb_defconfig
sh                            titan_defconfig
powerpc                 mpc85xx_cds_defconfig
xtensa                         virt_defconfig
arm                          prima2_defconfig
xtensa                  audio_kc705_defconfig
arm                          ixp4xx_defconfig
powerpc                    klondike_defconfig
mips                     cu1000-neo_defconfig
arm                     am200epdkit_defconfig
arm                           h5000_defconfig
arm                  colibri_pxa270_defconfig
mips                        vocore2_defconfig
mips                          rm200_defconfig
sparc                            alldefconfig
m68k                       m5275evb_defconfig
mips                        omega2p_defconfig
arm                          badge4_defconfig
xtensa                    smp_lx200_defconfig
arm                         lpc32xx_defconfig
mips                       bmips_be_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                       ebony_defconfig
sh                          r7785rp_defconfig
arm                      footbridge_defconfig
sh                            shmin_defconfig
openrisc                 simple_smp_defconfig
arm                         nhk8815_defconfig
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
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a005-20201119
i386                 randconfig-a002-20201119
i386                 randconfig-a001-20201119
i386                 randconfig-a003-20201119
i386                 randconfig-a004-20201119
i386                 randconfig-a006-20201119
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
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-a005-20201119
x86_64               randconfig-a003-20201119
x86_64               randconfig-a004-20201119
x86_64               randconfig-a002-20201119
x86_64               randconfig-a006-20201119
x86_64               randconfig-a001-20201119

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
