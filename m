Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08622B8020
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 16:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgKRPJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 10:09:08 -0500
Received: from mga05.intel.com ([192.55.52.43]:22082 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgKRPJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:09:08 -0500
IronPort-SDR: tzTjgOcVZI4yFYZsJPc14Rv07zZdKYEv6Odkf2PehYsIx5S19SmobjpVL+FzMHGlrIwiEUHU9h
 jTzOA/lL67kg==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="255839777"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="255839777"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 07:08:45 -0800
IronPort-SDR: OY43P+kZqllLMr3ReTtT2xW/WtStSEcYAsH1TCNR0IVk5e0CCruQ7nhF9QPexXrhOEyADSwwgB
 Hj1Mo4awQKiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="359488561"
Received: from lkp-server02.sh.intel.com (HELO 67996b229c47) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 18 Nov 2020 07:08:43 -0800
Received: from kbuild by 67996b229c47 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kfP4d-00008p-18; Wed, 18 Nov 2020 15:08:43 +0000
Date:   Wed, 18 Nov 2020 23:08:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.11.16a] BUILD SUCCESS
 11c40b6a6d081572e39732003d0bb536bf05a716
Message-ID: <5fb538e9.1Cd52QZ94+10j6N9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.11.16a
branch HEAD: 11c40b6a6d081572e39732003d0bb536bf05a716  torture: Prepare for splitting qemu execution from kvm-test-1-run.sh

elapsed time: 724m

configs tested: 160
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          rsk7269_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                        edosk7760_defconfig
sh                         microdev_defconfig
sh                            shmin_defconfig
sh                            migor_defconfig
arm                            hisi_defconfig
arm                         assabet_defconfig
powerpc                     kmeter1_defconfig
sh                     sh7710voipgw_defconfig
sh                         ecovec24_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                    ge_imp3a_defconfig
arm                          gemini_defconfig
xtensa                    xip_kc705_defconfig
powerpc                     ksi8560_defconfig
microblaze                    nommu_defconfig
arm                          exynos_defconfig
mips                 decstation_r4k_defconfig
mips                      maltasmvp_defconfig
mips                           ci20_defconfig
arc                         haps_hs_defconfig
sh                   sh7770_generic_defconfig
arm                          tango4_defconfig
mips                      loongson3_defconfig
arm                            mps2_defconfig
arc                     nsimosci_hs_defconfig
mips                            ar7_defconfig
powerpc                      cm5200_defconfig
mips                          malta_defconfig
openrisc                    or1ksim_defconfig
arm                         hackkit_defconfig
m68k                         apollo_defconfig
mips                          rm200_defconfig
mips                  decstation_64_defconfig
sh                            hp6xx_defconfig
mips                       bmips_be_defconfig
c6x                        evmc6472_defconfig
s390                       zfcpdump_defconfig
powerpc                     pq2fads_defconfig
powerpc                      pmac32_defconfig
sh                          rsk7203_defconfig
powerpc                      pcm030_defconfig
openrisc                         alldefconfig
sparc                               defconfig
powerpc                     kilauea_defconfig
sh                          polaris_defconfig
sh                           se7724_defconfig
m68k                          atari_defconfig
sh                        dreamcast_defconfig
mips                      maltaaprp_defconfig
arm                         socfpga_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                               j2_defconfig
xtensa                  cadence_csp_defconfig
arm                            lart_defconfig
arm                          prima2_defconfig
powerpc                    gamecube_defconfig
h8300                            alldefconfig
mips                      bmips_stb_defconfig
s390                             alldefconfig
arm                           h5000_defconfig
arm                        neponset_defconfig
i386                                defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20201118
x86_64               randconfig-a003-20201118
x86_64               randconfig-a004-20201118
x86_64               randconfig-a002-20201118
x86_64               randconfig-a006-20201118
x86_64               randconfig-a001-20201118
i386                 randconfig-a006-20201117
i386                 randconfig-a005-20201117
i386                 randconfig-a001-20201117
i386                 randconfig-a002-20201117
i386                 randconfig-a004-20201117
i386                 randconfig-a003-20201117
i386                 randconfig-a006-20201118
i386                 randconfig-a005-20201118
i386                 randconfig-a002-20201118
i386                 randconfig-a001-20201118
i386                 randconfig-a003-20201118
i386                 randconfig-a004-20201118
i386                 randconfig-a012-20201118
i386                 randconfig-a014-20201118
i386                 randconfig-a016-20201118
i386                 randconfig-a011-20201118
i386                 randconfig-a013-20201118
i386                 randconfig-a015-20201118
i386                 randconfig-a012-20201117
i386                 randconfig-a014-20201117
i386                 randconfig-a016-20201117
i386                 randconfig-a011-20201117
i386                 randconfig-a015-20201117
i386                 randconfig-a013-20201117
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
x86_64               randconfig-a003-20201117
x86_64               randconfig-a005-20201117
x86_64               randconfig-a004-20201117
x86_64               randconfig-a002-20201117
x86_64               randconfig-a001-20201117
x86_64               randconfig-a006-20201117
x86_64               randconfig-a015-20201118
x86_64               randconfig-a014-20201118
x86_64               randconfig-a011-20201118
x86_64               randconfig-a013-20201118
x86_64               randconfig-a016-20201118
x86_64               randconfig-a012-20201118
x86_64               randconfig-a015-20201116
x86_64               randconfig-a011-20201116
x86_64               randconfig-a014-20201116
x86_64               randconfig-a013-20201116
x86_64               randconfig-a016-20201116
x86_64               randconfig-a012-20201116

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
