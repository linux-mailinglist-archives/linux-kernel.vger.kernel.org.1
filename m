Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD24A2E3069
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 08:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgL0Hno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 02:43:44 -0500
Received: from mga17.intel.com ([192.55.52.151]:36889 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbgL0Hnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 02:43:43 -0500
IronPort-SDR: Rv3sffXdIRpMX6PI/o07ruaybSzwUUNQXxeuGlCEvJrXywrSQLLhydIDmGF02GfK2ASt0kPtAk
 gmOnE2gDCoeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9846"; a="156083210"
X-IronPort-AV: E=Sophos;i="5.78,452,1599548400"; 
   d="scan'208";a="156083210"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2020 23:43:03 -0800
IronPort-SDR: NmYimG3lURql5jFpIPld9YvVNpWbT3FltuIDtfmkeIuWqr43TU+uMVvsIXF5BHSHkeUrPx89W3
 kSSmUxiKRigw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,452,1599548400"; 
   d="scan'208";a="394702551"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 26 Dec 2020 23:43:01 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ktQhg-0002Ll-83; Sun, 27 Dec 2020 07:43:00 +0000
Date:   Sun, 27 Dec 2020 15:42:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.12.23b] BUILD SUCCESS
 70b734157f963df4731596ce826956205d076571
Message-ID: <5fe83ae6.8NFrEbtrdIVGn3hm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.12.23b
branch HEAD: 70b734157f963df4731596ce826956205d076571  squash! torture: Do Kconfig analysis only once per scenario

elapsed time: 721m

configs tested: 94
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
h8300                            allyesconfig
powerpc                     ep8248e_defconfig
arm                       spear13xx_defconfig
s390                                defconfig
sh                           se7705_defconfig
sh                ecovec24-romimage_defconfig
sh                             espt_defconfig
arm                         lpc32xx_defconfig
arm                          exynos_defconfig
s390                          debug_defconfig
sh                               j2_defconfig
mips                       bmips_be_defconfig
arm                          badge4_defconfig
h8300                               defconfig
xtensa                           alldefconfig
mips                  cavium_octeon_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                               allmodconfig
powerpc                      ppc40x_defconfig
powerpc                 mpc836x_mds_defconfig
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
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
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
i386                 randconfig-a002-20201227
i386                 randconfig-a005-20201227
i386                 randconfig-a006-20201227
i386                 randconfig-a004-20201227
i386                 randconfig-a003-20201227
i386                 randconfig-a001-20201227
x86_64               randconfig-a001-20201227
x86_64               randconfig-a006-20201227
x86_64               randconfig-a004-20201227
x86_64               randconfig-a002-20201227
x86_64               randconfig-a003-20201227
x86_64               randconfig-a005-20201227
i386                 randconfig-a011-20201227
i386                 randconfig-a016-20201227
i386                 randconfig-a012-20201227
i386                 randconfig-a014-20201227
i386                 randconfig-a015-20201227
i386                 randconfig-a013-20201227
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
x86_64               randconfig-a015-20201227
x86_64               randconfig-a014-20201227
x86_64               randconfig-a016-20201227
x86_64               randconfig-a012-20201227
x86_64               randconfig-a013-20201227
x86_64               randconfig-a011-20201227

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
