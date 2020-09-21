Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4E7271996
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 05:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgIUDc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 23:32:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:25267 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgIUDcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 23:32:25 -0400
IronPort-SDR: hJB8iPSiAaLGerJTwTr2HqzPue2pJcdMmU+8eIknTPXOMr+XPCnffI5XJx9mXa1LI57WVMaBnI
 VcH64Qg5xkXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9750"; a="221894975"
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; 
   d="scan'208";a="221894975"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2020 20:32:22 -0700
IronPort-SDR: zUyr+D9Wqw9Q4v1nK76Fsh9VyeassC0uwKHzdUcUKjrRMT2FtF5lfVG1rAsuRiQs7kWbRvR0k0
 uHVQSJD8F5/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,285,1596524400"; 
   d="scan'208";a="341345227"
Received: from lkp-server01.sh.intel.com (HELO 674716e234df) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 20 Sep 2020 20:32:20 -0700
Received: from kbuild by 674716e234df with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kKCYt-0000Di-Ga; Mon, 21 Sep 2020 03:32:19 +0000
Date:   Mon, 21 Sep 2020 11:31:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 ec179933e2502ebd3cbc31eac42a64d00e0e9c07
Message-ID: <5f681ea2.HDF6JHnZAB0vHGMG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: ec179933e2502ebd3cbc31eac42a64d00e0e9c07  rcutorture: Prevent hangs for invalid arguments

elapsed time: 723m

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
arc                 nsimosci_hs_smp_defconfig
powerpc                 mpc832x_mds_defconfig
parisc                generic-64bit_defconfig
powerpc                     mpc83xx_defconfig
arm                           corgi_defconfig
arm                          pcm027_defconfig
powerpc                      bamboo_defconfig
c6x                              alldefconfig
arc                          axs103_defconfig
sh                          sdk7780_defconfig
mips                           rs90_defconfig
sparc64                             defconfig
arm                          lpd270_defconfig
arm                         orion5x_defconfig
mips                   sb1250_swarm_defconfig
powerpc                    gamecube_defconfig
arm                        cerfcube_defconfig
microblaze                      mmu_defconfig
s390                                defconfig
xtensa                         virt_defconfig
m68k                             alldefconfig
sh                 kfr2r09-romimage_defconfig
sh                        sh7757lcr_defconfig
powerpc                    sam440ep_defconfig
arm                            zeus_defconfig
s390                          debug_defconfig
powerpc                        fsp2_defconfig
x86_64                           alldefconfig
arm                      footbridge_defconfig
powerpc                     akebono_defconfig
powerpc                      chrp32_defconfig
arm                          pxa3xx_defconfig
riscv                            alldefconfig
arm                        mvebu_v5_defconfig
arm                     am200epdkit_defconfig
powerpc                 mpc836x_rdk_defconfig
m68k                       m5275evb_defconfig
arm                          ep93xx_defconfig
sh                           sh2007_defconfig
sh                            migor_defconfig
arm                           sama5_defconfig
riscv                    nommu_virt_defconfig
powerpc                   currituck_defconfig
mips                           ip32_defconfig
powerpc                     tqm8540_defconfig
arm                       aspeed_g4_defconfig
sh                          urquell_defconfig
arm                             mxs_defconfig
powerpc                mpc7448_hpc2_defconfig
ia64                      gensparse_defconfig
mips                        nlm_xlp_defconfig
arm                          gemini_defconfig
arm                      tct_hammer_defconfig
sh                        sh7763rdp_defconfig
arm                            pleb_defconfig
arm                           sunxi_defconfig
powerpc                 mpc8540_ads_defconfig
arm                         assabet_defconfig
arm                  colibri_pxa270_defconfig
arm                       multi_v4t_defconfig
powerpc                      makalu_defconfig
sh                     magicpanelr2_defconfig
mips                        workpad_defconfig
arm                         socfpga_defconfig
sh                          rsk7269_defconfig
powerpc                          g5_defconfig
mips                           gcw0_defconfig
powerpc                    socrates_defconfig
powerpc                     ep8248e_defconfig
h8300                               defconfig
powerpc                    klondike_defconfig
arc                    vdk_hs38_smp_defconfig
sh                            shmin_defconfig
c6x                        evmc6474_defconfig
arm                         nhk8815_defconfig
m68k                          atari_defconfig
sh                          sdk7786_defconfig
arm                         palmz72_defconfig
mips                          ath79_defconfig
mips                           ip28_defconfig
sh                ecovec24-romimage_defconfig
sh                         ecovec24_defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20200920
x86_64               randconfig-a003-20200920
x86_64               randconfig-a004-20200920
x86_64               randconfig-a002-20200920
x86_64               randconfig-a006-20200920
x86_64               randconfig-a001-20200920
i386                 randconfig-a002-20200920
i386                 randconfig-a006-20200920
i386                 randconfig-a003-20200920
i386                 randconfig-a004-20200920
i386                 randconfig-a005-20200920
i386                 randconfig-a001-20200920
i386                 randconfig-a002-20200921
i386                 randconfig-a006-20200921
i386                 randconfig-a003-20200921
i386                 randconfig-a004-20200921
i386                 randconfig-a005-20200921
i386                 randconfig-a001-20200921
i386                 randconfig-a012-20200920
i386                 randconfig-a014-20200920
i386                 randconfig-a016-20200920
i386                 randconfig-a013-20200920
i386                 randconfig-a011-20200920
i386                 randconfig-a015-20200920
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
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20200920
x86_64               randconfig-a013-20200920
x86_64               randconfig-a014-20200920
x86_64               randconfig-a015-20200920
x86_64               randconfig-a012-20200920
x86_64               randconfig-a016-20200920

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
