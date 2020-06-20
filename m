Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE2D20217E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 06:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgFTEmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jun 2020 00:42:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:19677 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbgFTEmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 00:42:02 -0400
IronPort-SDR: FxiBdMApb5Kp1Du4BFWS8YL3bU4ABfVC0Sgf7Cl6WYsD37I7eNYA5ySi+/X9eqm7Eku5rb0oGn
 PHKM2QxCPwPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9657"; a="131598404"
X-IronPort-AV: E=Sophos;i="5.75,258,1589266800"; 
   d="scan'208";a="131598404"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 21:42:01 -0700
IronPort-SDR: LSypWXc8XS+VJHF4eR8bWbY5iLa59Rsk75CtlOBVNxsusJqh/pR3k69OskRl9Pep0CIiqvlkBG
 radTVudH3BKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,258,1589266800"; 
   d="scan'208";a="318309713"
Received: from lkp-server02.sh.intel.com (HELO 3aa54c81372e) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Jun 2020 21:42:00 -0700
Received: from kbuild by 3aa54c81372e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jmVKJ-00011Y-G9; Sat, 20 Jun 2020 04:41:59 +0000
Date:   Sat, 20 Jun 2020 12:41:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 bb5570ad3b54e7930997aec76ab68256d5236d94
Message-ID: <5eed9391.W1KQZheM+qBzYgBu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: bb5570ad3b54e7930997aec76ab68256d5236d94  x86/asm/64: Align start of __clear_user() loop to 16-bytes

elapsed time: 723m

configs tested: 114
configs skipped: 98

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
arc                        vdk_hs38_defconfig
arm                        spear6xx_defconfig
csky                             allyesconfig
mips                         tb0226_defconfig
sh                          r7780mp_defconfig
s390                             allyesconfig
sh                                  defconfig
arm                       mainstone_defconfig
m68k                       m5475evb_defconfig
powerpc                          g5_defconfig
mips                      pistachio_defconfig
arm                        trizeps4_defconfig
arm                     davinci_all_defconfig
nios2                         3c120_defconfig
mips                           ip27_defconfig
powerpc                      ep88xc_defconfig
m68k                        mvme16x_defconfig
mips                        qi_lb60_defconfig
arm                         s5pv210_defconfig
x86_64                              defconfig
arc                              alldefconfig
s390                              allnoconfig
arc                        nsimosci_defconfig
h8300                            allmodconfig
sh                               j2_defconfig
arm                           h5000_defconfig
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
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
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
i386                 randconfig-a002-20200619
i386                 randconfig-a006-20200619
i386                 randconfig-a001-20200619
i386                 randconfig-a004-20200619
i386                 randconfig-a005-20200619
i386                 randconfig-a003-20200619
i386                 randconfig-a011-20200619
i386                 randconfig-a015-20200619
i386                 randconfig-a014-20200619
i386                 randconfig-a013-20200619
i386                 randconfig-a016-20200619
i386                 randconfig-a012-20200619
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
um                               allmodconfig
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
