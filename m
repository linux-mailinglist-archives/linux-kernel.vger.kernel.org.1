Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D142EF3C0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 15:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbhAHOMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 09:12:43 -0500
Received: from mga12.intel.com ([192.55.52.136]:10340 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbhAHOMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 09:12:42 -0500
IronPort-SDR: b9EGTKpTnEajTLN2KIQ0cbpIOMp6gZ6yAvYO0g4lf5Lc08AagweL4Q4hiJxVqXdehLvRKz2jDo
 wv6Sg3aFhQVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="156783581"
X-IronPort-AV: E=Sophos;i="5.79,331,1602572400"; 
   d="scan'208";a="156783581"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 06:11:52 -0800
IronPort-SDR: QIvcRUEpv49LosbMs+0tjk4yidtLtHYQzcMuKTISxNNKSps1p+yp3rU8G6MMjI6BXW/pcKbxAX
 JTtAJcrQaCdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,331,1602572400"; 
   d="scan'208";a="347362189"
Received: from lkp-server01.sh.intel.com (HELO 412602b27703) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 Jan 2021 06:11:51 -0800
Received: from kbuild by 412602b27703 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kxsUY-0000JH-P0; Fri, 08 Jan 2021 14:11:50 +0000
Date:   Fri, 08 Jan 2021 22:11:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 91a8f6cb06b33adc79fbf5f7381d907485767c00
Message-ID: <5ff867fe.TlW+PDz7kRZGFfTl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cleanups
branch HEAD: 91a8f6cb06b33adc79fbf5f7381d907485767c00  x86/mm: Refine mmap syscall implementation

elapsed time: 749m

configs tested: 109
configs skipped: 133

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                            alldefconfig
c6x                         dsk6455_defconfig
arm                        mini2440_defconfig
mips                          rb532_defconfig
mips                       rbtx49xx_defconfig
nios2                            allyesconfig
powerpc                    mvme5100_defconfig
mips                          ath25_defconfig
sh                             shx3_defconfig
m68k                          multi_defconfig
sh                          lboxre2_defconfig
arm                       aspeed_g4_defconfig
arm                         vf610m4_defconfig
arm                          badge4_defconfig
arm                        neponset_defconfig
arm                       imx_v4_v5_defconfig
sh                         ap325rxa_defconfig
m68k                         amcore_defconfig
ia64                             alldefconfig
sh                        sh7785lcr_defconfig
nds32                            alldefconfig
sh                         microdev_defconfig
powerpc                      arches_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                          rm200_defconfig
powerpc                        cell_defconfig
x86_64                              defconfig
ia64                            zx1_defconfig
powerpc                     ppa8548_defconfig
mips                           ip22_defconfig
openrisc                    or1ksim_defconfig
sh                           se7724_defconfig
powerpc                      cm5200_defconfig
arm                         lpc32xx_defconfig
ia64                         bigsur_defconfig
arm                        vexpress_defconfig
mips                            gpr_defconfig
sh                            hp6xx_defconfig
arm                      integrator_defconfig
sh                   rts7751r2dplus_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
i386                             allyesconfig
i386                               tinyconfig
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210108
x86_64               randconfig-a006-20210108
x86_64               randconfig-a001-20210108
x86_64               randconfig-a002-20210108
x86_64               randconfig-a003-20210108
x86_64               randconfig-a005-20210108
i386                 randconfig-a005-20210108
i386                 randconfig-a002-20210108
i386                 randconfig-a001-20210108
i386                 randconfig-a003-20210108
i386                 randconfig-a006-20210108
i386                 randconfig-a004-20210108
i386                 randconfig-a016-20210108
i386                 randconfig-a011-20210108
i386                 randconfig-a014-20210108
i386                 randconfig-a015-20210108
i386                 randconfig-a013-20210108
i386                 randconfig-a012-20210108
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
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20210108
x86_64               randconfig-a011-20210108
x86_64               randconfig-a012-20210108
x86_64               randconfig-a016-20210108
x86_64               randconfig-a014-20210108
x86_64               randconfig-a015-20210108

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
