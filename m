Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A112DB7D8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 01:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgLPAkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 19:40:31 -0500
Received: from mga11.intel.com ([192.55.52.93]:12775 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgLPAk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 19:40:29 -0500
IronPort-SDR: S1WsKScjU/i8O0rFJnkelcYIqJkGjFz1VZC1VyjZLqZeQbxRV8+YbXVM86OeRlvMfXhQPRfBAQ
 HWmN67qGSQ9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="171466991"
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="171466991"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 16:39:48 -0800
IronPort-SDR: 6Vu2rS5oUT4CK/NAqcRjLJHLdL9bgUIiVCzUGnwYpvx/ENQPO3oPTBvpyI1pGTkfFhBU1DEL3s
 tHPAAdlTEnPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="337188972"
Received: from lkp-server02.sh.intel.com (HELO a947d92d0467) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Dec 2020 16:39:47 -0800
Received: from kbuild by a947d92d0467 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kpKr4-00014E-J7; Wed, 16 Dec 2020 00:39:46 +0000
Date:   Wed, 16 Dec 2020 08:39:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 d1c29f5debd4633eb0e9ea1bc00aaad48b077a9b
Message-ID: <5fd95744.QS+bcGCSYVVQY1sR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: d1c29f5debd4633eb0e9ea1bc00aaad48b077a9b  Merge branch 'efi/core'

elapsed time: 720m

configs tested: 123
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                     decstation_defconfig
arm64                            alldefconfig
powerpc                       holly_defconfig
powerpc                 mpc837x_mds_defconfig
arm                    vt8500_v6_v7_defconfig
riscv                    nommu_k210_defconfig
mips                            ar7_defconfig
powerpc                       ppc64_defconfig
arm                          ep93xx_defconfig
powerpc                        warp_defconfig
nios2                         10m50_defconfig
mips                       bmips_be_defconfig
arm                            qcom_defconfig
ia64                      gensparse_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                        sh7785lcr_defconfig
xtensa                  cadence_csp_defconfig
arm                        clps711x_defconfig
powerpc                     ep8248e_defconfig
arm                       netwinder_defconfig
arm                           h5000_defconfig
powerpc                     kmeter1_defconfig
arm                      integrator_defconfig
arm                  colibri_pxa300_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                        edosk7760_defconfig
c6x                                 defconfig
m68k                           sun3_defconfig
arm                     davinci_all_defconfig
powerpc                 linkstation_defconfig
m68k                            mac_defconfig
powerpc64                        alldefconfig
arm                           sunxi_defconfig
arm                            zeus_defconfig
mips                         tb0287_defconfig
powerpc                     sequoia_defconfig
mips                  decstation_64_defconfig
arm                       omap2plus_defconfig
powerpc                 mpc834x_itx_defconfig
sh                        sh7763rdp_defconfig
xtensa                          iss_defconfig
sh                           sh2007_defconfig
sh                        dreamcast_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                           corgi_defconfig
parisc                           alldefconfig
mips                      pic32mzda_defconfig
mips                           xway_defconfig
arm                         mv78xx0_defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20201215
x86_64               randconfig-a006-20201215
x86_64               randconfig-a002-20201215
x86_64               randconfig-a005-20201215
x86_64               randconfig-a004-20201215
x86_64               randconfig-a001-20201215
i386                 randconfig-a001-20201215
i386                 randconfig-a004-20201215
i386                 randconfig-a003-20201215
i386                 randconfig-a002-20201215
i386                 randconfig-a006-20201215
i386                 randconfig-a005-20201215
i386                 randconfig-a014-20201215
i386                 randconfig-a013-20201215
i386                 randconfig-a012-20201215
i386                 randconfig-a011-20201215
i386                 randconfig-a015-20201215
i386                 randconfig-a016-20201215
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
x86_64               randconfig-a016-20201215
x86_64               randconfig-a012-20201215
x86_64               randconfig-a013-20201215
x86_64               randconfig-a015-20201215
x86_64               randconfig-a014-20201215
x86_64               randconfig-a011-20201215

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
