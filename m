Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6ED289126
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 20:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388430AbgJISfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 14:35:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:34539 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390444AbgJISdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 14:33:00 -0400
IronPort-SDR: w5GTKjaVf4dLaVY3Y8m55HlQhrSBEtd2qstzeBZsslM+Rz8+tytnZ3Xsz2Yi7yg18ejQ8CqMQB
 AK+LOTYuL6Jw==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="162060802"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="162060802"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 11:32:59 -0700
IronPort-SDR: yZXJf3oCmwAj4Z47bBPhK287xdpXXW35jNQwBfwR2VishkrZYF1Jn6uYOM6WQJ/Fy3eRI51sB9
 F6qQn4nFM1Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="518780130"
Received: from lkp-server02.sh.intel.com (HELO 80eb06af76cf) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 09 Oct 2020 11:32:58 -0700
Received: from kbuild by 80eb06af76cf with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kQx7U-0000g1-JE; Fri, 09 Oct 2020 18:27:56 +0000
Date:   Sat, 10 Oct 2020 02:27:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 6d6b8b9f4fceab7266ca03d194f60ec72bd4b654
Message-ID: <5f80ab88.R6fNWEP5ay26wud3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  perf/urgent
branch HEAD: 6d6b8b9f4fceab7266ca03d194f60ec72bd4b654  perf: Fix task_function_call() error handling

elapsed time: 724m

configs tested: 147
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                    nommu_virt_defconfig
powerpc                      katmai_defconfig
mips                      loongson3_defconfig
s390                                defconfig
arm                            lart_defconfig
m68k                          atari_defconfig
powerpc                     pseries_defconfig
mips                       rbtx49xx_defconfig
arc                     nsimosci_hs_defconfig
sh                        sh7757lcr_defconfig
m68k                          hp300_defconfig
arc                    vdk_hs38_smp_defconfig
sparc64                          alldefconfig
arm                     am200epdkit_defconfig
arm                        magician_defconfig
powerpc                      ppc44x_defconfig
i386                             allyesconfig
arm                           corgi_defconfig
arc                      axs103_smp_defconfig
arm                         s3c6400_defconfig
arm                           efm32_defconfig
powerpc                 mpc8560_ads_defconfig
arm                             rpc_defconfig
m68k                          sun3x_defconfig
mips                      pistachio_defconfig
powerpc                   motionpro_defconfig
sparc64                             defconfig
arc                        nsim_700_defconfig
arm                        multi_v7_defconfig
sh                           se7724_defconfig
arm                       aspeed_g5_defconfig
sh                           sh2007_defconfig
sh                        sh7785lcr_defconfig
sh                   rts7751r2dplus_defconfig
arm                         cm_x300_defconfig
powerpc                      walnut_defconfig
mips                     loongson1b_defconfig
powerpc                      obs600_defconfig
riscv                               defconfig
sh                             shx3_defconfig
arm                       spear13xx_defconfig
mips                 decstation_r4k_defconfig
mips                           gcw0_defconfig
nios2                         3c120_defconfig
sh                          rsk7203_defconfig
powerpc                 mpc832x_mds_defconfig
sh                        dreamcast_defconfig
xtensa                              defconfig
arm                       mainstone_defconfig
powerpc                     tqm5200_defconfig
um                             i386_defconfig
openrisc                 simple_smp_defconfig
sh                        edosk7705_defconfig
powerpc                      pcm030_defconfig
xtensa                    xip_kc705_defconfig
arm                          pcm027_defconfig
sh                         microdev_defconfig
arm                        mvebu_v5_defconfig
arm                            xcep_defconfig
parisc                generic-32bit_defconfig
microblaze                    nommu_defconfig
sh                 kfr2r09-romimage_defconfig
mips                      pic32mzda_defconfig
arc                            hsdk_defconfig
arm                          lpd270_defconfig
arc                        vdk_hs38_defconfig
sh                   secureedge5410_defconfig
arm                        trizeps4_defconfig
arm                         nhk8815_defconfig
mips                           ip28_defconfig
powerpc                     powernv_defconfig
m68k                         apollo_defconfig
arm                         mv78xx0_defconfig
h8300                     edosk2674_defconfig
sh                             espt_defconfig
arm                   milbeaut_m10v_defconfig
mips                    maltaup_xpa_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201009
i386                 randconfig-a005-20201009
i386                 randconfig-a001-20201009
i386                 randconfig-a004-20201009
i386                 randconfig-a002-20201009
i386                 randconfig-a003-20201009
x86_64               randconfig-a012-20201009
x86_64               randconfig-a015-20201009
x86_64               randconfig-a013-20201009
x86_64               randconfig-a014-20201009
x86_64               randconfig-a011-20201009
x86_64               randconfig-a016-20201009
i386                 randconfig-a015-20201009
i386                 randconfig-a013-20201009
i386                 randconfig-a014-20201009
i386                 randconfig-a016-20201009
i386                 randconfig-a011-20201009
i386                 randconfig-a012-20201009
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201009
x86_64               randconfig-a003-20201009
x86_64               randconfig-a005-20201009
x86_64               randconfig-a001-20201009
x86_64               randconfig-a002-20201009
x86_64               randconfig-a006-20201009

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
