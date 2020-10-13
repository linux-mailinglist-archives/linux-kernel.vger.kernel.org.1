Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111D928C797
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 05:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbgJMDgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 23:36:10 -0400
Received: from mga06.intel.com ([134.134.136.31]:34911 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727831AbgJMDgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 23:36:10 -0400
IronPort-SDR: KGYM7UVn6pjYj/EoWjBx0HN/2H5aCV8QWib8RIMSXuXsLM8UjDHHMn1bPeNABlLAk+EVFwaoRR
 ArX6aYJ6AVag==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="227484433"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="227484433"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 20:36:09 -0700
IronPort-SDR: 1Jcv1ArMnmzgcgVklQzkqr8hL4fE3g4I5tNXfvA1X6NGDIOqofiO+bPzwLsXsgxRqVlzUz9hx8
 tHbGasGJfLAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="313657194"
Received: from lkp-server01.sh.intel.com (HELO aa1d92d39b27) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 12 Oct 2020 20:36:08 -0700
Received: from kbuild by aa1d92d39b27 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kSB6d-0000JZ-NG; Tue, 13 Oct 2020 03:36:07 +0000
Date:   Tue, 13 Oct 2020 11:36:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 20802fef73a5a98b6e8ed1c0aeca82994d835b13
Message-ID: <5f8520a1.beS1/PPVtnLMN68S%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: 20802fef73a5a98b6e8ed1c0aeca82994d835b13  x86/traps: Fix #DE Oops message regression

elapsed time: 721m

configs tested: 118
configs skipped: 49

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
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
powerpc                  mpc866_ads_defconfig
arm                         at91_dt_defconfig
m68k                         amcore_defconfig
sh                          lboxre2_defconfig
nios2                         3c120_defconfig
mips                           ip27_defconfig
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
