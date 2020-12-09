Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1A22D3BD9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 08:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgLIHCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 02:02:44 -0500
Received: from mga04.intel.com ([192.55.52.120]:23633 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbgLIHCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 02:02:38 -0500
IronPort-SDR: c0Mn+ISqSN25VyK1Vf4OxtvzbZreEp6ZZfUJ1U3hYeFTMTx5iabyMOMS/QjDlPg0KbtytP0AsG
 eCqduU+3Vb7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="171457499"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="171457499"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 23:01:56 -0800
IronPort-SDR: 7g+9QSKF7O/lQr4DlLyoJaTlMSAuFsxCev2U7Y113fMMhZOBxxyiIsypYpaCrEqB3EWtRJFDro
 RuN6cbebtx/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="348215614"
Received: from lkp-server01.sh.intel.com (HELO 2bbb63443648) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 08 Dec 2020 23:01:54 -0800
Received: from kbuild by 2bbb63443648 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kmtU2-00007S-Ah; Wed, 09 Dec 2020 07:01:54 +0000
Date:   Wed, 09 Dec 2020 15:01:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 262bd5724afdefd4c48a260d6100e78cc43ee06b
Message-ID: <5fd0764b.t19TcXwmrsFcK8LN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cpu
branch HEAD: 262bd5724afdefd4c48a260d6100e78cc43ee06b  x86/cpu/amd: Remove dead code for TSEG region remapping

elapsed time: 726m

configs tested: 118
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
arm                             rpc_defconfig
parisc                generic-32bit_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                        warp_defconfig
sh                          lboxre2_defconfig
powerpc64                           defconfig
powerpc                     pseries_defconfig
powerpc                 canyonlands_defconfig
powerpc                 mpc834x_mds_defconfig
sh                          rsk7264_defconfig
arc                     haps_hs_smp_defconfig
sh                           se7724_defconfig
powerpc                     ep8248e_defconfig
arm                         assabet_defconfig
mips                     cu1830-neo_defconfig
sh                           se7751_defconfig
arm                            lart_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                   rts7751r2dplus_defconfig
sh                           se7721_defconfig
mips                        omega2p_defconfig
arm                            dove_defconfig
mips                          ath79_defconfig
powerpc                     kmeter1_defconfig
mips                      maltaaprp_defconfig
powerpc                      mgcoge_defconfig
arc                            hsdk_defconfig
xtensa                              defconfig
powerpc                      pmac32_defconfig
arm                            mmp2_defconfig
powerpc                       holly_defconfig
arm                           h5000_defconfig
sh                            migor_defconfig
mips                        bcm63xx_defconfig
arm                           omap1_defconfig
h8300                               defconfig
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
i386                 randconfig-a004-20201208
i386                 randconfig-a005-20201208
i386                 randconfig-a001-20201208
i386                 randconfig-a002-20201208
i386                 randconfig-a006-20201208
i386                 randconfig-a003-20201208
x86_64               randconfig-a004-20201208
x86_64               randconfig-a006-20201208
x86_64               randconfig-a005-20201208
x86_64               randconfig-a001-20201208
x86_64               randconfig-a002-20201208
x86_64               randconfig-a003-20201208
i386                 randconfig-a013-20201208
i386                 randconfig-a014-20201208
i386                 randconfig-a011-20201208
i386                 randconfig-a015-20201208
i386                 randconfig-a012-20201208
i386                 randconfig-a016-20201208
i386                 randconfig-a013-20201209
i386                 randconfig-a014-20201209
i386                 randconfig-a011-20201209
i386                 randconfig-a015-20201209
i386                 randconfig-a012-20201209
i386                 randconfig-a016-20201209
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
x86_64               randconfig-a016-20201208
x86_64               randconfig-a012-20201208
x86_64               randconfig-a013-20201208
x86_64               randconfig-a014-20201208
x86_64               randconfig-a015-20201208
x86_64               randconfig-a011-20201208

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
