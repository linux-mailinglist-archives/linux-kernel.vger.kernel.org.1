Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC9527A448
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 23:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgI0V20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 17:28:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:30397 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgI0V20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 17:28:26 -0400
IronPort-SDR: w7A3uwPTCJFokF0Tv+TWNuWa4YcOBUJkeYlQmhwjckO/7btcEIGanVa7t/CaLlkZk5Pu6fwaqr
 ++SbUQWcckQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="226057687"
X-IronPort-AV: E=Sophos;i="5.77,311,1596524400"; 
   d="scan'208";a="226057687"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 14:28:25 -0700
IronPort-SDR: mL3jrKIlxFs04CLkoLIubQ4KRNpAN79kSsv/8J1Xa631GI2A2VO00E+9WCIVaFixDsHY8kWIgq
 /PVQT7mpg5+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,311,1596524400"; 
   d="scan'208";a="307094427"
Received: from lkp-server01.sh.intel.com (HELO 0e0978ea3297) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 27 Sep 2020 14:28:24 -0700
Received: from kbuild by 0e0978ea3297 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kMeDX-00005m-ON; Sun, 27 Sep 2020 21:28:23 +0000
Date:   Mon, 28 Sep 2020 05:27:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 a7b6c0feda15c9881cac83102cdbc82e39889995
Message-ID: <5f7103ce.c6qBDyrIjpvsLUw4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  timers/urgent
branch HEAD: a7b6c0feda15c9881cac83102cdbc82e39889995  Merge tag 'timers-v5.9-rc4' of https://git.linaro.org/people/daniel.lezcano/linux into timers/urgent

elapsed time: 721m

configs tested: 105
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      chrp32_defconfig
riscv                            allyesconfig
powerpc                 mpc8560_ads_defconfig
sh                   secureedge5410_defconfig
powerpc                      ppc6xx_defconfig
ia64                                defconfig
mips                           rs90_defconfig
mips                          rb532_defconfig
mips                          ath25_defconfig
sh                        sh7757lcr_defconfig
nios2                         3c120_defconfig
sh                          landisk_defconfig
powerpc                 mpc8272_ads_defconfig
sparc                            alldefconfig
sh                     magicpanelr2_defconfig
sh                          lboxre2_defconfig
mips                malta_kvm_guest_defconfig
sh                          rsk7203_defconfig
powerpc                     redwood_defconfig
arm                         s3c2410_defconfig
arm                           sama5_defconfig
arc                             nps_defconfig
m68k                            mac_defconfig
openrisc                    or1ksim_defconfig
arc                        nsimosci_defconfig
powerpc                      tqm8xx_defconfig
mips                             allyesconfig
arm                         lubbock_defconfig
arm                            u300_defconfig
xtensa                generic_kc705_defconfig
mips                  maltasmvp_eva_defconfig
arm                          tango4_defconfig
mips                          ath79_defconfig
arm                     eseries_pxa_defconfig
c6x                        evmc6678_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     tqm8540_defconfig
mips                 decstation_r4k_defconfig
sh                          urquell_defconfig
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
