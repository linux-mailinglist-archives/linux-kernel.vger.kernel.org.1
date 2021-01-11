Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811462F1AB8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732890AbhAKQQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:16:24 -0500
Received: from mga06.intel.com ([134.134.136.31]:55899 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730472AbhAKQQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:16:24 -0500
IronPort-SDR: CZdHZAoV+4FxQPWhF2J8dspYoor7Em41fNS0s25lQy9rIoTGvAOwQvuExfmfgeChdHkLV7kfSw
 Unflqg3elGDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9860"; a="239431242"
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="239431242"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 08:15:42 -0800
IronPort-SDR: f+CSvEBuxfGxXFmx2bVfWxpVI5vLfAnT23c/dbmDfZTfiFfDMJDAEHj14i2fgf5geFG0AsqFQp
 XYXygh1MLFeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; 
   d="scan'208";a="348153609"
Received: from lkp-server01.sh.intel.com (HELO 3cff8e4c45aa) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Jan 2021 08:15:41 -0800
Received: from kbuild by 3cff8e4c45aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kyzr3-0000DQ-1c; Mon, 11 Jan 2021 16:15:41 +0000
Date:   Tue, 12 Jan 2021 00:14:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS WITH WARNING
 122db0d42ba5aba3ec1aff777e6e4f6bbe52dd57
Message-ID: <5ffc7975.TWm909C8/WfTYrbi%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: 122db0d42ba5aba3ec1aff777e6e4f6bbe52dd57  torturescript: Don't rerun failed rcutorture builds

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-randconfig-c003-20210111
    `-- kernel-rcu-rcutorture.c:WARNING-kmalloc-is-used-to-allocate-this-memory-at-line

elapsed time: 724m

configs tested: 96
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
c6x                        evmc6457_defconfig
arc                            hsdk_defconfig
arm                         s5pv210_defconfig
mips                          ath25_defconfig
powerpc                       maple_defconfig
sh                          polaris_defconfig
arc                     haps_hs_smp_defconfig
arm                             mxs_defconfig
parisc                generic-32bit_defconfig
xtensa                       common_defconfig
mips                         bigsur_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                          pcm027_defconfig
mips                         cobalt_defconfig
powerpc                      chrp32_defconfig
m68k                          sun3x_defconfig
m68k                       m5275evb_defconfig
arm                       spear13xx_defconfig
arm                        oxnas_v6_defconfig
c6x                        evmc6474_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
i386                               tinyconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20210111
i386                 randconfig-a005-20210111
i386                 randconfig-a006-20210111
i386                 randconfig-a001-20210111
i386                 randconfig-a003-20210111
i386                 randconfig-a004-20210111
x86_64               randconfig-a015-20210110
x86_64               randconfig-a012-20210110
x86_64               randconfig-a013-20210110
x86_64               randconfig-a016-20210110
x86_64               randconfig-a014-20210110
x86_64               randconfig-a011-20210110
i386                 randconfig-a012-20210111
i386                 randconfig-a011-20210111
i386                 randconfig-a016-20210111
i386                 randconfig-a015-20210111
i386                 randconfig-a013-20210111
i386                 randconfig-a014-20210111
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
x86_64               randconfig-a004-20210110
x86_64               randconfig-a006-20210110
x86_64               randconfig-a001-20210110
x86_64               randconfig-a003-20210110
x86_64               randconfig-a005-20210110
x86_64               randconfig-a002-20210110

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
