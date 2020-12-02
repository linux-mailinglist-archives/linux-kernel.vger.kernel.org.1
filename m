Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC422CC9A1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 23:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgLBWbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 17:31:51 -0500
Received: from mga14.intel.com ([192.55.52.115]:60418 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgLBWbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 17:31:51 -0500
IronPort-SDR: kcK2lppwxtTZ+XQpnNpcNAnqBmiGNwXX3nB8dob33d8BNNjkVjU3CuUne2o/Mcs0Sg5Z5hBnPf
 AKOiYBW721FA==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="172317796"
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="172317796"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 14:31:10 -0800
IronPort-SDR: Pt/h9M1ujttWPD/OYAP1QBo8m7qT8eure8EPO8fO1v9NT1OYrMj63n9uhCkpQnI/uFu89a9bf4
 D+Sde18kcgFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,387,1599548400"; 
   d="scan'208";a="373322431"
Received: from lkp-server01.sh.intel.com (HELO 54133fc185c3) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 02 Dec 2020 14:31:09 -0800
Received: from kbuild by 54133fc185c3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kkaeS-0000NI-IS; Wed, 02 Dec 2020 22:31:08 +0000
Date:   Thu, 03 Dec 2020 06:30:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/apic] BUILD SUCCESS
 26ab12bb9d96133b7880141d68b5e01a8783de9d
Message-ID: <5fc81571.jDhXEbQSMEAft89s%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/apic
branch HEAD: 26ab12bb9d96133b7880141d68b5e01a8783de9d  iommu/hyper-v: Remove I/O-APIC ID check from hyperv_irq_remapping_select()

elapsed time: 722m

configs tested: 178
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
arm64                               defconfig
sh                           se7206_defconfig
sh                          sdk7786_defconfig
sparc64                          alldefconfig
arm                          exynos_defconfig
mips                           ip32_defconfig
mips                      loongson3_defconfig
powerpc                  mpc885_ads_defconfig
arm                           stm32_defconfig
powerpc                      pmac32_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                      fuloong2e_defconfig
arm                        spear6xx_defconfig
m68k                        m5407c3_defconfig
powerpc                      ppc64e_defconfig
arm                   milbeaut_m10v_defconfig
arm                  colibri_pxa300_defconfig
powerpc                      chrp32_defconfig
sh                          urquell_defconfig
arm                            mmp2_defconfig
mips                            gpr_defconfig
m68k                       m5249evb_defconfig
arm                             rpc_defconfig
arm                           sunxi_defconfig
arm                              alldefconfig
arm                        clps711x_defconfig
arm                        shmobile_defconfig
powerpc64                        alldefconfig
mips                 decstation_r4k_defconfig
s390                       zfcpdump_defconfig
xtensa                generic_kc705_defconfig
powerpc                    klondike_defconfig
mips                     loongson1c_defconfig
arc                        nsimosci_defconfig
arm                           u8500_defconfig
m68k                            mac_defconfig
x86_64                              defconfig
sh                          rsk7264_defconfig
powerpc                        fsp2_defconfig
sh                             shx3_defconfig
sh                        sh7785lcr_defconfig
mips                           gcw0_defconfig
xtensa                         virt_defconfig
c6x                        evmc6678_defconfig
arm                        realview_defconfig
arm                         s3c6400_defconfig
sparc                               defconfig
powerpc                     sequoia_defconfig
powerpc                 canyonlands_defconfig
arm                         nhk8815_defconfig
parisc                           alldefconfig
arm                      tct_hammer_defconfig
arm                        spear3xx_defconfig
m68k                          atari_defconfig
mips                        maltaup_defconfig
xtensa                       common_defconfig
sh                            migor_defconfig
mips                         tb0287_defconfig
m68k                          hp300_defconfig
mips                     cu1830-neo_defconfig
sh                           se7343_defconfig
arm                            u300_defconfig
mips                         rt305x_defconfig
sh                 kfr2r09-romimage_defconfig
arm                       cns3420vb_defconfig
m68k                       m5275evb_defconfig
microblaze                    nommu_defconfig
arm                       mainstone_defconfig
m68k                            q40_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                ecovec24-romimage_defconfig
mips                        nlm_xlr_defconfig
arc                     nsimosci_hs_defconfig
arc                        vdk_hs38_defconfig
arc                        nsim_700_defconfig
arm                        neponset_defconfig
arm                         lpc18xx_defconfig
nios2                         10m50_defconfig
mips                       lemote2f_defconfig
arm                        mvebu_v5_defconfig
sparc                            alldefconfig
xtensa                  audio_kc705_defconfig
sh                           sh2007_defconfig
sh                     sh7710voipgw_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                           jazz_defconfig
arc                         haps_hs_defconfig
m68k                       bvme6000_defconfig
sh                        dreamcast_defconfig
powerpc                 mpc8272_ads_defconfig
mips                         bigsur_defconfig
arm                          prima2_defconfig
arc                           tb10x_defconfig
m68k                                defconfig
powerpc                     akebono_defconfig
arm                     eseries_pxa_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201202
x86_64               randconfig-a006-20201202
x86_64               randconfig-a001-20201202
x86_64               randconfig-a002-20201202
x86_64               randconfig-a005-20201202
x86_64               randconfig-a003-20201202
i386                 randconfig-a004-20201202
i386                 randconfig-a005-20201202
i386                 randconfig-a001-20201202
i386                 randconfig-a002-20201202
i386                 randconfig-a006-20201202
i386                 randconfig-a003-20201202
i386                 randconfig-a004-20201201
i386                 randconfig-a005-20201201
i386                 randconfig-a001-20201201
i386                 randconfig-a002-20201201
i386                 randconfig-a006-20201201
i386                 randconfig-a003-20201201
i386                 randconfig-a014-20201202
i386                 randconfig-a013-20201202
i386                 randconfig-a011-20201202
i386                 randconfig-a015-20201202
i386                 randconfig-a012-20201202
i386                 randconfig-a016-20201202
i386                 randconfig-a014-20201201
i386                 randconfig-a013-20201201
i386                 randconfig-a011-20201201
i386                 randconfig-a015-20201201
i386                 randconfig-a012-20201201
i386                 randconfig-a016-20201201
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a016-20201202
x86_64               randconfig-a012-20201202
x86_64               randconfig-a014-20201202
x86_64               randconfig-a013-20201202
x86_64               randconfig-a015-20201202
x86_64               randconfig-a011-20201202

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
