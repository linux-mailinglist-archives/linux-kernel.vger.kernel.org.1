Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86FD528B1D8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 11:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgJLJ5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 05:57:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:38446 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgJLJ5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 05:57:30 -0400
IronPort-SDR: yN5dw3Iqta6C/7JXH0Ri/RjOZU192g5usfK8KC3VJkru4yCpnLr4G1GaxAtKkx6LZEj4VMOPPG
 DW9olwRC5oPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="163077319"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="163077319"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 02:57:24 -0700
IronPort-SDR: chQnRpzWQmAyvspHN7Fjvxro/uryDYgXMqscs4uy/8XlySR6zuc262Fula1VxvklXRkfOCQH2+
 3bZk+utPWe4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="317869596"
Received: from lkp-server02.sh.intel.com (HELO c41e9df04563) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 12 Oct 2020 02:57:23 -0700
Received: from kbuild by c41e9df04563 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kRua2-00004N-O7; Mon, 12 Oct 2020 09:57:22 +0000
Date:   Mon, 12 Oct 2020 17:56:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 863bae1fbcfa0420e5f51389218a9532542aa00f
Message-ID: <5f842850.gWtDZT/Fezm5ygj2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  irq/core
branch HEAD: 863bae1fbcfa0420e5f51389218a9532542aa00f  Merge tag 'irqchip-5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

elapsed time: 721m

configs tested: 109
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     tqm8541_defconfig
mips                        jmr3927_defconfig
m68k                       bvme6000_defconfig
arc                             nps_defconfig
arm                          tango4_defconfig
mips                      maltasmvp_defconfig
i386                             allyesconfig
sh                           se7206_defconfig
powerpc                     tqm5200_defconfig
mips                         bigsur_defconfig
mips                       bmips_be_defconfig
um                            kunit_defconfig
arm                           stm32_defconfig
xtensa                    smp_lx200_defconfig
x86_64                           alldefconfig
arm                            xcep_defconfig
xtensa                              defconfig
riscv                    nommu_k210_defconfig
sh                          rsk7269_defconfig
riscv                            allmodconfig
s390                                defconfig
arc                      axs103_smp_defconfig
powerpc                 linkstation_defconfig
mips                    maltaup_xpa_defconfig
i386                                defconfig
sh                        sh7785lcr_defconfig
arc                     nsimosci_hs_defconfig
powerpc                mpc7448_hpc2_defconfig
sh                           sh2007_defconfig
arm                          imote2_defconfig
arm                         ebsa110_defconfig
arm                        vexpress_defconfig
arm                          badge4_defconfig
mips                          ath79_defconfig
mips                        omega2p_defconfig
c6x                         dsk6455_defconfig
arm                         lubbock_defconfig
arm                       multi_v4t_defconfig
powerpc                 mpc837x_mds_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20201012
i386                 randconfig-a006-20201012
i386                 randconfig-a001-20201012
i386                 randconfig-a003-20201012
i386                 randconfig-a004-20201012
i386                 randconfig-a002-20201012
x86_64               randconfig-a016-20201012
x86_64               randconfig-a015-20201012
x86_64               randconfig-a012-20201012
x86_64               randconfig-a013-20201012
x86_64               randconfig-a014-20201012
x86_64               randconfig-a011-20201012
i386                 randconfig-a016-20201012
i386                 randconfig-a015-20201012
i386                 randconfig-a013-20201012
i386                 randconfig-a012-20201012
i386                 randconfig-a011-20201012
i386                 randconfig-a014-20201012
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201012
x86_64               randconfig-a002-20201012
x86_64               randconfig-a006-20201012
x86_64               randconfig-a001-20201012
x86_64               randconfig-a003-20201012
x86_64               randconfig-a005-20201012

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
