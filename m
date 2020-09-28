Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C764F27A938
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgI1IC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:02:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:62175 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgI1IC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:02:28 -0400
IronPort-SDR: 8oT1rlVCEaB5rWOMjtjkvhIF395mIl5WMXr5k2/+H7eABOsYHVmA9LPYxXOQe3wKJ9j/s0vEqa
 P3abfm/5Qg2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="223549583"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="223549583"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 01:02:27 -0700
IronPort-SDR: FKsiql2F5ddV4v4u8Sj5NjKk3OgMb+Uo9f/4Jpg9VWd8L1hTtLHnZP7+X31C6pezn8GZPScKcM
 0kue9zyqgBIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="293171515"
Received: from lkp-server01.sh.intel.com (HELO 0e0978ea3297) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Sep 2020 01:02:26 -0700
Received: from kbuild by 0e0978ea3297 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kMo77-0000DT-EE; Mon, 28 Sep 2020 08:02:25 +0000
Date:   Mon, 28 Sep 2020 16:01:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/irq] BUILD SUCCESS
 d27e623ace6af259075b6e0437380ee8d6268c5d
Message-ID: <5f71985b.AzjwRcgeVrxnBSc0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/irq
branch HEAD: d27e623ace6af259075b6e0437380ee8d6268c5d  x86/apic/msi: Unbreak DMAR and HPET MSI

elapsed time: 723m

configs tested: 105
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         rt305x_defconfig
mips                      fuloong2e_defconfig
arm                       versatile_defconfig
mips                        nlm_xlp_defconfig
sh                        edosk7705_defconfig
powerpc                    amigaone_defconfig
sh                          kfr2r09_defconfig
mips                         cobalt_defconfig
nios2                         3c120_defconfig
powerpc                     rainier_defconfig
powerpc                     mpc512x_defconfig
mips                       lemote2f_defconfig
riscv                          rv32_defconfig
sh                        edosk7760_defconfig
mips                      bmips_stb_defconfig
sh                        apsh4ad0a_defconfig
arm                        magician_defconfig
mips                           ip22_defconfig
arm                       aspeed_g4_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                        mvebu_v5_defconfig
mips                    maltaup_xpa_defconfig
powerpc                          allmodconfig
arm                          simpad_defconfig
powerpc                    adder875_defconfig
powerpc                    socrates_defconfig
arm                              zx_defconfig
sh                             espt_defconfig
arc                           tb10x_defconfig
arm                          ep93xx_defconfig
powerpc                     mpc83xx_defconfig
ia64                             alldefconfig
sh                   rts7751r2dplus_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20200927
i386                 randconfig-a006-20200927
i386                 randconfig-a003-20200927
i386                 randconfig-a004-20200927
i386                 randconfig-a005-20200927
i386                 randconfig-a001-20200927
x86_64               randconfig-a011-20200927
x86_64               randconfig-a013-20200927
x86_64               randconfig-a014-20200927
x86_64               randconfig-a015-20200927
x86_64               randconfig-a012-20200927
x86_64               randconfig-a016-20200927
i386                 randconfig-a012-20200928
i386                 randconfig-a016-20200928
i386                 randconfig-a014-20200928
i386                 randconfig-a013-20200928
i386                 randconfig-a015-20200928
i386                 randconfig-a011-20200928
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20200927
x86_64               randconfig-a003-20200927
x86_64               randconfig-a004-20200927
x86_64               randconfig-a002-20200927
x86_64               randconfig-a006-20200927
x86_64               randconfig-a001-20200927

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
