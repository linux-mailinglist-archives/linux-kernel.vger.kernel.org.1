Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CF729365F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 10:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733103AbgJTIGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 04:06:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:46479 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728482AbgJTIGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 04:06:24 -0400
IronPort-SDR: +D6pdKZ1DIHg8QgdNz5p07aAe5t5erDSCSVWMtYRifO7Wdble9bhPm/68hJE+iI4AtfkzWApjC
 LQXiqMfblH/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="228804721"
X-IronPort-AV: E=Sophos;i="5.77,396,1596524400"; 
   d="scan'208";a="228804721"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 01:06:22 -0700
IronPort-SDR: uK1onFztEA2uYJUP7iR4YaP8lMPlLnI5s9LpP/odKdQKjYoNGCmKOkB8RJtapUSpKlqWFihKf4
 ruSyGpcEyfOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,396,1596524400"; 
   d="scan'208";a="358439980"
Received: from lkp-server02.sh.intel.com (HELO 5d721fc6b6d3) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Oct 2020 01:06:21 -0700
Received: from kbuild by 5d721fc6b6d3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kUmez-00000n-1W; Tue, 20 Oct 2020 08:06:21 +0000
Date:   Tue, 20 Oct 2020 16:06:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/seves] BUILD SUCCESS
 b17a45b6e53f6613118b2e5cfc4a992cc50deb2c
Message-ID: <5f8e9a7a.aiL5BbTqINJQbjRH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/seves
branch HEAD: b17a45b6e53f6613118b2e5cfc4a992cc50deb2c  x86/boot/64: Explicitly map boot_params and command line

elapsed time: 721m

configs tested: 114
configs skipped: 59

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nds32                            alldefconfig
c6x                        evmc6457_defconfig
powerpc                     redwood_defconfig
parisc                generic-32bit_defconfig
arm                     am200epdkit_defconfig
mips                malta_qemu_32r6_defconfig
riscv                    nommu_virt_defconfig
mips                  decstation_64_defconfig
powerpc                 mpc837x_mds_defconfig
m68k                             allmodconfig
nios2                         3c120_defconfig
mips                      malta_kvm_defconfig
arm                           sama5_defconfig
sh                            migor_defconfig
powerpc                      makalu_defconfig
sh                         ap325rxa_defconfig
arm                          moxart_defconfig
powerpc                      pasemi_defconfig
um                             i386_defconfig
arm                             rpc_defconfig
mips                            e55_defconfig
mips                         tb0287_defconfig
arm                            hisi_defconfig
arm                          badge4_defconfig
h8300                            alldefconfig
alpha                            alldefconfig
arm                          pcm027_defconfig
sh                            shmin_defconfig
mips                       lemote2f_defconfig
arm                           sunxi_defconfig
arm                           efm32_defconfig
powerpc                    amigaone_defconfig
powerpc                     powernv_defconfig
sh                               j2_defconfig
mips                         tb0226_defconfig
powerpc                         ps3_defconfig
sh                          rsk7269_defconfig
arm                        mvebu_v7_defconfig
m68k                        mvme147_defconfig
arc                              allyesconfig
arm                  colibri_pxa300_defconfig
powerpc                    ge_imp3a_defconfig
mips                             allmodconfig
mips                         mpc30x_defconfig
alpha                               defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
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
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201019
x86_64               randconfig-a002-20201019
x86_64               randconfig-a006-20201019
x86_64               randconfig-a003-20201019
x86_64               randconfig-a005-20201019
x86_64               randconfig-a001-20201019
i386                 randconfig-a006-20201019
i386                 randconfig-a005-20201019
i386                 randconfig-a001-20201019
i386                 randconfig-a003-20201019
i386                 randconfig-a004-20201019
i386                 randconfig-a002-20201019
i386                 randconfig-a015-20201019
i386                 randconfig-a013-20201019
i386                 randconfig-a016-20201019
i386                 randconfig-a012-20201019
i386                 randconfig-a011-20201019
i386                 randconfig-a014-20201019
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
x86_64               randconfig-a016-20201019
x86_64               randconfig-a015-20201019
x86_64               randconfig-a012-20201019
x86_64               randconfig-a013-20201019
x86_64               randconfig-a011-20201019
x86_64               randconfig-a014-20201019

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
