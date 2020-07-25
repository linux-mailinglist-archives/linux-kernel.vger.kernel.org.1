Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FB022D452
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jul 2020 05:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgGYDdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 23:33:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:56861 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbgGYDdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 23:33:24 -0400
IronPort-SDR: 71+KwBj+bKNOdeLLSKk2lERFZVEwSFJzlmQZxu4Tv31krlNlNvNAUcyyOCgNCJgwzbrIPgpf3J
 pYNS3we3oYOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="215387441"
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="215387441"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 20:33:23 -0700
IronPort-SDR: WRkvy6WylEKupxweQMs0PybqtxKSuNU8EG0VIQq8WX6uUhzs1NHrfSFcD7Abt803wBJYsCKLIK
 7ifI5aLG3DBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,392,1589266800"; 
   d="scan'208";a="321221859"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2020 20:33:22 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jzAw5-0000jS-R0; Sat, 25 Jul 2020 03:33:21 +0000
Date:   Sat, 25 Jul 2020 11:32:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 fe5ed7ab99c656bd2f5b79b49df0e9ebf2cead8a
Message-ID: <5f1ba7c3.lrvLW+bpo7a6Vb1X%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  perf/urgent
branch HEAD: fe5ed7ab99c656bd2f5b79b49df0e9ebf2cead8a  uprobes: Change handle_swbp() to send SIGTRAP with si_code=SI_KERNEL, to fix GDB regression

elapsed time: 722m

configs tested: 98
configs skipped: 1

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
i386                 randconfig-a003-20200725
i386                 randconfig-a005-20200725
i386                 randconfig-a004-20200725
i386                 randconfig-a006-20200725
i386                 randconfig-a002-20200725
i386                 randconfig-a001-20200725
x86_64               randconfig-a014-20200724
x86_64               randconfig-a016-20200724
x86_64               randconfig-a015-20200724
x86_64               randconfig-a012-20200724
x86_64               randconfig-a013-20200724
x86_64               randconfig-a011-20200724
i386                 randconfig-a016-20200725
i386                 randconfig-a013-20200725
i386                 randconfig-a012-20200725
i386                 randconfig-a015-20200725
i386                 randconfig-a014-20200725
i386                 randconfig-a011-20200725
i386                 randconfig-a016-20200724
i386                 randconfig-a013-20200724
i386                 randconfig-a012-20200724
i386                 randconfig-a015-20200724
i386                 randconfig-a014-20200724
i386                 randconfig-a011-20200724
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
