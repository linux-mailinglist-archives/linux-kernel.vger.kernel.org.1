Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B501927E828
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbgI3MCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:02:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:9975 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729660AbgI3MCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:02:40 -0400
IronPort-SDR: utpNbzSdxtWCfaij0tU3X/DQ4QQi7iQKzOxfdnop5A37M4h2B0TZK31POxG53Ez7M6pwLe2EG+
 aOYL+Tcuwk0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="224024354"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="224024354"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 05:02:24 -0700
IronPort-SDR: m2PKZdOvelM1gk/qoTPdfPrtkzUp5QpbAPqHCqTawRpTtxpdRiz0nVDj26AtqlqPhycld/dDuQ
 s7I9xUYyDPoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="457630457"
Received: from lkp-server02.sh.intel.com (HELO de448af6ea1b) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 30 Sep 2020 05:02:22 -0700
Received: from kbuild by de448af6ea1b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kNaoP-0000D6-VT; Wed, 30 Sep 2020 12:02:21 +0000
Date:   Wed, 30 Sep 2020 20:02:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/tegra_nand] BUILD SUCCESS
 c403af786ee3c0efed51abb16211a854e29432dc
Message-ID: <5f7473c0.Vv4h6yzXSga90P04%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  testing/tegra_nand
branch HEAD: c403af786ee3c0efed51abb16211a854e29432dc  mtd: rawnand: Replace one-element array with flexible-array member

elapsed time: 722m

configs tested: 172
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                       maple_defconfig
arm                          gemini_defconfig
mips                            gpr_defconfig
arm                      integrator_defconfig
mips                         tb0219_defconfig
arm                         socfpga_defconfig
m68k                          atari_defconfig
arm                             ezx_defconfig
ia64                      gensparse_defconfig
xtensa                         virt_defconfig
sparc                            alldefconfig
powerpc                      pmac32_defconfig
powerpc                 mpc85xx_cds_defconfig
riscv                            alldefconfig
arm                           viper_defconfig
powerpc                 mpc834x_mds_defconfig
sh                           se7722_defconfig
m68k                       m5475evb_defconfig
mips                          rm200_defconfig
arm                          prima2_defconfig
arm                          iop32x_defconfig
mips                   sb1250_swarm_defconfig
powerpc                  mpc885_ads_defconfig
mips                      bmips_stb_defconfig
arm                            hisi_defconfig
arm                         lpc32xx_defconfig
powerpc                      ppc44x_defconfig
powerpc               mpc834x_itxgp_defconfig
openrisc                            defconfig
xtensa                          iss_defconfig
mips                        nlm_xlr_defconfig
powerpc                     ppa8548_defconfig
mips                           gcw0_defconfig
powerpc                    gamecube_defconfig
sh                        dreamcast_defconfig
m68k                        m5307c3_defconfig
powerpc                      obs600_defconfig
mips                           jazz_defconfig
powerpc                 canyonlands_defconfig
ia64                             allyesconfig
sh                           se7750_defconfig
m68k                          sun3x_defconfig
arm                           tegra_defconfig
arm                        multi_v5_defconfig
arm                             mxs_defconfig
mips                        vocore2_defconfig
arc                          axs103_defconfig
m68k                          hp300_defconfig
sh                            titan_defconfig
sparc                       sparc32_defconfig
arm                       multi_v4t_defconfig
arm                           sunxi_defconfig
mips                      pic32mzda_defconfig
mips                       lemote2f_defconfig
mips                 decstation_r4k_defconfig
powerpc                   motionpro_defconfig
arm                       imx_v4_v5_defconfig
um                           x86_64_defconfig
arm                       versatile_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                 linkstation_defconfig
arm                        realview_defconfig
powerpc                     taishan_defconfig
sh                        edosk7705_defconfig
arm                         ebsa110_defconfig
c6x                                 defconfig
arm                         cm_x300_defconfig
powerpc                 mpc832x_mds_defconfig
arm                             rpc_defconfig
arm                         lubbock_defconfig
c6x                        evmc6472_defconfig
sh                            hp6xx_defconfig
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
sh                 kfr2r09-romimage_defconfig
arm                            qcom_defconfig
powerpc64                           defconfig
powerpc                     ep8248e_defconfig
arm                        keystone_defconfig
arm                          pxa910_defconfig
ia64                             allmodconfig
ia64                                defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20200929
i386                 randconfig-a002-20200929
i386                 randconfig-a003-20200929
i386                 randconfig-a004-20200929
i386                 randconfig-a005-20200929
i386                 randconfig-a001-20200929
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
i386                 randconfig-a012-20200929
i386                 randconfig-a016-20200929
i386                 randconfig-a014-20200929
i386                 randconfig-a013-20200929
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
x86_64               randconfig-a001-20200930
x86_64               randconfig-a005-20200930
x86_64               randconfig-a003-20200930
x86_64               randconfig-a004-20200930
x86_64               randconfig-a002-20200930
x86_64               randconfig-a006-20200930

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
