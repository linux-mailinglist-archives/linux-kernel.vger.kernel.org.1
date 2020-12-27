Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5BE2E32A0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 20:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgL0T7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 14:59:11 -0500
Received: from mga03.intel.com ([134.134.136.65]:29811 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgL0T7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 14:59:10 -0500
IronPort-SDR: j/qcG7M8ba1c0o4lfKqqnpmUhKcl5GXi5/lXuqidKfc3QU1So2cXVUWxakc7QfCPsB5KkyFUpe
 phWFt6BrF4og==
X-IronPort-AV: E=McAfee;i="6000,8403,9847"; a="176419231"
X-IronPort-AV: E=Sophos;i="5.78,453,1599548400"; 
   d="scan'208";a="176419231"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2020 11:58:29 -0800
IronPort-SDR: YFwe7Ktwz3d0xOdbkNOojcKt4ID0HgnJywGHR2EUselv1+xaeXfkV0g6SFRuThPTDaAec+T0b2
 ZB2VWjhlKcWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,453,1599548400"; 
   d="scan'208";a="399742979"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Dec 2020 11:58:28 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ktcBP-0002Xy-Jv; Sun, 27 Dec 2020 19:58:27 +0000
Date:   Mon, 28 Dec 2020 03:57:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 e044796b02dbea4edd8a94055a5fe045cf3b4882
Message-ID: <5fe8e72b.xgzkgEAR0IzPPqyK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: e044796b02dbea4edd8a94055a5fe045cf3b4882  Merge branch 'locking/urgent'

elapsed time: 724m

configs tested: 95
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 xes_mpc85xx_defconfig
nios2                         10m50_defconfig
um                            kunit_defconfig
sh                           se7705_defconfig
sh                ecovec24-romimage_defconfig
sh                             espt_defconfig
arm                         lpc32xx_defconfig
arm                          exynos_defconfig
xtensa                           alldefconfig
powerpc                     akebono_defconfig
mips                         tb0219_defconfig
arm                       cns3420vb_defconfig
arm                           omap1_defconfig
powerpc                     sequoia_defconfig
mips                        vocore2_defconfig
powerpc                     mpc5200_defconfig
powerpc                      tqm8xx_defconfig
arm                       imx_v4_v5_defconfig
sparc64                          alldefconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20201227
x86_64               randconfig-a006-20201227
x86_64               randconfig-a004-20201227
x86_64               randconfig-a002-20201227
x86_64               randconfig-a003-20201227
x86_64               randconfig-a005-20201227
i386                 randconfig-a002-20201227
i386                 randconfig-a005-20201227
i386                 randconfig-a006-20201227
i386                 randconfig-a004-20201227
i386                 randconfig-a003-20201227
i386                 randconfig-a001-20201227
i386                 randconfig-a011-20201227
i386                 randconfig-a016-20201227
i386                 randconfig-a012-20201227
i386                 randconfig-a014-20201227
i386                 randconfig-a015-20201227
i386                 randconfig-a013-20201227
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20201227
x86_64               randconfig-a014-20201227
x86_64               randconfig-a016-20201227
x86_64               randconfig-a012-20201227
x86_64               randconfig-a013-20201227
x86_64               randconfig-a011-20201227

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
