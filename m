Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEBF2CCEC2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 06:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgLCFoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 00:44:37 -0500
Received: from mga18.intel.com ([134.134.136.126]:29288 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbgLCFog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 00:44:36 -0500
IronPort-SDR: 3U8X5QmW58UhJx+vFKmpAieJZezuRc8R/elGiUW6lO8GM3XGcUUgP8xsdm1desCHgNIIpeUknG
 LgcunJN0bo/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="160906868"
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="160906868"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 21:43:55 -0800
IronPort-SDR: 0vGqVHNsXL+ZNfrT3yKyArGNHRrnrKBCjgAMF8MUoedBXEkeAI1ugJEH3PeY9K1t2wdl2xfHZC
 ShuFoxIuWjvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="538233399"
Received: from lkp-server01.sh.intel.com (HELO c4fb854e61c6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 02 Dec 2020 21:43:53 -0800
Received: from kbuild by c4fb854e61c6 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kkhPF-00003j-7X; Thu, 03 Dec 2020 05:43:53 +0000
Date:   Thu, 03 Dec 2020 13:43:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 202bb4a77c5e68aced750f5998f0faf5564f95a0
Message-ID: <5fc87ae6./Wj7n89ZeHdzbkci%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 202bb4a77c5e68aced750f5998f0faf5564f95a0  Merge branch 'core/entry'

elapsed time: 728m

configs tested: 101
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                       maple_defconfig
arm                           h3600_defconfig
arm                           stm32_defconfig
mips                        bcm63xx_defconfig
arm                              alldefconfig
sh                          rsk7264_defconfig
powerpc                        fsp2_defconfig
sh                             shx3_defconfig
sh                        sh7785lcr_defconfig
mips                         tb0287_defconfig
m68k                          hp300_defconfig
mips                     cu1830-neo_defconfig
arm                         s3c6400_defconfig
sh                           se7343_defconfig
arm                            u300_defconfig
m68k                             alldefconfig
arm                        spear6xx_defconfig
arm                         assabet_defconfig
sh                              ul2_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                     mpc5200_defconfig
powerpc                 mpc8272_ads_defconfig
openrisc                            defconfig
powerpc                       holly_defconfig
mips                         bigsur_defconfig
arm                          prima2_defconfig
arc                           tb10x_defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201202
x86_64               randconfig-a006-20201202
x86_64               randconfig-a001-20201202
x86_64               randconfig-a002-20201202
x86_64               randconfig-a005-20201202
x86_64               randconfig-a003-20201202
i386                 randconfig-a004-20201202
i386                 randconfig-a005-20201202
i386                 randconfig-a001-20201202
i386                 randconfig-a002-20201202
i386                 randconfig-a006-20201202
i386                 randconfig-a003-20201202
i386                 randconfig-a014-20201202
i386                 randconfig-a013-20201202
i386                 randconfig-a011-20201202
i386                 randconfig-a015-20201202
i386                 randconfig-a012-20201202
i386                 randconfig-a016-20201202
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
x86_64               randconfig-a016-20201202
x86_64               randconfig-a012-20201202
x86_64               randconfig-a014-20201202
x86_64               randconfig-a013-20201202
x86_64               randconfig-a015-20201202
x86_64               randconfig-a011-20201202

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
