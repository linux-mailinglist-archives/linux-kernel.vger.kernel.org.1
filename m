Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B502D85D7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 11:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438676AbgLLKZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 05:25:33 -0500
Received: from mga07.intel.com ([134.134.136.100]:24949 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438605AbgLLKZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 05:25:22 -0500
IronPort-SDR: pUVjtSOEXcUXA3vT4/U/waV3X7gWONdilXgJKkuGqGh57/7dYSGs1qS1RX9KeA2+tg46UuhGfv
 zISl41BJt3Zw==
X-IronPort-AV: E=McAfee;i="6000,8403,9832"; a="238647807"
X-IronPort-AV: E=Sophos;i="5.78,414,1599548400"; 
   d="scan'208";a="238647807"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2020 02:24:34 -0800
IronPort-SDR: FzVQ0fbTN/0y48rdy25spiNUNplJ4qC3VDJhsoNaxQMFEW3SZ2oOQl4P+uVLcnKWDxeabJjSUz
 JWLtmvaTmh9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,414,1599548400"; 
   d="scan'208";a="376969102"
Received: from lkp-server01.sh.intel.com (HELO ecc0cebe68d1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 12 Dec 2020 02:24:33 -0800
Received: from kbuild by ecc0cebe68d1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ko24m-0001Il-Lr; Sat, 12 Dec 2020 10:24:32 +0000
Date:   Sat, 12 Dec 2020 18:23:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 aa3b66f401b372598b29421bab4d17b631b92407
Message-ID: <5fd49a25.gFbmllFPrqrUVwHo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  timers/core
branch HEAD: aa3b66f401b372598b29421bab4d17b631b92407  tick/sched: Make jiffies update quick check more robust

i386-tinyconfig vmlinux size:

========================================================================================================================
 TOTAL  TEXT  built-in.*  sysrq_timer_list_show()                                                                       
========================================================================================================================
    +1     0     +139484                        0  aa3b66f401b3 tick/sched: Make jiffies update quick check more robust 
  -124  -130     +139484                     -149  3650b228f83a..aa3b66f401b3 (ALL COMMITS)                             
========================================================================================================================

elapsed time: 723m

configs tested: 158
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                         3c120_defconfig
sh                 kfr2r09-romimage_defconfig
sh                          r7785rp_defconfig
mips                             allmodconfig
powerpc                     tqm8548_defconfig
m68k                           sun3_defconfig
openrisc                            defconfig
arm                            pleb_defconfig
ia64                             allyesconfig
arm                          collie_defconfig
arm                           sunxi_defconfig
parisc                generic-32bit_defconfig
m68k                       m5275evb_defconfig
arm                          exynos_defconfig
sh                           se7343_defconfig
arm                      integrator_defconfig
arm                            qcom_defconfig
sh                          rsk7264_defconfig
mips                     cu1000-neo_defconfig
powerpc                        cell_defconfig
arm                      jornada720_defconfig
arm                        spear6xx_defconfig
arm                          iop32x_defconfig
sh                          lboxre2_defconfig
powerpc                     tqm8541_defconfig
sh                          landisk_defconfig
powerpc                       holly_defconfig
s390                                defconfig
powerpc                 mpc832x_rdb_defconfig
parisc                              defconfig
xtensa                    smp_lx200_defconfig
arm                        mvebu_v7_defconfig
sh                             shx3_defconfig
arm                          gemini_defconfig
sh                          rsk7269_defconfig
sh                        apsh4ad0a_defconfig
m68k                        m5272c3_defconfig
mips                   sb1250_swarm_defconfig
arm                         socfpga_defconfig
arm                          moxart_defconfig
arc                                 defconfig
arm                         s3c6400_defconfig
arm                       aspeed_g4_defconfig
arc                         haps_hs_defconfig
powerpc                        warp_defconfig
nios2                         10m50_defconfig
parisc                generic-64bit_defconfig
arm                        mvebu_v5_defconfig
powerpc                      bamboo_defconfig
riscv                               defconfig
powerpc                     ppa8548_defconfig
sh                             sh03_defconfig
powerpc                      chrp32_defconfig
mips                           gcw0_defconfig
m68k                       bvme6000_defconfig
powerpc                   currituck_defconfig
mips                      loongson3_defconfig
nds32                               defconfig
parisc                           alldefconfig
ia64                                defconfig
powerpc                    klondike_defconfig
powerpc                 mpc8560_ads_defconfig
arm                         assabet_defconfig
powerpc                  mpc885_ads_defconfig
mips                           xway_defconfig
powerpc                      cm5200_defconfig
arm                      footbridge_defconfig
mips                      pistachio_defconfig
mips                      maltaaprp_defconfig
xtensa                         virt_defconfig
xtensa                generic_kc705_defconfig
sparc                            allyesconfig
powerpc                          g5_defconfig
xtensa                           allyesconfig
arm                         mv78xx0_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                          simpad_defconfig
sh                           se7724_defconfig
c6x                                 defconfig
sh                   secureedge5410_defconfig
sh                            hp6xx_defconfig
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
h8300                            allyesconfig
sh                               allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
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
i386                 randconfig-a014-20201211
i386                 randconfig-a013-20201211
i386                 randconfig-a012-20201211
i386                 randconfig-a011-20201211
i386                 randconfig-a016-20201211
i386                 randconfig-a015-20201211
i386                 randconfig-a014-20201212
i386                 randconfig-a013-20201212
i386                 randconfig-a012-20201212
i386                 randconfig-a011-20201212
i386                 randconfig-a016-20201212
i386                 randconfig-a015-20201212
riscv                    nommu_k210_defconfig
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
x86_64               randconfig-a004-20201209
x86_64               randconfig-a006-20201209
x86_64               randconfig-a005-20201209
x86_64               randconfig-a001-20201209
x86_64               randconfig-a002-20201209
x86_64               randconfig-a003-20201209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
