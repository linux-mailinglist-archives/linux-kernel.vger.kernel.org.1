Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCC12F28D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 08:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbhALHTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 02:19:20 -0500
Received: from mga14.intel.com ([192.55.52.115]:14960 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730504AbhALHTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 02:19:20 -0500
IronPort-SDR: 4qdSH+IFx49VE4ydMs3fDyxHiqsaI+bo287guxDygYNbtURAaUE//EhxT5yB3djYRI//nuY8Sd
 M2eAije4tocw==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="177222741"
X-IronPort-AV: E=Sophos;i="5.79,340,1602572400"; 
   d="scan'208";a="177222741"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 23:18:39 -0800
IronPort-SDR: J59Mi2asVSEuU6u+sMumuY8I8MgQK/PCaVHvSiutP3v7ZQJa56sTMBbVgrc8TBeJUFB/rMhmWC
 8VxoTVoPddpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,340,1602572400"; 
   d="scan'208";a="571612749"
Received: from lkp-server01.sh.intel.com (HELO 296aa122a686) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 11 Jan 2021 23:18:38 -0800
Received: from kbuild by 296aa122a686 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kzDwr-00001E-Hh; Tue, 12 Jan 2021 07:18:37 +0000
Date:   Tue, 12 Jan 2021 15:18:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 7024f60d655272bd2ca1d3a4c9e0a63319b1eea1
Message-ID: <5ffd4d39.hSOaaWhCFOTU/Jf4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: 7024f60d655272bd2ca1d3a4c9e0a63319b1eea1  x86/sev-es: Handle string port IO to kernel memory properly

elapsed time: 725m

configs tested: 136
configs skipped: 57

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                  cavium_octeon_defconfig
sh                           se7206_defconfig
powerpc                  storcenter_defconfig
arm                          ep93xx_defconfig
powerpc                  iss476-smp_defconfig
mips                        bcm63xx_defconfig
powerpc                      walnut_defconfig
powerpc                      arches_defconfig
powerpc                      ppc6xx_defconfig
mips                           mtx1_defconfig
arm                      tct_hammer_defconfig
powerpc               mpc834x_itxgp_defconfig
m68k                          atari_defconfig
arm                         lpc32xx_defconfig
sh                           sh2007_defconfig
h8300                     edosk2674_defconfig
arm                           h5000_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                           se7712_defconfig
mips                         tb0287_defconfig
powerpc                      ep88xc_defconfig
m68k                       m5249evb_defconfig
powerpc                     rainier_defconfig
sh                   secureedge5410_defconfig
arm                        vexpress_defconfig
mips                malta_kvm_guest_defconfig
mips                         rt305x_defconfig
powerpc                      ppc64e_defconfig
arm                         vf610m4_defconfig
m68k                           sun3_defconfig
openrisc                  or1klitex_defconfig
powerpc                      katmai_defconfig
powerpc                 canyonlands_defconfig
powerpc                      mgcoge_defconfig
powerpc                       ppc64_defconfig
m68k                       m5275evb_defconfig
mips                       rbtx49xx_defconfig
powerpc                      makalu_defconfig
arm                       cns3420vb_defconfig
mips                           rs90_defconfig
parisc                generic-32bit_defconfig
mips                           ip27_defconfig
nios2                            alldefconfig
mips                  maltasmvp_eva_defconfig
powerpc                     sbc8548_defconfig
arm                         palmz72_defconfig
arm                           efm32_defconfig
arm                        mvebu_v7_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
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
sh                               allmodconfig
arc                                 defconfig
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
x86_64               randconfig-a004-20210111
x86_64               randconfig-a006-20210111
x86_64               randconfig-a001-20210111
x86_64               randconfig-a003-20210111
x86_64               randconfig-a005-20210111
x86_64               randconfig-a002-20210111
i386                 randconfig-a002-20210111
i386                 randconfig-a005-20210111
i386                 randconfig-a006-20210111
i386                 randconfig-a001-20210111
i386                 randconfig-a003-20210111
i386                 randconfig-a004-20210111
x86_64               randconfig-a015-20210110
x86_64               randconfig-a012-20210110
x86_64               randconfig-a013-20210110
x86_64               randconfig-a016-20210110
x86_64               randconfig-a014-20210110
x86_64               randconfig-a011-20210110
i386                 randconfig-a012-20210111
i386                 randconfig-a011-20210111
i386                 randconfig-a015-20210111
i386                 randconfig-a013-20210111
i386                 randconfig-a014-20210111
i386                 randconfig-a016-20210111
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210111
x86_64               randconfig-a012-20210111
x86_64               randconfig-a013-20210111
x86_64               randconfig-a016-20210111
x86_64               randconfig-a014-20210111
x86_64               randconfig-a011-20210111
x86_64               randconfig-a006-20210112
x86_64               randconfig-a004-20210112
x86_64               randconfig-a001-20210112
x86_64               randconfig-a005-20210112
x86_64               randconfig-a003-20210112
x86_64               randconfig-a002-20210112

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
