Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E2027981E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 11:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgIZJJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 05:09:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:54786 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbgIZJJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 05:09:18 -0400
IronPort-SDR: WPunOVt4XYGyZQrUHyGOxbllGnpTINtqA3FBgHWw4jaZjFZIswuMqQx2H5Ru9eDVyYaOxH21lL
 VWZfDGpGTP+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="159121006"
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400"; 
   d="scan'208";a="159121006"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 23:31:05 -0700
IronPort-SDR: Fi1aCdWtB96gKbnt2vE4eR38/niRHSQfWLmOAQ9gWtEjpohDpsXefmy/XLO2thUrwRCQDwMhsq
 6CzaUmYCIeIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,303,1596524400"; 
   d="scan'208";a="487765924"
Received: from lkp-server01.sh.intel.com (HELO 2dda29302fe3) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 Sep 2020 23:31:03 -0700
Received: from kbuild by 2dda29302fe3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kM3ja-0000PK-Up; Sat, 26 Sep 2020 06:31:02 +0000
Date:   Sat, 26 Sep 2020 14:30:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 4bd442e9a8388e8ec4ba7cf23a4774989d93b78e
Message-ID: <5f6ee021.gldfwxnwW2KrcAYZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  ras/core
branch HEAD: 4bd442e9a8388e8ec4ba7cf23a4774989d93b78e  RAS/CEC: Convert to DEFINE_SHOW_ATTRIBUTE()

elapsed time: 724m

configs tested: 150
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
parisc                              defconfig
sh                               j2_defconfig
arm                        cerfcube_defconfig
h8300                            alldefconfig
arc                     nsimosci_hs_defconfig
sh                     magicpanelr2_defconfig
sh                           se7751_defconfig
mips                      malta_kvm_defconfig
arm                             mxs_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                           gcw0_defconfig
powerpc                    ge_imp3a_defconfig
m68k                       m5208evb_defconfig
sh                          sdk7786_defconfig
powerpc                        fsp2_defconfig
nios2                               defconfig
sh                          rsk7264_defconfig
mips                    maltaup_xpa_defconfig
arm                         lpc32xx_defconfig
powerpc                     tqm8548_defconfig
powerpc                   bluestone_defconfig
arc                     haps_hs_smp_defconfig
sh                          r7785rp_defconfig
arm                           stm32_defconfig
powerpc                     taishan_defconfig
sh                          landisk_defconfig
sh                            titan_defconfig
xtensa                    smp_lx200_defconfig
arm                       versatile_defconfig
powerpc                     stx_gp3_defconfig
sh                           se7780_defconfig
xtensa                         virt_defconfig
mips                         tb0219_defconfig
arc                    vdk_hs38_smp_defconfig
arm                          iop32x_defconfig
arm                         orion5x_defconfig
arm                         at91_dt_defconfig
m68k                        m5307c3_defconfig
mips                      bmips_stb_defconfig
m68k                       m5275evb_defconfig
mips                            gpr_defconfig
powerpc                        icon_defconfig
mips                         tb0287_defconfig
mips                         db1xxx_defconfig
arm                            dove_defconfig
sh                                  defconfig
sh                           se7724_defconfig
arm                            hisi_defconfig
i386                                defconfig
parisc                           allyesconfig
ia64                                defconfig
mips                        jmr3927_defconfig
sparc                       sparc64_defconfig
arm                       aspeed_g4_defconfig
csky                                defconfig
powerpc                     ksi8560_defconfig
arm                            mps2_defconfig
um                            kunit_defconfig
powerpc               mpc834x_itxgp_defconfig
sparc                            alldefconfig
arc                           tb10x_defconfig
arm                        keystone_defconfig
mips                        nlm_xlp_defconfig
arm                     davinci_all_defconfig
arm                         hackkit_defconfig
ia64                          tiger_defconfig
ia64                            zx1_defconfig
powerpc                        cell_defconfig
arc                          axs103_defconfig
powerpc                       maple_defconfig
arm                        mvebu_v5_defconfig
c6x                         dsk6455_defconfig
mips                         mpc30x_defconfig
powerpc                 mpc837x_mds_defconfig
sh                            migor_defconfig
microblaze                          defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20200925
i386                 randconfig-a006-20200925
i386                 randconfig-a003-20200925
i386                 randconfig-a004-20200925
i386                 randconfig-a005-20200925
i386                 randconfig-a001-20200925
i386                 randconfig-a002-20200926
i386                 randconfig-a006-20200926
i386                 randconfig-a003-20200926
i386                 randconfig-a004-20200926
i386                 randconfig-a005-20200926
i386                 randconfig-a001-20200926
x86_64               randconfig-a011-20200925
x86_64               randconfig-a013-20200925
x86_64               randconfig-a014-20200925
x86_64               randconfig-a015-20200925
x86_64               randconfig-a012-20200925
x86_64               randconfig-a016-20200925
i386                 randconfig-a012-20200925
i386                 randconfig-a014-20200925
i386                 randconfig-a016-20200925
i386                 randconfig-a013-20200925
i386                 randconfig-a011-20200925
i386                 randconfig-a015-20200925
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
x86_64               randconfig-a005-20200925
x86_64               randconfig-a003-20200925
x86_64               randconfig-a004-20200925
x86_64               randconfig-a002-20200925
x86_64               randconfig-a006-20200925
x86_64               randconfig-a001-20200925

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
