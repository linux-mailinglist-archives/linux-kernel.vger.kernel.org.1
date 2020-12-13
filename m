Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222052D90C4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 22:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406476AbgLMV1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 16:27:40 -0500
Received: from mga02.intel.com ([134.134.136.20]:33299 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406401AbgLMV1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 16:27:40 -0500
IronPort-SDR: qI5Q5JfIijXJsOlQyVKXkwsVwmwgdjymluRxtVt64YtkegETVG7jL/swbN3m+lGy4GcT/8m3te
 7rdQw3DPKaFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9834"; a="161680029"
X-IronPort-AV: E=Sophos;i="5.78,417,1599548400"; 
   d="scan'208";a="161680029"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2020 13:26:59 -0800
IronPort-SDR: 8BnkCE1X0d2mWOv2W9cd/0kkGSvdzZa3Ijayag4+XCj4IkY12PBZq/6jtLoLNclL/iaNz6Cv+G
 isDjW1JvRjXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,417,1599548400"; 
   d="scan'208";a="380351722"
Received: from lkp-server02.sh.intel.com (HELO a947d92d0467) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 13 Dec 2020 13:26:58 -0800
Received: from kbuild by a947d92d0467 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1koYtN-00002U-Mu; Sun, 13 Dec 2020 21:26:57 +0000
Date:   Mon, 14 Dec 2020 05:26:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 3cabca87b329cbcbdf295be0094adbd72c7b1f67
Message-ID: <5fd686e8.48u4IU1/sSUqTBuA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  timers/core
branch HEAD: 3cabca87b329cbcbdf295be0094adbd72c7b1f67  ntp: Fix prototype in the !CONFIG_GENERIC_CMOS_UPDATE case

elapsed time: 724m

configs tested: 93
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
sh                 kfr2r09-romimage_defconfig
sh                         microdev_defconfig
mips                        bcm47xx_defconfig
riscv                             allnoconfig
powerpc                mpc7448_hpc2_defconfig
sh                          lboxre2_defconfig
arm                           h3600_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                        sh7785lcr_defconfig
arm                              alldefconfig
arm                            zeus_defconfig
mips                      bmips_stb_defconfig
mips                    maltaup_xpa_defconfig
m68k                           sun3_defconfig
m68k                        m5272c3_defconfig
arm                     eseries_pxa_defconfig
m68k                        m5307c3_defconfig
powerpc                         wii_defconfig
sh                           se7780_defconfig
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
x86_64               randconfig-a003-20201213
x86_64               randconfig-a006-20201213
x86_64               randconfig-a002-20201213
x86_64               randconfig-a005-20201213
x86_64               randconfig-a004-20201213
x86_64               randconfig-a001-20201213
i386                 randconfig-a001-20201213
i386                 randconfig-a004-20201213
i386                 randconfig-a003-20201213
i386                 randconfig-a002-20201213
i386                 randconfig-a005-20201213
i386                 randconfig-a006-20201213
i386                 randconfig-a014-20201213
i386                 randconfig-a013-20201213
i386                 randconfig-a012-20201213
i386                 randconfig-a011-20201213
i386                 randconfig-a016-20201213
i386                 randconfig-a015-20201213
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-a016-20201213
x86_64               randconfig-a012-20201213
x86_64               randconfig-a013-20201213
x86_64               randconfig-a015-20201213
x86_64               randconfig-a014-20201213
x86_64               randconfig-a011-20201213

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
