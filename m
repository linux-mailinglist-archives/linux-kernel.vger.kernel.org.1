Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD6127A449
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 23:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgI0V23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 17:28:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:30397 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbgI0V21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 17:28:27 -0400
IronPort-SDR: zixKpylyoz+lumx2/bgU+ohJBBl/Or+p7M62qNno4IJaf1I9Kw20exrHKELwTD6OCNoN2GTOwo
 H4Kd8sTa9bWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="226057690"
X-IronPort-AV: E=Sophos;i="5.77,311,1596524400"; 
   d="scan'208";a="226057690"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 14:28:25 -0700
IronPort-SDR: ZVJgzgXSNlNdX1obqP0rVM0YxitWB0Rj16v5bzBBvhgMmAGdRplvU0lIhVB6WjsHVLe9wL/2Zj
 eLe7V65EEuTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,311,1596524400"; 
   d="scan'208";a="293032889"
Received: from lkp-server01.sh.intel.com (HELO 0e0978ea3297) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 27 Sep 2020 14:28:24 -0700
Received: from kbuild by 0e0978ea3297 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kMeDX-00005p-RG; Sun, 27 Sep 2020 21:28:23 +0000
Date:   Mon, 28 Sep 2020 05:27:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 3b17c8f9a4b680b938b0bf51db38bb510e12555e
Message-ID: <5f7103cd.CuRqWMD0lkxArph6%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  timers/core
branch HEAD: 3b17c8f9a4b680b938b0bf51db38bb510e12555e  Merge tag 'timers-v5.10' of https://git.linaro.org/people/daniel.lezcano/linux into timers/core

elapsed time: 721m

configs tested: 93
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
ia64                                defconfig
mips                           rs90_defconfig
mips                          rb532_defconfig
mips                          ath25_defconfig
sh                        sh7757lcr_defconfig
mips                malta_kvm_guest_defconfig
nios2                         3c120_defconfig
sh                          rsk7203_defconfig
powerpc                     redwood_defconfig
arm                         s3c2410_defconfig
arm                           sama5_defconfig
arc                             nps_defconfig
m68k                            mac_defconfig
openrisc                    or1ksim_defconfig
arc                        nsimosci_defconfig
powerpc                      tqm8xx_defconfig
powerpc                      chrp32_defconfig
mips                             allyesconfig
arm                         lubbock_defconfig
arm                            u300_defconfig
xtensa                generic_kc705_defconfig
mips                  maltasmvp_eva_defconfig
arm                          tango4_defconfig
mips                          ath79_defconfig
sh                          urquell_defconfig
powerpc                      ppc6xx_defconfig
ia64                             alldefconfig
ia64                             allmodconfig
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
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20200927
i386                 randconfig-a006-20200927
i386                 randconfig-a003-20200927
i386                 randconfig-a004-20200927
i386                 randconfig-a005-20200927
i386                 randconfig-a001-20200927
x86_64               randconfig-a011-20200927
x86_64               randconfig-a013-20200927
x86_64               randconfig-a014-20200927
x86_64               randconfig-a015-20200927
x86_64               randconfig-a012-20200927
x86_64               randconfig-a016-20200927
i386                 randconfig-a012-20200927
i386                 randconfig-a014-20200927
i386                 randconfig-a016-20200927
i386                 randconfig-a013-20200927
i386                 randconfig-a011-20200927
i386                 randconfig-a015-20200927
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
