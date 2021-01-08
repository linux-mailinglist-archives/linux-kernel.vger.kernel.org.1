Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A09F2EF7F7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 20:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbhAHTPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 14:15:51 -0500
Received: from mga14.intel.com ([192.55.52.115]:56332 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727376AbhAHTPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 14:15:50 -0500
IronPort-SDR: +Sr2Pu9goE2uXD9s11Ux0ZxByIPg04B6B144bfvvHK+eBTQ2q2n4FY47yl+pCtV7QNfhL41oTB
 0Ru8FH63N0Gg==
X-IronPort-AV: E=McAfee;i="6000,8403,9858"; a="176868081"
X-IronPort-AV: E=Sophos;i="5.79,332,1602572400"; 
   d="scan'208";a="176868081"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 11:15:09 -0800
IronPort-SDR: OdUIigq6k8VUHdciDQ/tK4laio5GW1EslOk9Lxg3+0BKKY+dmZWKS9IVHx2ulUxg/dyyS43hNJ
 T7NADVPt6uow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,332,1602572400"; 
   d="scan'208";a="463477099"
Received: from lkp-server01.sh.intel.com (HELO 412602b27703) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 08 Jan 2021 11:15:08 -0800
Received: from kbuild by 412602b27703 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kxxE3-0000ck-Rh; Fri, 08 Jan 2021 19:15:07 +0000
Date:   Sat, 09 Jan 2021 03:14:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 167dcfc08b0b1f964ea95d410aa496fd78adf475
Message-ID: <5ff8af0e.Qv+XiZyGlasvaPVw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/mm
branch HEAD: 167dcfc08b0b1f964ea95d410aa496fd78adf475  x86/mm: Increase pgt_buf size for 5-level page tables

elapsed time: 1053m

configs tested: 122
configs skipped: 113

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                       imx_v6_v7_defconfig
x86_64                              defconfig
nios2                            alldefconfig
c6x                         dsk6455_defconfig
arm                        mini2440_defconfig
mips                          rb532_defconfig
mips                       rbtx49xx_defconfig
nios2                            allyesconfig
powerpc                    mvme5100_defconfig
mips                          ath25_defconfig
sh                             shx3_defconfig
m68k                          multi_defconfig
sh                          lboxre2_defconfig
openrisc                            defconfig
powerpc                      arches_defconfig
mips                        qi_lb60_defconfig
powerpc                     sbc8548_defconfig
openrisc                 simple_smp_defconfig
sh                           se7780_defconfig
arm                       aspeed_g4_defconfig
arm                         vf610m4_defconfig
arm                          badge4_defconfig
arm                        neponset_defconfig
arm                       imx_v4_v5_defconfig
sh                         ap325rxa_defconfig
m68k                         amcore_defconfig
ia64                             alldefconfig
sh                        sh7785lcr_defconfig
nds32                            alldefconfig
sh                         microdev_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                          rm200_defconfig
powerpc                        cell_defconfig
ia64                            zx1_defconfig
powerpc                     ppa8548_defconfig
mips                           ip22_defconfig
openrisc                    or1ksim_defconfig
mips                malta_kvm_guest_defconfig
i386                             allyesconfig
powerpc                       ppc64_defconfig
powerpc                     tqm8560_defconfig
mips                         cobalt_defconfig
sh                           se7724_defconfig
powerpc                      cm5200_defconfig
arm                         lpc32xx_defconfig
ia64                         bigsur_defconfig
arm                        vexpress_defconfig
mips                            gpr_defconfig
sh                            hp6xx_defconfig
arm                      integrator_defconfig
sh                   rts7751r2dplus_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210108
x86_64               randconfig-a006-20210108
x86_64               randconfig-a001-20210108
x86_64               randconfig-a002-20210108
x86_64               randconfig-a003-20210108
x86_64               randconfig-a005-20210108
i386                 randconfig-a005-20210108
i386                 randconfig-a002-20210108
i386                 randconfig-a001-20210108
i386                 randconfig-a003-20210108
i386                 randconfig-a006-20210108
i386                 randconfig-a004-20210108
i386                 randconfig-a016-20210108
i386                 randconfig-a011-20210108
i386                 randconfig-a014-20210108
i386                 randconfig-a015-20210108
i386                 randconfig-a013-20210108
i386                 randconfig-a012-20210108
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
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20210108
x86_64               randconfig-a011-20210108
x86_64               randconfig-a012-20210108
x86_64               randconfig-a016-20210108
x86_64               randconfig-a014-20210108
x86_64               randconfig-a015-20210108

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
