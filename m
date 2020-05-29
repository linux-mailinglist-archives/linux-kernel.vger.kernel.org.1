Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECDE1E74F8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 06:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgE2Eix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 00:38:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:59460 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbgE2Eiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 00:38:51 -0400
IronPort-SDR: eJKrcMyQMZuIEOeY+iUDRsGytA+wQQZdBrGctuoczE89fwnuE5e9vnXxVu4RtXI3pBKJM0FJd/
 a+302pILYSXA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 21:38:50 -0700
IronPort-SDR: YPK1J1Ez9vyFmWMcpsuTV4ytsgQ8KebeRFO9eqRUgvU5YfMcZN4YGOm1sA6GF4Z1u8OajuCmOS
 naxkINqzOE3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,447,1583222400"; 
   d="scan'208";a="311135054"
Received: from lkp-server02.sh.intel.com (HELO 5e8f22f9921b) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 28 May 2020 21:38:49 -0700
Received: from kbuild by 5e8f22f9921b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jeWnA-0000M2-V0; Fri, 29 May 2020 04:38:48 +0000
Date:   Fri, 29 May 2020 12:38:43 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 18f855e574d9799a0e7489f8ae6fd8447d0dd74a
Message-ID: <5ed091d3.VcyaCWlkd9oZzBVt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  sched/urgent
branch HEAD: 18f855e574d9799a0e7489f8ae6fd8447d0dd74a  sched/fair: Don't NUMA balance for kthreads

elapsed time: 3598m

configs tested: 115
configs skipped: 3

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
mips                malta_kvm_guest_defconfig
arm                         socfpga_defconfig
nds32                             allnoconfig
mips                          malta_defconfig
arc                              alldefconfig
arm                         orion5x_defconfig
arc                     nsimosci_hs_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                                defconfig
ia64                              allnoconfig
ia64                             allmodconfig
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
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                              defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
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
i386                 randconfig-a001-20200527
i386                 randconfig-a004-20200527
i386                 randconfig-a003-20200527
i386                 randconfig-a006-20200527
i386                 randconfig-a002-20200527
i386                 randconfig-a005-20200527
x86_64               randconfig-a013-20200528
x86_64               randconfig-a015-20200528
x86_64               randconfig-a012-20200528
x86_64               randconfig-a016-20200528
x86_64               randconfig-a014-20200528
x86_64               randconfig-a011-20200528
i386                 randconfig-a013-20200527
i386                 randconfig-a015-20200527
i386                 randconfig-a012-20200527
i386                 randconfig-a011-20200527
i386                 randconfig-a016-20200527
i386                 randconfig-a014-20200527
i386                 randconfig-a013-20200528
i386                 randconfig-a011-20200528
i386                 randconfig-a012-20200528
i386                 randconfig-a015-20200528
i386                 randconfig-a016-20200528
i386                 randconfig-a014-20200528
x86_64               randconfig-a006-20200527
x86_64               randconfig-a002-20200527
x86_64               randconfig-a005-20200527
x86_64               randconfig-a003-20200527
x86_64               randconfig-a004-20200527
x86_64               randconfig-a001-20200527
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                              allnoconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
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
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
