Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4BE92FCD02
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbhATIzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 03:55:37 -0500
Received: from mga11.intel.com ([192.55.52.93]:53661 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728895AbhATIym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 03:54:42 -0500
IronPort-SDR: H//ImVd3yBsGYerjy2LZq9O1uOtQiZXBfBvjJvQdtM8S2/ksrNtso5ciz++tvvMNdkDRSWEpiJ
 bUYEPiaLrnow==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="175565799"
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="175565799"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 00:54:02 -0800
IronPort-SDR: IJD254fB4SzPFzMAL7NZ7hVw/yg58Wj37D6rJAfFZkJpLV2NEpCKLsnfSM//6daXCF5l01+LHO
 wSVyYzYTTSTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="402671742"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 20 Jan 2021 00:54:01 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l29FY-0005is-Nk; Wed, 20 Jan 2021 08:54:00 +0000
Date:   Wed, 20 Jan 2021 16:53:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 9c7d9017a49fb8516c13b7bff59b7da2abed23e1
Message-ID: <6007ef76.C1HvQ4syztLJQdW2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: 9c7d9017a49fb8516c13b7bff59b7da2abed23e1  x86: PM: Register syscore_ops for scale invariance

elapsed time: 726m

configs tested: 122
configs skipped: 61

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                         ap325rxa_defconfig
c6x                        evmc6678_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                          rm200_defconfig
arm                         s5pv210_defconfig
sh                              ul2_defconfig
sh                          polaris_defconfig
powerpc                      pasemi_defconfig
sparc64                             defconfig
arc                           tb10x_defconfig
m68k                        m5272c3_defconfig
c6x                        evmc6474_defconfig
powerpc                      pmac32_defconfig
mips                           ci20_defconfig
arm                           sunxi_defconfig
mips                        bcm63xx_defconfig
powerpc                  iss476-smp_defconfig
m68k                            q40_defconfig
nios2                            allyesconfig
alpha                               defconfig
arm                        neponset_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                    adder875_defconfig
arm                            hisi_defconfig
arm                         palmz72_defconfig
powerpc                     sbc8548_defconfig
i386                                defconfig
c6x                        evmc6472_defconfig
powerpc                 mpc837x_mds_defconfig
mips                         cobalt_defconfig
arm                           corgi_defconfig
m68k                        m5407c3_defconfig
m68k                          amiga_defconfig
powerpc                      cm5200_defconfig
arm                       omap2plus_defconfig
powerpc                     pq2fads_defconfig
powerpc                       eiger_defconfig
arc                              alldefconfig
powerpc                      tqm8xx_defconfig
arm                            lart_defconfig
mips                     cu1000-neo_defconfig
arm                       cns3420vb_defconfig
um                             i386_defconfig
xtensa                           alldefconfig
h8300                            allyesconfig
arm                        spear6xx_defconfig
ia64                        generic_defconfig
powerpc                     mpc83xx_defconfig
arm                           stm32_defconfig
sh                           se7780_defconfig
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
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210120
i386                 randconfig-a002-20210120
i386                 randconfig-a004-20210120
i386                 randconfig-a006-20210120
i386                 randconfig-a005-20210120
i386                 randconfig-a003-20210120
x86_64               randconfig-a012-20210120
x86_64               randconfig-a015-20210120
x86_64               randconfig-a016-20210120
x86_64               randconfig-a011-20210120
x86_64               randconfig-a013-20210120
x86_64               randconfig-a014-20210120
i386                 randconfig-a013-20210120
i386                 randconfig-a011-20210120
i386                 randconfig-a012-20210120
i386                 randconfig-a014-20210120
i386                 randconfig-a015-20210120
i386                 randconfig-a016-20210120
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
x86_64               randconfig-a002-20210120
x86_64               randconfig-a003-20210120
x86_64               randconfig-a001-20210120
x86_64               randconfig-a005-20210120
x86_64               randconfig-a006-20210120
x86_64               randconfig-a004-20210120

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
