Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571F22F2E59
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbhALLs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 06:48:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:60751 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbhALLs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:48:26 -0500
IronPort-SDR: l/moMYwN7GPqh4kwiV8UQYyPDln1dahr1V5cdJn0l2ceYN1NG5o/pam5QbAS1neajAc4mYCiN0
 ZvD22v4YvpMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="177250983"
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="177250983"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 03:47:45 -0800
IronPort-SDR: ClE9jCOIVHDNtQgPuONMhiWhnZf7wlMvU8X9yWyJK29uG9Kzi+LB/vVS9M+XOHqBOUJaLH8jwd
 /dkpT3F/QWYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="351860248"
Received: from lkp-server01.sh.intel.com (HELO b73930e00c65) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 12 Jan 2021 03:47:44 -0800
Received: from kbuild by b73930e00c65 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kzI9H-00006i-Dx; Tue, 12 Jan 2021 11:47:43 +0000
Date:   Tue, 12 Jan 2021 19:47:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 c60427c5df46d89f7e4bf47025394d3ba0a9a6a9
Message-ID: <5ffd8c5a.E69KKblqABUuFV+D%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: c60427c5df46d89f7e4bf47025394d3ba0a9a6a9  Merge branch 'linus'

elapsed time: 724m

configs tested: 155
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
m68k                          hp300_defconfig
arm                         bcm2835_defconfig
openrisc                            defconfig
mips                           rs90_defconfig
arm                          iop32x_defconfig
mips                  cavium_octeon_defconfig
sh                           se7206_defconfig
powerpc                  storcenter_defconfig
arm                          ep93xx_defconfig
mips                        bcm63xx_defconfig
powerpc                  iss476-smp_defconfig
arm                        realview_defconfig
powerpc                       ppc64_defconfig
powerpc                        cell_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      walnut_defconfig
mips                           mtx1_defconfig
powerpc                      arches_defconfig
powerpc                      ppc6xx_defconfig
h8300                     edosk2674_defconfig
arm                           h5000_defconfig
sh                  sh7785lcr_32bit_defconfig
nios2                               defconfig
arm                             pxa_defconfig
sh                           se7750_defconfig
powerpc                      ep88xc_defconfig
powerpc                     tqm8548_defconfig
mips                malta_kvm_guest_defconfig
mips                         rt305x_defconfig
powerpc                      ppc64e_defconfig
arm                         vf610m4_defconfig
m68k                           sun3_defconfig
sh                               allmodconfig
mips                        maltaup_defconfig
m68k                       bvme6000_defconfig
arm                        cerfcube_defconfig
sh                             shx3_defconfig
sh                          landisk_defconfig
powerpc                     asp8347_defconfig
powerpc                   currituck_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                      mgcoge_defconfig
m68k                       m5275evb_defconfig
mips                       rbtx49xx_defconfig
powerpc                      makalu_defconfig
mips                           ip27_defconfig
arm                       cns3420vb_defconfig
parisc                generic-32bit_defconfig
arm                             rpc_defconfig
powerpc                      bamboo_defconfig
arm                          ixp4xx_defconfig
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
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
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
i386                 randconfig-a002-20210112
i386                 randconfig-a005-20210112
i386                 randconfig-a006-20210112
i386                 randconfig-a003-20210112
i386                 randconfig-a001-20210112
i386                 randconfig-a004-20210112
i386                 randconfig-a002-20210110
i386                 randconfig-a005-20210110
i386                 randconfig-a006-20210110
i386                 randconfig-a001-20210110
i386                 randconfig-a003-20210110
i386                 randconfig-a004-20210110
x86_64               randconfig-a015-20210110
x86_64               randconfig-a012-20210110
x86_64               randconfig-a013-20210110
x86_64               randconfig-a016-20210110
x86_64               randconfig-a014-20210110
x86_64               randconfig-a011-20210110
x86_64               randconfig-a015-20210112
x86_64               randconfig-a012-20210112
x86_64               randconfig-a013-20210112
x86_64               randconfig-a016-20210112
x86_64               randconfig-a014-20210112
x86_64               randconfig-a011-20210112
i386                 randconfig-a012-20210111
i386                 randconfig-a011-20210111
i386                 randconfig-a016-20210111
i386                 randconfig-a015-20210111
i386                 randconfig-a013-20210111
i386                 randconfig-a014-20210111
i386                 randconfig-a012-20210112
i386                 randconfig-a011-20210112
i386                 randconfig-a016-20210112
i386                 randconfig-a013-20210112
i386                 randconfig-a015-20210112
i386                 randconfig-a014-20210112
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
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
