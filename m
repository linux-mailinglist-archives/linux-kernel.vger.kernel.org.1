Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0102D8C0B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 08:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732940AbgLMHoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 02:44:23 -0500
Received: from mga02.intel.com ([134.134.136.20]:27068 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbgLMHoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 02:44:23 -0500
IronPort-SDR: 3fZrxlRi/qySvtSrEdDXuIaDiO14Un8HqgT6xf+9oWYPhqSUsNMAkHevuTSBxyscJg0anKlrdn
 3DSwK7/wFoKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9833"; a="161642501"
X-IronPort-AV: E=Sophos;i="5.78,415,1599548400"; 
   d="scan'208";a="161642501"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2020 23:43:41 -0800
IronPort-SDR: kTF65yV5xKDLfShkNZ2Yx/5EfdgNnmFW0lhj/AGainA6zLwqYXES5XjAly9d5fI8OecRfHnUrO
 9q3fTAd8P+RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,415,1599548400"; 
   d="scan'208";a="384934685"
Received: from lkp-server01.sh.intel.com (HELO ecc0cebe68d1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Dec 2020 23:43:40 -0800
Received: from kbuild by ecc0cebe68d1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1koM2d-0001il-UZ; Sun, 13 Dec 2020 07:43:39 +0000
Date:   Sun, 13 Dec 2020 15:43:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 559db8c7e6ed1f24baf7264a6966ee4f051c6446
Message-ID: <5fd5c60c.kyXWnkgBFWRJK7l5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  irq/core
branch HEAD: 559db8c7e6ed1f24baf7264a6966ee4f051c6446  Merge tag 'irqchip-5.11' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

elapsed time: 725m

configs tested: 123
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      tqm8xx_defconfig
sh                                  defconfig
parisc                              defconfig
m68k                        m5407c3_defconfig
arm                        vexpress_defconfig
sh                             shx3_defconfig
nios2                            alldefconfig
sh                          polaris_defconfig
m68k                        mvme16x_defconfig
openrisc                            defconfig
mips                        qi_lb60_defconfig
arm                           tegra_defconfig
mips                          rm200_defconfig
sh                               j2_defconfig
powerpc                     pseries_defconfig
mips                        bcm63xx_defconfig
mips                        nlm_xlp_defconfig
powerpc                      pcm030_defconfig
m68k                          atari_defconfig
mips                      loongson3_defconfig
powerpc                    amigaone_defconfig
powerpc                       ebony_defconfig
x86_64                              defconfig
alpha                            allyesconfig
mips                      maltasmvp_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                   currituck_defconfig
arm                          pxa910_defconfig
arm                          imote2_defconfig
sh                               allmodconfig
powerpc                      bamboo_defconfig
mips                           rs90_defconfig
sh                        apsh4ad0a_defconfig
riscv                             allnoconfig
powerpc                 mpc8315_rdb_defconfig
mips                         tb0287_defconfig
powerpc                      cm5200_defconfig
mips                        maltaup_defconfig
ia64                      gensparse_defconfig
arm                        multi_v7_defconfig
powerpc                     powernv_defconfig
sh                        sh7763rdp_defconfig
arm                        realview_defconfig
mips                      maltaaprp_defconfig
arm                       aspeed_g4_defconfig
nios2                         3c120_defconfig
sh                          urquell_defconfig
mips                           ip27_defconfig
riscv                    nommu_virt_defconfig
sparc64                          alldefconfig
parisc                generic-32bit_defconfig
csky                                defconfig
arm                       multi_v4t_defconfig
sh                         ecovec24_defconfig
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
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
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
x86_64               randconfig-a003-20201213
x86_64               randconfig-a006-20201213
x86_64               randconfig-a002-20201213
x86_64               randconfig-a005-20201213
x86_64               randconfig-a004-20201213
x86_64               randconfig-a001-20201213
i386                 randconfig-a001-20201213
i386                 randconfig-a004-20201213
i386                 randconfig-a003-20201213
i386                 randconfig-a002-20201213
i386                 randconfig-a005-20201213
i386                 randconfig-a006-20201213
i386                 randconfig-a014-20201213
i386                 randconfig-a013-20201213
i386                 randconfig-a012-20201213
i386                 randconfig-a011-20201213
i386                 randconfig-a016-20201213
i386                 randconfig-a015-20201213
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a016-20201213
x86_64               randconfig-a012-20201213
x86_64               randconfig-a013-20201213
x86_64               randconfig-a015-20201213
x86_64               randconfig-a014-20201213
x86_64               randconfig-a011-20201213

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
