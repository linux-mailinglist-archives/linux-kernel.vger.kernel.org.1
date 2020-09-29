Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6B127C1B7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgI2JwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:52:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:14091 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgI2JwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:52:11 -0400
IronPort-SDR: kTI21bfh+s1r/HjPKyOysAEZLKNpiNe7FBiAcQvLqqLR4keRnQVncMIqNe7hoEPDxb5809S0ub
 bKL5OpnXremQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="141546390"
X-IronPort-AV: E=Sophos;i="5.77,317,1596524400"; 
   d="scan'208";a="141546390"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 01:12:53 -0700
IronPort-SDR: oi9SrMvN7wHuiHJO8p/Ezpm4bh3joT/SfssgJvrvgiTP4oZXqqlatK/rxbreK+SKB/swrp+xC+
 NP/L/G5fgriw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,317,1596524400"; 
   d="scan'208";a="513769730"
Received: from lkp-server02.sh.intel.com (HELO dda5aa0886d8) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 29 Sep 2020 01:12:51 -0700
Received: from kbuild by dda5aa0886d8 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kNAkl-00004R-BN; Tue, 29 Sep 2020 08:12:51 +0000
Date:   Tue, 29 Sep 2020 16:12:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:urezki-pcount.2020.09.28c] BUILD SUCCESS
 71aa30d791cf3ca748f72dcb22fab9e0f70a246f
Message-ID: <5f72ec79.AZq5SfjUllgSb16L%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  urezki-pcount.2020.09.28c
branch HEAD: 71aa30d791cf3ca748f72dcb22fab9e0f70a246f  fixup! rcu/tree: Allocate a page when caller is preemptable

elapsed time: 824m

configs tested: 128
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                     haps_hs_smp_defconfig
m68k                          amiga_defconfig
ia64                         bigsur_defconfig
sh                             shx3_defconfig
m68k                        stmark2_defconfig
nios2                         3c120_defconfig
powerpc                      arches_defconfig
powerpc                      cm5200_defconfig
sparc                       sparc32_defconfig
arm                          badge4_defconfig
powerpc                        cell_defconfig
powerpc                     tqm8541_defconfig
powerpc64                           defconfig
csky                             alldefconfig
riscv                          rv32_defconfig
sh                          rsk7201_defconfig
mips                        workpad_defconfig
xtensa                       common_defconfig
powerpc64                        alldefconfig
arm                          lpd270_defconfig
mips                         cobalt_defconfig
arm                        multi_v7_defconfig
powerpc                 mpc836x_rdk_defconfig
arc                      axs103_smp_defconfig
arm                              zx_defconfig
arm                        mvebu_v5_defconfig
c6x                        evmc6472_defconfig
arm                  colibri_pxa300_defconfig
powerpc                      ppc40x_defconfig
arm                      integrator_defconfig
arc                          axs103_defconfig
mips                      malta_kvm_defconfig
arm                         s5pv210_defconfig
mips                       bmips_be_defconfig
sh                           se7343_defconfig
arm                           sunxi_defconfig
m68k                          multi_defconfig
arm                         cm_x300_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                   secureedge5410_defconfig
mips                  decstation_64_defconfig
arm                         bcm2835_defconfig
mips                           xway_defconfig
ia64                            zx1_defconfig
arm                          pxa910_defconfig
sh                           se7750_defconfig
arm                        cerfcube_defconfig
arm                  colibri_pxa270_defconfig
mips                      maltaaprp_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20200928
x86_64               randconfig-a003-20200928
x86_64               randconfig-a004-20200928
x86_64               randconfig-a002-20200928
x86_64               randconfig-a006-20200928
x86_64               randconfig-a001-20200928
i386                 randconfig-a006-20200928
i386                 randconfig-a002-20200928
i386                 randconfig-a003-20200928
i386                 randconfig-a004-20200928
i386                 randconfig-a005-20200928
i386                 randconfig-a001-20200928
i386                 randconfig-a012-20200928
i386                 randconfig-a016-20200928
i386                 randconfig-a014-20200928
i386                 randconfig-a013-20200928
i386                 randconfig-a015-20200928
i386                 randconfig-a011-20200928
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20200927
x86_64               randconfig-a003-20200927
x86_64               randconfig-a004-20200927
x86_64               randconfig-a002-20200927
x86_64               randconfig-a006-20200927
x86_64               randconfig-a001-20200927
x86_64               randconfig-a011-20200928
x86_64               randconfig-a013-20200928
x86_64               randconfig-a015-20200928
x86_64               randconfig-a014-20200928
x86_64               randconfig-a016-20200928
x86_64               randconfig-a012-20200928

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
