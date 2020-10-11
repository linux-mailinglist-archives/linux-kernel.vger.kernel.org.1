Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6051628AA69
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 22:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgJKUao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 16:30:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:61652 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbgJKUan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 16:30:43 -0400
IronPort-SDR: H0l6e/wL3LsrlX1Lo0SIypeokk0QWy2bvNIKIQ1WC41n6NzkZCU8WoIKjPURNUAewailNdTkuQ
 Lq9Lbwt6X9IA==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="163025998"
X-IronPort-AV: E=Sophos;i="5.77,364,1596524400"; 
   d="scan'208";a="163025998"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2020 13:30:30 -0700
IronPort-SDR: huZrpddIAsFI/8AGEpj9jmtGWfbFHAmq3/KtwQXoGUm5imLv3hOitNoJ17PIlYOv9qIMmUeMWh
 lT+mtXKnU9mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,364,1596524400"; 
   d="scan'208";a="519387563"
Received: from lkp-server02.sh.intel.com (HELO 92b3fbfaed90) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 11 Oct 2020 13:30:29 -0700
Received: from kbuild by 92b3fbfaed90 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kRhz9-0000ec-Gn; Sun, 11 Oct 2020 20:30:27 +0000
Date:   Mon, 12 Oct 2020 04:29:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD REGRESSION
 820e6f502f021417140bc8ee11f9c7be148ea844
Message-ID: <5f836b39.c3yjFVKN7hg/wyOg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 820e6f502f021417140bc8ee11f9c7be148ea844  Merge branch 'efi/core'

Error/Warning reports:

https://lore.kernel.org/lkml/202010112007.JDl1BSci-lkp@intel.com

Error/Warning in current branch:

tools/include/linux/types.h:30:18: error: typedef redefinition with different types ('uint64_t' (aka 'unsigned long') vs '__u64' (aka 'unsigned long long'))
tools/include/linux/types.h:31:17: error: typedef redefinition with different types ('int64_t' (aka 'long') vs '__s64' (aka 'long long'))

Error/Warning ids grouped by kconfigs:

clang_recent_errors
`-- x86_64-randconfig-a016-20201011
    |-- tools-include-linux-types.h:error:typedef-redefinition-with-different-types-(-int64_t-(aka-long-)-vs-__s64-(aka-long-long-))
    `-- tools-include-linux-types.h:error:typedef-redefinition-with-different-types-(-uint64_t-(aka-unsigned-long-)-vs-__u64-(aka-unsigned-long-long-))

elapsed time: 722m

configs tested: 93
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
powerpc                   motionpro_defconfig
sh                               alldefconfig
powerpc                    klondike_defconfig
mips                           jazz_defconfig
mips                            gpr_defconfig
arm                        oxnas_v6_defconfig
arm                  colibri_pxa300_defconfig
arm                         hackkit_defconfig
powerpc                 mpc8272_ads_defconfig
openrisc                            defconfig
powerpc                  iss476-smp_defconfig
arm                       omap2plus_defconfig
c6x                        evmc6457_defconfig
arc                      axs103_smp_defconfig
microblaze                      mmu_defconfig
powerpc                      pcm030_defconfig
arm                         socfpga_defconfig
arm                           sama5_defconfig
sh                           se7721_defconfig
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
x86_64               randconfig-a004-20201011
x86_64               randconfig-a002-20201011
x86_64               randconfig-a006-20201011
x86_64               randconfig-a001-20201011
x86_64               randconfig-a003-20201011
x86_64               randconfig-a005-20201011
i386                 randconfig-a005-20201011
i386                 randconfig-a006-20201011
i386                 randconfig-a001-20201011
i386                 randconfig-a003-20201011
i386                 randconfig-a004-20201011
i386                 randconfig-a002-20201011
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
