Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1457301E02
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 18:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbhAXRuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 12:50:25 -0500
Received: from mga02.intel.com ([134.134.136.20]:48866 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbhAXRuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 12:50:24 -0500
IronPort-SDR: lWMfKV8mBeWdnN/HfL2OWWyti1bsVk2JdFECDoncKpFRLfxgG5rYq8fJ+6BwGojBQVGPjY11z+
 g/1UQW73cw4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="166729359"
X-IronPort-AV: E=Sophos;i="5.79,371,1602572400"; 
   d="scan'208";a="166729359"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2021 09:49:43 -0800
IronPort-SDR: uFfMO18GSO3h1zmsypelOV+0TS0zYR6j1hhpv0va6G7RHNMeNgQNsi4fBEe2BLMVax+8UfNlNp
 6bSr9pKmWIUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,371,1602572400"; 
   d="scan'208";a="576316375"
Received: from lkp-server01.sh.intel.com (HELO 27c4e0a4b6d9) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jan 2021 09:49:42 -0800
Received: from kbuild by 27c4e0a4b6d9 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l3jW9-0000No-EK; Sun, 24 Jan 2021 17:49:41 +0000
Date:   Mon, 25 Jan 2021 01:49:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.01.21b] BUILD SUCCESS
 f3ab77a0df4972bcc272ca45ac407dde1d9409e6
Message-ID: <600db318.O3X6sfUDntqieTn4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.01.21b
branch HEAD: f3ab77a0df4972bcc272ca45ac407dde1d9409e6  preempt/dynamic: Support dynamic preempt with preempt= boot option

elapsed time: 733m

configs tested: 87
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc               mpc834x_itxgp_defconfig
mips                        omega2p_defconfig
powerpc                     tqm8548_defconfig
arm                      jornada720_defconfig
mips                         tb0219_defconfig
powerpc                      pcm030_defconfig
powerpc                       ebony_defconfig
sh                             espt_defconfig
sparc64                             defconfig
nios2                            alldefconfig
arm                          pcm027_defconfig
mips                       capcella_defconfig
mips                          ath25_defconfig
sh                   rts7751r2dplus_defconfig
arm                          simpad_defconfig
m68k                        m5407c3_defconfig
mips                           jazz_defconfig
arm                         lpc32xx_defconfig
arm                        neponset_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                             allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210124
i386                 randconfig-a002-20210124
i386                 randconfig-a003-20210124
x86_64               randconfig-a012-20210124
x86_64               randconfig-a016-20210124
x86_64               randconfig-a015-20210124
x86_64               randconfig-a011-20210124
x86_64               randconfig-a013-20210124
x86_64               randconfig-a014-20210124
i386                 randconfig-a013-20210124
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210124
x86_64               randconfig-a002-20210124
x86_64               randconfig-a001-20210124
x86_64               randconfig-a005-20210124
x86_64               randconfig-a006-20210124
x86_64               randconfig-a004-20210124

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
