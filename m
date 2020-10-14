Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8DCD28D814
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 03:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388570AbgJNBmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 21:42:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:13062 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388515AbgJNBmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 21:42:49 -0400
IronPort-SDR: wk0tNOlYZTPU3a+D3DuioFKm1P+9J+Ang2exCc2NlhWjd0NdaV0lkNb1U2bKOll3S3V9anZDGm
 /ozQdW/Yl3BA==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="166076728"
X-IronPort-AV: E=Sophos;i="5.77,373,1596524400"; 
   d="scan'208";a="166076728"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 18:42:47 -0700
IronPort-SDR: Qsx9Ycne/ihuhW3OzWwtT4AnsNLFf5F1E4Nwr6O5GD+JA+jDqjm0oEzHi9oMdymZPtBvrQ8LP7
 QZ0whmzID9cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,373,1596524400"; 
   d="scan'208";a="318508422"
Received: from lkp-server02.sh.intel.com (HELO c57e4c60a28b) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Oct 2020 18:42:46 -0700
Received: from kbuild by c57e4c60a28b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kSVoT-00006d-Ci; Wed, 14 Oct 2020 01:42:45 +0000
Date:   Wed, 14 Oct 2020 09:41:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/asm] BUILD SUCCESS
 3e626682046e30282979f7d71e054cd4c00069a7
Message-ID: <5f865765.G0tlj0YmbCwiUyYA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/asm
branch HEAD: 3e626682046e30282979f7d71e054cd4c00069a7  x86/asm: Replace __force_order with a memory clobber

elapsed time: 724m

configs tested: 132
configs skipped: 84

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7206_defconfig
m68k                       m5249evb_defconfig
arc                            hsdk_defconfig
h8300                    h8300h-sim_defconfig
microblaze                    nommu_defconfig
sh                        sh7763rdp_defconfig
powerpc                     tqm8555_defconfig
powerpc                       eiger_defconfig
ia64                             alldefconfig
powerpc                     tqm5200_defconfig
arc                             nps_defconfig
arm                       versatile_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                  mpc866_ads_defconfig
sh                            titan_defconfig
arm                            hisi_defconfig
powerpc                     ppa8548_defconfig
parisc                              defconfig
powerpc                       holly_defconfig
mips                       capcella_defconfig
powerpc                      katmai_defconfig
arm                          iop32x_defconfig
arm                          pxa3xx_defconfig
sh                          rsk7203_defconfig
powerpc                      ep88xc_defconfig
powerpc                 linkstation_defconfig
arm                          pxa168_defconfig
sh                     magicpanelr2_defconfig
sh                               allmodconfig
sh                          sdk7786_defconfig
mips                      pistachio_defconfig
sh                        sh7785lcr_defconfig
sh                        edosk7705_defconfig
arm                         hackkit_defconfig
sh                         ap325rxa_defconfig
arm                           corgi_defconfig
arm                           h3600_defconfig
ia64                                defconfig
arm                        multi_v7_defconfig
powerpc                      mgcoge_defconfig
arm                              zx_defconfig
powerpc                   currituck_defconfig
xtensa                           alldefconfig
microblaze                      mmu_defconfig
arm                     davinci_all_defconfig
arm                            dove_defconfig
sh                             shx3_defconfig
arm                          lpd270_defconfig
xtensa                generic_kc705_defconfig
c6x                        evmc6474_defconfig
mips                        bcm63xx_defconfig
ia64                             allmodconfig
powerpc                 mpc8272_ads_defconfig
mips                        qi_lb60_defconfig
arm                           h5000_defconfig
powerpc                     tqm8540_defconfig
arm                        mini2440_defconfig
sparc                       sparc32_defconfig
powerpc                 mpc836x_mds_defconfig
arm                         bcm2835_defconfig
powerpc                      pasemi_defconfig
mips                       bmips_be_defconfig
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
x86_64               randconfig-a004-20201013
x86_64               randconfig-a002-20201013
x86_64               randconfig-a006-20201013
x86_64               randconfig-a001-20201013
x86_64               randconfig-a003-20201013
x86_64               randconfig-a005-20201013
i386                 randconfig-a005-20201013
i386                 randconfig-a006-20201013
i386                 randconfig-a001-20201013
i386                 randconfig-a003-20201013
i386                 randconfig-a004-20201013
i386                 randconfig-a002-20201013
i386                 randconfig-a016-20201013
i386                 randconfig-a015-20201013
i386                 randconfig-a013-20201013
i386                 randconfig-a012-20201013
i386                 randconfig-a011-20201013
i386                 randconfig-a014-20201013
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
x86_64               randconfig-a016-20201013
x86_64               randconfig-a015-20201013
x86_64               randconfig-a012-20201013
x86_64               randconfig-a013-20201013
x86_64               randconfig-a014-20201013
x86_64               randconfig-a011-20201013

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
