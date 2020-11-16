Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A658F2B3D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 08:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbgKPHAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 02:00:21 -0500
Received: from mga11.intel.com ([192.55.52.93]:33335 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbgKPHAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 02:00:21 -0500
IronPort-SDR: agsMhFDot2Gi4YIU3XABrasvnA6e6kQveRYFg3pO8v0p3GAUID10BeVOFZr1pEZuqfFKJRcgSj
 hAh/pp7YI4Cg==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="167197352"
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; 
   d="scan'208";a="167197352"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2020 23:00:20 -0800
IronPort-SDR: a6YVB0d1c8XEAhXYaX/DDafoePLfja47dmT9Gus18T6MbGJyDXT3cTy/twhAlVmjj4w9zj4htk
 yxgAiw5AIFXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; 
   d="scan'208";a="367404067"
Received: from lkp-server01.sh.intel.com (HELO bf1bf4bba8e9) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Nov 2020 23:00:18 -0800
Received: from kbuild by bf1bf4bba8e9 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1keYUr-00000b-TK; Mon, 16 Nov 2020 07:00:17 +0000
Date:   Mon, 16 Nov 2020 15:00:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.11.10a] BUILD REGRESSION
 1bc2f285f9c940176cc2c231db1372d5b2f0c635
Message-ID: <5fb22380.8TYwn7qlnkn+uOFU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.11.10a
branch HEAD: 1bc2f285f9c940176cc2c231db1372d5b2f0c635  EXP refscale: Allow summarization of verbose output

Error/Warning reports:

https://lore.kernel.org/lkml/202011160746.rMeDMJQM-lkp@intel.com

Error/Warning in current branch:

ERROR: modpost: "get_state_synchronize_srcu" [kernel/rcu/rcutorture.ko] undefined!
ERROR: modpost: "poll_state_synchronize_srcu" [kernel/rcu/rcutorture.ko] undefined!
ERROR: modpost: "start_poll_synchronize_srcu" [kernel/rcu/rcutorture.ko] undefined!

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-m021-20201115
|   |-- ERROR:get_state_synchronize_srcu-kernel-rcu-rcutorture.ko-undefined
|   |-- ERROR:poll_state_synchronize_srcu-kernel-rcu-rcutorture.ko-undefined
|   `-- ERROR:start_poll_synchronize_srcu-kernel-rcu-rcutorture.ko-undefined
`-- x86_64-randconfig-s022-20201115
    |-- ERROR:get_state_synchronize_srcu-kernel-rcu-rcutorture.ko-undefined
    |-- ERROR:poll_state_synchronize_srcu-kernel-rcu-rcutorture.ko-undefined
    `-- ERROR:start_poll_synchronize_srcu-kernel-rcu-rcutorture.ko-undefined

elapsed time: 721m

configs tested: 110
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         lpc32xx_defconfig
mips                            e55_defconfig
openrisc                 simple_smp_defconfig
powerpc                           allnoconfig
sh                      rts7751r2d1_defconfig
riscv                    nommu_k210_defconfig
arm                     eseries_pxa_defconfig
mips                      malta_kvm_defconfig
m68k                         amcore_defconfig
arm                           viper_defconfig
ia64                          tiger_defconfig
mips                       capcella_defconfig
mips                        nlm_xlr_defconfig
sh                        dreamcast_defconfig
h8300                       h8s-sim_defconfig
powerpc64                           defconfig
xtensa                           alldefconfig
powerpc                      pmac32_defconfig
nios2                               defconfig
nds32                            alldefconfig
powerpc                      ppc40x_defconfig
arm                          badge4_defconfig
um                            kunit_defconfig
sh                          rsk7203_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                           xway_defconfig
alpha                               defconfig
riscv                             allnoconfig
powerpc                     mpc512x_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
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
i386                 randconfig-a006-20201116
i386                 randconfig-a005-20201116
i386                 randconfig-a001-20201116
i386                 randconfig-a002-20201116
i386                 randconfig-a004-20201116
i386                 randconfig-a003-20201116
i386                 randconfig-a006-20201115
i386                 randconfig-a005-20201115
i386                 randconfig-a001-20201115
i386                 randconfig-a002-20201115
i386                 randconfig-a004-20201115
i386                 randconfig-a003-20201115
x86_64               randconfig-a015-20201115
x86_64               randconfig-a011-20201115
x86_64               randconfig-a014-20201115
x86_64               randconfig-a013-20201115
x86_64               randconfig-a016-20201115
x86_64               randconfig-a012-20201115
i386                 randconfig-a012-20201115
i386                 randconfig-a014-20201115
i386                 randconfig-a016-20201115
i386                 randconfig-a011-20201115
i386                 randconfig-a015-20201115
i386                 randconfig-a013-20201115
x86_64               randconfig-a003-20201116
x86_64               randconfig-a005-20201116
x86_64               randconfig-a004-20201116
x86_64               randconfig-a002-20201116
x86_64               randconfig-a001-20201116
x86_64               randconfig-a006-20201116
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-a003-20201115
x86_64               randconfig-a005-20201115
x86_64               randconfig-a004-20201115
x86_64               randconfig-a002-20201115
x86_64               randconfig-a001-20201115
x86_64               randconfig-a006-20201115

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
