Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C033D2F2F50
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 13:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388383AbhALMqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 07:46:31 -0500
Received: from mga18.intel.com ([134.134.136.126]:45958 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388277AbhALMqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 07:46:31 -0500
IronPort-SDR: maR3ae26CJwBL0NrgTK4Z84elmSJgYTOjHJ5VGHfwMNWBrv6VPDYiY+nTLHtvOIt7+jZdRvk0Z
 PK2E0mUIXHqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="165710645"
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="165710645"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 04:45:49 -0800
IronPort-SDR: Wu2d1rrEgvmPW+wFgPxbR6DdZhyNT6BTgfLe4F3KojiMYj3VjEj5hyBArY6+o7oc4FRSOYFF/9
 EQKVoLz+2wdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="404453977"
Received: from lkp-server01.sh.intel.com (HELO b73930e00c65) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jan 2021 04:45:48 -0800
Received: from kbuild by b73930e00c65 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kzJ3T-00008z-U8; Tue, 12 Jan 2021 12:45:47 +0000
Date:   Tue, 12 Jan 2021 20:45:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS WITH WARNING
 a18ab6e012ea03b839274d746a0732adbde3dc4c
Message-ID: <5ffd99f0.rJV1p1sVleU6OhYa%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: a18ab6e012ea03b839274d746a0732adbde3dc4c  torturescript: Don't rerun failed rcutorture builds

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- i386-randconfig-c003-20210111
    `-- kernel-rcu-rcutorture.c:WARNING-kmalloc-is-used-to-allocate-this-memory-at-line

elapsed time: 721m

configs tested: 151
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                  cavium_octeon_defconfig
sh                           se7206_defconfig
powerpc                  storcenter_defconfig
arm                          ep93xx_defconfig
mips                        bcm63xx_defconfig
powerpc                  iss476-smp_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                   motionpro_defconfig
c6x                        evmc6678_defconfig
m68k                       m5275evb_defconfig
h8300                               defconfig
powerpc                      walnut_defconfig
mips                           mtx1_defconfig
powerpc                      arches_defconfig
powerpc                      ppc6xx_defconfig
arm                      tct_hammer_defconfig
powerpc               mpc834x_itxgp_defconfig
m68k                          atari_defconfig
arm                         lpc32xx_defconfig
sh                           sh2007_defconfig
powerpc                      tqm8xx_defconfig
powerpc                     tqm5200_defconfig
c6x                                 defconfig
arm                     am200epdkit_defconfig
c6x                              alldefconfig
openrisc                 simple_smp_defconfig
arm                             pxa_defconfig
sh                           se7750_defconfig
powerpc                      ep88xc_defconfig
powerpc                     tqm8548_defconfig
powerpc                     mpc5200_defconfig
sh                           se7724_defconfig
mips                         db1xxx_defconfig
xtensa                       common_defconfig
arm                        oxnas_v6_defconfig
mips                         tb0287_defconfig
m68k                       m5249evb_defconfig
powerpc                     rainier_defconfig
sh                   secureedge5410_defconfig
arm                        vexpress_defconfig
arm                         axm55xx_defconfig
arm                            pleb_defconfig
sh                        sh7785lcr_defconfig
arm                        multi_v7_defconfig
arm                          prima2_defconfig
arm                           stm32_defconfig
arc                           tb10x_defconfig
arc                              alldefconfig
mips                 decstation_r4k_defconfig
powerpc                      mgcoge_defconfig
powerpc                       ppc64_defconfig
mips                       rbtx49xx_defconfig
powerpc                      makalu_defconfig
mips                           ip27_defconfig
arm                       cns3420vb_defconfig
mips                           rs90_defconfig
parisc                generic-32bit_defconfig
arm                           efm32_defconfig
nios2                            alldefconfig
mips                  maltasmvp_eva_defconfig
powerpc                     sbc8548_defconfig
arm                         palmz72_defconfig
arm                        mvebu_v7_defconfig
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
x86_64               randconfig-a015-20210112
x86_64               randconfig-a012-20210112
x86_64               randconfig-a013-20210112
x86_64               randconfig-a016-20210112
x86_64               randconfig-a014-20210112
x86_64               randconfig-a011-20210112
i386                 randconfig-a012-20210112
i386                 randconfig-a011-20210112
i386                 randconfig-a016-20210112
i386                 randconfig-a013-20210112
i386                 randconfig-a015-20210112
i386                 randconfig-a014-20210112
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
x86_64               randconfig-a015-20210111
x86_64               randconfig-a012-20210111
x86_64               randconfig-a013-20210111
x86_64               randconfig-a016-20210111
x86_64               randconfig-a014-20210111
x86_64               randconfig-a011-20210111

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
