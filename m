Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAAC268075
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 19:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgIMRI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 13:08:56 -0400
Received: from mga06.intel.com ([134.134.136.31]:60290 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgIMRIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 13:08:55 -0400
IronPort-SDR: Sv5N/j5whLKnAXNZmRNCw+Zsww7kPX6FbouA23XQv9eLuN1h75odLm7CNsHWdJq5aFZJSOO71g
 4QnEbZ9hllMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9743"; a="220547310"
X-IronPort-AV: E=Sophos;i="5.76,422,1592895600"; 
   d="scan'208";a="220547310"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2020 10:08:54 -0700
IronPort-SDR: tA/ku7jkQSkJTiOTDFXfhZZ/osXJuJHgEXh1jJigngadFNWve0+UogoiEKJ5YJUNpIgK8Lygz6
 0m1YQrybH5zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,422,1592895600"; 
   d="scan'208";a="379079244"
Received: from lkp-server01.sh.intel.com (HELO a75722977aa5) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Sep 2020 10:08:53 -0700
Received: from kbuild by a75722977aa5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kHVUj-0000rd-7e; Sun, 13 Sep 2020 17:08:53 +0000
Date:   Mon, 14 Sep 2020 01:08:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 45faed7569d35a7890e734d9d8d5b5cfe5f4c438
Message-ID: <5f5e5206.4wth2TdjoethtBj+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: 45faed7569d35a7890e734d9d8d5b5cfe5f4c438  srcu: Take early exit on memory-allocation failure

elapsed time: 724m

configs tested: 109
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
s390                          debug_defconfig
arm                          gemini_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                          malta_defconfig
arm                         s3c2410_defconfig
powerpc                      ppc44x_defconfig
arm                       aspeed_g4_defconfig
sh                          r7780mp_defconfig
arm                       netwinder_defconfig
arm                         lpc32xx_defconfig
xtensa                              defconfig
arm                          simpad_defconfig
arc                          axs101_defconfig
powerpc                      pasemi_defconfig
arc                    vdk_hs38_smp_defconfig
mips                           rs90_defconfig
sparc                       sparc32_defconfig
arc                                 defconfig
arm                        shmobile_defconfig
arm                          tango4_defconfig
h8300                            alldefconfig
arc                          axs103_defconfig
parisc                              defconfig
arm                          pxa3xx_defconfig
mips                          rm200_defconfig
arm                          iop32x_defconfig
mips                           gcw0_defconfig
arc                            hsdk_defconfig
ia64                             allyesconfig
mips                        vocore2_defconfig
openrisc                    or1ksim_defconfig
sh                           se7705_defconfig
mips                       capcella_defconfig
mips                malta_kvm_guest_defconfig
nds32                               defconfig
powerpc                    amigaone_defconfig
mips                 pnx8335_stb225_defconfig
sh                          r7785rp_defconfig
powerpc                      arches_defconfig
m68k                          atari_defconfig
powerpc                        fsp2_defconfig
arm                        spear3xx_defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
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
i386                 randconfig-a004-20200913
i386                 randconfig-a006-20200913
i386                 randconfig-a003-20200913
i386                 randconfig-a001-20200913
i386                 randconfig-a002-20200913
i386                 randconfig-a005-20200913
x86_64               randconfig-a014-20200913
x86_64               randconfig-a011-20200913
x86_64               randconfig-a012-20200913
x86_64               randconfig-a016-20200913
x86_64               randconfig-a015-20200913
x86_64               randconfig-a013-20200913
i386                 randconfig-a015-20200913
i386                 randconfig-a014-20200913
i386                 randconfig-a011-20200913
i386                 randconfig-a013-20200913
i386                 randconfig-a016-20200913
i386                 randconfig-a012-20200913
riscv                            allyesconfig
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
x86_64               randconfig-a006-20200913
x86_64               randconfig-a004-20200913
x86_64               randconfig-a003-20200913
x86_64               randconfig-a002-20200913
x86_64               randconfig-a005-20200913
x86_64               randconfig-a001-20200913

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
