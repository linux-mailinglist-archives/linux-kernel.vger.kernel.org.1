Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A5727F0FE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgI3SDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:03:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:42484 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgI3SDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:03:05 -0400
IronPort-SDR: V8JlfXFgkdx7eC6gQz6ygPeyVilc84zLK9VpyOOF+wjJmoFxMHIATD4tu/Xsm7FkUsMrNkty2N
 c3r9WJpwu+ng==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="150165198"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="150165198"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 11:03:05 -0700
IronPort-SDR: tqpXF8qAXh+wxzza2Hqbr9yIzOVY8POTHryLGdw0+Ag7ByAhddDjW77BDXJBAMahkFYVDNxJ/S
 pMKmTn+BWYow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="312677016"
Received: from lkp-server02.sh.intel.com (HELO de448af6ea1b) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 30 Sep 2020 11:03:03 -0700
Received: from kbuild by de448af6ea1b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kNgRT-0000K1-6E; Wed, 30 Sep 2020 18:03:03 +0000
Date:   Thu, 01 Oct 2020 02:02:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 ed9705e4ad1c19ae51ed0cb4c112f9eb6dfc69fc
Message-ID: <5f74c82e.1jbwE7o5Jcl3m2/4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  ras/core
branch HEAD: ed9705e4ad1c19ae51ed0cb4c112f9eb6dfc69fc  x86/mce: Drop AMD-specific "DEFERRED" case from Intel severity rule list

elapsed time: 724m

configs tested: 155
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       aspeed_g4_defconfig
powerpc                   motionpro_defconfig
sh                         ap325rxa_defconfig
powerpc                     sequoia_defconfig
mips                    maltaup_xpa_defconfig
xtensa                         virt_defconfig
sparc                            alldefconfig
powerpc                      pmac32_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                           se7722_defconfig
m68k                       m5475evb_defconfig
mips                          rm200_defconfig
arm                          prima2_defconfig
arm                          iop32x_defconfig
mips                   sb1250_swarm_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                 linkstation_defconfig
c6x                         dsk6455_defconfig
powerpc64                        alldefconfig
nds32                            alldefconfig
mips                           rs90_defconfig
mips                      pistachio_defconfig
riscv                          rv32_defconfig
arm                          imote2_defconfig
powerpc                  mpc885_ads_defconfig
mips                      bmips_stb_defconfig
arm                            hisi_defconfig
arm                         lpc32xx_defconfig
arm                           viper_defconfig
powerpc                      ppc44x_defconfig
m68k                        m5307c3_defconfig
powerpc                      obs600_defconfig
mips                           jazz_defconfig
powerpc                 canyonlands_defconfig
powerpc                       maple_defconfig
sh                           se7750_defconfig
m68k                          sun3x_defconfig
arm                           tegra_defconfig
arm                        multi_v5_defconfig
sh                        dreamcast_defconfig
powerpc                    mvme5100_defconfig
sh                            migor_defconfig
arm                       imx_v4_v5_defconfig
um                           x86_64_defconfig
powerpc                    gamecube_defconfig
arm                       versatile_defconfig
mips                       lemote2f_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                        realview_defconfig
powerpc                     taishan_defconfig
sh                        edosk7705_defconfig
powerpc                      chrp32_defconfig
arm                           stm32_defconfig
x86_64                              defconfig
mips                      loongson3_defconfig
powerpc                      makalu_defconfig
openrisc                            defconfig
mips                           xway_defconfig
powerpc                      bamboo_defconfig
microblaze                      mmu_defconfig
powerpc                  iss476-smp_defconfig
arm                         cm_x300_defconfig
powerpc                 mpc832x_mds_defconfig
arm                             rpc_defconfig
arm                         lubbock_defconfig
c6x                        evmc6472_defconfig
sh                            hp6xx_defconfig
arm                       imx_v6_v7_defconfig
arc                    vdk_hs38_smp_defconfig
mips                        bcm47xx_defconfig
arm                        mini2440_defconfig
arc                             nps_defconfig
sh                           se7343_defconfig
c6x                              alldefconfig
powerpc                        cell_defconfig
arm                           efm32_defconfig
mips                         tb0287_defconfig
nds32                               defconfig
mips                           mtx1_defconfig
arm                            pleb_defconfig
sh                        apsh4ad0a_defconfig
parisc                              defconfig
powerpc                     mpc83xx_defconfig
microblaze                          defconfig
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
riscv                    nommu_k210_defconfig
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
