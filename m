Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E592CF924
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 04:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgLEDM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 22:12:27 -0500
Received: from mga11.intel.com ([192.55.52.93]:59765 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbgLEDM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 22:12:27 -0500
IronPort-SDR: Mpx1WWz7+EUDSifvUVXUe2eooajfR3HYUbvjkC0iFuYc8vRXALTtjXojXXpgBaZbsQ+75/v4ro
 O6zt5ATpikEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9825"; a="169973565"
X-IronPort-AV: E=Sophos;i="5.78,394,1599548400"; 
   d="scan'208";a="169973565"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 19:11:46 -0800
IronPort-SDR: IXiFbpPUTVP87hR2zzws49LwhqwVjXSJ8GDJayYHPaN+uj7+DmcA0vOvNKjTrfKBS8eHPnbK3C
 7YISecs8E2KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,394,1599548400"; 
   d="scan'208";a="435993878"
Received: from lkp-server01.sh.intel.com (HELO 47754f1311fc) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 04 Dec 2020 19:11:45 -0800
Received: from kbuild by 47754f1311fc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1klNz6-00003s-ON; Sat, 05 Dec 2020 03:11:44 +0000
Date:   Sat, 05 Dec 2020 11:11:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 46a4ad7814fa39971aa6549b30c1a08d5c2ec65f
Message-ID: <5fcafa6b.tQ7UW5nrYBVxITRx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: 46a4ad7814fa39971aa6549b30c1a08d5c2ec65f  x86/sev-es: Use new for_each_insn_prefix() macro to loop over prefixes bytes

elapsed time: 725m

configs tested: 135
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
nios2                            alldefconfig
arc                        vdk_hs38_defconfig
powerpc                      cm5200_defconfig
arm                          tango4_defconfig
mips                 decstation_r4k_defconfig
m68k                          amiga_defconfig
sh                          r7785rp_defconfig
sh                         microdev_defconfig
m68k                       m5275evb_defconfig
arm                        shmobile_defconfig
um                           x86_64_defconfig
ia64                          tiger_defconfig
arm                         mv78xx0_defconfig
ia64                            zx1_defconfig
nios2                            allyesconfig
parisc                generic-64bit_defconfig
powerpc                     sbc8548_defconfig
powerpc                     skiroot_defconfig
sh                          lboxre2_defconfig
powerpc                      ep88xc_defconfig
arm                         bcm2835_defconfig
powerpc                      acadia_defconfig
arm                         assabet_defconfig
arc                     haps_hs_smp_defconfig
arm                       netwinder_defconfig
arm                          iop32x_defconfig
ia64                             allyesconfig
arm                          collie_defconfig
mips                         cobalt_defconfig
powerpc                   motionpro_defconfig
mips                           jazz_defconfig
powerpc                        cell_defconfig
ia64                             alldefconfig
arm                       aspeed_g4_defconfig
arm                         hackkit_defconfig
sparc                       sparc64_defconfig
powerpc                         wii_defconfig
arm                       versatile_defconfig
arc                     nsimosci_hs_defconfig
arm                          pxa3xx_defconfig
openrisc                         alldefconfig
powerpc                      mgcoge_defconfig
arm                         s3c2410_defconfig
openrisc                    or1ksim_defconfig
mips                  maltasmvp_eva_defconfig
arm                        trizeps4_defconfig
arm                        spear3xx_defconfig
mips                         tb0219_defconfig
arm                          prima2_defconfig
sh                            titan_defconfig
powerpc                       eiger_defconfig
powerpc                    amigaone_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                 mpc8272_ads_defconfig
sh                             espt_defconfig
arm                         vf610m4_defconfig
arm                        multi_v5_defconfig
arm                         nhk8815_defconfig
m68k                        m5307c3_defconfig
arm                      tct_hammer_defconfig
m68k                       bvme6000_defconfig
arm                        keystone_defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                                defconfig
s390                             allyesconfig
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
x86_64               randconfig-a004-20201204
x86_64               randconfig-a006-20201204
x86_64               randconfig-a002-20201204
x86_64               randconfig-a001-20201204
x86_64               randconfig-a005-20201204
x86_64               randconfig-a003-20201204
i386                 randconfig-a005-20201204
i386                 randconfig-a004-20201204
i386                 randconfig-a001-20201204
i386                 randconfig-a002-20201204
i386                 randconfig-a006-20201204
i386                 randconfig-a003-20201204
i386                 randconfig-a014-20201204
i386                 randconfig-a013-20201204
i386                 randconfig-a011-20201204
i386                 randconfig-a015-20201204
i386                 randconfig-a012-20201204
i386                 randconfig-a016-20201204
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-a016-20201204
x86_64               randconfig-a012-20201204
x86_64               randconfig-a014-20201204
x86_64               randconfig-a013-20201204
x86_64               randconfig-a015-20201204
x86_64               randconfig-a011-20201204

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
