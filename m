Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFF0289E7E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 07:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgJJFB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 01:01:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:64225 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbgJJFAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 01:00:23 -0400
IronPort-SDR: 5/MG/jRXkneyB+KJrxt+HURqBVkq26f7B0RMsjayv5FeTH6sLe+Seqj+Rxa0+yKbXwQYhL5XNn
 OBIXNIbCZE1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="227209836"
X-IronPort-AV: E=Sophos;i="5.77,357,1596524400"; 
   d="scan'208";a="227209836"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 22:00:19 -0700
IronPort-SDR: FzlwOFTprddyINm+vld6Me7DMFGdP3fF6LHrfiRftTooy2uY8kDxFK2Opt040dumcQkvb4AT1e
 nhhKrjS0vVlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,357,1596524400"; 
   d="scan'208";a="317267446"
Received: from lkp-server02.sh.intel.com (HELO 3104d2c277ac) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Oct 2020 22:00:17 -0700
Received: from kbuild by 3104d2c277ac with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kR6zR-00001M-0v; Sat, 10 Oct 2020 05:00:17 +0000
Date:   Sat, 10 Oct 2020 12:59:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 f3c8abf68068b0b183d55fb013a82bc799896699
Message-ID: <5f813fc3.cH73Sd3tILjF+iXZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: f3c8abf68068b0b183d55fb013a82bc799896699  Merge branch 'core/rcu'

elapsed time: 720m

configs tested: 131
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                                 defconfig
c6x                                 defconfig
riscv                    nommu_virt_defconfig
sparc64                          alldefconfig
arm                          iop32x_defconfig
nios2                               defconfig
powerpc                     pq2fads_defconfig
arm                        spear6xx_defconfig
arm                          ep93xx_defconfig
ia64                             alldefconfig
nios2                         3c120_defconfig
powerpc                      walnut_defconfig
powerpc                    gamecube_defconfig
xtensa                          iss_defconfig
sh                             shx3_defconfig
arc                      axs103_smp_defconfig
arm                           sama5_defconfig
ia64                        generic_defconfig
sparc                       sparc64_defconfig
arm                          pxa910_defconfig
sh                           se7721_defconfig
arm                           corgi_defconfig
arm                         s3c6400_defconfig
mips                          rm200_defconfig
sh                               j2_defconfig
arm                           spitz_defconfig
h8300                    h8300h-sim_defconfig
mips                      maltasmvp_defconfig
openrisc                    or1ksim_defconfig
h8300                            allyesconfig
mips                malta_qemu_32r6_defconfig
powerpc                       ppc64_defconfig
nds32                            alldefconfig
riscv                    nommu_k210_defconfig
powerpc                  mpc866_ads_defconfig
m68k                       m5475evb_defconfig
sh                        sh7763rdp_defconfig
arc                          axs103_defconfig
arm                       mainstone_defconfig
powerpc                     tqm5200_defconfig
um                             i386_defconfig
sparc64                             defconfig
openrisc                 simple_smp_defconfig
sh                        edosk7705_defconfig
sh                 kfr2r09-romimage_defconfig
mips                      pic32mzda_defconfig
arc                            hsdk_defconfig
arm                          lpd270_defconfig
arc                         haps_hs_defconfig
sh                           se7712_defconfig
mips                        bcm47xx_defconfig
arm                         s3c2410_defconfig
sh                           sh2007_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                           se7705_defconfig
arm                     davinci_all_defconfig
powerpc                      bamboo_defconfig
m68k                         amcore_defconfig
arm                             ezx_defconfig
i386                             alldefconfig
xtensa                  audio_kc705_defconfig
arm                       spear13xx_defconfig
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201009
i386                 randconfig-a005-20201009
i386                 randconfig-a001-20201009
i386                 randconfig-a004-20201009
i386                 randconfig-a002-20201009
i386                 randconfig-a003-20201009
x86_64               randconfig-a012-20201009
x86_64               randconfig-a015-20201009
x86_64               randconfig-a013-20201009
x86_64               randconfig-a014-20201009
x86_64               randconfig-a011-20201009
x86_64               randconfig-a016-20201009
i386                 randconfig-a015-20201009
i386                 randconfig-a013-20201009
i386                 randconfig-a014-20201009
i386                 randconfig-a016-20201009
i386                 randconfig-a011-20201009
i386                 randconfig-a012-20201009
riscv                            allyesconfig
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
x86_64               randconfig-a004-20201009
x86_64               randconfig-a003-20201009
x86_64               randconfig-a005-20201009
x86_64               randconfig-a001-20201009
x86_64               randconfig-a002-20201009
x86_64               randconfig-a006-20201009

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
