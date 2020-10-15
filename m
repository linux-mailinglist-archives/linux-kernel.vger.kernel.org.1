Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA17128EFEF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 12:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389195AbgJOKPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 06:15:17 -0400
Received: from mga12.intel.com ([192.55.52.136]:8962 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389099AbgJOKPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 06:15:16 -0400
IronPort-SDR: s0Z05+15zwsxOvPr7FZo5R05XY80ZRjjC7bYWkCUBe60wfJpSZR64RU0CQqyyqH9N6QWKPI8jR
 d+XhF4Syc6eA==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="145625145"
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; 
   d="scan'208";a="145625145"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 03:15:15 -0700
IronPort-SDR: K3xbiDQTEFyp2MVDFd76XuMB/v0vr0zwx97tkOA5Pg/9jY7ra37Pg0c/5eNaw+h+PQkc2Dshzd
 N5mucjiB3NvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; 
   d="scan'208";a="318972914"
Received: from lkp-server02.sh.intel.com (HELO 7220befbd762) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Oct 2020 03:15:14 -0700
Received: from kbuild by 7220befbd762 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kT0Hx-00005p-UF; Thu, 15 Oct 2020 10:15:13 +0000
Date:   Thu, 15 Oct 2020 18:15:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:auto-latest] BUILD SUCCESS
 80f92ca9b86c71450f003d39956fca4327cc5586
Message-ID: <5f882128.OQUnDcw/c7qkkmEd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  auto-latest
branch HEAD: 80f92ca9b86c71450f003d39956fca4327cc5586  Merge branch 'core/rcu'

elapsed time: 1618m

configs tested: 151
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
mips                         tb0287_defconfig
sh                   sh7724_generic_defconfig
s390                             allyesconfig
arm                       netwinder_defconfig
xtensa                              defconfig
mips                            e55_defconfig
mips                        omega2p_defconfig
arm                           stm32_defconfig
sh                            migor_defconfig
arm                         orion5x_defconfig
arc                     nsimosci_hs_defconfig
arm                        spear3xx_defconfig
arm                         cm_x300_defconfig
arm                              zx_defconfig
mips                        jmr3927_defconfig
powerpc                     tqm8555_defconfig
arm                              alldefconfig
powerpc                 mpc8560_ads_defconfig
arm                          pxa3xx_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                 mpc832x_mds_defconfig
sh                        apsh4ad0a_defconfig
mips                          ath79_defconfig
arm                  colibri_pxa300_defconfig
arm                            xcep_defconfig
powerpc                       eiger_defconfig
mips                           ip32_defconfig
alpha                               defconfig
mips                        workpad_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                           u8500_defconfig
riscv                          rv32_defconfig
arm                          prima2_defconfig
m68k                             allmodconfig
arm                           tegra_defconfig
mips                      pistachio_defconfig
ia64                      gensparse_defconfig
sh                          rsk7203_defconfig
powerpc                     powernv_defconfig
sh                        edosk7760_defconfig
arm                        mvebu_v7_defconfig
sh                           se7619_defconfig
powerpc                   motionpro_defconfig
mips                          malta_defconfig
arm                         lpc32xx_defconfig
arm                          simpad_defconfig
sh                               allmodconfig
riscv                    nommu_k210_defconfig
mips                           ip28_defconfig
i386                             alldefconfig
arc                        vdk_hs38_defconfig
powerpc                      pmac32_defconfig
mips                malta_kvm_guest_defconfig
h8300                     edosk2674_defconfig
mips                 pnx8335_stb225_defconfig
mips                       bmips_be_defconfig
arm                    vt8500_v6_v7_defconfig
parisc                           alldefconfig
sh                           se7751_defconfig
mips                  maltasmvp_eva_defconfig
microblaze                      mmu_defconfig
powerpc                     mpc5200_defconfig
arm                       imx_v4_v5_defconfig
powerpc                       ebony_defconfig
arm                            pleb_defconfig
sh                   sh7770_generic_defconfig
sh                          lboxre2_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                         axm55xx_defconfig
arm                       aspeed_g5_defconfig
sh                ecovec24-romimage_defconfig
mips                         mpc30x_defconfig
mips                     loongson1b_defconfig
mips                      malta_kvm_defconfig
mips                         tb0226_defconfig
mips                 decstation_r4k_defconfig
mips                     decstation_defconfig
arm                          ixp4xx_defconfig
m68k                            q40_defconfig
powerpc                 linkstation_defconfig
powerpc                      cm5200_defconfig
arm                             rpc_defconfig
arm                        trizeps4_defconfig
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
csky                                defconfig
alpha                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
parisc                              defconfig
s390                                defconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20201014
i386                 randconfig-a006-20201014
i386                 randconfig-a001-20201014
i386                 randconfig-a003-20201014
i386                 randconfig-a004-20201014
i386                 randconfig-a002-20201014
x86_64               randconfig-a016-20201014
x86_64               randconfig-a012-20201014
x86_64               randconfig-a015-20201014
x86_64               randconfig-a013-20201014
x86_64               randconfig-a014-20201014
x86_64               randconfig-a011-20201014
i386                 randconfig-a016-20201014
i386                 randconfig-a013-20201014
i386                 randconfig-a015-20201014
i386                 randconfig-a011-20201014
i386                 randconfig-a012-20201014
i386                 randconfig-a014-20201014
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201014
x86_64               randconfig-a002-20201014
x86_64               randconfig-a006-20201014
x86_64               randconfig-a001-20201014
x86_64               randconfig-a005-20201014
x86_64               randconfig-a003-20201014

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
