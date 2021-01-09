Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271F42EFE91
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 09:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbhAIIBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 03:01:41 -0500
Received: from mga01.intel.com ([192.55.52.88]:58068 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbhAIIBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 03:01:40 -0500
IronPort-SDR: rDsiOObsDocygycYJ29Og103xOPGdx71VGu827PBkeGX9nku2ZMEcBuPdb86+4WYxLnaEdKFjr
 N7z7LRUxLoig==
X-IronPort-AV: E=McAfee;i="6000,8403,9858"; a="196265885"
X-IronPort-AV: E=Sophos;i="5.79,333,1602572400"; 
   d="scan'208";a="196265885"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2021 00:00:59 -0800
IronPort-SDR: EELSJnFcWmhBfQcugwzbrB5M2bWcOJuuegbtRFP4iPYw0JHfA+QSjTgmu2mT9Sd1uVKhSOGtRX
 u3lZJ76DWd6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,333,1602572400"; 
   d="scan'208";a="351933311"
Received: from lkp-server01.sh.intel.com (HELO 412602b27703) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jan 2021 00:00:57 -0800
Received: from kbuild by 412602b27703 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ky9BA-0000xp-Tj; Sat, 09 Jan 2021 08:00:56 +0000
Date:   Sat, 09 Jan 2021 16:00:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 7bb39313cd6239e7eb95198950a02b4ad2a08316
Message-ID: <5ff96290.NY6ORFIbv1Kit8vP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  ras/core
branch HEAD: 7bb39313cd6239e7eb95198950a02b4ad2a08316  x86/mce: Make mce_timed_out() identify holdout CPUs

elapsed time: 892m

configs tested: 122
configs skipped: 59

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
openrisc                            defconfig
powerpc                      arches_defconfig
mips                        qi_lb60_defconfig
powerpc                     sbc8548_defconfig
openrisc                 simple_smp_defconfig
sh                           se7780_defconfig
powerpc                      mgcoge_defconfig
mips                      malta_kvm_defconfig
m68k                        mvme16x_defconfig
powerpc                         wii_defconfig
riscv                          rv32_defconfig
powerpc                    sam440ep_defconfig
mips                         tb0219_defconfig
mips                      bmips_stb_defconfig
powerpc                      ppc6xx_defconfig
mips                  decstation_64_defconfig
arm                         lpc18xx_defconfig
arm                        mvebu_v7_defconfig
microblaze                          defconfig
arm                        oxnas_v6_defconfig
m68k                                defconfig
m68k                         apollo_defconfig
powerpc64                           defconfig
arm                       cns3420vb_defconfig
m68k                        mvme147_defconfig
sh                            shmin_defconfig
powerpc                  iss476-smp_defconfig
ia64                                defconfig
powerpc                     pseries_defconfig
arm                         lpc32xx_defconfig
powerpc                     kilauea_defconfig
m68k                             allyesconfig
arm                       aspeed_g5_defconfig
m68k                       m5249evb_defconfig
sh                           se7619_defconfig
mips                      maltaaprp_defconfig
arc                          axs103_defconfig
arm                     eseries_pxa_defconfig
sh                          r7780mp_defconfig
powerpc                      acadia_defconfig
riscv                            allyesconfig
arc                          axs101_defconfig
mips                           gcw0_defconfig
mips                      pic32mzda_defconfig
parisc                generic-32bit_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                      pistachio_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                      chrp32_defconfig
arm                          lpd270_defconfig
mips                           ci20_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
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
