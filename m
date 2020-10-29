Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8AD429F761
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 23:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgJ2WHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 18:07:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:40727 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgJ2WHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 18:07:53 -0400
IronPort-SDR: vNpG6lKjZpfocm7H2vE6ddHEZX6mGznIL7H72Y7ZpFpsGPVAv4VnwfAvwWJoAh+4kE6dxwbHUd
 9rTehhx/r9cw==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="230156884"
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="230156884"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 15:07:51 -0700
IronPort-SDR: HaL2JcdeCVaA2KSkMoMEjJvKAlAqxpUC3Wx3VUvBNH+w46OwWde4gowZqKvS8P/Mhpsfg9AjLA
 +0is/EyQXxMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="351629813"
Received: from lkp-server01.sh.intel.com (HELO c01187be935a) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 29 Oct 2020 15:07:50 -0700
Received: from kbuild by c01187be935a with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kYG5F-0000HU-To; Thu, 29 Oct 2020 22:07:49 +0000
Date:   Fri, 30 Oct 2020 06:07:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 306e3e91edf1c6739a55312edd110d298ff498dd
Message-ID: <5f9b3d14.5lDePpLFnhkcEvVU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  perf/core
branch HEAD: 306e3e91edf1c6739a55312edd110d298ff498dd  perf/x86/intel: Add event constraint for CYCLE_ACTIVITY.STALLS_MEM_ANY

elapsed time: 724m

configs tested: 132
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                          amiga_defconfig
powerpc                      ppc64e_defconfig
powerpc                         wii_defconfig
xtensa                           alldefconfig
powerpc                 mpc8315_rdb_defconfig
arm                           corgi_defconfig
powerpc                    adder875_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                  mpc866_ads_defconfig
mips                           gcw0_defconfig
parisc                           alldefconfig
arm                           u8500_defconfig
sh                              ul2_defconfig
powerpc                     mpc5200_defconfig
powerpc                       maple_defconfig
c6x                        evmc6678_defconfig
powerpc                      arches_defconfig
sh                        apsh4ad0a_defconfig
mips                          rb532_defconfig
arm                         hackkit_defconfig
arm                          gemini_defconfig
powerpc                 mpc8313_rdb_defconfig
sparc                       sparc64_defconfig
sh                        dreamcast_defconfig
sh                        edosk7705_defconfig
nios2                         3c120_defconfig
c6x                                 defconfig
mips                       bmips_be_defconfig
ia64                      gensparse_defconfig
sh                           se7780_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                       m5475evb_defconfig
sh                ecovec24-romimage_defconfig
powerpc                    gamecube_defconfig
powerpc                     stx_gp3_defconfig
powerpc                  mpc885_ads_defconfig
sh                          rsk7264_defconfig
sh                             sh03_defconfig
arm                          prima2_defconfig
mips                       capcella_defconfig
c6x                              alldefconfig
s390                             allyesconfig
sh                            shmin_defconfig
c6x                        evmc6472_defconfig
sh                         ecovec24_defconfig
mips                malta_kvm_guest_defconfig
sh                          sdk7780_defconfig
arm                              zx_defconfig
ia64                          tiger_defconfig
mips                       rbtx49xx_defconfig
c6x                        evmc6457_defconfig
mips                malta_qemu_32r6_defconfig
ia64                             alldefconfig
arm                            mps2_defconfig
arm                         ebsa110_defconfig
ia64                        generic_defconfig
arm                         assabet_defconfig
arm                          simpad_defconfig
arm                      jornada720_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
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
powerpc                           allnoconfig
x86_64               randconfig-a001-20201029
x86_64               randconfig-a002-20201029
x86_64               randconfig-a003-20201029
x86_64               randconfig-a006-20201029
x86_64               randconfig-a005-20201029
x86_64               randconfig-a004-20201029
i386                 randconfig-a002-20201029
i386                 randconfig-a005-20201029
i386                 randconfig-a003-20201029
i386                 randconfig-a001-20201029
i386                 randconfig-a004-20201029
i386                 randconfig-a006-20201029
i386                 randconfig-a016-20201029
i386                 randconfig-a014-20201029
i386                 randconfig-a015-20201029
i386                 randconfig-a013-20201029
i386                 randconfig-a012-20201029
i386                 randconfig-a011-20201029
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
x86_64               randconfig-a011-20201029
x86_64               randconfig-a013-20201029
x86_64               randconfig-a016-20201029
x86_64               randconfig-a015-20201029
x86_64               randconfig-a012-20201029
x86_64               randconfig-a014-20201029

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
