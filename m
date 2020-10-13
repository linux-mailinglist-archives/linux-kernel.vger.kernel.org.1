Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EC128C798
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 05:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgJMDgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 23:36:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:21672 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729124AbgJMDgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 23:36:15 -0400
IronPort-SDR: OfqBRRPCXbOmQPtt5rpDW6ruDy745vk2caWqpObc/eRRHZa+QoTninC7Dx4khEhUpXCvuBQvoP
 sa4m7vAqYkDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="145705993"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="145705993"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 20:36:14 -0700
IronPort-SDR: l8vKCrBCMkd89qvMvteAB3p+3W6pyTj2ygEwVOuwtiJeQRZ5MoJ4zW2Mc7B4ex2TFempftBHcV
 doPgGNAExwuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="299412122"
Received: from lkp-server01.sh.intel.com (HELO aa1d92d39b27) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 12 Oct 2020 20:36:13 -0700
Received: from kbuild by aa1d92d39b27 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kSB6i-0000Jc-RA; Tue, 13 Oct 2020 03:36:12 +0000
Date:   Tue, 13 Oct 2020 11:36:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 f91072ed1b7283b13ca57fcfbece5a3b92726143
Message-ID: <5f8520a4.yQbOwCkJAYJBFdh6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  perf/core
branch HEAD: f91072ed1b7283b13ca57fcfbece5a3b92726143  perf/core: Fix race in the perf_mmap_close() function

elapsed time: 721m

configs tested: 147
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     pseries_defconfig
m68k                       m5275evb_defconfig
arm                      integrator_defconfig
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
nios2                            allyesconfig
powerpc                          g5_defconfig
arc                             nps_defconfig
m68k                        m5272c3_defconfig
mips                      loongson3_defconfig
arc                              allyesconfig
m68k                            q40_defconfig
powerpc                      pmac32_defconfig
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
arm                           h5000_defconfig
alpha                            allyesconfig
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
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
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
