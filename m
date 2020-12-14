Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F0B2D91E8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 03:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438123AbgLNCzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 21:55:36 -0500
Received: from mga05.intel.com ([192.55.52.43]:39178 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbgLNCzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 21:55:36 -0500
IronPort-SDR: lkf3SNpL/q7m11VzAreQNAQ+xjDkfaU9Udl5KP9eGuB0juA3XSW8aPEJpoM1GqpkfMPg5PQfbG
 Ulhzj7Uefg+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9834"; a="259372351"
X-IronPort-AV: E=Sophos;i="5.78,417,1599548400"; 
   d="scan'208";a="259372351"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2020 18:54:52 -0800
IronPort-SDR: xlRut6PSb/7PvRgbse2l5QRFPa2urVkOtb+RmBpop9tCNdLRxzIUSw5Qv6bZMlbJYz1ZRyFtXL
 pUBZlIYxh//g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,417,1599548400"; 
   d="scan'208";a="331660700"
Received: from lkp-server02.sh.intel.com (HELO a947d92d0467) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 13 Dec 2020 18:54:51 -0800
Received: from kbuild by a947d92d0467 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1koe0g-00007E-FD; Mon, 14 Dec 2020 02:54:50 +0000
Date:   Mon, 14 Dec 2020 10:54:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD REGRESSION
 3bda84519c6c2d57e7378417ac116f61d50abae1
Message-ID: <5fd6d3f8.gEmff2CDu9zPTszN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  irq/core
branch HEAD: 3bda84519c6c2d57e7378417ac116f61d50abae1  genirq: Reexport irq_to_desc() for PPC KVM

Error/Warning reports:

https://lore.kernel.org/lkml/202012140602.BCg2ue7N-lkp@intel.com

Error/Warning in current branch:

ERROR: modpost: ".irq_to_desc" [arch/powerpc/kvm/kvm-hv.ko] undefined!

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- powerpc-allmodconfig
    `-- ERROR:irq_to_desc-arch-powerpc-kvm-kvm-hv.ko-undefined

elapsed time: 772m

configs tested: 104
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                 kfr2r09-romimage_defconfig
sh                         microdev_defconfig
mips                        bcm47xx_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                          lboxre2_defconfig
arm                           h3600_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                        sh7785lcr_defconfig
arm                              alldefconfig
arc                          axs101_defconfig
sh                          urquell_defconfig
sh                        dreamcast_defconfig
arm                  colibri_pxa300_defconfig
sh                         apsh4a3a_defconfig
c6x                         dsk6455_defconfig
powerpc                     sbc8548_defconfig
sparc                       sparc64_defconfig
powerpc                     sequoia_defconfig
mips                malta_kvm_guest_defconfig
c6x                        evmc6678_defconfig
mips                        bcm63xx_defconfig
arm                     eseries_pxa_defconfig
m68k                        m5307c3_defconfig
powerpc                         wii_defconfig
sh                           se7780_defconfig
powerpc                       ebony_defconfig
m68k                          sun3x_defconfig
m68k                       m5275evb_defconfig
xtensa                  audio_kc705_defconfig
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
i386                 randconfig-a001-20201213
i386                 randconfig-a004-20201213
i386                 randconfig-a003-20201213
i386                 randconfig-a002-20201213
i386                 randconfig-a005-20201213
i386                 randconfig-a006-20201213
x86_64               randconfig-a003-20201213
x86_64               randconfig-a006-20201213
x86_64               randconfig-a002-20201213
x86_64               randconfig-a005-20201213
x86_64               randconfig-a004-20201213
x86_64               randconfig-a001-20201213
i386                 randconfig-a014-20201213
i386                 randconfig-a013-20201213
i386                 randconfig-a012-20201213
i386                 randconfig-a011-20201213
i386                 randconfig-a016-20201213
i386                 randconfig-a015-20201213
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
x86_64                                  kexec
x86_64                               rhel-8.3

clang tested configs:
x86_64               randconfig-a016-20201213
x86_64               randconfig-a012-20201213
x86_64               randconfig-a013-20201213
x86_64               randconfig-a015-20201213
x86_64               randconfig-a014-20201213
x86_64               randconfig-a011-20201213

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
