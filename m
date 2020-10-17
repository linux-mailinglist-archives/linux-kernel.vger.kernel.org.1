Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0037E291465
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 22:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439080AbgJQUyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 16:54:05 -0400
Received: from mga03.intel.com ([134.134.136.65]:60391 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439049AbgJQUyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 16:54:05 -0400
IronPort-SDR: /1412WXuS/2+GySH3pr2WE0KItmsVIhYV5Pjbdz1fiekS9tWurox0zQAlsyqa+HqGdGteWy4A1
 4b6VqJ856xPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9777"; a="166912209"
X-IronPort-AV: E=Sophos;i="5.77,388,1596524400"; 
   d="scan'208";a="166912209"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2020 13:54:04 -0700
IronPort-SDR: Ia5mvpe+nhIuvxWU7pSeJNOIb5VmJpsE0ag7EYB33kt8+PpouOovarV/3mlX87Ib1KlEm2ILXY
 YfsZBQ6fPgyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,388,1596524400"; 
   d="scan'208";a="521564549"
Received: from lkp-server02.sh.intel.com (HELO c383df7b95ee) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 17 Oct 2020 13:54:03 -0700
Received: from kbuild by c383df7b95ee with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kTtDG-00006D-Jp; Sat, 17 Oct 2020 20:54:02 +0000
Date:   Sun, 18 Oct 2020 04:53:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 c8cd075be67b25278b7a2eb47b21002228a11b9c
Message-ID: <5f8b59c8.Ol1L5nfkdsvkJN3K%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: c8cd075be67b25278b7a2eb47b21002228a11b9c  Merge branch 'core/rcu'

elapsed time: 722m

configs tested: 90
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                   motionpro_defconfig
m68k                        m5407c3_defconfig
mips                         mpc30x_defconfig
arm                  colibri_pxa270_defconfig
mips                   sb1250_swarm_defconfig
arc                        vdk_hs38_defconfig
arm                      tct_hammer_defconfig
arc                        nsim_700_defconfig
arm                        cerfcube_defconfig
arm                         socfpga_defconfig
mips                          ath25_defconfig
i386                             alldefconfig
arm                          gemini_defconfig
um                           x86_64_defconfig
powerpc                     asp8347_defconfig
arm                           spitz_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20201017
i386                 randconfig-a006-20201017
i386                 randconfig-a001-20201017
i386                 randconfig-a003-20201017
i386                 randconfig-a004-20201017
i386                 randconfig-a002-20201017
i386                 randconfig-a016-20201017
i386                 randconfig-a013-20201017
i386                 randconfig-a015-20201017
i386                 randconfig-a011-20201017
i386                 randconfig-a012-20201017
i386                 randconfig-a014-20201017
x86_64               randconfig-a004-20201017
x86_64               randconfig-a002-20201017
x86_64               randconfig-a006-20201017
x86_64               randconfig-a001-20201017
x86_64               randconfig-a005-20201017
x86_64               randconfig-a003-20201017
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
x86_64               randconfig-a016-20201017
x86_64               randconfig-a012-20201017
x86_64               randconfig-a015-20201017
x86_64               randconfig-a013-20201017
x86_64               randconfig-a014-20201017
x86_64               randconfig-a011-20201017

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
