Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5127327CBB0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgI2LXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 07:23:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:4731 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729438AbgI2LRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:17:34 -0400
IronPort-SDR: yPDuCnUzXdw1E2lG/oyxxzrXI6YmYl1flCKefe1xh4EGCOXuzkLwgIwcgrcf169C6d7p1HOQH4
 LNKq31A0m27A==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="223755289"
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; 
   d="scan'208";a="223755289"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 04:17:32 -0700
IronPort-SDR: Swr8C4loAq/cyZqbHf/Y5JidPgI7itO/PHCZgXfPrBVqjifmd4hr93kcQBbqhQr12Lq/Q6y3O/
 WmZIA6aqArPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; 
   d="scan'208";a="490259651"
Received: from lkp-server02.sh.intel.com (HELO dda5aa0886d8) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 29 Sep 2020 04:17:31 -0700
Received: from kbuild by dda5aa0886d8 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kNDdS-00009A-Py; Tue, 29 Sep 2020 11:17:30 +0000
Date:   Tue, 29 Sep 2020 19:16:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:urezki-pcount] BUILD SUCCESS
 5f5f44ca646fa86f31cc66de8b647c8dba40a8a7
Message-ID: <5f731797.mokTWNkNDphwSEgI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  urezki-pcount
branch HEAD: 5f5f44ca646fa86f31cc66de8b647c8dba40a8a7  EXP Revert "KVM: Check the allocation of pv cpu mask"

elapsed time: 725m

configs tested: 103
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
m68k                          hp300_defconfig
arm                          moxart_defconfig
powerpc                         wii_defconfig
arm                           sunxi_defconfig
h8300                            allyesconfig
mips                           ip28_defconfig
xtensa                  audio_kc705_defconfig
c6x                        evmc6474_defconfig
powerpc                     rainier_defconfig
sh                           se7619_defconfig
i386                             alldefconfig
sh                           se7724_defconfig
riscv                    nommu_virt_defconfig
arm                         mv78xx0_defconfig
powerpc                     kilauea_defconfig
arm                        shmobile_defconfig
sh                           se7751_defconfig
arm                       cns3420vb_defconfig
h8300                    h8300h-sim_defconfig
sh                           se7750_defconfig
mips                           xway_defconfig
arm                        cerfcube_defconfig
arm                  colibri_pxa270_defconfig
sh                          rsk7201_defconfig
mips                      maltaaprp_defconfig
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
x86_64               randconfig-a005-20200928
x86_64               randconfig-a003-20200928
x86_64               randconfig-a004-20200928
x86_64               randconfig-a002-20200928
x86_64               randconfig-a006-20200928
x86_64               randconfig-a001-20200928
i386                 randconfig-a006-20200928
i386                 randconfig-a002-20200928
i386                 randconfig-a003-20200928
i386                 randconfig-a004-20200928
i386                 randconfig-a005-20200928
i386                 randconfig-a001-20200928
x86_64               randconfig-a011-20200929
x86_64               randconfig-a013-20200929
x86_64               randconfig-a015-20200929
x86_64               randconfig-a014-20200929
x86_64               randconfig-a016-20200929
x86_64               randconfig-a012-20200929
i386                 randconfig-a012-20200928
i386                 randconfig-a016-20200928
i386                 randconfig-a014-20200928
i386                 randconfig-a013-20200928
i386                 randconfig-a015-20200928
i386                 randconfig-a011-20200928
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-a005-20200929
x86_64               randconfig-a003-20200929
x86_64               randconfig-a004-20200929
x86_64               randconfig-a002-20200929
x86_64               randconfig-a006-20200929
x86_64               randconfig-a001-20200929

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
