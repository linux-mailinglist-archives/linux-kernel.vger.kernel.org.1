Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BFB2AF5A7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgKKQDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:03:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:4968 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbgKKQC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:02:59 -0500
IronPort-SDR: /8tckMxPhDnTdb9X3mtbnHPf1OMbdcIoAA3yuFQ2KpZgYyBZofPQeNEiqJQVxrfEvqSDtAWNfw
 Y4d/qde9rbPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="169383931"
X-IronPort-AV: E=Sophos;i="5.77,469,1596524400"; 
   d="scan'208";a="169383931"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 08:02:58 -0800
IronPort-SDR: B69PQ50fOjQXUaVXSRQt4YtgAgWIGb9nqxOaB3l9j63OZEcL2nHKw45hwhQtgdvUcLZiCobiHk
 emZ3CRrjx0IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,469,1596524400"; 
   d="scan'208";a="399068010"
Received: from lkp-server02.sh.intel.com (HELO f059bffed10d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 11 Nov 2020 08:02:57 -0800
Received: from kbuild by f059bffed10d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kcsaG-00000e-PY; Wed, 11 Nov 2020 16:02:56 +0000
Date:   Thu, 12 Nov 2020 00:02:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 005ea905304542854a4adebd720e72fa20b5566c
Message-ID: <5fac0b23.bpGD7G44uhHh4OE+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: 005ea905304542854a4adebd720e72fa20b5566c  rcutorture: Use "all" and "last" in "nohz_full" and "rcu_nocbs"

elapsed time: 1048m

configs tested: 103
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
nios2                            alldefconfig
powerpc                      pcm030_defconfig
powerpc                    amigaone_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                      ppc64e_defconfig
arm                      pxa255-idp_defconfig
arm                           efm32_defconfig
arm                          iop32x_defconfig
arm                        cerfcube_defconfig
h8300                    h8300h-sim_defconfig
h8300                               defconfig
sh                         apsh4a3a_defconfig
arm                       netwinder_defconfig
arm                         mv78xx0_defconfig
sh                            migor_defconfig
powerpc                   bluestone_defconfig
sh                         ap325rxa_defconfig
powerpc                      bamboo_defconfig
sh                            shmin_defconfig
powerpc                     tqm8540_defconfig
mips                        maltaup_defconfig
arm                        magician_defconfig
mips                 decstation_r4k_defconfig
powerpc                 mpc836x_mds_defconfig
m68k                            q40_defconfig
arc                      axs103_smp_defconfig
x86_64                           alldefconfig
arm                   milbeaut_m10v_defconfig
arm                         nhk8815_defconfig
parisc                              defconfig
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
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201111
i386                 randconfig-a005-20201111
i386                 randconfig-a002-20201111
i386                 randconfig-a001-20201111
i386                 randconfig-a003-20201111
i386                 randconfig-a004-20201111
x86_64               randconfig-a015-20201111
x86_64               randconfig-a011-20201111
x86_64               randconfig-a014-20201111
x86_64               randconfig-a013-20201111
x86_64               randconfig-a016-20201111
x86_64               randconfig-a012-20201111
i386                 randconfig-a012-20201111
i386                 randconfig-a014-20201111
i386                 randconfig-a016-20201111
i386                 randconfig-a011-20201111
i386                 randconfig-a015-20201111
i386                 randconfig-a013-20201111
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
x86_64               randconfig-a003-20201111
x86_64               randconfig-a005-20201111
x86_64               randconfig-a004-20201111
x86_64               randconfig-a002-20201111
x86_64               randconfig-a006-20201111
x86_64               randconfig-a001-20201111

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
