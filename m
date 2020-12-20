Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FDA2DF2A0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 02:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgLTBgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 20:36:39 -0500
Received: from mga17.intel.com ([192.55.52.151]:24622 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbgLTBgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 20:36:38 -0500
IronPort-SDR: dCxmnb3Td3ctmsVz+699KZqm4qsxlE7r7gkeKSKo8K8+/xt0JWZXY5S0R6QkpL9STDrEjU/hK+
 Vmx86Teean6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9840"; a="155403933"
X-IronPort-AV: E=Sophos;i="5.78,433,1599548400"; 
   d="scan'208";a="155403933"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2020 17:35:58 -0800
IronPort-SDR: 9z/VN68nM8EQZtqdPvfYDc9VnUzQ+BLR6qYSlXJlDYRG3Q1d6onyzqo2jKfLG5RTPt2D/sdP3r
 esL2BEXx32VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,433,1599548400"; 
   d="scan'208";a="395074962"
Received: from lkp-server02.sh.intel.com (HELO c4fb2a2464e8) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Dec 2020 17:35:57 -0800
Received: from kbuild by c4fb2a2464e8 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kqndc-0001ws-FR; Sun, 20 Dec 2020 01:35:56 +0000
Date:   Sun, 20 Dec 2020 09:35:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 981316394e3558064e65bfabbae71acb9145e483
Message-ID: <5fdeaa57.kRB5SnJmG4tmINCk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 981316394e3558064e65bfabbae71acb9145e483  Merge branch 'locking/urgent'

elapsed time: 725m

configs tested: 97
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          urquell_defconfig
nds32                             allnoconfig
powerpc                     tqm5200_defconfig
powerpc                     stx_gp3_defconfig
arc                          axs101_defconfig
xtensa                         virt_defconfig
powerpc                 mpc832x_mds_defconfig
arm                             ezx_defconfig
powerpc                     mpc83xx_defconfig
sh                          r7785rp_defconfig
arm                        magician_defconfig
h8300                               defconfig
powerpc                        cell_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                     akebono_defconfig
x86_64                           allyesconfig
arc                 nsimosci_hs_smp_defconfig
arm                         lubbock_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc836x_rdk_defconfig
sh                        edosk7760_defconfig
ia64                        generic_defconfig
h8300                            alldefconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
x86_64               randconfig-a003-20201219
x86_64               randconfig-a006-20201219
x86_64               randconfig-a002-20201219
x86_64               randconfig-a005-20201219
x86_64               randconfig-a001-20201219
x86_64               randconfig-a004-20201219
i386                 randconfig-a004-20201219
i386                 randconfig-a001-20201219
i386                 randconfig-a002-20201219
i386                 randconfig-a003-20201219
i386                 randconfig-a005-20201219
i386                 randconfig-a006-20201219
i386                 randconfig-a014-20201219
i386                 randconfig-a013-20201219
i386                 randconfig-a011-20201219
i386                 randconfig-a012-20201219
i386                 randconfig-a016-20201219
i386                 randconfig-a015-20201219
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a016-20201219
x86_64               randconfig-a013-20201219
x86_64               randconfig-a012-20201219
x86_64               randconfig-a015-20201219
x86_64               randconfig-a014-20201219
x86_64               randconfig-a011-20201219

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
