Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED7C28C799
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 05:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbgJMDhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 23:37:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:34980 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727831AbgJMDhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 23:37:15 -0400
IronPort-SDR: JAdq/wQj1KlWw3LibfBpeBeh7BsP/KWJ+bScQlJm8SsYJbfsv+qRcuqabVW+XNLDtmEJEzJLSd
 to6etOghv2KQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="227484505"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="227484505"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 20:37:14 -0700
IronPort-SDR: AnhKyBwvHZTDGh+VVjNe9bTbjhBwc94dZm8mX16opSV5SlXay/ZauwpYNcPMWHyVbC8MTMl49h
 zpY4sJA1jZ/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="329960714"
Received: from lkp-server01.sh.intel.com (HELO aa1d92d39b27) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 12 Oct 2020 20:37:13 -0700
Received: from kbuild by aa1d92d39b27 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kSB7g-0000Jf-Rl; Tue, 13 Oct 2020 03:37:12 +0000
Date:   Tue, 13 Oct 2020 11:36:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:efi/core] BUILD SUCCESS
 4d0a4388ccdd9482fef6b26f879d0f6099143f80
Message-ID: <5f8520a5.GaFSm2njPFYkdVZx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  efi/core
branch HEAD: 4d0a4388ccdd9482fef6b26f879d0f6099143f80  Merge branch 'efi/urgent' into efi/core, to pick up fixes

elapsed time: 721m

configs tested: 149
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7750_defconfig
mips                        omega2p_defconfig
arc                        nsimosci_defconfig
xtensa                  nommu_kc705_defconfig
h8300                            allyesconfig
arm                       mainstone_defconfig
openrisc                 simple_smp_defconfig
csky                                defconfig
arc                 nsimosci_hs_smp_defconfig
sh                   sh7770_generic_defconfig
arm                         palmz72_defconfig
arm                      integrator_defconfig
arm                        multi_v7_defconfig
arm                              alldefconfig
arm                      tct_hammer_defconfig
mips                         db1xxx_defconfig
arm                        realview_defconfig
mips                           ip32_defconfig
powerpc                 mpc834x_mds_defconfig
sparc                            allyesconfig
xtensa                    xip_kc705_defconfig
sh                   secureedge5410_defconfig
arm                          iop32x_defconfig
mips                      pistachio_defconfig
openrisc                    or1ksim_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                            qcom_defconfig
sh                        sh7785lcr_defconfig
m68k                        stmark2_defconfig
xtensa                  cadence_csp_defconfig
x86_64                           allyesconfig
mips                      fuloong2e_defconfig
parisc                              defconfig
mips                           xway_defconfig
arm                            xcep_defconfig
powerpc                     tqm8548_defconfig
um                           x86_64_defconfig
powerpc                          g5_defconfig
arc                             nps_defconfig
m68k                        m5272c3_defconfig
mips                      loongson3_defconfig
arm                       aspeed_g4_defconfig
mips                           ip27_defconfig
powerpc                    adder875_defconfig
powerpc                      mgcoge_defconfig
mips                  maltasmvp_eva_defconfig
mips                  decstation_64_defconfig
h8300                     edosk2674_defconfig
powerpc                      pcm030_defconfig
arm64                            alldefconfig
arm                             rpc_defconfig
powerpc                     tqm8555_defconfig
arm                       multi_v4t_defconfig
arm                             pxa_defconfig
sh                          rsk7203_defconfig
mips                            ar7_defconfig
arm                            mmp2_defconfig
powerpc                   motionpro_defconfig
mips                        workpad_defconfig
sh                   rts7751r2dplus_defconfig
arc                        vdk_hs38_defconfig
mips                      malta_kvm_defconfig
arc                            hsdk_defconfig
alpha                            allyesconfig
arm                           h5000_defconfig
powerpc                  mpc885_ads_defconfig
arc                           tb10x_defconfig
mips                          ath25_defconfig
parisc                           allyesconfig
sh                     sh7710voipgw_defconfig
powerpc                  mpc866_ads_defconfig
arm                         at91_dt_defconfig
m68k                         amcore_defconfig
sh                          lboxre2_defconfig
nios2                         3c120_defconfig
powerpc                     pq2fads_defconfig
m68k                             allmodconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20201012
i386                 randconfig-a006-20201012
i386                 randconfig-a001-20201012
i386                 randconfig-a003-20201012
i386                 randconfig-a004-20201012
i386                 randconfig-a002-20201012
x86_64               randconfig-a016-20201012
x86_64               randconfig-a015-20201012
x86_64               randconfig-a012-20201012
x86_64               randconfig-a013-20201012
x86_64               randconfig-a014-20201012
x86_64               randconfig-a011-20201012
i386                 randconfig-a016-20201012
i386                 randconfig-a015-20201012
i386                 randconfig-a013-20201012
i386                 randconfig-a012-20201012
i386                 randconfig-a011-20201012
i386                 randconfig-a014-20201012
x86_64               randconfig-a004-20201013
x86_64               randconfig-a002-20201013
x86_64               randconfig-a006-20201013
x86_64               randconfig-a001-20201013
x86_64               randconfig-a003-20201013
x86_64               randconfig-a005-20201013
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201012
x86_64               randconfig-a002-20201012
x86_64               randconfig-a006-20201012
x86_64               randconfig-a001-20201012
x86_64               randconfig-a003-20201012
x86_64               randconfig-a005-20201012

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
