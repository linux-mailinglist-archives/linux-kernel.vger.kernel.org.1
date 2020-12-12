Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CC22D8491
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 06:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgLLFD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 00:03:29 -0500
Received: from mga14.intel.com ([192.55.52.115]:13949 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgLLFCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 00:02:35 -0500
IronPort-SDR: C6uW5OjWaXZPvfJirnU9379uzt+8/mTmHiUCqxXEMGxCgHmoJV+wUPOo6GzIfoVdlsiJrkYUaz
 UPNe6U1vz/Sg==
X-IronPort-AV: E=McAfee;i="6000,8403,9832"; a="173760554"
X-IronPort-AV: E=Sophos;i="5.78,413,1599548400"; 
   d="scan'208";a="173760554"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 21:01:53 -0800
IronPort-SDR: +wxxtlVkv+5gSr1RCOHm+YlPmgEUTVS8Td9NAAap6aVMB013Rxv0spgZFAcLi5vECdwtqbKlBR
 +UzCVXMIVqpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,413,1599548400"; 
   d="scan'208";a="349922280"
Received: from lkp-server01.sh.intel.com (HELO ecc0cebe68d1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 11 Dec 2020 21:01:52 -0800
Received: from kbuild by ecc0cebe68d1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1knx2V-0001EL-E3; Sat, 12 Dec 2020 05:01:51 +0000
Date:   Sat, 12 Dec 2020 13:00:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.12.11a] BUILD SUCCESS
 915fc30b2c2c6f03d8fe36707ee0f908bb28dc0d
Message-ID: <5fd44e85.XRp3ew+l4A7XLJbA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.12.11a
branch HEAD: 915fc30b2c2c6f03d8fe36707ee0f908bb28dc0d  doc: Remove obsolete rcutree.rcu_idle_lazy_gp_delay boot parameter

elapsed time: 722m

configs tested: 122
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
sh                          urquell_defconfig
mips                           mtx1_defconfig
powerpc                    mvme5100_defconfig
mips                         cobalt_defconfig
m68k                             allyesconfig
powerpc                     tqm8541_defconfig
sh                          landisk_defconfig
powerpc                       holly_defconfig
arm                          exynos_defconfig
arm                          gemini_defconfig
sh                          rsk7269_defconfig
sh                        apsh4ad0a_defconfig
m68k                        m5272c3_defconfig
mips                   sb1250_swarm_defconfig
arm                       aspeed_g4_defconfig
arc                         haps_hs_defconfig
powerpc                        warp_defconfig
sh                           se7343_defconfig
parisc                           alldefconfig
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
m68k                       bvme6000_defconfig
nds32                               defconfig
powerpc                      pasemi_defconfig
mips                     cu1000-neo_defconfig
xtensa                    smp_lx200_defconfig
sh                           se7619_defconfig
xtensa                           allyesconfig
arm                         mv78xx0_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                          simpad_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
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
x86_64               randconfig-a004-20201209
x86_64               randconfig-a006-20201209
x86_64               randconfig-a005-20201209
x86_64               randconfig-a001-20201209
x86_64               randconfig-a002-20201209
x86_64               randconfig-a003-20201209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
