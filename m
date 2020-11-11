Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636712AE6E5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 04:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgKKDNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 22:13:40 -0500
Received: from mga04.intel.com ([192.55.52.120]:23542 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgKKDNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 22:13:40 -0500
IronPort-SDR: y22DogiJ77zt8Td/99i6RLFaTWxjqTVwiMnlPRurPNLGp1BhRhPXcNRobXPVKdLoKMChfVpPDb
 OCF/ctH9GiRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="167503404"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="167503404"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 19:13:39 -0800
IronPort-SDR: Hcs3e31srey0nlQgBwuc3Wya+Xw3V3WL6TyUXcb9gkvrWYeCBQmWf0iSTe+UpENcQREQleFUbX
 EjaNyNXbkrcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="354713074"
Received: from lkp-server02.sh.intel.com (HELO 14a21f3b7a6a) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 10 Nov 2020 19:13:37 -0800
Received: from kbuild by 14a21f3b7a6a with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kcgZl-00000S-5r; Wed, 11 Nov 2020 03:13:37 +0000
Date:   Wed, 11 Nov 2020 11:13:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:auto-latest] BUILD SUCCESS
 8624d09ea0d50b66d0b2ac8eaa8d450264bdcd91
Message-ID: <5fab56be.uNodcYJBaoVvp3a8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  auto-latest
branch HEAD: 8624d09ea0d50b66d0b2ac8eaa8d450264bdcd91  Merge branch 'core/entry'

elapsed time: 1081m

configs tested: 111
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                malta_kvm_guest_defconfig
mips                         rt305x_defconfig
mips                           jazz_defconfig
m68k                        stmark2_defconfig
arm                          imote2_defconfig
powerpc                   motionpro_defconfig
sh                           se7750_defconfig
arm                          moxart_defconfig
powerpc                          g5_defconfig
mips                           ip22_defconfig
arm                      jornada720_defconfig
arm                            zeus_defconfig
arc                 nsimosci_hs_smp_defconfig
sparc64                             defconfig
arm                          badge4_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
sh                          rsk7203_defconfig
arm                       cns3420vb_defconfig
arm                           omap1_defconfig
c6x                        evmc6472_defconfig
arm                          ixp4xx_defconfig
sh                          r7785rp_defconfig
m68k                       bvme6000_defconfig
arm                       spear13xx_defconfig
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
x86_64               randconfig-a003-20201110
x86_64               randconfig-a005-20201110
x86_64               randconfig-a004-20201110
x86_64               randconfig-a002-20201110
x86_64               randconfig-a006-20201110
x86_64               randconfig-a001-20201110
i386                 randconfig-a006-20201110
i386                 randconfig-a005-20201110
i386                 randconfig-a002-20201110
i386                 randconfig-a001-20201110
i386                 randconfig-a003-20201110
i386                 randconfig-a004-20201110
i386                 randconfig-a006-20201111
i386                 randconfig-a005-20201111
i386                 randconfig-a002-20201111
i386                 randconfig-a001-20201111
i386                 randconfig-a003-20201111
i386                 randconfig-a004-20201111
i386                 randconfig-a012-20201110
i386                 randconfig-a014-20201110
i386                 randconfig-a016-20201110
i386                 randconfig-a011-20201110
i386                 randconfig-a015-20201110
i386                 randconfig-a013-20201110
i386                 randconfig-a012-20201111
i386                 randconfig-a014-20201111
i386                 randconfig-a016-20201111
i386                 randconfig-a011-20201111
i386                 randconfig-a015-20201111
i386                 randconfig-a013-20201111
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
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
x86_64               randconfig-a015-20201110
x86_64               randconfig-a011-20201110
x86_64               randconfig-a014-20201110
x86_64               randconfig-a013-20201110
x86_64               randconfig-a016-20201110
x86_64               randconfig-a012-20201110

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
