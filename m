Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DA61C8149
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 07:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgEGFDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 01:03:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:13542 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgEGFDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 01:03:54 -0400
IronPort-SDR: UUapGBflz0SZkX0BBdYf3kdtyl3BWNM3A9IjAilTQrS0o5UWLu1ztEsOytvm2wd749atibUwnN
 SslPc0G7qUsA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 22:03:53 -0700
IronPort-SDR: JDMPi4J5tTFEgCNjxL2pFzfCKgxlsdEK9g3fU0/dEYdJhb/1fsWrC2nTteztaho1kthciLSQ/b
 caVZpJiSAdcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,362,1583222400"; 
   d="scan'208";a="249991765"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 06 May 2020 22:03:52 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jWYhK-000IUt-LP; Thu, 07 May 2020 13:03:50 +0800
Date:   Thu, 07 May 2020 13:03:36 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:kcsan-dev] BUILD SUCCESS
 50a19ad4b1ec531eb550183cb5d4ab9f25a56bf8
Message-ID: <5eb396a8.2a93NZjuG/kFptfv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  kcsan-dev
branch HEAD: 50a19ad4b1ec531eb550183cb5d4ab9f25a56bf8  objtool, kcsan: Add kcsan_disable_current() and kcsan_enable_current_nowarn()

elapsed time: 483m

configs tested: 174
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
arm                              allmodconfig
arm64                             allnoconfig
arm                               allnoconfig
sparc                            allyesconfig
m68k                             allyesconfig
ia64                             allyesconfig
i386                              allnoconfig
s390                             allmodconfig
csky                             allyesconfig
mips                             allyesconfig
riscv                               defconfig
openrisc                            defconfig
powerpc                             defconfig
h8300                            allmodconfig
ia64                             alldefconfig
xtensa                              defconfig
openrisc                         allyesconfig
um                               allmodconfig
nds32                               defconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
m68k                             allmodconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
m68k                                defconfig
nios2                               defconfig
nios2                            allyesconfig
c6x                              allyesconfig
c6x                               allnoconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
arc                              allyesconfig
microblaze                       allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          alldefconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
m68k                 randconfig-a001-20200506
mips                 randconfig-a001-20200506
nds32                randconfig-a001-20200506
parisc               randconfig-a001-20200506
alpha                randconfig-a001-20200506
riscv                randconfig-a001-20200506
m68k                 randconfig-a001-20200507
mips                 randconfig-a001-20200507
nds32                randconfig-a001-20200507
parisc               randconfig-a001-20200507
alpha                randconfig-a001-20200507
riscv                randconfig-a001-20200507
h8300                randconfig-a001-20200506
nios2                randconfig-a001-20200506
microblaze           randconfig-a001-20200506
c6x                  randconfig-a001-20200506
sparc64              randconfig-a001-20200506
h8300                randconfig-a001-20200507
nios2                randconfig-a001-20200507
microblaze           randconfig-a001-20200507
c6x                  randconfig-a001-20200507
sparc64              randconfig-a001-20200507
s390                 randconfig-a001-20200506
xtensa               randconfig-a001-20200506
sh                   randconfig-a001-20200506
openrisc             randconfig-a001-20200506
csky                 randconfig-a001-20200506
xtensa               randconfig-a001-20200507
sh                   randconfig-a001-20200507
openrisc             randconfig-a001-20200507
csky                 randconfig-a001-20200507
i386                 randconfig-b003-20200506
i386                 randconfig-b001-20200506
x86_64               randconfig-b001-20200506
x86_64               randconfig-b003-20200506
i386                 randconfig-b002-20200506
x86_64               randconfig-c002-20200507
x86_64               randconfig-c001-20200507
i386                 randconfig-c002-20200507
i386                 randconfig-c003-20200507
x86_64               randconfig-c003-20200507
i386                 randconfig-c001-20200507
x86_64               randconfig-d001-20200507
i386                 randconfig-d003-20200507
i386                 randconfig-d001-20200507
x86_64               randconfig-d003-20200507
x86_64               randconfig-d002-20200507
i386                 randconfig-d002-20200507
i386                 randconfig-e003-20200506
x86_64               randconfig-e003-20200506
x86_64               randconfig-e001-20200506
i386                 randconfig-e002-20200506
i386                 randconfig-e001-20200506
x86_64               randconfig-a003-20200506
x86_64               randconfig-a001-20200506
x86_64               randconfig-a002-20200506
i386                 randconfig-a001-20200506
i386                 randconfig-a002-20200506
i386                 randconfig-a003-20200506
i386                 randconfig-f003-20200507
x86_64               randconfig-f002-20200507
i386                 randconfig-f001-20200507
i386                 randconfig-f002-20200507
x86_64               randconfig-g003-20200506
i386                 randconfig-g003-20200506
i386                 randconfig-g002-20200506
x86_64               randconfig-g001-20200506
i386                 randconfig-g001-20200506
x86_64               randconfig-g002-20200506
i386                 randconfig-h002-20200506
i386                 randconfig-h001-20200506
i386                 randconfig-h003-20200506
x86_64               randconfig-h002-20200506
x86_64               randconfig-h003-20200506
x86_64               randconfig-h001-20200506
x86_64               randconfig-a002-20200507
i386                 randconfig-a001-20200507
i386                 randconfig-a002-20200507
i386                 randconfig-a003-20200507
ia64                 randconfig-a001-20200506
arm64                randconfig-a001-20200506
arc                  randconfig-a001-20200506
powerpc              randconfig-a001-20200506
arm                  randconfig-a001-20200506
sparc                randconfig-a001-20200506
ia64                 randconfig-a001-20200507
arm64                randconfig-a001-20200507
arc                  randconfig-a001-20200507
arm                  randconfig-a001-20200507
sparc                randconfig-a001-20200507
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             alldefconfig
s390                                defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                             i386_defconfig
um                               allyesconfig
um                                  defconfig
um                           x86_64_defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
