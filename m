Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5BB22DF66
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 14:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgGZM6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 08:58:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:11971 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbgGZM6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 08:58:40 -0400
IronPort-SDR: o8xTc4lMjx8poQT/adcoEGsTbOQQFt9CRbJ4jtFreAlMpwxp6ZB+Ab0mZW0MYMauQV1Vz5EX2X
 N1xQHwd8+tiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9693"; a="138406020"
X-IronPort-AV: E=Sophos;i="5.75,398,1589266800"; 
   d="scan'208";a="138406020"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2020 05:58:40 -0700
IronPort-SDR: ctmewIlLnguoNWjsW6c0xARxVJ7oDCAUYIO50f3c77BNgMFz5k+XBABNKx+XU9QPfh4qnaLURJ
 YENYigs8Q8YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,398,1589266800"; 
   d="scan'208";a="327759107"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jul 2020 05:58:38 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jzgEf-0001S1-Do; Sun, 26 Jul 2020 12:58:37 +0000
Date:   Sun, 26 Jul 2020 20:58:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:WIP.x86/entry] BUILD REGRESSION
 6ea7527a81333198dfb204c95e57e1891c61bfcd
Message-ID: <5f1d7de0.1/TrGqkTfQZMeqTK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  WIP.x86/entry
branch HEAD: 6ea7527a81333198dfb204c95e57e1891c61bfcd  Merge branch 'locking/nmi' into x86/entry

Error/Warning in current branch:

include/linux/irqflags.h:40:41: error: expected expression before ')' token

Error/Warning ids grouped by kconfigs:

recent_errors
|-- i386-allyesconfig
|   `-- include-linux-irqflags.h:error:expected-expression-before-)-token
|-- x86_64-allyesconfig
|   `-- include-linux-irqflags.h:error:expected-expression-before-)-token
|-- x86_64-lkp
|   `-- include-linux-irqflags.h:error:expected-expression-before-)-token
|-- x86_64-randconfig-c002-20200726
|   `-- include-linux-irqflags.h:error:expected-expression-before-)-token
`-- x86_64-rhel-7.6-kselftests
    `-- include-linux-irqflags.h:error:expected-expression-before-)-token

elapsed time: 1600m

configs tested: 92
configs skipped: 1

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
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
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
