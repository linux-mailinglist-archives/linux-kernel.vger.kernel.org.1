Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09D727AB87
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgI1KKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:10:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:21525 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgI1KK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:10:29 -0400
IronPort-SDR: T5cK2VPuqzNFZveSd9t5OI3RZSdznkDyKX0U69w+axLkqvl53ru7J7sPRYxESe5WkRtTAk9kqQ
 26a11ofDKzaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="159349353"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="159349353"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 03:04:26 -0700
IronPort-SDR: iDv/EAoafqTqQ0ch0b4gwAibLpK030DyMEBcVjrnySzcaxOqiWeb23TUJ13vco0amVA7MnLxzF
 82nB3mXgc9Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="338122231"
Received: from lkp-server01.sh.intel.com (HELO 0e0978ea3297) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 28 Sep 2020 03:04:24 -0700
Received: from kbuild by 0e0978ea3297 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kMq1A-0000F5-0r; Mon, 28 Sep 2020 10:04:24 +0000
Date:   Mon, 28 Sep 2020 18:03:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:urezki-pcount.2020.09.26a] BUILD SUCCESS WITH WARNING
 517442b71402169151e9dad8380cba3a9f295bc9
Message-ID: <5f71b4ef.fCruHQycg8yWsV2w%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  urezki-pcount.2020.09.26a
branch HEAD: 517442b71402169151e9dad8380cba3a9f295bc9  Revert "KVM: Check the allocation of pv cpu mask"

Warning in current branch:

kernel/rcu/tree.c:3169:4-9: WARNING: NULL check before some freeing functions is not needed.

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-randconfig-c002-20200928
    `-- kernel-rcu-tree.c:WARNING:NULL-check-before-some-freeing-functions-is-not-needed.

elapsed time: 720m

configs tested: 93
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      obs600_defconfig
sh                        apsh4ad0a_defconfig
sh                            shmin_defconfig
arm                        neponset_defconfig
arm                          collie_defconfig
powerpc                     akebono_defconfig
arc                          axs101_defconfig
arm                          prima2_defconfig
sh                        sh7763rdp_defconfig
sh                           se7619_defconfig
ia64                      gensparse_defconfig
powerpc                    adder875_defconfig
powerpc                    socrates_defconfig
arm                              zx_defconfig
sh                             espt_defconfig
riscv                          rv32_defconfig
mips                     loongson1b_defconfig
xtensa                    smp_lx200_defconfig
mips                 decstation_r4k_defconfig
powerpc                 mpc837x_rdb_defconfig
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
i386                 randconfig-a006-20200928
i386                 randconfig-a002-20200928
i386                 randconfig-a003-20200928
i386                 randconfig-a004-20200928
i386                 randconfig-a005-20200928
i386                 randconfig-a001-20200928
x86_64               randconfig-a005-20200928
x86_64               randconfig-a003-20200928
x86_64               randconfig-a004-20200928
x86_64               randconfig-a002-20200928
x86_64               randconfig-a006-20200928
x86_64               randconfig-a001-20200928
i386                 randconfig-a012-20200928
i386                 randconfig-a016-20200928
i386                 randconfig-a014-20200928
i386                 randconfig-a013-20200928
i386                 randconfig-a015-20200928
i386                 randconfig-a011-20200928
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-a011-20200928
x86_64               randconfig-a013-20200928
x86_64               randconfig-a015-20200928
x86_64               randconfig-a014-20200928
x86_64               randconfig-a016-20200928
x86_64               randconfig-a012-20200928

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
