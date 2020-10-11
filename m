Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F3328AA68
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 22:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgJKUab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 16:30:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:57080 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbgJKUaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 16:30:30 -0400
IronPort-SDR: 9jriRVYeo7FfCzH8zNkJUVGINQJgtitHFki1cU/6RBYh71/ZBA/5QUdyhRzK88RkSKJ+ILqOF2
 1eJRTeo40U8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="164878000"
X-IronPort-AV: E=Sophos;i="5.77,364,1596524400"; 
   d="scan'208";a="164878000"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 13:30:29 -0700
IronPort-SDR: ysvkMyxbHLDWH9CNZ5yhEAViYBBTgRWlAbaG6u/dfrsQvS04W18xSryF85hMaBDyQBos+XP47K
 OMaa/GUjYRrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,364,1596524400"; 
   d="scan'208";a="462872193"
Received: from lkp-server02.sh.intel.com (HELO 92b3fbfaed90) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 11 Oct 2020 13:30:28 -0700
Received: from kbuild by 92b3fbfaed90 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kRhz9-0000eZ-GJ; Sun, 11 Oct 2020 20:30:27 +0000
Date:   Mon, 12 Oct 2020 04:29:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:efi/core] BUILD SUCCESS
 cc383a9e245c527d3175e2cf4cced9dbbedbbac6
Message-ID: <5f836b2f.TIrKdnLKeqqPO17B%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  efi/core
branch HEAD: cc383a9e245c527d3175e2cf4cced9dbbedbbac6  efi: mokvar: add missing include of asm/early_ioremap.h

elapsed time: 722m

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
powerpc                      ep88xc_defconfig
arm                           h3600_defconfig
arm                       spear13xx_defconfig
c6x                        evmc6474_defconfig
arm                      jornada720_defconfig
sh                   sh7724_generic_defconfig
c6x                        evmc6472_defconfig
sh                           se7619_defconfig
sh                            migor_defconfig
arm                         nhk8815_defconfig
arm                  colibri_pxa300_defconfig
powerpc                     tqm8541_defconfig
xtensa                         virt_defconfig
powerpc                          g5_defconfig
powerpc                   currituck_defconfig
mips                        nlm_xlp_defconfig
powerpc                         ps3_defconfig
powerpc                     pq2fads_defconfig
m68k                          sun3x_defconfig
powerpc                       ppc64_defconfig
ia64                         bigsur_defconfig
arm                       multi_v4t_defconfig
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
i386                 randconfig-a005-20201011
i386                 randconfig-a006-20201011
i386                 randconfig-a001-20201011
i386                 randconfig-a003-20201011
i386                 randconfig-a004-20201011
i386                 randconfig-a002-20201011
x86_64               randconfig-a004-20201011
x86_64               randconfig-a002-20201011
x86_64               randconfig-a006-20201011
x86_64               randconfig-a001-20201011
x86_64               randconfig-a003-20201011
x86_64               randconfig-a005-20201011
i386                 randconfig-a016-20201011
i386                 randconfig-a015-20201011
i386                 randconfig-a013-20201011
i386                 randconfig-a012-20201011
i386                 randconfig-a011-20201011
i386                 randconfig-a014-20201011
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
x86_64               randconfig-a016-20201011
x86_64               randconfig-a015-20201011
x86_64               randconfig-a012-20201011
x86_64               randconfig-a013-20201011
x86_64               randconfig-a014-20201011
x86_64               randconfig-a011-20201011

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
