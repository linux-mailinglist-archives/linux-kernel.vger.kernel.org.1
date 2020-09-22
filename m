Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DAF274B19
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 23:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgIVVYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 17:24:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:10328 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgIVVYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:24:41 -0400
IronPort-SDR: iVSNVquoyHQeUOIdRXoP4F/UBnIbvsvT9dOS8vmYiuaubcgbHrNS99HGyXtLBNTgQ7Ufw+RfMT
 bxzsKaTCdzIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="161647513"
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; 
   d="scan'208";a="161647513"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 14:24:40 -0700
IronPort-SDR: 3TZ4dG6fo5wW4nSbMMFmpgbW6bKYVKBHbgLB8blUx0UWcgHLbtn2qpDUT6hdC3QMwKBHgpL4YE
 DJmXVXN+7yEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; 
   d="scan'208";a="309648351"
Received: from lkp-server01.sh.intel.com (HELO 928d8e596b58) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Sep 2020 14:24:38 -0700
Received: from kbuild by 928d8e596b58 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kKpm9-0000e7-GE; Tue, 22 Sep 2020 21:24:37 +0000
Date:   Wed, 23 Sep 2020 05:24:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/fpu] BUILD SUCCESS
 1ef5423a55c2ac6f1361811efe75b6e46d1023ed
Message-ID: <5f6a6b88./6sQ2LvwdgT1rAts%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/fpu
branch HEAD: 1ef5423a55c2ac6f1361811efe75b6e46d1023ed  x86/fpu: Handle FPU-related and clearcpuid command line arguments earlier

elapsed time: 721m

configs tested: 176
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                malta_kvm_guest_defconfig
mips                           gcw0_defconfig
sh                             sh03_defconfig
arm                             ezx_defconfig
mips                      pistachio_defconfig
xtensa                         virt_defconfig
powerpc                     asp8347_defconfig
arc                        nsim_700_defconfig
arm                        vexpress_defconfig
arm                       spear13xx_defconfig
arm                  colibri_pxa300_defconfig
arm                          pxa3xx_defconfig
um                           x86_64_defconfig
m68k                         amcore_defconfig
arm                       versatile_defconfig
powerpc                     pq2fads_defconfig
m68k                            q40_defconfig
arm                      tct_hammer_defconfig
arc                            hsdk_defconfig
xtensa                          iss_defconfig
parisc                           alldefconfig
powerpc                      mgcoge_defconfig
arm                         palmz72_defconfig
arm                          pxa168_defconfig
powerpc                     kilauea_defconfig
arm                           sunxi_defconfig
mips                      malta_kvm_defconfig
mips                            ar7_defconfig
sh                            hp6xx_defconfig
mips                  cavium_octeon_defconfig
arm                         lpc18xx_defconfig
sh                          rsk7203_defconfig
arm                         s5pv210_defconfig
arm                          exynos_defconfig
sh                           se7343_defconfig
powerpc                     tqm8540_defconfig
arm                          pxa910_defconfig
arm                       aspeed_g5_defconfig
mips                      loongson3_defconfig
mips                 decstation_r4k_defconfig
powerpc                 mpc836x_mds_defconfig
m68k                             alldefconfig
arm                            pleb_defconfig
arm                      footbridge_defconfig
mips                        nlm_xlr_defconfig
c6x                        evmc6474_defconfig
x86_64                              defconfig
powerpc                  mpc866_ads_defconfig
m68k                       m5249evb_defconfig
arm                          ep93xx_defconfig
mips                           ip32_defconfig
sh                          landisk_defconfig
mips                     loongson1b_defconfig
powerpc                      acadia_defconfig
mips                         tb0219_defconfig
mips                  maltasmvp_eva_defconfig
mips                           xway_defconfig
arm                           u8500_defconfig
sh                          lboxre2_defconfig
sh                        edosk7760_defconfig
powerpc                       eiger_defconfig
mips                        vocore2_defconfig
sh                     magicpanelr2_defconfig
sh                          sdk7780_defconfig
arm                          prima2_defconfig
powerpc                    gamecube_defconfig
h8300                            alldefconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20200920
x86_64               randconfig-a003-20200920
x86_64               randconfig-a004-20200920
x86_64               randconfig-a002-20200920
x86_64               randconfig-a006-20200920
x86_64               randconfig-a001-20200920
i386                 randconfig-a002-20200920
i386                 randconfig-a006-20200920
i386                 randconfig-a003-20200920
i386                 randconfig-a004-20200920
i386                 randconfig-a005-20200920
i386                 randconfig-a001-20200920
i386                 randconfig-a002-20200921
i386                 randconfig-a006-20200921
i386                 randconfig-a003-20200921
i386                 randconfig-a004-20200921
i386                 randconfig-a005-20200921
i386                 randconfig-a001-20200921
i386                 randconfig-a002-20200922
i386                 randconfig-a006-20200922
i386                 randconfig-a003-20200922
i386                 randconfig-a004-20200922
i386                 randconfig-a005-20200922
i386                 randconfig-a001-20200922
x86_64               randconfig-a011-20200921
x86_64               randconfig-a013-20200921
x86_64               randconfig-a014-20200921
x86_64               randconfig-a015-20200921
x86_64               randconfig-a012-20200921
x86_64               randconfig-a016-20200921
i386                 randconfig-a012-20200921
i386                 randconfig-a014-20200921
i386                 randconfig-a016-20200921
i386                 randconfig-a013-20200921
i386                 randconfig-a011-20200921
i386                 randconfig-a015-20200921
i386                 randconfig-a012-20200920
i386                 randconfig-a014-20200920
i386                 randconfig-a016-20200920
i386                 randconfig-a013-20200920
i386                 randconfig-a011-20200920
i386                 randconfig-a015-20200920
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
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20200921
x86_64               randconfig-a003-20200921
x86_64               randconfig-a004-20200921
x86_64               randconfig-a002-20200921
x86_64               randconfig-a006-20200921
x86_64               randconfig-a001-20200921
x86_64               randconfig-a011-20200922
x86_64               randconfig-a013-20200922
x86_64               randconfig-a014-20200922
x86_64               randconfig-a015-20200922
x86_64               randconfig-a012-20200922
x86_64               randconfig-a016-20200922
x86_64               randconfig-a011-20200920
x86_64               randconfig-a013-20200920
x86_64               randconfig-a014-20200920
x86_64               randconfig-a015-20200920
x86_64               randconfig-a012-20200920
x86_64               randconfig-a016-20200920

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
