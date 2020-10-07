Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA41028567D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 03:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgJGBt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 21:49:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:18924 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgJGBt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 21:49:59 -0400
IronPort-SDR: U6+F29jbWgpaikfIr5MiqKuKNcFiG2hm/FQzZfD2dp4pf5pnUhcbobfs4k2VSL2reUYa6DMUoC
 KVHkue9KCZNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="161390516"
X-IronPort-AV: E=Sophos;i="5.77,344,1596524400"; 
   d="scan'208";a="161390516"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 18:49:59 -0700
IronPort-SDR: dRtCuKsSrPKy5sdr+0b+GXG4dnCovzs95+c1XxukWNGvsjW9JpMfsPGBbD1bUrt0IwzOBd1T3A
 ECX+DOn4CWmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,344,1596524400"; 
   d="scan'208";a="418507180"
Received: from lkp-server02.sh.intel.com (HELO b5ae2f167493) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 06 Oct 2020 18:49:57 -0700
Received: from kbuild by b5ae2f167493 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kPyab-0001Qk-AL; Wed, 07 Oct 2020 01:49:57 +0000
Date:   Wed, 07 Oct 2020 09:49:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:auto-latest] BUILD SUCCESS
 6f7122ae48059b458385c6a750575faa6f4ef64d
Message-ID: <5f7d1e98.pBybiuoNNv2DgWdu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  auto-latest
branch HEAD: 6f7122ae48059b458385c6a750575faa6f4ef64d  Merge branch 'objtool/core'

elapsed time: 723m

configs tested: 156
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                  cavium_octeon_defconfig
sh                           se7724_defconfig
mips                      pic32mzda_defconfig
m68k                       m5275evb_defconfig
powerpc                     rainier_defconfig
arm                          ixp4xx_defconfig
mips                        bcm63xx_defconfig
mips                           ip28_defconfig
mips                        omega2p_defconfig
mips                      pistachio_defconfig
sh                           se7721_defconfig
powerpc                     mpc5200_defconfig
arm                            zeus_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      obs600_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                     sh7710voipgw_defconfig
sh                   sh7724_generic_defconfig
arm64                            alldefconfig
powerpc                          g5_defconfig
arm                           sunxi_defconfig
powerpc                 mpc8272_ads_defconfig
arm                        magician_defconfig
arm                         lpc32xx_defconfig
arm                       imx_v6_v7_defconfig
arm                        mvebu_v5_defconfig
powerpc                     tqm8555_defconfig
mips                            e55_defconfig
sh                        apsh4ad0a_defconfig
mips                        vocore2_defconfig
c6x                        evmc6474_defconfig
openrisc                    or1ksim_defconfig
sh                          lboxre2_defconfig
arm                         lpc18xx_defconfig
arm                          exynos_defconfig
powerpc                     ppa8548_defconfig
h8300                       h8s-sim_defconfig
powerpc                    ge_imp3a_defconfig
mips                      malta_kvm_defconfig
csky                             alldefconfig
parisc                generic-32bit_defconfig
sh                           se7705_defconfig
sh                               alldefconfig
arm                      footbridge_defconfig
c6x                        evmc6472_defconfig
sh                         ecovec24_defconfig
m68k                          hp300_defconfig
arm                         mv78xx0_defconfig
mips                 decstation_r4k_defconfig
sh                        edosk7705_defconfig
nios2                            alldefconfig
m68k                       m5208evb_defconfig
powerpc                       eiger_defconfig
mips                         tb0226_defconfig
mips                        nlm_xlr_defconfig
powerpc                      ep88xc_defconfig
powerpc                     redwood_defconfig
sh                          rsk7269_defconfig
arm                              alldefconfig
arm                    vt8500_v6_v7_defconfig
sh                             espt_defconfig
m68k                       bvme6000_defconfig
arm                         palmz72_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                 mpc837x_rdb_defconfig
arc                          axs101_defconfig
sh                          landisk_defconfig
arm                           sama5_defconfig
sh                        sh7785lcr_defconfig
powerpc                  iss476-smp_defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201006
x86_64               randconfig-a002-20201006
x86_64               randconfig-a001-20201006
x86_64               randconfig-a005-20201006
x86_64               randconfig-a003-20201006
x86_64               randconfig-a006-20201006
i386                 randconfig-a006-20201005
i386                 randconfig-a005-20201005
i386                 randconfig-a001-20201005
i386                 randconfig-a004-20201005
i386                 randconfig-a003-20201005
i386                 randconfig-a002-20201005
x86_64               randconfig-a012-20201005
x86_64               randconfig-a015-20201005
x86_64               randconfig-a014-20201005
x86_64               randconfig-a013-20201005
x86_64               randconfig-a011-20201005
x86_64               randconfig-a016-20201005
i386                 randconfig-a014-20201005
i386                 randconfig-a015-20201005
i386                 randconfig-a013-20201005
i386                 randconfig-a016-20201005
i386                 randconfig-a011-20201005
i386                 randconfig-a012-20201005
i386                 randconfig-a014-20201007
i386                 randconfig-a013-20201007
i386                 randconfig-a015-20201007
i386                 randconfig-a016-20201007
i386                 randconfig-a011-20201007
i386                 randconfig-a012-20201007
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
x86_64               randconfig-a004-20201005
x86_64               randconfig-a002-20201005
x86_64               randconfig-a001-20201005
x86_64               randconfig-a003-20201005
x86_64               randconfig-a005-20201005
x86_64               randconfig-a006-20201005

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
