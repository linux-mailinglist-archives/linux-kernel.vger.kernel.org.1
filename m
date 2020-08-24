Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268C525071E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 20:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgHXSHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 14:07:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:2300 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgHXSHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 14:07:30 -0400
IronPort-SDR: 6qJRLuPHEX/CrQA8D/HwI/xiFU3lt+Uz81gM4nWg5HMuRErDwMFqNdToJ0e/mRW8obH2nkIicE
 nfaE0utWvn7w==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="174004217"
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="174004217"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 11:07:28 -0700
IronPort-SDR: VV8A1511vCngjUeNQoS1pNZEaXHC9S7d/52jf69/7B4je4sPfMoGBr6opv9Ki7AT4kFCMmtjQ8
 bUIWO2/SP9vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="328585726"
Received: from lkp-server01.sh.intel.com (HELO c420d4f0765f) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 24 Aug 2020 11:07:26 -0700
Received: from kbuild by c420d4f0765f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kAGsQ-0000JK-59; Mon, 24 Aug 2020 18:07:26 +0000
Date:   Tue, 25 Aug 2020 02:07:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 21f294e9c2da915d0cebb747f64e2c08b24fbd93
Message-ID: <5f4401d8.GLmbsIHHix1JT5lb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 21f294e9c2da915d0cebb747f64e2c08b24fbd93  Merge branch 'perf/core'

elapsed time: 721m

configs tested: 124
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      tqm8xx_defconfig
nios2                         10m50_defconfig
m68k                        m5407c3_defconfig
powerpc                          g5_defconfig
arm                    vt8500_v6_v7_defconfig
sh                           se7206_defconfig
arm                       imx_v6_v7_defconfig
ia64                            zx1_defconfig
m68k                                defconfig
sh                     magicpanelr2_defconfig
mips                           jazz_defconfig
c6x                         dsk6455_defconfig
arm                         lpc32xx_defconfig
arm                      integrator_defconfig
arm                           sunxi_defconfig
xtensa                         virt_defconfig
powerpc                      mgcoge_defconfig
ia64                          tiger_defconfig
sh                        dreamcast_defconfig
xtensa                           alldefconfig
mips                     loongson1b_defconfig
m68k                             allmodconfig
arm                         mv78xx0_defconfig
sh                          landisk_defconfig
powerpc                     ep8248e_defconfig
mips                       rbtx49xx_defconfig
m68k                           sun3_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                     mpc5200_defconfig
mips                     cu1830-neo_defconfig
sh                 kfr2r09-romimage_defconfig
c6x                        evmc6678_defconfig
arm                        mvebu_v7_defconfig
h8300                            alldefconfig
sh                          polaris_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                     mpc83xx_defconfig
mips                      loongson3_defconfig
arm                            zeus_defconfig
arm                              zx_defconfig
arc                              alldefconfig
arm                          badge4_defconfig
sh                          sdk7780_defconfig
sh                          r7785rp_defconfig
arm                             rpc_defconfig
h8300                    h8300h-sim_defconfig
powerpc                         ps3_defconfig
riscv                    nommu_k210_defconfig
arc                        nsimosci_defconfig
sh                           se7721_defconfig
sparc                               defconfig
m68k                            q40_defconfig
arm                           stm32_defconfig
x86_64                           alldefconfig
sparc                       sparc64_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
powerpc                             defconfig
i386                 randconfig-a002-20200823
i386                 randconfig-a004-20200823
i386                 randconfig-a003-20200823
i386                 randconfig-a005-20200823
i386                 randconfig-a006-20200823
i386                 randconfig-a001-20200823
i386                 randconfig-a002-20200824
i386                 randconfig-a004-20200824
i386                 randconfig-a005-20200824
i386                 randconfig-a003-20200824
i386                 randconfig-a006-20200824
i386                 randconfig-a001-20200824
x86_64               randconfig-a015-20200824
x86_64               randconfig-a016-20200824
x86_64               randconfig-a012-20200824
x86_64               randconfig-a014-20200824
x86_64               randconfig-a011-20200824
x86_64               randconfig-a013-20200824
i386                 randconfig-a013-20200824
i386                 randconfig-a012-20200824
i386                 randconfig-a011-20200824
i386                 randconfig-a016-20200824
i386                 randconfig-a015-20200824
i386                 randconfig-a014-20200824
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
