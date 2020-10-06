Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E15284A34
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 12:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgJFKNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 06:13:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:54366 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJFKNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 06:13:47 -0400
IronPort-SDR: iQ0dOvr4qX9IJZ6n7ZJRsVMCCc+TE1lqhZ6m1KiRxJ2WMhyqJjbh21zOn0mMbgT67MTM9cSttF
 nKlpPrNpUS/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="164575603"
X-IronPort-AV: E=Sophos;i="5.77,342,1596524400"; 
   d="scan'208";a="164575603"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 03:13:46 -0700
IronPort-SDR: ScqH8csVV1zLuwo2l3oG0h165BQWplaKmrUcnYGHfUlMspJv7wTzYbvoAHLwJ9tHtyedsQppUE
 d34clss6wOww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,342,1596524400"; 
   d="scan'208";a="342179276"
Received: from lkp-server02.sh.intel.com (HELO b5ae2f167493) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 06 Oct 2020 03:13:45 -0700
Received: from kbuild by b5ae2f167493 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kPjya-00019y-SA; Tue, 06 Oct 2020 10:13:44 +0000
Date:   Tue, 06 Oct 2020 18:13:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/drm/amd/pm/phm_clock_array] BUILD
 SUCCESS 1f7c023f13d8ff183e706018a0d5690e3e851f12
Message-ID: <5f7c433f.ZyMD+YUIVAwiHGVe%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  testing/drm/amd/pm/phm_clock_array
branch HEAD: 1f7c023f13d8ff183e706018a0d5690e3e851f12  drm/amd/pm: Replace one-element array with flexible-array in struct phm_clock_array

elapsed time: 724m

configs tested: 96
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                           ip28_defconfig
sh                   sh7724_generic_defconfig
m68k                          atari_defconfig
arc                            hsdk_defconfig
mips                        qi_lb60_defconfig
mips                      maltaaprp_defconfig
mips                           rs90_defconfig
arm                          exynos_defconfig
mips                          ath79_defconfig
arm                          pxa168_defconfig
mips                           ci20_defconfig
m68k                            q40_defconfig
sh                          r7780mp_defconfig
sparc64                             defconfig
powerpc                      chrp32_defconfig
mips                malta_qemu_32r6_defconfig
arm                         palmz72_defconfig
arm                          ixp4xx_defconfig
mips                        jmr3927_defconfig
arm                         vf610m4_defconfig
mips                          ath25_defconfig
powerpc                 canyonlands_defconfig
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
i386                 randconfig-a006-20201004
i386                 randconfig-a005-20201004
i386                 randconfig-a001-20201004
i386                 randconfig-a004-20201004
i386                 randconfig-a003-20201004
i386                 randconfig-a002-20201004
x86_64               randconfig-a012-20201005
x86_64               randconfig-a015-20201005
x86_64               randconfig-a014-20201005
x86_64               randconfig-a013-20201005
x86_64               randconfig-a011-20201005
x86_64               randconfig-a016-20201005
i386                 randconfig-a014-20201005
i386                 randconfig-a015-20201005
i386                 randconfig-a013-20201005
i386                 randconfig-a016-20201005
i386                 randconfig-a011-20201005
i386                 randconfig-a012-20201005
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
x86_64               randconfig-a004-20201005
x86_64               randconfig-a002-20201005
x86_64               randconfig-a001-20201005
x86_64               randconfig-a003-20201005
x86_64               randconfig-a005-20201005
x86_64               randconfig-a006-20201005

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
