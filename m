Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6FD2AFF76
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgKLFcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:32:52 -0500
Received: from mga03.intel.com ([134.134.136.65]:44044 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729288AbgKLBm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 20:42:27 -0500
IronPort-SDR: 5U1n4Z1RV5Va0E91oenzoPLxYPfSc69ZYhgCFVv7UIYrFCWYj9dCeC8oSNaUxrb1lGc9+1xRtu
 sge0bhVTSsOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="170352446"
X-IronPort-AV: E=Sophos;i="5.77,471,1596524400"; 
   d="scan'208";a="170352446"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 17:42:19 -0800
IronPort-SDR: GG0yaUkINO188xdZhO6yc27GzSD+biRtha5XOw7f75GHTB7pXiT4KJW+B3IhNmmeS6qq//Vm1W
 07kzXoOXmIuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,471,1596524400"; 
   d="scan'208";a="474078109"
Received: from lkp-server02.sh.intel.com (HELO de5c6a867800) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 11 Nov 2020 17:42:17 -0800
Received: from kbuild by de5c6a867800 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kd1cu-00001c-PB; Thu, 12 Nov 2020 01:42:16 +0000
Date:   Thu, 12 Nov 2020 09:41:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 b2896458b850ec7cb69b054b195b4b399f7e1f22
Message-ID: <5fac92e7.AJwLQ0Pnl5Kfu/S2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: b2896458b850ec7cb69b054b195b4b399f7e1f22  x86/platform/uv: Drop last traces of uv_flush_tlb_others

elapsed time: 725m

configs tested: 126
configs skipped: 60

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
riscv                            alldefconfig
ia64                          tiger_defconfig
m68k                         amcore_defconfig
arm                     am200epdkit_defconfig
powerpc                     tqm8548_defconfig
sh                           se7206_defconfig
arm                            qcom_defconfig
sh                            titan_defconfig
arm                        mini2440_defconfig
powerpc                     mpc512x_defconfig
sh                          lboxre2_defconfig
powerpc                     mpc5200_defconfig
arm                       aspeed_g4_defconfig
mips                        workpad_defconfig
sh                           se7712_defconfig
um                            kunit_defconfig
um                           x86_64_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                         tb0226_defconfig
sh                             shx3_defconfig
m68k                        m5307c3_defconfig
c6x                                 defconfig
sh                   secureedge5410_defconfig
mips                      pistachio_defconfig
ia64                      gensparse_defconfig
powerpc                     tqm8560_defconfig
riscv                    nommu_k210_defconfig
powerpc                       ebony_defconfig
sh                               allmodconfig
ia64                            zx1_defconfig
xtensa                  nommu_kc705_defconfig
sh                             sh03_defconfig
sh                         microdev_defconfig
arm                   milbeaut_m10v_defconfig
arm                         nhk8815_defconfig
arm                          moxart_defconfig
powerpc                     ep8248e_defconfig
powerpc                   currituck_defconfig
powerpc                 mpc837x_mds_defconfig
m68k                           sun3_defconfig
c6x                        evmc6474_defconfig
powerpc                    socrates_defconfig
sh                           se7751_defconfig
powerpc                      walnut_defconfig
sh                        dreamcast_defconfig
arm                        multi_v7_defconfig
sh                           se7705_defconfig
arm                          collie_defconfig
mips                         cobalt_defconfig
arm                      tct_hammer_defconfig
mips                     decstation_defconfig
arm                          ixp4xx_defconfig
sh                               j2_defconfig
mips                malta_qemu_32r6_defconfig
mips                   sb1250_swarm_defconfig
m68k                          hp300_defconfig
arm                         socfpga_defconfig
m68k                          sun3x_defconfig
sh                     magicpanelr2_defconfig
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
i386                 randconfig-a006-20201111
i386                 randconfig-a005-20201111
i386                 randconfig-a002-20201111
i386                 randconfig-a001-20201111
i386                 randconfig-a003-20201111
i386                 randconfig-a004-20201111
x86_64               randconfig-a015-20201111
x86_64               randconfig-a011-20201111
x86_64               randconfig-a014-20201111
x86_64               randconfig-a013-20201111
x86_64               randconfig-a016-20201111
x86_64               randconfig-a012-20201111
i386                 randconfig-a012-20201111
i386                 randconfig-a014-20201111
i386                 randconfig-a016-20201111
i386                 randconfig-a011-20201111
i386                 randconfig-a015-20201111
i386                 randconfig-a013-20201111
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel

clang tested configs:
x86_64               randconfig-a003-20201111
x86_64               randconfig-a005-20201111
x86_64               randconfig-a004-20201111
x86_64               randconfig-a002-20201111
x86_64               randconfig-a006-20201111
x86_64               randconfig-a001-20201111

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
