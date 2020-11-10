Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3E72ACF42
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 06:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731778AbgKJFrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 00:47:43 -0500
Received: from mga17.intel.com ([192.55.52.151]:15738 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729795AbgKJFrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 00:47:43 -0500
IronPort-SDR: UvppF8u1v/nfekaDldiy9AqPLg2CI7Aevbdq+CA5P8kdNtRvfYkUHHyzBSbzjfxAHElK7ax/td
 PKstRXg7tyAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="149772114"
X-IronPort-AV: E=Sophos;i="5.77,465,1596524400"; 
   d="scan'208";a="149772114"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 21:47:42 -0800
IronPort-SDR: nRt2GGkEnhm9nxZyM5n1dyayCznOJWemLdx4HDCGOptiRCeYd6soReNpsJA6geSA+Yxn9G9MFF
 M0kbBmMKa/Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,465,1596524400"; 
   d="scan'208";a="365358641"
Received: from lkp-server02.sh.intel.com (HELO c6c5fbb3488a) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Nov 2020 21:47:41 -0800
Received: from kbuild by c6c5fbb3488a with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kcMVI-00003J-Lp; Tue, 10 Nov 2020 05:47:40 +0000
Date:   Tue, 10 Nov 2020 13:47:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 1e106aa3509b86738769775969822ffc1ec21bf4
Message-ID: <5faa2976.pTJWwmMmDCslLXVq%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  locking/urgent
branch HEAD: 1e106aa3509b86738769775969822ffc1ec21bf4  futex: Don't enable IRQs unconditionally in put_pi_state()

elapsed time: 972m

configs tested: 127
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                          hp300_defconfig
sh                           se7206_defconfig
arm                          ep93xx_defconfig
arc                        nsimosci_defconfig
powerpc                       maple_defconfig
sh                               alldefconfig
sh                ecovec24-romimage_defconfig
m68k                         amcore_defconfig
powerpc                      katmai_defconfig
sh                   sh7770_generic_defconfig
parisc                           alldefconfig
arm                        shmobile_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                     tqm8540_defconfig
powerpc                     skiroot_defconfig
sh                          rsk7203_defconfig
arm                       cns3420vb_defconfig
arm                           omap1_defconfig
c6x                        evmc6472_defconfig
arm                          ixp4xx_defconfig
ia64                             allyesconfig
arm                         shannon_defconfig
powerpc                    sam440ep_defconfig
arm                           corgi_defconfig
arm                          gemini_defconfig
arm                            mmp2_defconfig
sh                          urquell_defconfig
powerpc                     sequoia_defconfig
powerpc                     tqm8548_defconfig
sh                            hp6xx_defconfig
ia64                             allmodconfig
ia64                                defconfig
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
x86_64               randconfig-a003-20201110
x86_64               randconfig-a005-20201110
x86_64               randconfig-a004-20201110
x86_64               randconfig-a002-20201110
x86_64               randconfig-a006-20201110
x86_64               randconfig-a001-20201110
i386                 randconfig-a004-20201109
i386                 randconfig-a006-20201109
i386                 randconfig-a005-20201109
i386                 randconfig-a001-20201109
i386                 randconfig-a003-20201109
i386                 randconfig-a002-20201109
i386                 randconfig-a006-20201110
i386                 randconfig-a005-20201110
i386                 randconfig-a002-20201110
i386                 randconfig-a001-20201110
i386                 randconfig-a003-20201110
i386                 randconfig-a004-20201110
i386                 randconfig-a012-20201110
i386                 randconfig-a014-20201110
i386                 randconfig-a016-20201110
i386                 randconfig-a011-20201110
i386                 randconfig-a015-20201110
i386                 randconfig-a013-20201110
i386                 randconfig-a014-20201109
i386                 randconfig-a015-20201109
i386                 randconfig-a013-20201109
i386                 randconfig-a016-20201109
i386                 randconfig-a011-20201109
i386                 randconfig-a012-20201109
x86_64               randconfig-a004-20201109
x86_64               randconfig-a002-20201109
x86_64               randconfig-a003-20201109
x86_64               randconfig-a005-20201109
x86_64               randconfig-a006-20201109
x86_64               randconfig-a001-20201109
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
x86_64               randconfig-a012-20201109
x86_64               randconfig-a015-20201109
x86_64               randconfig-a013-20201109
x86_64               randconfig-a011-20201109
x86_64               randconfig-a014-20201109
x86_64               randconfig-a016-20201109
x86_64               randconfig-a015-20201110
x86_64               randconfig-a011-20201110
x86_64               randconfig-a014-20201110
x86_64               randconfig-a013-20201110
x86_64               randconfig-a016-20201110
x86_64               randconfig-a012-20201110

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
