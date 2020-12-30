Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E0B2E7C48
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 21:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgL3UgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 15:36:01 -0500
Received: from mga06.intel.com ([134.134.136.31]:51503 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgL3UgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 15:36:01 -0500
IronPort-SDR: jqC7w99YI6kocZAIRSLqUTIMk+7Fu+rSLRV12djPO8nDlm6Mu6m6cqr5rikvaHan4W4ziRQmit
 tGYQYRLdcM7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9850"; a="238191989"
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; 
   d="scan'208";a="238191989"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2020 12:35:19 -0800
IronPort-SDR: O/2wLUoox4zh8Va8EbzL4NS/Jqf3SReiiBwJnmViH2kaPt4Fcfp0zKoGpSQNnX74XoWamE0tcv
 R5XEm/2gTjqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,462,1599548400"; 
   d="scan'208";a="395976239"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 30 Dec 2020 12:35:18 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kuiBh-0004VH-UM; Wed, 30 Dec 2020 20:35:17 +0000
Date:   Thu, 31 Dec 2020 04:34:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/platform] BUILD SUCCESS
 bdb154f074a6d73d520b1fdee6b4143e2e311dfb
Message-ID: <5fece46e.g1+SZGhaECddmc3Y%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/platform
branch HEAD: bdb154f074a6d73d520b1fdee6b4143e2e311dfb  x86/platform/intel-mid: Convert comma to semicolon

elapsed time: 725m

configs tested: 144
configs skipped: 62

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc834x_itx_defconfig
arm                          gemini_defconfig
arm                         bcm2835_defconfig
mips                         bigsur_defconfig
powerpc                      cm5200_defconfig
powerpc                  mpc885_ads_defconfig
sh                          polaris_defconfig
riscv                            allyesconfig
arc                        nsim_700_defconfig
riscv                               defconfig
m68k                         apollo_defconfig
powerpc                    mvme5100_defconfig
sh                           se7343_defconfig
sh                             shx3_defconfig
powerpc                 mpc837x_mds_defconfig
arm                     davinci_all_defconfig
arm                           corgi_defconfig
arm                        mvebu_v5_defconfig
arm                            u300_defconfig
mips                      maltasmvp_defconfig
sh                             sh03_defconfig
arc                            hsdk_defconfig
powerpc                  storcenter_defconfig
sh                          lboxre2_defconfig
arm                  colibri_pxa300_defconfig
mips                      fuloong2e_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     mpc83xx_defconfig
mips                       lemote2f_defconfig
arm                          imote2_defconfig
sh                   sh7724_generic_defconfig
mips                      pic32mzda_defconfig
arm                       aspeed_g5_defconfig
arm                           spitz_defconfig
powerpc                     tqm8540_defconfig
h8300                       h8s-sim_defconfig
mips                          malta_defconfig
mips                     loongson1b_defconfig
mips                     loongson1c_defconfig
x86_64                           alldefconfig
m68k                           sun3_defconfig
mips                           ip22_defconfig
powerpc                      ppc44x_defconfig
powerpc                    sam440ep_defconfig
arc                     haps_hs_smp_defconfig
riscv                    nommu_virt_defconfig
ia64                             alldefconfig
sh                     sh7710voipgw_defconfig
arm                         lpc18xx_defconfig
sh                         microdev_defconfig
arm                         s5pv210_defconfig
mips                         tb0226_defconfig
arm                          pxa910_defconfig
c6x                        evmc6474_defconfig
arm                        shmobile_defconfig
powerpc                    socrates_defconfig
mips                        qi_lb60_defconfig
sparc                       sparc32_defconfig
arc                     nsimosci_hs_defconfig
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
s390                                defconfig
parisc                           allyesconfig
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
i386                 randconfig-a002-20201229
i386                 randconfig-a005-20201229
i386                 randconfig-a004-20201229
i386                 randconfig-a006-20201229
i386                 randconfig-a003-20201229
i386                 randconfig-a001-20201229
i386                 randconfig-a005-20201230
i386                 randconfig-a006-20201230
i386                 randconfig-a004-20201230
i386                 randconfig-a003-20201230
i386                 randconfig-a002-20201230
i386                 randconfig-a001-20201230
i386                 randconfig-a016-20201230
i386                 randconfig-a014-20201230
i386                 randconfig-a012-20201230
i386                 randconfig-a015-20201230
i386                 randconfig-a011-20201230
i386                 randconfig-a013-20201230
x86_64               randconfig-a005-20201230
x86_64               randconfig-a001-20201230
x86_64               randconfig-a006-20201230
x86_64               randconfig-a002-20201230
x86_64               randconfig-a004-20201230
x86_64               randconfig-a003-20201230
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
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
x86_64               randconfig-a015-20201230
x86_64               randconfig-a014-20201230
x86_64               randconfig-a016-20201230
x86_64               randconfig-a011-20201230
x86_64               randconfig-a013-20201230
x86_64               randconfig-a012-20201230
x86_64               randconfig-a014-20201229
x86_64               randconfig-a015-20201229
x86_64               randconfig-a016-20201229
x86_64               randconfig-a012-20201229
x86_64               randconfig-a011-20201229
x86_64               randconfig-a013-20201229

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
