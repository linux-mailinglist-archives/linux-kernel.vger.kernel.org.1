Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CF52D8B9E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 06:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbgLMFjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 00:39:14 -0500
Received: from mga02.intel.com ([134.134.136.20]:55717 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727865AbgLMFjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 00:39:12 -0500
IronPort-SDR: l5q4eZqR6tjA3Gpae8UqyLYPwCvaoroDuLgmS4GzrlKDpDBKlna50pNFJQRa/+m/aQUSHWj3tx
 p+oS7nFDYyRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9833"; a="161637335"
X-IronPort-AV: E=Sophos;i="5.78,415,1599548400"; 
   d="scan'208";a="161637335"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2020 21:38:31 -0800
IronPort-SDR: L2ex9e4dLquHGrr8ro7dTAHijzgMCT5Bz1o4YrZQtUjfA6VqxYteJNylHNNg8XO/aFH3eBvdyn
 /xJyWdfgpEgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,415,1599548400"; 
   d="scan'208";a="445304176"
Received: from lkp-server01.sh.intel.com (HELO ecc0cebe68d1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 12 Dec 2020 21:38:29 -0800
Received: from kbuild by ecc0cebe68d1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1koK5U-0001fd-Rs; Sun, 13 Dec 2020 05:38:28 +0000
Date:   Sun, 13 Dec 2020 13:37:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 dc780fed5a1be01ece7e0d5588337340a642183c
Message-ID: <5fd5a8a4.hN0QZ5p6nzWxTnEe%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: dc780fed5a1be01ece7e0d5588337340a642183c  Merge branch 'core/entry'

elapsed time: 720m

configs tested: 151
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
arm                        mvebu_v5_defconfig
powerpc                         wii_defconfig
arm                        cerfcube_defconfig
mips                        nlm_xlr_defconfig
arm                        spear3xx_defconfig
nds32                            alldefconfig
powerpc                    amigaone_defconfig
mips                      fuloong2e_defconfig
mips                      bmips_stb_defconfig
arm                      footbridge_defconfig
mips                          ath79_defconfig
mips                          rm200_defconfig
sh                               j2_defconfig
powerpc                     pseries_defconfig
mips                        bcm63xx_defconfig
mips                        nlm_xlp_defconfig
powerpc                         ps3_defconfig
mips                           ip28_defconfig
arm                           stm32_defconfig
m68k                           sun3_defconfig
arm                        multi_v7_defconfig
powerpc                  mpc885_ads_defconfig
arm                     davinci_all_defconfig
sh                        edosk7705_defconfig
sh                           se7724_defconfig
arm                       imx_v6_v7_defconfig
powerpc                     tqm8540_defconfig
mips                      loongson3_defconfig
arm                          simpad_defconfig
powerpc                      pcm030_defconfig
m68k                          atari_defconfig
powerpc                       ebony_defconfig
x86_64                              defconfig
alpha                            allyesconfig
mips                      maltasmvp_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                   currituck_defconfig
arm                          pxa910_defconfig
arm                          imote2_defconfig
powerpc                      ep88xc_defconfig
riscv                               defconfig
sh                     sh7710voipgw_defconfig
mips                       lemote2f_defconfig
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
powerpc                     powernv_defconfig
sh                        sh7763rdp_defconfig
arm                        realview_defconfig
mips                      maltaaprp_defconfig
mips                         rt305x_defconfig
h8300                       h8s-sim_defconfig
m68k                          amiga_defconfig
ia64                          tiger_defconfig
arm                       aspeed_g4_defconfig
nios2                         3c120_defconfig
sh                          urquell_defconfig
mips                           ip27_defconfig
riscv                    nommu_virt_defconfig
sparc64                          alldefconfig
parisc                generic-32bit_defconfig
arm                       multi_v4t_defconfig
sh                         ecovec24_defconfig
csky                                defconfig
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
