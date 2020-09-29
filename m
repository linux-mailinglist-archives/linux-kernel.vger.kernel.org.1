Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D130F27C1DD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 12:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbgI2KFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 06:05:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:8714 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgI2KFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 06:05:55 -0400
IronPort-SDR: 34daH3ZITRCbzM9L3wNNLuFp+HyAPUF7i+oYHH8Knpap2dklEyjeZOa5GXj219kdGT3Hl4eVkP
 BRNVoRow/ZyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="159451637"
X-IronPort-AV: E=Sophos;i="5.77,317,1596524400"; 
   d="scan'208";a="159451637"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 22:12:45 -0700
IronPort-SDR: fqdbavZNGWrnZB3XUgInjYbXvrmJoIWRevBpJi1IqMpaVFuAP3r7M93Xj5JM09QX9yCaCOB4+2
 wtF04YR3w22w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,317,1596524400"; 
   d="scan'208";a="307617742"
Received: from lkp-server02.sh.intel.com (HELO 029ab7997206) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 28 Sep 2020 22:12:44 -0700
Received: from kbuild by 029ab7997206 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kN7wR-00006q-FF; Tue, 29 Sep 2020 05:12:43 +0000
Date:   Tue, 29 Sep 2020 13:12:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/fam1-fddi] BUILD SUCCESS
 ce71a10ee8f3bc7ead17c4a4333d6a57455bde2b
Message-ID: <5f72c23f./kPBWcZBu+W6HKH4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  testing/fam1-fddi
branch HEAD: ce71a10ee8f3bc7ead17c4a4333d6a57455bde2b  fddi/skfp: Avoid the use of one-element array

elapsed time: 723m

configs tested: 141
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                     haps_hs_smp_defconfig
m68k                          amiga_defconfig
ia64                         bigsur_defconfig
sh                             shx3_defconfig
m68k                        stmark2_defconfig
nios2                         3c120_defconfig
powerpc                      arches_defconfig
powerpc                      cm5200_defconfig
sparc                       sparc32_defconfig
arm                          badge4_defconfig
powerpc                        cell_defconfig
powerpc                     tqm8541_defconfig
powerpc64                           defconfig
csky                             alldefconfig
riscv                          rv32_defconfig
sh                          rsk7201_defconfig
openrisc                         alldefconfig
mips                      pic32mzda_defconfig
arm                   milbeaut_m10v_defconfig
m68k                          multi_defconfig
sh                        edosk7705_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                      mgcoge_defconfig
mips                        maltaup_defconfig
alpha                            allyesconfig
powerpc                     tqm8548_defconfig
arm                          simpad_defconfig
mips                        workpad_defconfig
xtensa                       common_defconfig
powerpc64                        alldefconfig
arm                          lpd270_defconfig
mips                         cobalt_defconfig
arm                        multi_v7_defconfig
powerpc                       maple_defconfig
powerpc                   bluestone_defconfig
powerpc                     tqm5200_defconfig
arm                             mxs_defconfig
arm                           omap1_defconfig
microblaze                      mmu_defconfig
powerpc                 mpc836x_rdk_defconfig
arc                      axs103_smp_defconfig
arm                              zx_defconfig
arm                        mvebu_v5_defconfig
c6x                        evmc6472_defconfig
arm                  colibri_pxa300_defconfig
powerpc                      ppc40x_defconfig
arm                      integrator_defconfig
arc                          axs103_defconfig
mips                      malta_kvm_defconfig
arm                         s5pv210_defconfig
mips                       bmips_be_defconfig
sh                           se7343_defconfig
arm                           sunxi_defconfig
m68k                          atari_defconfig
arm                         orion5x_defconfig
powerpc                     pseries_defconfig
arm                         lpc32xx_defconfig
ia64                            zx1_defconfig
sh                           se7750_defconfig
mips                           xway_defconfig
arm                        cerfcube_defconfig
arm                  colibri_pxa270_defconfig
mips                      maltaaprp_defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20200928
x86_64               randconfig-a003-20200928
x86_64               randconfig-a004-20200928
x86_64               randconfig-a002-20200928
x86_64               randconfig-a006-20200928
x86_64               randconfig-a001-20200928
i386                 randconfig-a006-20200928
i386                 randconfig-a002-20200928
i386                 randconfig-a003-20200928
i386                 randconfig-a004-20200928
i386                 randconfig-a005-20200928
i386                 randconfig-a001-20200928
i386                 randconfig-a012-20200928
i386                 randconfig-a016-20200928
i386                 randconfig-a014-20200928
i386                 randconfig-a013-20200928
i386                 randconfig-a015-20200928
i386                 randconfig-a011-20200928
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20200927
x86_64               randconfig-a003-20200927
x86_64               randconfig-a004-20200927
x86_64               randconfig-a002-20200927
x86_64               randconfig-a006-20200927
x86_64               randconfig-a001-20200927
x86_64               randconfig-a011-20200928
x86_64               randconfig-a013-20200928
x86_64               randconfig-a015-20200928
x86_64               randconfig-a014-20200928
x86_64               randconfig-a016-20200928
x86_64               randconfig-a012-20200928

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
