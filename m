Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D066527A068
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 12:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgI0KBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 06:01:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:41494 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgI0KBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 06:01:07 -0400
IronPort-SDR: 86/sZN6JIH0BOFYxQi4MSFXQmQiYV2Jo6KbwB/YoZtilSyihehp96nxRwOmihmL1BUvo/fxv8y
 aR7/VVvPbGcA==
X-IronPort-AV: E=McAfee;i="6000,8403,9756"; a="149526775"
X-IronPort-AV: E=Sophos;i="5.77,309,1596524400"; 
   d="scan'208";a="149526775"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 03:01:06 -0700
IronPort-SDR: Ctcqg3F0rUx6GHUSf39wFtn1pFsXeiXqlbL5CgaKM+StsS49dVhEDw1f4Har5y1csnepuL/0GM
 iOHwAB15VXmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,309,1596524400"; 
   d="scan'208";a="344499551"
Received: from lkp-server01.sh.intel.com (HELO 2dda29302fe3) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 27 Sep 2020 03:01:04 -0700
Received: from kbuild by 2dda29302fe3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kMTUO-0000jn-8W; Sun, 27 Sep 2020 10:01:04 +0000
Date:   Sun, 27 Sep 2020 18:00:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/fam1-refactors] BUILD SUCCESS
 c62f8c6726ed904e4ddb5514c0f85ce133708f9a
Message-ID: <5f7062af.z3T9tn9yIPv6h5Ny%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  testing/fam1-refactors
branch HEAD: c62f8c6726ed904e4ddb5514c0f85ce133708f9a  net/sched: cls_u32: Replace one-element array with flexible-array member

elapsed time: 722m

configs tested: 110
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
xtensa                           allyesconfig
powerpc                        fsp2_defconfig
powerpc                     sequoia_defconfig
arm                            hisi_defconfig
xtensa                       common_defconfig
arm                        trizeps4_defconfig
powerpc                         ps3_defconfig
powerpc                     akebono_defconfig
powerpc                  mpc866_ads_defconfig
arc                        vdk_hs38_defconfig
mips                        nlm_xlp_defconfig
mips                malta_kvm_guest_defconfig
nios2                         3c120_defconfig
sh                          rsk7203_defconfig
powerpc                     redwood_defconfig
x86_64                           allyesconfig
arm                         s3c2410_defconfig
arm                          pxa3xx_defconfig
arm                            qcom_defconfig
arm                           corgi_defconfig
c6x                        evmc6678_defconfig
arm                      tct_hammer_defconfig
powerpc                     rainier_defconfig
powerpc                      tqm8xx_defconfig
powerpc                      chrp32_defconfig
mips                             allyesconfig
arm                         lubbock_defconfig
arm                            u300_defconfig
xtensa                generic_kc705_defconfig
mips                  maltasmvp_eva_defconfig
arm                          tango4_defconfig
mips                          ath79_defconfig
openrisc                    or1ksim_defconfig
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
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20200926
x86_64               randconfig-a013-20200926
x86_64               randconfig-a014-20200926
x86_64               randconfig-a015-20200926
x86_64               randconfig-a012-20200926
x86_64               randconfig-a016-20200926
x86_64               randconfig-a005-20200927
x86_64               randconfig-a003-20200927
x86_64               randconfig-a004-20200927
x86_64               randconfig-a002-20200927
x86_64               randconfig-a006-20200927
x86_64               randconfig-a001-20200927

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
