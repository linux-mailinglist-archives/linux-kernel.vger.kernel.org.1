Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E200F29A766
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895426AbgJ0JKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:10:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:49777 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895418AbgJ0JK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:10:29 -0400
IronPort-SDR: 0lQ9axIpq4eFg1jWYv3/vWVvdZYXUwPZnPeN4JF9Tq4hxAMzOSAFBI4E1hK7H7vPUQ7Veo6rj+
 1Er9+zwraIPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="168148674"
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="scan'208";a="168148674"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 02:10:29 -0700
IronPort-SDR: JzOA+8Ng03l5Gs8dfWV9JYIHOwJTV5KSd4Uglp8CvAoXjH8pv9AeDxs9kAg7mB+F35Y3J5zGrX
 l4FKFf0VRT4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="scan'208";a="360682044"
Received: from lkp-server01.sh.intel.com (HELO ef28dff175aa) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Oct 2020 02:10:27 -0700
Received: from kbuild by ef28dff175aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kXKzr-0000As-7J; Tue, 27 Oct 2020 09:10:27 +0000
Date:   Tue, 27 Oct 2020 17:10:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/test] BUILD REGRESSION
 784a6343c3660446ae62db13628b20e9f876100f
Message-ID: <5f97e400.VWXHKLytnMYjFN8a%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/test
branch HEAD: 784a6343c3660446ae62db13628b20e9f876100f  Merge commit '3650b22' into rcu/test

Error/Warning reports:

https://lore.kernel.org/lkml/202010270828.0bL3aIGL-lkp@intel.com
https://lore.kernel.org/lkml/202010271032.kdHe29Mn-lkp@intel.com

Error/Warning in current branch:

drivers/dax/super.c:21:1: error: use of undeclared identifier '___srcu_struct_ptrs'
kernel/rcu/rcutorture.c:531:1: error: use of undeclared identifier '___srcu_struct_ptrs'
kernel/rcu/refscale.c:162:1: error: use of undeclared identifier '___srcu_struct_ptrs'

possible Error/Warning in current branch:

fs/dlm/lowcomms.c:139:1: error: use of undeclared identifier '___srcu_struct_ptrs'

Error/Warning ids grouped by kconfigs:

clang_recent_errors
|-- arm-randconfig-r026-20201026
|   `-- drivers-dax-super.c:error:use-of-undeclared-identifier-___srcu_struct_ptrs
|-- x86_64-randconfig-a001-20201026
|   |-- drivers-dax-super.c:error:use-of-undeclared-identifier-___srcu_struct_ptrs
|   |-- kernel-rcu-rcutorture.c:error:use-of-undeclared-identifier-___srcu_struct_ptrs
|   `-- kernel-rcu-refscale.c:error:use-of-undeclared-identifier-___srcu_struct_ptrs
|-- x86_64-randconfig-a002-20201026
|   |-- kernel-rcu-rcutorture.c:error:use-of-undeclared-identifier-___srcu_struct_ptrs
|   `-- kernel-rcu-refscale.c:error:use-of-undeclared-identifier-___srcu_struct_ptrs
`-- x86_64-randconfig-a005-20201026
    |-- fs-dlm-lowcomms.c:error:use-of-undeclared-identifier-___srcu_struct_ptrs
    |-- kernel-rcu-rcutorture.c:error:use-of-undeclared-identifier-___srcu_struct_ptrs
    `-- kernel-rcu-refscale.c:error:use-of-undeclared-identifier-___srcu_struct_ptrs

elapsed time: 721m

configs tested: 149
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                             sh03_defconfig
powerpc                     sequoia_defconfig
ia64                             alldefconfig
arm                           sunxi_defconfig
powerpc                        icon_defconfig
sh                     magicpanelr2_defconfig
mips                         tb0219_defconfig
sh                          landisk_defconfig
arm                             mxs_defconfig
powerpc                       holly_defconfig
ia64                             allyesconfig
arm                          pxa910_defconfig
sh                   secureedge5410_defconfig
mips                       rbtx49xx_defconfig
sh                     sh7710voipgw_defconfig
powerpc                 mpc85xx_cds_defconfig
xtensa                generic_kc705_defconfig
arm                            qcom_defconfig
arm                           h3600_defconfig
arm                           sama5_defconfig
arm                         s3c2410_defconfig
sh                          rsk7264_defconfig
powerpc                     sbc8548_defconfig
arm                          exynos_defconfig
sh                      rts7751r2d1_defconfig
mips                      malta_kvm_defconfig
arm                         assabet_defconfig
arc                              alldefconfig
sh                           se7343_defconfig
xtensa                         virt_defconfig
powerpc                 linkstation_defconfig
mips                      bmips_stb_defconfig
parisc                generic-32bit_defconfig
arm                      integrator_defconfig
arm                          simpad_defconfig
arm                         shannon_defconfig
arm                         s3c6400_defconfig
sh                            shmin_defconfig
sh                             espt_defconfig
arm                          iop32x_defconfig
xtensa                              defconfig
arm                        multi_v7_defconfig
xtensa                  nommu_kc705_defconfig
i386                                defconfig
i386                             alldefconfig
powerpc                      mgcoge_defconfig
arm                            lart_defconfig
mips                     loongson1c_defconfig
arm                        mvebu_v5_defconfig
ia64                         bigsur_defconfig
arm                          moxart_defconfig
sh                        edosk7760_defconfig
arm                             rpc_defconfig
sh                              ul2_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                          allyesconfig
powerpc                 mpc8313_rdb_defconfig
ia64                        generic_defconfig
m68k                       m5275evb_defconfig
m68k                        m5272c3_defconfig
arm                      footbridge_defconfig
arm                  colibri_pxa270_defconfig
mips                      fuloong2e_defconfig
mips                           mtx1_defconfig
m68k                            mac_defconfig
sh                        dreamcast_defconfig
powerpc                     ppa8548_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                         ps3_defconfig
powerpc                 mpc832x_rdb_defconfig
c6x                        evmc6678_defconfig
powerpc                       ppc64_defconfig
arm                       versatile_defconfig
arc                     nsimosci_hs_defconfig
arm                           stm32_defconfig
powerpc                    gamecube_defconfig
mips                      pistachio_defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20201026
i386                 randconfig-a003-20201026
i386                 randconfig-a005-20201026
i386                 randconfig-a001-20201026
i386                 randconfig-a006-20201026
i386                 randconfig-a004-20201026
x86_64               randconfig-a011-20201026
x86_64               randconfig-a013-20201026
x86_64               randconfig-a016-20201026
x86_64               randconfig-a015-20201026
x86_64               randconfig-a012-20201026
x86_64               randconfig-a014-20201026
i386                 randconfig-a016-20201026
i386                 randconfig-a015-20201026
i386                 randconfig-a014-20201026
i386                 randconfig-a012-20201026
i386                 randconfig-a013-20201026
i386                 randconfig-a011-20201026
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
x86_64               randconfig-a001-20201026
x86_64               randconfig-a003-20201026
x86_64               randconfig-a002-20201026
x86_64               randconfig-a006-20201026
x86_64               randconfig-a004-20201026
x86_64               randconfig-a005-20201026

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
