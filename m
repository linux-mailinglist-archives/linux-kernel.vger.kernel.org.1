Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE45D2D44F9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 16:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbgLIPAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 10:00:13 -0500
Received: from mga12.intel.com ([192.55.52.136]:42464 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727956AbgLIPAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 10:00:05 -0500
IronPort-SDR: ZyRyq4l6m7WK63dXLkNtZ3q5LvXYWYISdIsSYkpzfJ+hdDYK0dsl+MvNDD8JQJ1G7hitkhlo2E
 8Z9XWMa+oM2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="153322688"
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="153322688"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 06:59:24 -0800
IronPort-SDR: vAtOEGt32DgOylthd0Lo/+emNSTp9u9859tH6HeX+LTvUgaLQGh7eSs+Js6aFwP+MLB1QG2ik+
 Z1QALJ3079/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="348355471"
Received: from lkp-server01.sh.intel.com (HELO 2bbb63443648) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 Dec 2020 06:59:23 -0800
Received: from kbuild by 2bbb63443648 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kn0w6-0000Jd-Ch; Wed, 09 Dec 2020 14:59:22 +0000
Date:   Wed, 09 Dec 2020 22:59:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.12.08b] BUILD SUCCESS
 7d9ce80dd1253cef9317fa5e45023c6971605f49
Message-ID: <5fd0e637.L7RL0X5wib+G81HV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.12.08b
branch HEAD: 7d9ce80dd1253cef9317fa5e45023c6971605f49  squash! mm: Add kmalloc_debug_print_provenance() to print source of memory block

elapsed time: 722m

configs tested: 135
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                       m5475evb_defconfig
powerpc                     tqm5200_defconfig
arm                            lart_defconfig
ia64                        generic_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     redwood_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                              ul2_defconfig
ia64                             alldefconfig
sh                          lboxre2_defconfig
sh                         apsh4a3a_defconfig
x86_64                           alldefconfig
powerpc                         wii_defconfig
powerpc                     mpc83xx_defconfig
arm                     davinci_all_defconfig
powerpc                      mgcoge_defconfig
mips                         bigsur_defconfig
powerpc                      ppc64e_defconfig
sh                            shmin_defconfig
mips                         tb0226_defconfig
m68k                        mvme16x_defconfig
arc                         haps_hs_defconfig
c6x                         dsk6455_defconfig
c6x                        evmc6472_defconfig
mips                       lemote2f_defconfig
powerpc                     sequoia_defconfig
c6x                              alldefconfig
arm                          ixp4xx_defconfig
sh                                  defconfig
arm                       imx_v6_v7_defconfig
arm                            mmp2_defconfig
alpha                            allyesconfig
mips                      pistachio_defconfig
sh                           se7751_defconfig
powerpc                       holly_defconfig
arm                           h5000_defconfig
sh                            migor_defconfig
mips                        bcm63xx_defconfig
powerpc                    socrates_defconfig
powerpc                    klondike_defconfig
arm                           tegra_defconfig
powerpc                 xes_mpc85xx_defconfig
m68k                       bvme6000_defconfig
sh                           se7619_defconfig
arm                             mxs_defconfig
powerpc                      ppc40x_defconfig
m68k                        m5272c3_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                        sh7785lcr_defconfig
arm                          prima2_defconfig
arm                            pleb_defconfig
powerpc                     pseries_defconfig
arm                             ezx_defconfig
powerpc                        icon_defconfig
arm                              alldefconfig
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
i386                 randconfig-a004-20201209
i386                 randconfig-a005-20201209
i386                 randconfig-a001-20201209
i386                 randconfig-a002-20201209
i386                 randconfig-a006-20201209
i386                 randconfig-a003-20201209
x86_64               randconfig-a016-20201209
x86_64               randconfig-a012-20201209
x86_64               randconfig-a013-20201209
x86_64               randconfig-a014-20201209
x86_64               randconfig-a015-20201209
x86_64               randconfig-a011-20201209
i386                 randconfig-a013-20201209
i386                 randconfig-a014-20201209
i386                 randconfig-a011-20201209
i386                 randconfig-a015-20201209
i386                 randconfig-a012-20201209
i386                 randconfig-a016-20201209
x86_64               randconfig-a004-20201208
x86_64               randconfig-a006-20201208
x86_64               randconfig-a005-20201208
x86_64               randconfig-a001-20201208
x86_64               randconfig-a002-20201208
x86_64               randconfig-a003-20201208
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
x86_64               randconfig-a004-20201209
x86_64               randconfig-a006-20201209
x86_64               randconfig-a005-20201209
x86_64               randconfig-a001-20201209
x86_64               randconfig-a002-20201209
x86_64               randconfig-a003-20201209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
