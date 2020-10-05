Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3816283F83
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 21:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbgJETWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 15:22:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:53215 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgJETWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 15:22:33 -0400
IronPort-SDR: tgA7504hS4hYcU3ddEXk7k+CFd9w6FMNk8dPWLKzNHUpDZ0NONfg+Wju04rxoXaHJhrqMoXru7
 ooSv/c6rMfXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="151655681"
X-IronPort-AV: E=Sophos;i="5.77,340,1596524400"; 
   d="scan'208";a="151655681"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 12:13:04 -0700
IronPort-SDR: 7jHHCy1LuL6f0XkBYfOPE9Zk1DHLOLyLtr8WVVm4OEDrZemImJBXH/DrdiHANUb6vEqDOn6vac
 rkrW3GrN8bjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,340,1596524400"; 
   d="scan'208";a="526294488"
Received: from lkp-server02.sh.intel.com (HELO b5ae2f167493) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 05 Oct 2020 10:43:03 -0700
Received: from kbuild by b5ae2f167493 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kPUVg-0000tc-4O; Mon, 05 Oct 2020 17:42:52 +0000
Date:   Tue, 06 Oct 2020 01:42:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 d429a8e5aae53186cedb473439de6d59661f15c9
Message-ID: <5f7b5ae8.47SLUTO5YT7tqXlN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: d429a8e5aae53186cedb473439de6d59661f15c9  rcu,ftrace: Fix ftrace recursion

elapsed time: 722m

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
powerpc                     pq2fads_defconfig
riscv                            alldefconfig
mips                           ip32_defconfig
arc                          axs103_defconfig
powerpc                     tqm8541_defconfig
arm                          moxart_defconfig
mips                           xway_defconfig
sh                              ul2_defconfig
riscv                          rv32_defconfig
arm                        clps711x_defconfig
arm                            hisi_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     ksi8560_defconfig
arm                            zeus_defconfig
sh                      rts7751r2d1_defconfig
arm                         axm55xx_defconfig
arm                       mainstone_defconfig
arm                          exynos_defconfig
arm                           corgi_defconfig
powerpc                      ep88xc_defconfig
powerpc64                           defconfig
arm                            pleb_defconfig
c6x                              alldefconfig
i386                             allyesconfig
xtensa                         virt_defconfig
powerpc                 mpc834x_itx_defconfig
sh                          landisk_defconfig
arm                         bcm2835_defconfig
powerpc                     pseries_defconfig
powerpc                     mpc5200_defconfig
alpha                            alldefconfig
m68k                            q40_defconfig
c6x                                 defconfig
mips                           rs90_defconfig
sh                          urquell_defconfig
powerpc                 mpc8313_rdb_defconfig
riscv                    nommu_virt_defconfig
sh                        apsh4ad0a_defconfig
mips                         mpc30x_defconfig
arm                        spear3xx_defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201005
i386                 randconfig-a005-20201005
i386                 randconfig-a001-20201005
i386                 randconfig-a004-20201005
i386                 randconfig-a003-20201005
i386                 randconfig-a002-20201005
x86_64               randconfig-a012-20201005
x86_64               randconfig-a015-20201005
x86_64               randconfig-a014-20201005
x86_64               randconfig-a013-20201005
x86_64               randconfig-a011-20201005
x86_64               randconfig-a016-20201005
i386                 randconfig-a014-20201005
i386                 randconfig-a015-20201005
i386                 randconfig-a013-20201005
i386                 randconfig-a016-20201005
i386                 randconfig-a011-20201005
i386                 randconfig-a012-20201005
riscv                    nommu_k210_defconfig
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
x86_64               randconfig-a004-20201005
x86_64               randconfig-a002-20201005
x86_64               randconfig-a001-20201005
x86_64               randconfig-a003-20201005
x86_64               randconfig-a005-20201005
x86_64               randconfig-a006-20201005

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
