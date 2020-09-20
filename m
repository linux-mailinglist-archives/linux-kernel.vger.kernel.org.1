Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF87827136E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 13:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgITLLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 07:11:23 -0400
Received: from mga09.intel.com ([134.134.136.24]:4983 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbgITLLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 07:11:23 -0400
IronPort-SDR: znR7c2E70qF/X/iICk1Ikgu/+jS61/sgVWGPtncIMnMDP5RsStC2vMe7k5jM5YMlpAK8KK6v3i
 ESHQXYXgNAjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9749"; a="161152499"
X-IronPort-AV: E=Sophos;i="5.77,282,1596524400"; 
   d="scan'208";a="161152499"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2020 04:11:22 -0700
IronPort-SDR: v5YFUoO1dmuMk+5ydsc+kmilckR48r8pY48QdgPkq7HejmBPS6Rl5ZuU8i9bImSrZtZVJUbV4i
 nR4AoVq5Em8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,282,1596524400"; 
   d="scan'208";a="509845858"
Received: from lkp-server01.sh.intel.com (HELO 674716e234df) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 20 Sep 2020 04:11:21 -0700
Received: from kbuild by 674716e234df with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kJxFY-00001W-D8; Sun, 20 Sep 2020 11:11:20 +0000
Date:   Sun, 20 Sep 2020 19:11:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.09.17b] BUILD SUCCESS
 ef749b8a4cc43dcbdf6e5848acdc2cb8d6950b45
Message-ID: <5f6738d1.zFGM68KAQiTyxnW1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.09.17b
branch HEAD: ef749b8a4cc43dcbdf6e5848acdc2cb8d6950b45  fixup! locktorture: Prevent hangs for invalid arguments

elapsed time: 722m

configs tested: 110
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
sh                         microdev_defconfig
arm                        neponset_defconfig
powerpc                     kmeter1_defconfig
powerpc                         ps3_defconfig
powerpc                     tqm8541_defconfig
mips                      pic32mzda_defconfig
arm                            mmp2_defconfig
sparc                            alldefconfig
powerpc                        icon_defconfig
riscv                    nommu_k210_defconfig
sh                 kfr2r09-romimage_defconfig
m68k                          atari_defconfig
powerpc                     rainier_defconfig
powerpc                     sbc8548_defconfig
mips                           jazz_defconfig
powerpc                     pseries_defconfig
mips                       capcella_defconfig
xtensa                           alldefconfig
powerpc                     tqm8540_defconfig
powerpc                     mpc512x_defconfig
m68k                       m5208evb_defconfig
csky                             alldefconfig
powerpc                     tqm8555_defconfig
h8300                       h8s-sim_defconfig
sh                          rsk7264_defconfig
sh                           se7724_defconfig
mips                  decstation_64_defconfig
mips                           ci20_defconfig
powerpc                    socrates_defconfig
sh                            hp6xx_defconfig
sh                        edosk7705_defconfig
arm                             pxa_defconfig
powerpc                 mpc832x_mds_defconfig
arm                           h5000_defconfig
mips                           ip32_defconfig
mips                           ip22_defconfig
powerpc                           allnoconfig
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
x86_64               randconfig-a005-20200920
x86_64               randconfig-a003-20200920
x86_64               randconfig-a004-20200920
x86_64               randconfig-a002-20200920
x86_64               randconfig-a006-20200920
x86_64               randconfig-a001-20200920
i386                 randconfig-a002-20200920
i386                 randconfig-a006-20200920
i386                 randconfig-a003-20200920
i386                 randconfig-a004-20200920
i386                 randconfig-a005-20200920
i386                 randconfig-a001-20200920
i386                 randconfig-a012-20200920
i386                 randconfig-a014-20200920
i386                 randconfig-a016-20200920
i386                 randconfig-a013-20200920
i386                 randconfig-a011-20200920
i386                 randconfig-a015-20200920
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
x86_64               randconfig-a011-20200920
x86_64               randconfig-a013-20200920
x86_64               randconfig-a014-20200920
x86_64               randconfig-a015-20200920
x86_64               randconfig-a012-20200920
x86_64               randconfig-a016-20200920

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
