Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8703D290F45
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 07:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407396AbgJQFdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 01:33:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:22077 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404845AbgJQFc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 01:32:59 -0400
IronPort-SDR: zrbc8xyhv37IIBow7N+yrIb20TvHa0FFQGpRs+Wv/HcgTFLzZnecrsdcUsDGicEADzq9arACKU
 HRbVR7nUsm4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9776"; a="163281924"
X-IronPort-AV: E=Sophos;i="5.77,385,1596524400"; 
   d="scan'208";a="163281924"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 22:32:58 -0700
IronPort-SDR: paIA1B5Muq6jz0pWQV5nOuZMSGcyVqIHXGcfCRUzmIzkieHD8QuXOc9iZVo0bbsXLBLkIIbNTe
 KX5J4AtVFkmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,385,1596524400"; 
   d="scan'208";a="346800153"
Received: from lkp-server02.sh.intel.com (HELO 262a2cdd3070) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 16 Oct 2020 22:32:57 -0700
Received: from kbuild by 262a2cdd3070 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kTeps-0000GQ-UJ; Sat, 17 Oct 2020 05:32:56 +0000
Date:   Sat, 17 Oct 2020 13:32:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:master] BUILD SUCCESS
 78b9b11ec17709681e5fc7b50287354f9b0f7728
Message-ID: <5f8a81d8.hiTvQr/pTsIZKsSA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  master
branch HEAD: 78b9b11ec17709681e5fc7b50287354f9b0f7728  Merge branch 'urezki-pcount.2020.10.01a' into HEAD

elapsed time: 720m

configs tested: 150
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                        workpad_defconfig
powerpc                     redwood_defconfig
sh                           se7751_defconfig
arm                           omap1_defconfig
h8300                               defconfig
mips                      fuloong2e_defconfig
parisc                              defconfig
mips                     loongson1b_defconfig
powerpc                     taishan_defconfig
powerpc                     ksi8560_defconfig
arm                      jornada720_defconfig
mips                  cavium_octeon_defconfig
arm                          moxart_defconfig
alpha                            alldefconfig
powerpc                    adder875_defconfig
mips                 pnx8335_stb225_defconfig
riscv                    nommu_virt_defconfig
mips                           ip28_defconfig
powerpc                       ebony_defconfig
sh                          r7785rp_defconfig
arm                          pcm027_defconfig
xtensa                          iss_defconfig
arm                              alldefconfig
arm                         ebsa110_defconfig
mips                       rbtx49xx_defconfig
arm                           viper_defconfig
arm                         axm55xx_defconfig
arm                        cerfcube_defconfig
mips                         tb0226_defconfig
arm                            u300_defconfig
ia64                          tiger_defconfig
powerpc                     pseries_defconfig
xtensa                       common_defconfig
um                            kunit_defconfig
sh                        sh7757lcr_defconfig
arm                             mxs_defconfig
mips                        qi_lb60_defconfig
powerpc                      acadia_defconfig
arc                        nsimosci_defconfig
mips                         db1xxx_defconfig
powerpc                   lite5200b_defconfig
m68k                         amcore_defconfig
arc                              alldefconfig
h8300                    h8300h-sim_defconfig
arm                         at91_dt_defconfig
openrisc                            defconfig
arm                        magician_defconfig
arm                  colibri_pxa270_defconfig
arc                          axs103_defconfig
arm                       imx_v4_v5_defconfig
sh                 kfr2r09-romimage_defconfig
parisc                           alldefconfig
mips                      malta_kvm_defconfig
powerpc                   currituck_defconfig
arm                            lart_defconfig
mips                        omega2p_defconfig
arm                         vf610m4_defconfig
sh                             shx3_defconfig
powerpc                 mpc834x_itx_defconfig
arm                         s3c6400_defconfig
powerpc                     sbc8548_defconfig
m68k                        m5272c3_defconfig
i386                             alldefconfig
arm                          gemini_defconfig
um                           x86_64_defconfig
powerpc                     asp8347_defconfig
arm                           spitz_defconfig
arm                         cm_x300_defconfig
sh                      rts7751r2d1_defconfig
m68k                             alldefconfig
powerpc                     tqm8548_defconfig
powerpc                 mpc834x_mds_defconfig
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
i386                 randconfig-a005-20201016
i386                 randconfig-a006-20201016
i386                 randconfig-a001-20201016
i386                 randconfig-a003-20201016
i386                 randconfig-a004-20201016
i386                 randconfig-a002-20201016
x86_64               randconfig-a016-20201016
x86_64               randconfig-a012-20201016
x86_64               randconfig-a015-20201016
x86_64               randconfig-a013-20201016
x86_64               randconfig-a014-20201016
x86_64               randconfig-a011-20201016
i386                 randconfig-a016-20201016
i386                 randconfig-a013-20201016
i386                 randconfig-a015-20201016
i386                 randconfig-a011-20201016
i386                 randconfig-a012-20201016
i386                 randconfig-a014-20201016
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-a004-20201016
x86_64               randconfig-a002-20201016
x86_64               randconfig-a006-20201016
x86_64               randconfig-a001-20201016
x86_64               randconfig-a005-20201016
x86_64               randconfig-a003-20201016
x86_64               randconfig-a016-20201017
x86_64               randconfig-a012-20201017
x86_64               randconfig-a015-20201017
x86_64               randconfig-a013-20201017
x86_64               randconfig-a014-20201017
x86_64               randconfig-a011-20201017

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
