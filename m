Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E7627F3E3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 23:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbgI3VGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 17:06:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:58757 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgI3VGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 17:06:50 -0400
IronPort-SDR: wLCw9VcNZrumOzhqmubkA8+Xe77CzhWb2UpV30OTFTM9yD4HB8oKaIdxyEg2kbDWeIkQrU4bR8
 DbSb7lXDzFbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="150198897"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="150198897"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 14:06:46 -0700
IronPort-SDR: 67U9YDUQ+0HnoCjfDxkTVQYQKU3e3zHl7DXLnv1puULvhFB8k/uiH0EoX5+thPMY/qQuAVwcS8
 ASZrAPuelN7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="294755921"
Received: from lkp-server02.sh.intel.com (HELO de448af6ea1b) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 30 Sep 2020 14:06:45 -0700
Received: from kbuild by de448af6ea1b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kNjJF-0000OK-0d; Wed, 30 Sep 2020 21:06:45 +0000
Date:   Thu, 01 Oct 2020 05:06:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 bc21a291fc11bbd60868c45b9f5a79ceed97fd4e
Message-ID: <5f74f342.+KrEvjfzX8HuFxLn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: bc21a291fc11bbd60868c45b9f5a79ceed97fd4e  x86/mce: Use idtentry_nmi_enter/exit()

elapsed time: 724m

configs tested: 131
configs skipped: 66

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7722_defconfig
m68k                       m5475evb_defconfig
mips                          rm200_defconfig
arm                          prima2_defconfig
arm                          iop32x_defconfig
mips                   sb1250_swarm_defconfig
nds32                            alldefconfig
mips                           rs90_defconfig
mips                      pistachio_defconfig
riscv                          rv32_defconfig
arm                          imote2_defconfig
arc                          axs101_defconfig
riscv                    nommu_k210_defconfig
sh                           se7712_defconfig
powerpc                     sbc8548_defconfig
arm                         lubbock_defconfig
powerpc                  iss476-smp_defconfig
m68k                        m5307c3_defconfig
powerpc                      obs600_defconfig
mips                           jazz_defconfig
powerpc                 canyonlands_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                        clps711x_defconfig
arm                       mainstone_defconfig
arm                          ep93xx_defconfig
arm                             mxs_defconfig
arm                         lpc32xx_defconfig
mips                        vocore2_defconfig
arc                          axs103_defconfig
powerpc                    sam440ep_defconfig
sh                          sdk7786_defconfig
xtensa                          iss_defconfig
sh                           sh2007_defconfig
powerpc                      ppc44x_defconfig
arm                       imx_v4_v5_defconfig
um                           x86_64_defconfig
powerpc                    gamecube_defconfig
arm                       versatile_defconfig
mips                       lemote2f_defconfig
arm                        trizeps4_defconfig
powerpc                 linkstation_defconfig
arm                        realview_defconfig
powerpc                     taishan_defconfig
sh                        edosk7705_defconfig
powerpc                      chrp32_defconfig
arm                           stm32_defconfig
x86_64                              defconfig
mips                      loongson3_defconfig
powerpc                      makalu_defconfig
arm                       imx_v6_v7_defconfig
arc                    vdk_hs38_smp_defconfig
mips                        bcm47xx_defconfig
arm                           efm32_defconfig
mips                         tb0287_defconfig
nds32                               defconfig
mips                           mtx1_defconfig
arm                            pleb_defconfig
sh                        apsh4ad0a_defconfig
powerpc                     mpc83xx_defconfig
microblaze                          defconfig
powerpc64                        alldefconfig
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
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20200930
i386                 randconfig-a002-20200930
i386                 randconfig-a006-20200930
i386                 randconfig-a005-20200930
i386                 randconfig-a004-20200930
i386                 randconfig-a001-20200930
x86_64               randconfig-a015-20200930
x86_64               randconfig-a013-20200930
x86_64               randconfig-a012-20200930
x86_64               randconfig-a016-20200930
x86_64               randconfig-a014-20200930
x86_64               randconfig-a011-20200930
i386                 randconfig-a011-20200930
i386                 randconfig-a015-20200930
i386                 randconfig-a012-20200930
i386                 randconfig-a014-20200930
i386                 randconfig-a016-20200930
i386                 randconfig-a013-20200930
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20200930
x86_64               randconfig-a005-20200930
x86_64               randconfig-a003-20200930
x86_64               randconfig-a004-20200930
x86_64               randconfig-a002-20200930
x86_64               randconfig-a006-20200930

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
