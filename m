Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE786284B47
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 14:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgJFMEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 08:04:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:20617 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgJFMET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 08:04:19 -0400
IronPort-SDR: vwUA/g/xhA4MKTNMYL9VuEdb5vGEWwDBKDM8fqGNuYmb9K4c60dmEfSVI3O+PiTxNZi8WbZZ+/
 csc56WMEV79A==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="144369141"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="144369141"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 05:04:17 -0700
IronPort-SDR: iPg3alJBt6zviF0gPgzYByuyCk1eN9Q24WJyGtR2kOQpngwTFvMPs6YA1ntPOqKfRZnixI9gpS
 MxHLhQXPjsuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="418150113"
Received: from lkp-server02.sh.intel.com (HELO b5ae2f167493) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 06 Oct 2020 05:04:14 -0700
Received: from kbuild by b5ae2f167493 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kPlhW-0001BW-7f; Tue, 06 Oct 2020 12:04:14 +0000
Date:   Tue, 06 Oct 2020 20:04:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/drm/amd/pm/phm_cac] BUILD SUCCESS
 a9df66c2ed2dcb9da7ed0eb65f69bf9532c3b324
Message-ID: <5f7c5d38.iT/QTjN+659XUDo5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  testing/drm/amd/pm/phm_cac
branch HEAD: a9df66c2ed2dcb9da7ed0eb65f69bf9532c3b324  drm/amd/pm: Replace one-element array with flexible-array in struct phm_cac_leakage_table

elapsed time: 724m

configs tested: 97
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                           rs90_defconfig
arm                          exynos_defconfig
mips                          ath79_defconfig
arm                          pxa168_defconfig
mips                           ci20_defconfig
arm                         cm_x300_defconfig
powerpc                      pasemi_defconfig
mips                      bmips_stb_defconfig
powerpc                      cm5200_defconfig
powerpc                     stx_gp3_defconfig
sh                           se7721_defconfig
m68k                            q40_defconfig
sh                          r7780mp_defconfig
sparc                               defconfig
sparc64                             defconfig
arm                           efm32_defconfig
mips                           ip27_defconfig
sh                           se7724_defconfig
powerpc                   lite5200b_defconfig
arm                           omap1_defconfig
ia64                             allmodconfig
mips                        jmr3927_defconfig
arm                         vf610m4_defconfig
mips                          ath25_defconfig
powerpc                 canyonlands_defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201005
i386                 randconfig-a005-20201005
i386                 randconfig-a001-20201005
i386                 randconfig-a004-20201005
i386                 randconfig-a003-20201005
i386                 randconfig-a002-20201005
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
