Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D33A27A09A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 13:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgI0L0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 07:26:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:41938 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgI0L0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 07:26:25 -0400
IronPort-SDR: 34AUaKTc7dYN6P9jhJjLFkD5eNsA4GCuBvs6yM17S+K/XjoL09+IyxhWiq/nWz1CA6KQ6XgxMs
 hz4oRMEr5QnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9756"; a="141271934"
X-IronPort-AV: E=Sophos;i="5.77,309,1596524400"; 
   d="scan'208";a="141271934"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 04:04:17 -0700
IronPort-SDR: ZLr1i1kHzxkwqR9lsf8qKq9gllp8VYDvzOYgd97DVoQpKF071xbbOXgd2M+iFzYTmp/A4FUEft
 PJPc6IhTWdGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,309,1596524400"; 
   d="scan'208";a="311442082"
Received: from lkp-server01.sh.intel.com (HELO 2dda29302fe3) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Sep 2020 04:04:15 -0700
Received: from kbuild by 2dda29302fe3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kMUTX-0000ld-4O; Sun, 27 Sep 2020 11:04:15 +0000
Date:   Sun, 27 Sep 2020 19:03:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/fam1-qed_ll2] BUILD SUCCESS
 135c92af879fcfb53b7d71306b1adf4d5885b175
Message-ID: <5f707198.PA1UCZ8MYozYZYAR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  testing/fam1-qed_ll2
branch HEAD: 135c92af879fcfb53b7d71306b1adf4d5885b175  qed/qed_ll2: Replace one-element array with flexible-array member

elapsed time: 724m

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
arm                     eseries_pxa_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     tqm8540_defconfig
mips                 decstation_r4k_defconfig
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
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20200927
x86_64               randconfig-a003-20200927
x86_64               randconfig-a004-20200927
x86_64               randconfig-a002-20200927
x86_64               randconfig-a006-20200927
x86_64               randconfig-a001-20200927
x86_64               randconfig-a011-20200926
x86_64               randconfig-a013-20200926
x86_64               randconfig-a014-20200926
x86_64               randconfig-a015-20200926
x86_64               randconfig-a012-20200926
x86_64               randconfig-a016-20200926

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
