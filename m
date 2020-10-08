Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571A028723E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 12:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgJHKKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 06:10:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:16099 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729210AbgJHKKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 06:10:05 -0400
IronPort-SDR: tsV/jE4TZ6pYvp1DWoX7Kdp0X4VKNuIrQ2F38Pr8REv7X/8Fq4sWGt29Nd3PRq8FJEZGmsYG4A
 FfC+c5SN4QrA==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="152227980"
X-IronPort-AV: E=Sophos;i="5.77,350,1596524400"; 
   d="scan'208";a="152227980"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 03:10:03 -0700
IronPort-SDR: I4MOMjdh2fQROgjgA1FsfZCwc80vfTzukfE9vNk8yu3tvUFYlSl6KIaJqM8awCgqjKwyuwhrnb
 Vne6fwT8jZ+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,350,1596524400"; 
   d="scan'208";a="349444877"
Received: from lkp-server02.sh.intel.com (HELO b5ae2f167493) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 08 Oct 2020 03:10:02 -0700
Received: from kbuild by b5ae2f167493 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kQSs5-00022j-Vm; Thu, 08 Oct 2020 10:10:01 +0000
Date:   Thu, 08 Oct 2020 18:09:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/pasid] BUILD SUCCESS
 7f5933f81bd85a0bf6a87d65c7327ea048a75e54
Message-ID: <5f7ee573.wheX8AuiDs5ebOD+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/pasid
branch HEAD: 7f5933f81bd85a0bf6a87d65c7327ea048a75e54  x86/asm: Add an enqcmds() wrapper for the ENQCMDS instruction

elapsed time: 722m

configs tested: 125
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         bigsur_defconfig
powerpc                       eiger_defconfig
mips                       rbtx49xx_defconfig
arm                           tegra_defconfig
powerpc                        icon_defconfig
mips                malta_qemu_32r6_defconfig
arm                        magician_defconfig
powerpc                     tqm8540_defconfig
arm                       omap2plus_defconfig
m68k                         apollo_defconfig
powerpc                          g5_defconfig
mips                          ath25_defconfig
arm                             pxa_defconfig
mips                           mtx1_defconfig
mips                          malta_defconfig
c6x                              allyesconfig
powerpc                      pmac32_defconfig
powerpc                  mpc885_ads_defconfig
arm                            qcom_defconfig
arm                             rpc_defconfig
c6x                              alldefconfig
arm                      integrator_defconfig
sh                        sh7757lcr_defconfig
h8300                       h8s-sim_defconfig
m68k                       m5249evb_defconfig
xtensa                    smp_lx200_defconfig
arm                        keystone_defconfig
mips                      pic32mzda_defconfig
mips                          rb532_defconfig
arm                         mv78xx0_defconfig
arm                         assabet_defconfig
powerpc                     tqm8548_defconfig
arm                       aspeed_g4_defconfig
arm                         hackkit_defconfig
powerpc                      pcm030_defconfig
arm                          gemini_defconfig
ia64                        generic_defconfig
arm                          tango4_defconfig
s390                       zfcpdump_defconfig
powerpc                       ebony_defconfig
arm                           h5000_defconfig
arm                        clps711x_defconfig
arm                          ep93xx_defconfig
h8300                               defconfig
sh                              ul2_defconfig
nds32                             allnoconfig
powerpc                      cm5200_defconfig
sh                   sh7770_generic_defconfig
arm                           spitz_defconfig
arm                          iop32x_defconfig
sh                          r7780mp_defconfig
microblaze                          defconfig
mips                           ip22_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201008
x86_64               randconfig-a003-20201008
x86_64               randconfig-a005-20201008
x86_64               randconfig-a001-20201008
x86_64               randconfig-a002-20201008
x86_64               randconfig-a006-20201008
i386                 randconfig-a006-20201008
i386                 randconfig-a005-20201008
i386                 randconfig-a001-20201008
i386                 randconfig-a004-20201008
i386                 randconfig-a002-20201008
i386                 randconfig-a003-20201008
i386                 randconfig-a015-20201008
i386                 randconfig-a013-20201008
i386                 randconfig-a014-20201008
i386                 randconfig-a016-20201008
i386                 randconfig-a011-20201008
i386                 randconfig-a012-20201008
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
x86_64               randconfig-a012-20201008
x86_64               randconfig-a015-20201008
x86_64               randconfig-a013-20201008
x86_64               randconfig-a014-20201008
x86_64               randconfig-a011-20201008
x86_64               randconfig-a016-20201008

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
