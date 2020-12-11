Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 551562D7666
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 14:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405977AbgLKNR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 08:17:28 -0500
Received: from mga06.intel.com ([134.134.136.31]:25929 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404411AbgLKNRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 08:17:08 -0500
IronPort-SDR: 0D66X/fNK2s6jmyha+mN4qZenac3Z9tupBPvzb7qOvLPCun+KXa8eqZsHjXf97XIn3gh8RAGqr
 8F3lNDDE45XQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9831"; a="236023120"
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; 
   d="scan'208";a="236023120"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 05:16:27 -0800
IronPort-SDR: ZIwXymvG0TGA3n5JoOcN5nndnIhV7ePfG7BhDfi4ifN/ohFCq62e3hbGXaKIwjX9/BhoWuIKwO
 Vi7QKPZwcgZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; 
   d="scan'208";a="440914829"
Received: from lkp-server01.sh.intel.com (HELO ecc0cebe68d1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 11 Dec 2020 05:16:26 -0800
Received: from kbuild by ecc0cebe68d1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kniHZ-0000tU-E2; Fri, 11 Dec 2020 13:16:25 +0000
Date:   Fri, 11 Dec 2020 21:16:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.12.09a] BUILD SUCCESS
 de1366e564f526e20a480cb46d6a28b966409ab6
Message-ID: <5fd37114.quf6iVNTeZ4NK+mY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.12.09a
branch HEAD: de1366e564f526e20a480cb46d6a28b966409ab6  fixup! mm: Add mem_dump_obj() to print source of memory block

elapsed time: 723m

configs tested: 163
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       omap2plus_defconfig
mips                         db1xxx_defconfig
powerpc                      cm5200_defconfig
mips                        maltaup_defconfig
powerpc                     skiroot_defconfig
mips                         bigsur_defconfig
powerpc                 canyonlands_defconfig
mips                           ci20_defconfig
xtensa                  nommu_kc705_defconfig
sh                           se7705_defconfig
arm                          moxart_defconfig
powerpc                      walnut_defconfig
mips                     cu1000-neo_defconfig
arc                            hsdk_defconfig
mips                           ip28_defconfig
nds32                               defconfig
sh                 kfr2r09-romimage_defconfig
um                             i386_defconfig
mips                    maltaup_xpa_defconfig
arm                          ep93xx_defconfig
arm                            zeus_defconfig
sh                           se7343_defconfig
sh                            migor_defconfig
mips                        vocore2_defconfig
arm                         orion5x_defconfig
powerpc                 mpc836x_mds_defconfig
arm                     eseries_pxa_defconfig
arm                      tct_hammer_defconfig
powerpc                    mvme5100_defconfig
powerpc                      acadia_defconfig
sh                             shx3_defconfig
arm                          imote2_defconfig
mips                malta_kvm_guest_defconfig
sh                          sdk7780_defconfig
powerpc                 mpc8560_ads_defconfig
arm                         lubbock_defconfig
arm                          tango4_defconfig
mips                           gcw0_defconfig
sparc                            allyesconfig
powerpc                     asp8347_defconfig
arm                          simpad_defconfig
m68k                                defconfig
arm                         shannon_defconfig
c6x                                 defconfig
m68k                       m5249evb_defconfig
arm                           stm32_defconfig
arm                           h5000_defconfig
alpha                            alldefconfig
sh                         microdev_defconfig
arm                           u8500_defconfig
powerpc                        icon_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                             alldefconfig
powerpc64                           defconfig
powerpc                     rainier_defconfig
powerpc                        warp_defconfig
arm                          badge4_defconfig
sh                          urquell_defconfig
sh                          sdk7786_defconfig
powerpc                      ppc64e_defconfig
arm                         palmz72_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                               j2_defconfig
arm                       versatile_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                       ebony_defconfig
arc                         haps_hs_defconfig
arm                         s5pv210_defconfig
microblaze                      mmu_defconfig
powerpc                      makalu_defconfig
mips                           ip27_defconfig
arm                          gemini_defconfig
arm                      pxa255-idp_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                 randconfig-a001-20201210
i386                 randconfig-a004-20201210
i386                 randconfig-a003-20201210
i386                 randconfig-a002-20201210
i386                 randconfig-a005-20201210
i386                 randconfig-a006-20201210
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
i386                 randconfig-a014-20201210
i386                 randconfig-a013-20201210
i386                 randconfig-a012-20201210
i386                 randconfig-a011-20201210
i386                 randconfig-a016-20201210
i386                 randconfig-a015-20201210
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
x86_64               randconfig-a003-20201210
x86_64               randconfig-a006-20201210
x86_64               randconfig-a002-20201210
x86_64               randconfig-a005-20201210
x86_64               randconfig-a004-20201210
x86_64               randconfig-a001-20201210

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
