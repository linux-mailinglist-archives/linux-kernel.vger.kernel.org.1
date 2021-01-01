Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293392E8353
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 09:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbhAAIcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jan 2021 03:32:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:26512 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbhAAIcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jan 2021 03:32:01 -0500
IronPort-SDR: vIolvsz4TJoweul10dqqjuB2LYrjtVR/f2/AxhMeyMI/gHeZwbLpzNxxd87UAnhGaUtiQCRIat
 LLAR5JpdE5ng==
X-IronPort-AV: E=McAfee;i="6000,8403,9851"; a="175988033"
X-IronPort-AV: E=Sophos;i="5.78,466,1599548400"; 
   d="scan'208";a="175988033"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2021 00:31:19 -0800
IronPort-SDR: yf9MOKL/BZMOrYTNsvyjpb39w/yDMlCSnOlgAjDW9bg3qzzOST1Jm9jwQY2/6UMimwJ/ojcARP
 N7/RkJgCiEcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,466,1599548400"; 
   d="scan'208";a="348727352"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 01 Jan 2021 00:31:18 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kvFqA-0005RA-4P; Fri, 01 Jan 2021 08:31:18 +0000
Date:   Fri, 01 Jan 2021 16:30:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 6b0ac27ffb70d3f7dbba28a1053ac114db75b146
Message-ID: <5feeddad.SNa2whO9QdK03n3g%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: 6b0ac27ffb70d3f7dbba28a1053ac114db75b146  ACPI: processor: Fix missing need_resched() check after rcu_idle_enter()

elapsed time: 722m

configs tested: 127
configs skipped: 31

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
s390                          debug_defconfig
sh                        apsh4ad0a_defconfig
m68k                        mvme147_defconfig
arm                           viper_defconfig
sh                          rsk7201_defconfig
mips                           gcw0_defconfig
powerpc                    amigaone_defconfig
powerpc                     ep8248e_defconfig
arc                           tb10x_defconfig
powerpc                      pmac32_defconfig
sh                        edosk7705_defconfig
arm                    vt8500_v6_v7_defconfig
h8300                     edosk2674_defconfig
arm                          pxa3xx_defconfig
arm                           omap1_defconfig
sh                         ecovec24_defconfig
powerpc                     mpc5200_defconfig
arm                     davinci_all_defconfig
powerpc                 mpc8272_ads_defconfig
arm                         lubbock_defconfig
riscv                          rv32_defconfig
xtensa                           allyesconfig
powerpc                       maple_defconfig
powerpc                 mpc8540_ads_defconfig
sh                           se7724_defconfig
mips                          ath25_defconfig
parisc                              defconfig
m68k                          sun3x_defconfig
m68k                       m5275evb_defconfig
arm                        vexpress_defconfig
arm                       multi_v4t_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                         microdev_defconfig
powerpc                      acadia_defconfig
arm                          ixp4xx_defconfig
microblaze                      mmu_defconfig
m68k                       m5208evb_defconfig
arm                       cns3420vb_defconfig
arc                            hsdk_defconfig
mips                       capcella_defconfig
sh                            hp6xx_defconfig
arc                          axs103_defconfig
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
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
i386                 randconfig-a005-20210101
i386                 randconfig-a002-20210101
i386                 randconfig-a001-20210101
i386                 randconfig-a003-20210101
i386                 randconfig-a006-20210101
i386                 randconfig-a004-20210101
x86_64               randconfig-a013-20210101
x86_64               randconfig-a012-20210101
x86_64               randconfig-a011-20210101
x86_64               randconfig-a016-20210101
x86_64               randconfig-a014-20210101
x86_64               randconfig-a015-20210101
x86_64               randconfig-a015-20201231
x86_64               randconfig-a014-20201231
x86_64               randconfig-a011-20201231
x86_64               randconfig-a016-20201231
x86_64               randconfig-a013-20201231
x86_64               randconfig-a012-20201231
i386                 randconfig-a016-20210101
i386                 randconfig-a011-20210101
i386                 randconfig-a014-20210101
i386                 randconfig-a015-20210101
i386                 randconfig-a013-20210101
i386                 randconfig-a012-20210101
i386                 randconfig-a016-20201231
i386                 randconfig-a014-20201231
i386                 randconfig-a012-20201231
i386                 randconfig-a015-20201231
i386                 randconfig-a011-20201231
i386                 randconfig-a013-20201231
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20201231
x86_64               randconfig-a006-20201231
x86_64               randconfig-a001-20201231
x86_64               randconfig-a002-20201231
x86_64               randconfig-a004-20201231
x86_64               randconfig-a003-20201231

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
