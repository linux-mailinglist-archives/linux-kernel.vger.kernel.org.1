Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBE32CE8D3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 08:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbgLDHwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 02:52:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:5964 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728006AbgLDHwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 02:52:10 -0500
IronPort-SDR: EoYwucPsrSvmePbVBEKIJq7JIFAIN4+FR2WmoZapYrohYeGeHokSe0wJGQk2jsDwJLLackH/4I
 sBrBBnipr6ow==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="173497843"
X-IronPort-AV: E=Sophos;i="5.78,392,1599548400"; 
   d="scan'208";a="173497843"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 23:51:26 -0800
IronPort-SDR: 7ZcG8G328PkbIiQVxSKegSYITiuu3ko9fMBMY1LENB2V4PwMbSPoMwJUlOzPLJsBV+ZQhEe/nD
 4FaMN8kekBgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,392,1599548400"; 
   d="scan'208";a="540599851"
Received: from lkp-server02.sh.intel.com (HELO f74a175f0d75) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 03 Dec 2020 23:51:25 -0800
Received: from kbuild by f74a175f0d75 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kl5sC-00000v-Az; Fri, 04 Dec 2020 07:51:24 +0000
Date:   Fri, 04 Dec 2020 15:50:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 9dc242493c6ebbea55c354b7dbce7edfc1b5a75c
Message-ID: <5fc9ea4e.4QuUOfahhQY7cFTl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 9dc242493c6ebbea55c354b7dbce7edfc1b5a75c  Merge branch 'linus'

elapsed time: 1107m

configs tested: 117
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       aspeed_g5_defconfig
riscv                            alldefconfig
sh                             espt_defconfig
sh                            hp6xx_defconfig
arm                          pxa168_defconfig
arm                         orion5x_defconfig
nds32                            alldefconfig
mips                      fuloong2e_defconfig
sh                           se7724_defconfig
powerpc                      obs600_defconfig
arm                          pcm027_defconfig
arm                            dove_defconfig
arm                  colibri_pxa300_defconfig
powerpc                      pcm030_defconfig
arc                        nsim_700_defconfig
sparc64                          alldefconfig
mips                  decstation_64_defconfig
sh                           se7750_defconfig
ia64                          tiger_defconfig
mips                        jmr3927_defconfig
xtensa                          iss_defconfig
arm                          ixp4xx_defconfig
powerpc                   motionpro_defconfig
powerpc                     asp8347_defconfig
arm                         nhk8815_defconfig
powerpc                    amigaone_defconfig
sh                          rsk7269_defconfig
powerpc                      mgcoge_defconfig
m68k                         amcore_defconfig
powerpc                    gamecube_defconfig
xtensa                  nommu_kc705_defconfig
arm                         shannon_defconfig
mips                           ip32_defconfig
arm                         s3c2410_defconfig
xtensa                              defconfig
powerpc                     skiroot_defconfig
c6x                        evmc6474_defconfig
arm                             pxa_defconfig
arm                       omap2plus_defconfig
powerpc                    socrates_defconfig
xtensa                    smp_lx200_defconfig
c6x                        evmc6472_defconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                               tinyconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20201204
i386                 randconfig-a004-20201204
i386                 randconfig-a001-20201204
i386                 randconfig-a002-20201204
i386                 randconfig-a006-20201204
i386                 randconfig-a003-20201204
i386                 randconfig-a014-20201203
i386                 randconfig-a013-20201203
i386                 randconfig-a011-20201203
i386                 randconfig-a015-20201203
i386                 randconfig-a012-20201203
i386                 randconfig-a016-20201203
x86_64               randconfig-a004-20201204
x86_64               randconfig-a006-20201204
x86_64               randconfig-a002-20201204
x86_64               randconfig-a001-20201204
x86_64               randconfig-a005-20201204
x86_64               randconfig-a003-20201204
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3

clang tested configs:
x86_64               randconfig-a016-20201204
x86_64               randconfig-a012-20201204
x86_64               randconfig-a014-20201204
x86_64               randconfig-a013-20201204
x86_64               randconfig-a015-20201204
x86_64               randconfig-a011-20201204

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
