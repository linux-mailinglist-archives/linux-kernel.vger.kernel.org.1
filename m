Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289BE2F72D6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 07:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbhAOGZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 01:25:09 -0500
Received: from mga06.intel.com ([134.134.136.31]:47744 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbhAOGZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:25:08 -0500
IronPort-SDR: T4AX21aAya/Tn1Qj5GWUpvP6K1KQmnthDXMDOVHbUVnaBXfkIhejtlbrMlyrEN6IwQOFDFwTiz
 8xhhsEHO4ULg==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="240050308"
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="240050308"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:24:27 -0800
IronPort-SDR: cY6fVE17p7cmyXtfPEO9GW3r5tVwXZ4Exp5xj5TSs3uRfh/OfuONkAp+Bb2EkdXeJAI9KGpVqP
 CtHUUThpE9kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="405401848"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jan 2021 22:24:25 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l0IX3-0000Dq-7W; Fri, 15 Jan 2021 06:24:25 +0000
Date:   Fri, 15 Jan 2021 14:23:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 2c2adbc40b7276518921864053f3c02034b2290f
Message-ID: <600134e5.slW6DBwOd3tDUxj2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 2c2adbc40b7276518921864053f3c02034b2290f  Merge branch 'irq/urgent'

elapsed time: 723m

configs tested: 106
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       imx_v4_v5_defconfig
arc                      axs103_smp_defconfig
sh                          r7785rp_defconfig
m68k                        m5272c3_defconfig
arm                        oxnas_v6_defconfig
sh                                  defconfig
powerpc                    socrates_defconfig
arm                           spitz_defconfig
sh                            migor_defconfig
arm                           sunxi_defconfig
powerpc                      tqm8xx_defconfig
xtensa                    smp_lx200_defconfig
arm                         vf610m4_defconfig
mips                          rb532_defconfig
sh                             shx3_defconfig
powerpc                 mpc837x_mds_defconfig
i386                             alldefconfig
powerpc                     redwood_defconfig
arm                            lart_defconfig
arm                            pleb_defconfig
sh                     sh7710voipgw_defconfig
sh                     magicpanelr2_defconfig
mips                malta_kvm_guest_defconfig
c6x                         dsk6455_defconfig
arm                             ezx_defconfig
arm                      integrator_defconfig
powerpc                   lite5200b_defconfig
arc                            hsdk_defconfig
riscv                    nommu_virt_defconfig
mips                      maltaaprp_defconfig
arm                          imote2_defconfig
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
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20210114
i386                 randconfig-a005-20210114
i386                 randconfig-a006-20210114
i386                 randconfig-a001-20210114
i386                 randconfig-a003-20210114
i386                 randconfig-a004-20210114
x86_64               randconfig-a015-20210114
x86_64               randconfig-a012-20210114
x86_64               randconfig-a013-20210114
x86_64               randconfig-a016-20210114
x86_64               randconfig-a014-20210114
x86_64               randconfig-a011-20210114
i386                 randconfig-a012-20210114
i386                 randconfig-a011-20210114
i386                 randconfig-a016-20210114
i386                 randconfig-a015-20210114
i386                 randconfig-a013-20210114
i386                 randconfig-a014-20210114
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210114
x86_64               randconfig-a006-20210114
x86_64               randconfig-a001-20210114
x86_64               randconfig-a003-20210114
x86_64               randconfig-a005-20210114
x86_64               randconfig-a002-20210114

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
