Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AF81EA8A4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 19:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgFARwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 13:52:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:58724 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728285AbgFARwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:52:15 -0400
IronPort-SDR: fgvXVHzLb9N09xmOtP9/w6/ELrok4UuGD+66MbISmKZkzkGgYBwgGNQazpoXuf5LXmLrKUg6GY
 cMtbXH7d1TYw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 10:52:15 -0700
IronPort-SDR: jMkn93Sv5D/WENoEXZ3Pda2jZBfAVhbyS2d6aCaLNDVWccIiYIIIFB8ge9hnwn8qYfZMdjF0Jn
 wjZSL9/gxO8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,461,1583222400"; 
   d="scan'208";a="303713789"
Received: from lkp-server01.sh.intel.com (HELO 78d03bb9d680) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 01 Jun 2020 10:52:14 -0700
Received: from kbuild by 78d03bb9d680 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jfobd-00007c-EA; Mon, 01 Jun 2020 17:52:13 +0000
Date:   Tue, 02 Jun 2020 01:52:09 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/rcu] BUILD SUCCESS
 cb3cb6733fbd8fd8d2c716095fdca42dadba2063
Message-ID: <5ed54049.eGk4Kms1fpi1bloZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  core/rcu
branch HEAD: cb3cb6733fbd8fd8d2c716095fdca42dadba2063  Merge branch 'WIP.core/rcu' into core/rcu, to pick up two x86/entry dependencies

elapsed time: 481m

configs tested: 99
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
powerpc                    mvme5100_defconfig
mips                        maltaup_defconfig
arm                       multi_v4t_defconfig
powerpc                        cell_defconfig
openrisc                 simple_smp_defconfig
nds32                            alldefconfig
mips                         tb0287_defconfig
sh                         microdev_defconfig
powerpc                       holly_defconfig
powerpc                mpc7448_hpc2_defconfig
nios2                            alldefconfig
nds32                               defconfig
mips                      pic32mzda_defconfig
xtensa                          iss_defconfig
powerpc                     mpc83xx_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
x86_64               randconfig-a002-20200601
x86_64               randconfig-a006-20200601
x86_64               randconfig-a001-20200601
x86_64               randconfig-a003-20200601
x86_64               randconfig-a004-20200601
x86_64               randconfig-a005-20200601
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc                            allyesconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                allnoconfig
um                                  defconfig
um                               allyesconfig
um                               allmodconfig
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
