Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676B82BA17D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 05:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgKTEeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 23:34:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:51373 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgKTEeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 23:34:46 -0500
IronPort-SDR: UE8AGGKFSshksIQbEdULVI5RdE2oOW0Gahu3SmFwMCPGaWzS8IDJ2g+jQS+6yBMvMplrtWDBnU
 +qFAGUWOAIyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="151261299"
X-IronPort-AV: E=Sophos;i="5.78,355,1599548400"; 
   d="scan'208";a="151261299"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 20:34:45 -0800
IronPort-SDR: hrhPEMdzszq0tXfOTztxrETTJ7wyOiHcWGB79YmCD5HrYNd47D7cn1YnZGXyp3WjjpDzlYLGAN
 3l0M9e3t8rcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,355,1599548400"; 
   d="scan'208";a="326225207"
Received: from lkp-server01.sh.intel.com (HELO f63bb96ba247) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 19 Nov 2020 20:34:42 -0800
Received: from kbuild by f63bb96ba247 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kfy89-00000M-FB; Fri, 20 Nov 2020 04:34:41 +0000
Date:   Fri, 20 Nov 2020 12:34:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:for-next/kspp] BUILD SUCCESS
 36f9ff9e03de89691274a6aec45aa079bd3ae405
Message-ID: <5fb74742.c/3oCoTQ3O3wElNI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  for-next/kspp
branch HEAD: 36f9ff9e03de89691274a6aec45aa079bd3ae405  lib: Fix fall-through warnings for Clang

elapsed time: 724m

configs tested: 123
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     mpc5200_defconfig
arm                     davinci_all_defconfig
arm                         hackkit_defconfig
sparc                       sparc64_defconfig
m68k                        mvme147_defconfig
xtensa                           alldefconfig
powerpc                      obs600_defconfig
m68k                          atari_defconfig
sh                           se7712_defconfig
arm                       multi_v4t_defconfig
mips                        omega2p_defconfig
mips                       bmips_be_defconfig
riscv                             allnoconfig
sh                           sh2007_defconfig
h8300                               defconfig
arm                          pxa910_defconfig
powerpc                     akebono_defconfig
arm                          moxart_defconfig
arc                        nsim_700_defconfig
mips                       capcella_defconfig
powerpc                     tqm8548_defconfig
mips                     cu1830-neo_defconfig
arm                         bcm2835_defconfig
mips                          rm200_defconfig
powerpc                     rainier_defconfig
powerpc                     tqm8540_defconfig
arm                        trizeps4_defconfig
powerpc                     powernv_defconfig
m68k                          sun3x_defconfig
arm                          exynos_defconfig
mips                      pistachio_defconfig
mips                        nlm_xlp_defconfig
arm                            zeus_defconfig
parisc                              defconfig
mips                     cu1000-neo_defconfig
arm                          pcm027_defconfig
arm                     am200epdkit_defconfig
sh                           se7721_defconfig
powerpc                 mpc836x_rdk_defconfig
h8300                     edosk2674_defconfig
powerpc                  storcenter_defconfig
mips                           ip27_defconfig
powerpc                    gamecube_defconfig
mips                      bmips_stb_defconfig
sh                            titan_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                  mpc866_ads_defconfig
arm                          badge4_defconfig
s390                                defconfig
arc                         haps_hs_defconfig
arm                         s5pv210_defconfig
powerpc                       eiger_defconfig
powerpc                           allnoconfig
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
s390                             allyesconfig
parisc                           allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a006-20201119
i386                 randconfig-a005-20201119
i386                 randconfig-a002-20201119
i386                 randconfig-a001-20201119
i386                 randconfig-a003-20201119
i386                 randconfig-a004-20201119
x86_64               randconfig-a015-20201119
x86_64               randconfig-a014-20201119
x86_64               randconfig-a011-20201119
x86_64               randconfig-a013-20201119
x86_64               randconfig-a016-20201119
x86_64               randconfig-a012-20201119
i386                 randconfig-a012-20201119
i386                 randconfig-a014-20201119
i386                 randconfig-a016-20201119
i386                 randconfig-a011-20201119
i386                 randconfig-a013-20201119
i386                 randconfig-a015-20201119
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-a005-20201119
x86_64               randconfig-a003-20201119
x86_64               randconfig-a004-20201119
x86_64               randconfig-a002-20201119
x86_64               randconfig-a006-20201119
x86_64               randconfig-a001-20201119

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
