Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7F12D3FBC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 11:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgLIKQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 05:16:51 -0500
Received: from mga02.intel.com ([134.134.136.20]:27984 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729704AbgLIKQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:16:50 -0500
IronPort-SDR: nzqj3ar/S7s7ahO39Ld91VjlCRhXLHR7qGGAmTKPMPEha8e55fRkIkjeRZ/E411gmkdkg4xw9O
 DvMTFLrv2fCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="161105984"
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="161105984"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 02:16:09 -0800
IronPort-SDR: RCKTtoB3QqT6P2bEicIpMFz7p5LVZCrTHXVGJmpNgoqkLgNFrPOcyGfFPcIBqOYUqKWvQN3/75
 1/cgZsAZh5lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="437729348"
Received: from lkp-server01.sh.intel.com (HELO 2bbb63443648) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 09 Dec 2020 02:16:08 -0800
Received: from kbuild by 2bbb63443648 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kmwVz-0000Dq-KR; Wed, 09 Dec 2020 10:16:07 +0000
Date:   Wed, 09 Dec 2020 18:15:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.12.04b] BUILD SUCCESS
 feffbd268355e75eb00cb901bf2cc8b8d72a63e1
Message-ID: <5fd0a3db.1fOzhs5PKDkFPJgv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.12.04b
branch HEAD: feffbd268355e75eb00cb901bf2cc8b8d72a63e1  fixup! rcu: Make call_rcu() print allocation address of double-freed callback

elapsed time: 720m

configs tested: 121
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                          g5_defconfig
powerpc                     skiroot_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                         ps3_defconfig
arm                            qcom_defconfig
sh                             espt_defconfig
sh                            shmin_defconfig
arm                         orion5x_defconfig
mips                           gcw0_defconfig
sh                           se7722_defconfig
mips                        qi_lb60_defconfig
arm                         mv78xx0_defconfig
sh                        dreamcast_defconfig
sh                         apsh4a3a_defconfig
mips                      bmips_stb_defconfig
arm                          ep93xx_defconfig
riscv                               defconfig
mips                  decstation_64_defconfig
ia64                             allmodconfig
arm                       omap2plus_defconfig
m68k                       m5475evb_defconfig
arm                             mxs_defconfig
powerpc                   currituck_defconfig
powerpc                      mgcoge_defconfig
arc                            hsdk_defconfig
xtensa                              defconfig
powerpc                      pmac32_defconfig
sh                           se7721_defconfig
sh                           se7751_defconfig
arm                            mmp2_defconfig
powerpc                       holly_defconfig
arm                           h5000_defconfig
sh                            migor_defconfig
mips                        bcm63xx_defconfig
mips                         rt305x_defconfig
powerpc                     tqm8541_defconfig
c6x                        evmc6678_defconfig
powerpc                     tqm5200_defconfig
powerpc                      acadia_defconfig
arc                        nsimosci_defconfig
sh                           se7724_defconfig
powerpc64                           defconfig
arm                           omap1_defconfig
h8300                               defconfig
arm                     davinci_all_defconfig
arm                        spear6xx_defconfig
arm                   milbeaut_m10v_defconfig
sh                     magicpanelr2_defconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
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
