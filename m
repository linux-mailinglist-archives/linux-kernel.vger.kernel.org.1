Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D08224A95
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 12:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgGRK36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 06:29:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:8569 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgGRK3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 06:29:55 -0400
IronPort-SDR: /idt12LN+M+ibu8AFxdpS9hkcU93lR7EvorIgSV1pCU9nRtgbzM6fFC3EUGbOnV4MSOh0sb3Gq
 rABdBq6xSEyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9685"; a="167867665"
X-IronPort-AV: E=Sophos;i="5.75,366,1589266800"; 
   d="scan'208";a="167867665"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2020 03:29:55 -0700
IronPort-SDR: cyuEgSxJylhkUxtd9Z5Ga4j7aRRbADYR4oRH5k2D0Lv7QOpb1p+IrI8xrfvl4MPEa8rQTqOF9c
 jOvpKEB4aXuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,366,1589266800"; 
   d="scan'208";a="283029354"
Received: from lkp-server02.sh.intel.com (HELO 50058c6ee6fc) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 18 Jul 2020 03:29:53 -0700
Received: from kbuild by 50058c6ee6fc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jwk6L-0000jq-7r; Sat, 18 Jul 2020 10:29:53 +0000
Date:   Sat, 18 Jul 2020 18:28:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 36cd28a4cdd05d47ccb62a2d86e8f37839cc879a
Message-ID: <5f12ceb8.jYLhPH6slNcfHzWQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  timers/core
branch HEAD: 36cd28a4cdd05d47ccb62a2d86e8f37839cc879a  timers: Lower base clock forwarding threshold

i386-tinyconfig vmlinux size:

=====================================================================================================================
 TOTAL  TEXT  run_timer_softirq()  calc_wheel_index()                                                                
=====================================================================================================================
     0     0                    0                   0  30c66fc30ee7 timer: Prevent base->clk from moving backward    
    +7    +5                    0                  +5  e2a71bdea816 timer: Fix wheel index calculation on last level 
  +414  +412                 +186                +108  dcb7fd82c75e..36cd28a4cdd0 (ALL COMMITS)                      
=====================================================================================================================

elapsed time: 726m

configs tested: 112
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
nds32                             allnoconfig
powerpc                      ppc64e_defconfig
arm                           viper_defconfig
ia64                             alldefconfig
sh                           se7721_defconfig
arm                           corgi_defconfig
sh                        edosk7760_defconfig
mips                        omega2p_defconfig
powerpc                  storcenter_defconfig
arm                           tegra_defconfig
h8300                            allyesconfig
powerpc                 linkstation_defconfig
sparc                       sparc32_defconfig
arm                          badge4_defconfig
powerpc                      pmac32_defconfig
riscv                          rv32_defconfig
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
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
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
i386                 randconfig-a001-20200717
i386                 randconfig-a005-20200717
i386                 randconfig-a002-20200717
i386                 randconfig-a006-20200717
i386                 randconfig-a003-20200717
i386                 randconfig-a004-20200717
x86_64               randconfig-a005-20200717
x86_64               randconfig-a006-20200717
x86_64               randconfig-a002-20200717
x86_64               randconfig-a001-20200717
x86_64               randconfig-a003-20200717
x86_64               randconfig-a004-20200717
x86_64               randconfig-a012-20200716
x86_64               randconfig-a011-20200716
x86_64               randconfig-a016-20200716
x86_64               randconfig-a014-20200716
x86_64               randconfig-a013-20200716
x86_64               randconfig-a015-20200716
i386                 randconfig-a016-20200717
i386                 randconfig-a011-20200717
i386                 randconfig-a015-20200717
i386                 randconfig-a012-20200717
i386                 randconfig-a013-20200717
i386                 randconfig-a014-20200717
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
