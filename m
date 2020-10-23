Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC542969DF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 08:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375396AbgJWGqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 02:46:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:64768 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S373110AbgJWGqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 02:46:25 -0400
IronPort-SDR: vXF2q0QuI9Nn/Nzoy4JyisSC0X17+q1GwxJhmP22QVqzLGA3927pUbqhjGXXTYSO4xxpX3VmfS
 nnThRm77R9Hw==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="154593898"
X-IronPort-AV: E=Sophos;i="5.77,407,1596524400"; 
   d="scan'208";a="154593898"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 23:46:18 -0700
IronPort-SDR: YvNCxjV+D2RHcl1oHCWkr7ONJG4nVIRDltY35a/+CvtQTaoEsvzbPnToEyYmLQSiUy3nHBTZLX
 rgXEVwJKZRSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,407,1596524400"; 
   d="scan'208";a="360135219"
Received: from lkp-server01.sh.intel.com (HELO 1f55bd7cde4b) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 22 Oct 2020 23:46:16 -0700
Received: from kbuild by 1f55bd7cde4b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kVqq6-00005d-Pf; Fri, 23 Oct 2020 06:46:14 +0000
Date:   Fri, 23 Oct 2020 14:45:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 95d591cca3b1851eaf66af066149183f18ff5ab3
Message-ID: <5f927c0f.GCAhIuu1h+35XIYh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 95d591cca3b1851eaf66af066149183f18ff5ab3  Merge branch 'x86/urgent'

elapsed time: 722m

configs tested: 143
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc837x_mds_defconfig
mips                          ath79_defconfig
um                            kunit_defconfig
powerpc                     ppa8548_defconfig
mips                      malta_kvm_defconfig
arm                             mxs_defconfig
arc                        nsim_700_defconfig
powerpc                      ppc44x_defconfig
m68k                        m5307c3_defconfig
s390                             allyesconfig
powerpc                   currituck_defconfig
powerpc                 canyonlands_defconfig
arm                          pxa910_defconfig
mips                         db1xxx_defconfig
sparc64                             defconfig
sh                           se7343_defconfig
sh                           se7780_defconfig
arm                            zeus_defconfig
sh                           se7722_defconfig
mips                     decstation_defconfig
arm                      jornada720_defconfig
sh                          lboxre2_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                     redwood_defconfig
sh                             sh03_defconfig
mips                      bmips_stb_defconfig
sparc64                          alldefconfig
sh                     magicpanelr2_defconfig
sh                           se7206_defconfig
parisc                generic-64bit_defconfig
powerpc                         wii_defconfig
arm                      integrator_defconfig
arm                       aspeed_g4_defconfig
arm                          moxart_defconfig
mips                           jazz_defconfig
arm                          lpd270_defconfig
m68k                          hp300_defconfig
arc                         haps_hs_defconfig
mips                        qi_lb60_defconfig
arm                            hisi_defconfig
arm                        multi_v5_defconfig
xtensa                              defconfig
mips                  cavium_octeon_defconfig
xtensa                    xip_kc705_defconfig
m68k                        m5407c3_defconfig
sh                             espt_defconfig
arm                        realview_defconfig
arm                           spitz_defconfig
xtensa                         virt_defconfig
powerpc                      ppc6xx_defconfig
arm                       versatile_defconfig
h8300                               defconfig
m68k                        stmark2_defconfig
powerpc                        icon_defconfig
sh                               alldefconfig
m68k                        mvme16x_defconfig
mips                           rs90_defconfig
powerpc                     mpc512x_defconfig
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
i386                 randconfig-a002-20201023
i386                 randconfig-a005-20201023
i386                 randconfig-a003-20201023
i386                 randconfig-a001-20201023
i386                 randconfig-a006-20201023
i386                 randconfig-a004-20201023
i386                 randconfig-a002-20201022
i386                 randconfig-a005-20201022
i386                 randconfig-a003-20201022
i386                 randconfig-a001-20201022
i386                 randconfig-a006-20201022
i386                 randconfig-a004-20201022
x86_64               randconfig-a011-20201022
x86_64               randconfig-a013-20201022
x86_64               randconfig-a016-20201022
x86_64               randconfig-a015-20201022
x86_64               randconfig-a012-20201022
x86_64               randconfig-a014-20201022
i386                 randconfig-a016-20201022
i386                 randconfig-a014-20201022
i386                 randconfig-a015-20201022
i386                 randconfig-a012-20201022
i386                 randconfig-a013-20201022
i386                 randconfig-a011-20201022
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
x86_64               randconfig-a011-20201023
x86_64               randconfig-a013-20201023
x86_64               randconfig-a016-20201023
x86_64               randconfig-a015-20201023
x86_64               randconfig-a012-20201023
x86_64               randconfig-a014-20201023
x86_64               randconfig-a001-20201022
x86_64               randconfig-a002-20201022
x86_64               randconfig-a003-20201022
x86_64               randconfig-a006-20201022
x86_64               randconfig-a004-20201022
x86_64               randconfig-a005-20201022

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
