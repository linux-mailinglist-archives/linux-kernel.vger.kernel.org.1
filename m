Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B70A25F017
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Sep 2020 21:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbgIFTXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Sep 2020 15:23:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:16784 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgIFTX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 15:23:29 -0400
IronPort-SDR: 7XGBin7HPaP558pnW+cem0LtzQNDADhVu5T7B5GG8Ddmx+MNLUN7NuMkF/dPcJTvDxSZUdhATR
 67Lp7V1/iwuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="222135917"
X-IronPort-AV: E=Sophos;i="5.76,399,1592895600"; 
   d="scan'208";a="222135917"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2020 12:23:25 -0700
IronPort-SDR: ssJe41I6GX7fg7SWaab45YeE+NQoKEXfTuI4Q9mpqKHiRuKJeYsYt0a26oYYcSNXsgXMVPGG3R
 Woul/ACJ0FPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,399,1592895600"; 
   d="scan'208";a="316666730"
Received: from lkp-server01.sh.intel.com (HELO 4b5d6de90563) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Sep 2020 12:23:24 -0700
Received: from kbuild by 4b5d6de90563 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kF0G3-0000Hg-ON; Sun, 06 Sep 2020 19:23:23 +0000
Date:   Mon, 07 Sep 2020 03:22:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 59f8c7a9140d7f9861f8da3b21a7d56a170d1141
Message-ID: <5f5536f0.Ar+y9cmbN4QevV8B%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 59f8c7a9140d7f9861f8da3b21a7d56a170d1141  Merge branch 'linus'

elapsed time: 723m

configs tested: 88
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          kfr2r09_defconfig
mips                  maltasmvp_eva_defconfig
arm                          pcm027_defconfig
ia64                      gensparse_defconfig
mips                        nlm_xlp_defconfig
powerpc                       maple_defconfig
powerpc                      chrp32_defconfig
arm                         socfpga_defconfig
sh                               j2_defconfig
powerpc                         wii_defconfig
mips                 pnx8335_stb225_defconfig
mips                     loongson1c_defconfig
ia64                          tiger_defconfig
arc                             nps_defconfig
arm                          iop32x_defconfig
riscv                          rv32_defconfig
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
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20200906
i386                 randconfig-a005-20200906
i386                 randconfig-a006-20200906
i386                 randconfig-a002-20200906
i386                 randconfig-a003-20200906
i386                 randconfig-a001-20200906
x86_64               randconfig-a013-20200906
x86_64               randconfig-a011-20200906
x86_64               randconfig-a016-20200906
x86_64               randconfig-a012-20200906
x86_64               randconfig-a015-20200906
x86_64               randconfig-a014-20200906
i386                 randconfig-a016-20200906
i386                 randconfig-a015-20200906
i386                 randconfig-a011-20200906
i386                 randconfig-a013-20200906
i386                 randconfig-a014-20200906
i386                 randconfig-a012-20200906
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

clang tested configs:
x86_64               randconfig-a006-20200906
x86_64               randconfig-a004-20200906
x86_64               randconfig-a003-20200906
x86_64               randconfig-a005-20200906
x86_64               randconfig-a001-20200906
x86_64               randconfig-a002-20200906

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
