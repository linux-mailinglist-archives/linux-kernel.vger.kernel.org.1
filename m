Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47802F11F2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 12:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbhAKLyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 06:54:01 -0500
Received: from mga02.intel.com ([134.134.136.20]:15323 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbhAKLyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:54:01 -0500
IronPort-SDR: nYWXJOfXj2w9FC9G5DMBFXSa0rD6SIpA4qhJt1vsZcUR9T8Hf0Bt78Zdm/63n7/JGHsgkbNojy
 bVZW45wfnQRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9860"; a="164928824"
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="164928824"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 03:53:19 -0800
IronPort-SDR: 2yold6fRnyjnSeFUW7OsBPh6lc2XxlDQdi/hT8a4sirFKwOek8llyrZmTcGQLa2fStWNLklv9l
 lmGZqLvnwnIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="397008754"
Received: from lkp-server01.sh.intel.com (HELO 3cff8e4c45aa) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 11 Jan 2021 03:53:18 -0800
Received: from kbuild by 3cff8e4c45aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kyvl8-00005p-1v; Mon, 11 Jan 2021 11:53:18 +0000
Date:   Mon, 11 Jan 2021 19:52:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.01.10a] BUILD SUCCESS
 7975c26716559b3b9a177ee7acd83b25d56f1792
Message-ID: <5ffc3bf6.PEOmaS4GYvfJ3RHk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2021.01.10a
branch HEAD: 7975c26716559b3b9a177ee7acd83b25d56f1792  fixup! torture: Break affinity of kthreads last running on outgoing CPU

elapsed time: 725m

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
mips                           jazz_defconfig
powerpc                 mpc8560_ads_defconfig
sh                        dreamcast_defconfig
powerpc                      makalu_defconfig
nios2                            allyesconfig
powerpc                           allnoconfig
powerpc                   motionpro_defconfig
nds32                               defconfig
powerpc                 mpc832x_mds_defconfig
sh                           sh2007_defconfig
sh                   rts7751r2dplus_defconfig
arm                     eseries_pxa_defconfig
sh                          sdk7780_defconfig
riscv                            alldefconfig
mips                       rbtx49xx_defconfig
sh                             shx3_defconfig
powerpc                   bluestone_defconfig
arm                         socfpga_defconfig
arm                        realview_defconfig
mips                         cobalt_defconfig
sh                          lboxre2_defconfig
h8300                     edosk2674_defconfig
powerpc                      ep88xc_defconfig
arc                      axs103_smp_defconfig
arm                       multi_v4t_defconfig
sh                          sdk7786_defconfig
arc                           tb10x_defconfig
arm                         assabet_defconfig
xtensa                           alldefconfig
sh                  sh7785lcr_32bit_defconfig
arc                     nsimosci_hs_defconfig
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
x86_64               randconfig-a004-20210111
x86_64               randconfig-a006-20210111
x86_64               randconfig-a001-20210111
x86_64               randconfig-a003-20210111
x86_64               randconfig-a005-20210111
x86_64               randconfig-a002-20210111
i386                 randconfig-a002-20210111
i386                 randconfig-a005-20210111
i386                 randconfig-a006-20210111
i386                 randconfig-a001-20210111
i386                 randconfig-a003-20210111
i386                 randconfig-a004-20210111
i386                 randconfig-a002-20210110
i386                 randconfig-a005-20210110
i386                 randconfig-a006-20210110
i386                 randconfig-a001-20210110
i386                 randconfig-a003-20210110
i386                 randconfig-a004-20210110
x86_64               randconfig-a015-20210110
x86_64               randconfig-a012-20210110
x86_64               randconfig-a013-20210110
x86_64               randconfig-a016-20210110
x86_64               randconfig-a014-20210110
x86_64               randconfig-a011-20210110
i386                 randconfig-a012-20210110
i386                 randconfig-a011-20210110
i386                 randconfig-a016-20210110
i386                 randconfig-a015-20210110
i386                 randconfig-a013-20210110
i386                 randconfig-a014-20210110
i386                 randconfig-a012-20210111
i386                 randconfig-a011-20210111
i386                 randconfig-a016-20210111
i386                 randconfig-a015-20210111
i386                 randconfig-a013-20210111
i386                 randconfig-a014-20210111
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
x86_64               randconfig-a004-20210110
x86_64               randconfig-a006-20210110
x86_64               randconfig-a001-20210110
x86_64               randconfig-a003-20210110
x86_64               randconfig-a005-20210110
x86_64               randconfig-a002-20210110

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
