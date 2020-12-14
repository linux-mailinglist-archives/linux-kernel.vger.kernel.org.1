Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80042D944C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 09:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406789AbgLNIoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 03:44:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:54257 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387906AbgLNIoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 03:44:10 -0500
IronPort-SDR: TNa/NlvzCB6UnSAQNRyLMjOOcc3PFygvbriqDADGK84BwiU2R8MZuzoCQ8lbXKmfMBqozVNPwL
 VNV5/dBtWWAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9834"; a="236261355"
X-IronPort-AV: E=Sophos;i="5.78,418,1599548400"; 
   d="scan'208";a="236261355"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2020 00:43:29 -0800
IronPort-SDR: pmqH/9W0YHmYSL3r2xAFIJGeLSsQxsY0XmRXx/NFSpbXVWDzbVotXboiu6hzhSfRhhA5IK9ZBP
 q5Dwr3eencfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,418,1599548400"; 
   d="scan'208";a="351218857"
Received: from lkp-server02.sh.intel.com (HELO a947d92d0467) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 14 Dec 2020 00:43:00 -0800
Received: from kbuild by a947d92d0467 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kojRb-0000D3-QU; Mon, 14 Dec 2020 08:42:59 +0000
Date:   Mon, 14 Dec 2020 16:42:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.12.11a] BUILD SUCCESS
 457a888fb6f529c50eb5bcaf1efe416f58d89d6f
Message-ID: <5fd72585.kL6/F/656o53H+1f%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.12.11a
branch HEAD: 457a888fb6f529c50eb5bcaf1efe416f58d89d6f  squash! torture: Compress KASAN vmlinux files

elapsed time: 723m

configs tested: 94
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7705_defconfig
sh                      rts7751r2d1_defconfig
sh                           se7206_defconfig
powerpc                    sam440ep_defconfig
arc                              allyesconfig
powerpc                      cm5200_defconfig
xtensa                  audio_kc705_defconfig
sh                        dreamcast_defconfig
arm                         cm_x300_defconfig
openrisc                         alldefconfig
arm                         at91_dt_defconfig
arm                       netwinder_defconfig
arm                          ixp4xx_defconfig
arm                          pxa910_defconfig
mips                      fuloong2e_defconfig
mips                         db1xxx_defconfig
arm                             ezx_defconfig
mips                       bmips_be_defconfig
sh                            migor_defconfig
powerpc                 mpc85xx_cds_defconfig
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
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20201214
i386                 randconfig-a004-20201214
i386                 randconfig-a003-20201214
i386                 randconfig-a002-20201214
i386                 randconfig-a006-20201214
i386                 randconfig-a005-20201214
i386                 randconfig-a014-20201213
i386                 randconfig-a013-20201213
i386                 randconfig-a012-20201213
i386                 randconfig-a011-20201213
i386                 randconfig-a016-20201213
i386                 randconfig-a015-20201213
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
x86_64               randconfig-a016-20201213
x86_64               randconfig-a012-20201213
x86_64               randconfig-a013-20201213
x86_64               randconfig-a015-20201213
x86_64               randconfig-a014-20201213
x86_64               randconfig-a011-20201213
x86_64               randconfig-a003-20201214
x86_64               randconfig-a006-20201214
x86_64               randconfig-a002-20201214
x86_64               randconfig-a005-20201214
x86_64               randconfig-a004-20201214
x86_64               randconfig-a001-20201214

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
