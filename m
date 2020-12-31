Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FD62E7E72
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 07:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgLaGeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 01:34:23 -0500
Received: from mga09.intel.com ([134.134.136.24]:65308 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgLaGeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 01:34:22 -0500
IronPort-SDR: sQX1YcFhCdOjp1YrPxFDKYu5nNAa3/6QO84ZLujThFS26G9yMOdBgCkxmedQiFHctKNkJKzwuu
 bCLw/cxRLE+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9850"; a="176828772"
X-IronPort-AV: E=Sophos;i="5.78,463,1599548400"; 
   d="scan'208";a="176828772"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2020 22:33:41 -0800
IronPort-SDR: lx8Xcadb3pTDI7DWthnzlbq4gSdtmLqCA582AkrY2chr00Ahr/5AQ2cEYxMXcEjoORJJuzq1j2
 gDxYUrguLiqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,463,1599548400"; 
   d="scan'208";a="376675311"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 30 Dec 2020 22:33:40 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kurWl-0004lA-DD; Thu, 31 Dec 2020 06:33:39 +0000
Date:   Thu, 31 Dec 2020 14:32:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.12.26a] BUILD SUCCESS
 99f7c53b43866761e4df3460ace228e7520898f3
Message-ID: <5fed708d.NzSp1vtU6vQDMq0A%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.12.26a
branch HEAD: 99f7c53b43866761e4df3460ace228e7520898f3  squash! clocksource: Retry clock read if long delays detected

elapsed time: 724m

configs tested: 133
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                            alldefconfig
powerpc                      pcm030_defconfig
x86_64                              defconfig
sh                  sh7785lcr_32bit_defconfig
mips                        bcm63xx_defconfig
arm                            zeus_defconfig
arm64                            alldefconfig
h8300                               defconfig
sh                            migor_defconfig
powerpc                     akebono_defconfig
powerpc                      obs600_defconfig
powerpc                    klondike_defconfig
arm                        mvebu_v5_defconfig
s390                             alldefconfig
sh                   rts7751r2dplus_defconfig
arm                  colibri_pxa300_defconfig
mips                      fuloong2e_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     mpc83xx_defconfig
mips                       lemote2f_defconfig
arm                          imote2_defconfig
powerpc                      tqm8xx_defconfig
arm                           u8500_defconfig
powerpc                     skiroot_defconfig
arm                        oxnas_v6_defconfig
mips                     loongson1b_defconfig
mips                     loongson1c_defconfig
x86_64                           alldefconfig
m68k                           sun3_defconfig
mips                           ip22_defconfig
powerpc                      ppc44x_defconfig
arm                           sama5_defconfig
parisc                generic-64bit_defconfig
powerpc                      pmac32_defconfig
arm                          pxa910_defconfig
openrisc                    or1ksim_defconfig
sh                           se7721_defconfig
powerpc                    sam440ep_defconfig
arc                     haps_hs_smp_defconfig
riscv                    nommu_virt_defconfig
ia64                             alldefconfig
sh                     sh7710voipgw_defconfig
arm                          pcm027_defconfig
mips                       capcella_defconfig
arm                      footbridge_defconfig
arm                   milbeaut_m10v_defconfig
sparc                       sparc32_defconfig
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
x86_64               randconfig-a005-20201230
x86_64               randconfig-a001-20201230
x86_64               randconfig-a006-20201230
x86_64               randconfig-a002-20201230
x86_64               randconfig-a004-20201230
x86_64               randconfig-a003-20201230
i386                 randconfig-a005-20201230
i386                 randconfig-a006-20201230
i386                 randconfig-a004-20201230
i386                 randconfig-a003-20201230
i386                 randconfig-a002-20201230
i386                 randconfig-a001-20201230
x86_64               randconfig-a015-20201231
x86_64               randconfig-a014-20201231
x86_64               randconfig-a011-20201231
x86_64               randconfig-a016-20201231
x86_64               randconfig-a013-20201231
x86_64               randconfig-a012-20201231
i386                 randconfig-a016-20201230
i386                 randconfig-a014-20201230
i386                 randconfig-a012-20201230
i386                 randconfig-a015-20201230
i386                 randconfig-a011-20201230
i386                 randconfig-a013-20201230
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20201229
x86_64               randconfig-a015-20201229
x86_64               randconfig-a016-20201229
x86_64               randconfig-a012-20201229
x86_64               randconfig-a011-20201229
x86_64               randconfig-a013-20201229
x86_64               randconfig-a015-20201230
x86_64               randconfig-a014-20201230
x86_64               randconfig-a016-20201230
x86_64               randconfig-a011-20201230
x86_64               randconfig-a013-20201230
x86_64               randconfig-a012-20201230

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
