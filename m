Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C4022DDBA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 11:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgGZJVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 05:21:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:2538 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgGZJVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 05:21:22 -0400
IronPort-SDR: rCT/aaBrPBwnTwMXAj47jUSLikRhjMIiQMkCDOkqPsldMTyYT0wMWREYqoknuxVyngwWPku1lB
 1HrmNnPfvlWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9693"; a="130435409"
X-IronPort-AV: E=Sophos;i="5.75,398,1589266800"; 
   d="scan'208";a="130435409"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2020 02:21:20 -0700
IronPort-SDR: pDKcTx0HMpUjHHDZWg/Q+ojOf0aed7X6GAjANVC2k6PJcvDZJWagH3qjEGqb68hKO/S4nWus3X
 tgnh/UdtbJPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,398,1589266800"; 
   d="scan'208";a="433544099"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2020 02:21:19 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jzcqM-0001Ms-Rr; Sun, 26 Jul 2020 09:21:18 +0000
Date:   Sun, 26 Jul 2020 17:19:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 a7ef9b28aa8d72a1656fa6f0a01bbd1493886317
Message-ID: <5f1d4aa2.6IY2LrUyWQazHk0W%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  locking/urgent
branch HEAD: a7ef9b28aa8d72a1656fa6f0a01bbd1493886317  locking/lockdep: Fix overflow in presentation of average lock-time

elapsed time: 723m

configs tested: 92
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
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
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
i386                 randconfig-a003-20200726
i386                 randconfig-a005-20200726
i386                 randconfig-a004-20200726
i386                 randconfig-a006-20200726
i386                 randconfig-a002-20200726
i386                 randconfig-a001-20200726
x86_64               randconfig-a014-20200726
x86_64               randconfig-a016-20200726
x86_64               randconfig-a015-20200726
x86_64               randconfig-a012-20200726
x86_64               randconfig-a013-20200726
x86_64               randconfig-a011-20200726
i386                 randconfig-a016-20200726
i386                 randconfig-a013-20200726
i386                 randconfig-a012-20200726
i386                 randconfig-a015-20200726
i386                 randconfig-a011-20200726
i386                 randconfig-a014-20200726
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
