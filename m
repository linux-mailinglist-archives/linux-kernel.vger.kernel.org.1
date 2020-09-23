Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25303275003
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 06:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgIWEfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 00:35:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:45541 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgIWEfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 00:35:44 -0400
IronPort-SDR: 9miDPIrfa3RpPV54OcQmmQdBBG9U1Pu5Kat3fPJxvePsPgMPV+fhSf25CCLn8stIsbMDMcA9XJ
 73UZv5jL4BrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="245617976"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="245617976"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 21:35:43 -0700
IronPort-SDR: odeJsbsQ/E/Zlq4Jys9kwSkTkUORTzeajsQSvjaqRe+akyVXWX2urSV/21QKO8uVZYY5/ef6Dj
 e7zh0FYGo2iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="291533652"
Received: from lkp-server01.sh.intel.com (HELO 928d8e596b58) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 22 Sep 2020 21:35:42 -0700
Received: from kbuild by 928d8e596b58 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kKwVJ-0000lo-Pe; Wed, 23 Sep 2020 04:35:41 +0000
Date:   Wed, 23 Sep 2020 12:35:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 900ffe39fec908e0aa26a30612e43ebc7140db79
Message-ID: <5f6ad098.JnU4t0xk8fCeiLq6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cleanups
branch HEAD: 900ffe39fec908e0aa26a30612e43ebc7140db79  x86/entry: Fix typo in comments for syscall_enter_from_user_mode()

elapsed time: 724m

configs tested: 204
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                          pcm027_defconfig
arm                         vf610m4_defconfig
arm                           viper_defconfig
arm                      jornada720_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                malta_kvm_guest_defconfig
mips                           gcw0_defconfig
sh                             sh03_defconfig
arm                             ezx_defconfig
mips                      pistachio_defconfig
nios2                         3c120_defconfig
powerpc                     tqm8555_defconfig
arm                          iop32x_defconfig
ia64                         bigsur_defconfig
sh                     magicpanelr2_defconfig
h8300                     edosk2674_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                            lart_defconfig
powerpc                        warp_defconfig
arm                  colibri_pxa300_defconfig
arm                          pxa3xx_defconfig
um                           x86_64_defconfig
m68k                         amcore_defconfig
arm                       versatile_defconfig
arm                           efm32_defconfig
powerpc                      walnut_defconfig
arm                        spear6xx_defconfig
parisc                generic-64bit_defconfig
arm                      integrator_defconfig
powerpc                      makalu_defconfig
arm                    vt8500_v6_v7_defconfig
sh                          kfr2r09_defconfig
sh                           se7751_defconfig
mips                             allmodconfig
sh                     sh7710voipgw_defconfig
sh                           se7722_defconfig
arm                      tct_hammer_defconfig
powerpc                       ebony_defconfig
arm                          tango4_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                         apollo_defconfig
arm                           h5000_defconfig
arm                        multi_v5_defconfig
m68k                             allyesconfig
powerpc                      obs600_defconfig
m68k                          amiga_defconfig
m68k                       m5275evb_defconfig
sh                           sh2007_defconfig
arc                            hsdk_defconfig
arm                      footbridge_defconfig
m68k                        mvme147_defconfig
c6x                        evmc6457_defconfig
arm                           sama5_defconfig
x86_64                           alldefconfig
arm                         s5pv210_defconfig
arm                       aspeed_g5_defconfig
mips                      loongson3_defconfig
mips                 decstation_r4k_defconfig
powerpc                 mpc836x_mds_defconfig
riscv                    nommu_k210_defconfig
mips                           ip28_defconfig
mips                          malta_defconfig
powerpc                         wii_defconfig
microblaze                          defconfig
arm                         bcm2835_defconfig
powerpc                      arches_defconfig
arm                            hisi_defconfig
sh                           se7619_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                         tb0219_defconfig
mips                  maltasmvp_eva_defconfig
mips                           xway_defconfig
arm                           u8500_defconfig
sh                          lboxre2_defconfig
powerpc                      ep88xc_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                       cns3420vb_defconfig
h8300                    h8300h-sim_defconfig
riscv                            allmodconfig
arm                       imx_v4_v5_defconfig
arm                         ebsa110_defconfig
arm                     am200epdkit_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                       mainstone_defconfig
powerpc                      pasemi_defconfig
mips                            ar7_defconfig
arm                         lubbock_defconfig
sh                          sdk7780_defconfig
arm                          prima2_defconfig
powerpc                    gamecube_defconfig
h8300                            alldefconfig
x86_64                              defconfig
powerpc                      chrp32_defconfig
sh                                  defconfig
arm                         lpc18xx_defconfig
mips                           ip27_defconfig
sh                   sh7724_generic_defconfig
arm                         mv78xx0_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20200921
i386                 randconfig-a006-20200921
i386                 randconfig-a003-20200921
i386                 randconfig-a004-20200921
i386                 randconfig-a005-20200921
i386                 randconfig-a001-20200921
i386                 randconfig-a002-20200922
i386                 randconfig-a006-20200922
i386                 randconfig-a003-20200922
i386                 randconfig-a004-20200922
i386                 randconfig-a005-20200922
i386                 randconfig-a001-20200922
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
i386                 randconfig-a012-20200920
i386                 randconfig-a014-20200920
i386                 randconfig-a016-20200920
i386                 randconfig-a013-20200920
i386                 randconfig-a011-20200920
i386                 randconfig-a015-20200920
i386                 randconfig-a012-20200923
i386                 randconfig-a014-20200923
i386                 randconfig-a016-20200923
i386                 randconfig-a013-20200923
i386                 randconfig-a011-20200923
i386                 randconfig-a015-20200923
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20200923
x86_64               randconfig-a003-20200923
x86_64               randconfig-a004-20200923
x86_64               randconfig-a002-20200923
x86_64               randconfig-a006-20200923
x86_64               randconfig-a001-20200923
x86_64               randconfig-a005-20200921
x86_64               randconfig-a003-20200921
x86_64               randconfig-a004-20200921
x86_64               randconfig-a002-20200921
x86_64               randconfig-a006-20200921
x86_64               randconfig-a001-20200921
x86_64               randconfig-a011-20200922
x86_64               randconfig-a013-20200922
x86_64               randconfig-a014-20200922
x86_64               randconfig-a015-20200922
x86_64               randconfig-a012-20200922
x86_64               randconfig-a016-20200922
x86_64               randconfig-a011-20200920
x86_64               randconfig-a013-20200920
x86_64               randconfig-a014-20200920
x86_64               randconfig-a015-20200920
x86_64               randconfig-a012-20200920
x86_64               randconfig-a016-20200920

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
