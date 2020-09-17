Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA7826DF1E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 17:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgIQPII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 11:08:08 -0400
Received: from mga03.intel.com ([134.134.136.65]:21774 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbgIQPHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 11:07:44 -0400
IronPort-SDR: sR4dr4Rr9xQb43Mg4CjjWfnnfcT9Nw8H1iG6uPW7gipBuls2TFwaFhtbXywjTCmnSU4UXMFY86
 xiTeoVgcNMDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="159769203"
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; 
   d="scan'208";a="159769203"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 08:06:13 -0700
IronPort-SDR: 3Abfnlj2zcLUEH0QXrR0WLXGrLd90ZvG7MuNMqU0U2dPiyXQ5MS5Ab/ENlth3SZ3Uf+RCrgoGF
 CMRpZrMsm7Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,271,1596524400"; 
   d="scan'208";a="507715035"
Received: from lkp-server01.sh.intel.com (HELO a05db971c861) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 17 Sep 2020 08:06:11 -0700
Received: from kbuild by a05db971c861 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kIvUB-00003G-6n; Thu, 17 Sep 2020 15:06:11 +0000
Date:   Thu, 17 Sep 2020 23:04:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.09.16a] BUILD SUCCESS
 37f202d6cbf3dd42bde5fe1c253940b36d5fd140
Message-ID: <5f637b0b.UVNrvWajBXHs1bB7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.09.16a
branch HEAD: 37f202d6cbf3dd42bde5fe1c253940b36d5fd140  rcu: Prevent RCU_LOCKDEP_WARN() from swallowing the condition

elapsed time: 725m

configs tested: 117
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
mips                        omega2p_defconfig
arm                         lubbock_defconfig
arm                           spitz_defconfig
powerpc                        warp_defconfig
sh                        dreamcast_defconfig
parisc                           allyesconfig
m68k                          hp300_defconfig
powerpc                      mgcoge_defconfig
powerpc                 mpc832x_mds_defconfig
arm                            u300_defconfig
m68k                             allyesconfig
arm                        mvebu_v7_defconfig
powerpc                       eiger_defconfig
powerpc                     tqm8548_defconfig
sh                         ecovec24_defconfig
powerpc                       maple_defconfig
m68k                          amiga_defconfig
riscv                            alldefconfig
mips                     loongson1c_defconfig
arc                     nsimosci_hs_defconfig
riscv                          rv32_defconfig
powerpc                      chrp32_defconfig
mips                     cu1830-neo_defconfig
nios2                         3c120_defconfig
powerpc                      bamboo_defconfig
arm                      integrator_defconfig
arm                           efm32_defconfig
arm                             mxs_defconfig
arc                            hsdk_defconfig
arm                           u8500_defconfig
mips                     decstation_defconfig
powerpc                   lite5200b_defconfig
sh                           sh2007_defconfig
sh                        sh7757lcr_defconfig
powerpc                  iss476-smp_defconfig
arm                       omap2plus_defconfig
sh                           se7712_defconfig
powerpc                      katmai_defconfig
arm                         lpc18xx_defconfig
mips                           rs90_defconfig
arm                        vexpress_defconfig
mips                         rt305x_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                   milbeaut_m10v_defconfig
mips                    maltaup_xpa_defconfig
parisc                generic-32bit_defconfig
riscv                             allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
i386                 randconfig-a004-20200917
i386                 randconfig-a006-20200917
i386                 randconfig-a003-20200917
i386                 randconfig-a001-20200917
i386                 randconfig-a002-20200917
i386                 randconfig-a005-20200917
x86_64               randconfig-a014-20200917
x86_64               randconfig-a011-20200917
x86_64               randconfig-a016-20200917
x86_64               randconfig-a012-20200917
x86_64               randconfig-a015-20200917
x86_64               randconfig-a013-20200917
i386                 randconfig-a015-20200917
i386                 randconfig-a014-20200917
i386                 randconfig-a011-20200917
i386                 randconfig-a013-20200917
i386                 randconfig-a016-20200917
i386                 randconfig-a012-20200917
riscv                            allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20200917
x86_64               randconfig-a004-20200917
x86_64               randconfig-a003-20200917
x86_64               randconfig-a002-20200917
x86_64               randconfig-a001-20200917
x86_64               randconfig-a005-20200917

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
