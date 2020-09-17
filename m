Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D900126DBF1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbgIQMqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 08:46:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:61610 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbgIQMnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 08:43:20 -0400
IronPort-SDR: 0h8UUWqgI7Z6d8+c02Q/048ALz4aNpTFaCJgp1RUvhEDATfuZStD9KR98iF6jIDegXotY1JFiq
 W+AQXHEZtG/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="147373218"
X-IronPort-AV: E=Sophos;i="5.76,436,1592895600"; 
   d="scan'208";a="147373218"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 05:43:14 -0700
IronPort-SDR: 6Fvuxw55l3OKRZviiauIZyNQL4kpmHf99NHxt4c4qKXQYH1ht4L8rqosI2oDIyrXzxk4SBVx8k
 eXU3K9SPlTPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,436,1592895600"; 
   d="scan'208";a="288753780"
Received: from lkp-server02.sh.intel.com (HELO bdcb92cf8b4e) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 17 Sep 2020 05:43:10 -0700
Received: from kbuild by bdcb92cf8b4e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kItFm-0000bK-7N; Thu, 17 Sep 2020 12:43:10 +0000
Date:   Thu, 17 Sep 2020 20:43:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rtt-speedup.2020.09.16a] BUILD SUCCESS
 f747c7e15d7bc71a967a94ceda686cf2460b69e8
Message-ID: <5f6359d4.aVQii8cmphu1HFbK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rtt-speedup.2020.09.16a
branch HEAD: f747c7e15d7bc71a967a94ceda686cf2460b69e8  rcu-tasks: Enclose task-list scan in rcu_read_lock()

elapsed time: 723m

configs tested: 162
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                    vt8500_v6_v7_defconfig
arm                       omap2plus_defconfig
arc                     haps_hs_smp_defconfig
sparc                               defconfig
m68k                        mvme16x_defconfig
sh                             espt_defconfig
mips                        omega2p_defconfig
arm                         lubbock_defconfig
arm                           spitz_defconfig
powerpc                        warp_defconfig
sh                        dreamcast_defconfig
parisc                           allyesconfig
m68k                          hp300_defconfig
powerpc                      mgcoge_defconfig
powerpc                 mpc832x_mds_defconfig
arm                            u300_defconfig
m68k                             allyesconfig
arm                         axm55xx_defconfig
sh                           se7722_defconfig
powerpc                      pasemi_defconfig
sh                        apsh4ad0a_defconfig
arm                         ebsa110_defconfig
openrisc                         alldefconfig
arm                      tct_hammer_defconfig
openrisc                 simple_smp_defconfig
arm                      jornada720_defconfig
mips                     decstation_defconfig
mips                      malta_kvm_defconfig
sh                        sh7763rdp_defconfig
arm                          pcm027_defconfig
powerpc                  storcenter_defconfig
mips                         cobalt_defconfig
m68k                             alldefconfig
sh                   sh7724_generic_defconfig
mips                          malta_defconfig
m68k                          sun3x_defconfig
sh                        edosk7705_defconfig
riscv                            alldefconfig
sh                   secureedge5410_defconfig
sh                            shmin_defconfig
arm                           efm32_defconfig
arm                             mxs_defconfig
arc                            hsdk_defconfig
arm                           u8500_defconfig
arm                      integrator_defconfig
powerpc                  mpc885_ads_defconfig
nios2                            allyesconfig
arm                           sama5_defconfig
sh                ecovec24-romimage_defconfig
mips                         tb0287_defconfig
mips                         db1xxx_defconfig
arc                             nps_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc836x_mds_defconfig
mips                         rt305x_defconfig
powerpc                  mpc866_ads_defconfig
alpha                            alldefconfig
m68k                         apollo_defconfig
alpha                               defconfig
powerpc                   motionpro_defconfig
powerpc                      obs600_defconfig
powerpc                     rainier_defconfig
arm                         assabet_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                       imx_v6_v7_defconfig
arc                           tb10x_defconfig
arm                             ezx_defconfig
arm                        multi_v5_defconfig
arm                       spear13xx_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20200916
x86_64               randconfig-a004-20200916
x86_64               randconfig-a003-20200916
x86_64               randconfig-a002-20200916
x86_64               randconfig-a001-20200916
x86_64               randconfig-a005-20200916
i386                 randconfig-a004-20200916
i386                 randconfig-a006-20200916
i386                 randconfig-a003-20200916
i386                 randconfig-a001-20200916
i386                 randconfig-a002-20200916
i386                 randconfig-a005-20200916
i386                 randconfig-a004-20200917
i386                 randconfig-a006-20200917
i386                 randconfig-a003-20200917
i386                 randconfig-a001-20200917
i386                 randconfig-a002-20200917
i386                 randconfig-a005-20200917
x86_64               randconfig-a014-20200917
x86_64               randconfig-a011-20200917
x86_64               randconfig-a016-20200917
x86_64               randconfig-a012-20200917
x86_64               randconfig-a015-20200917
x86_64               randconfig-a013-20200917
i386                 randconfig-a015-20200917
i386                 randconfig-a014-20200917
i386                 randconfig-a011-20200917
i386                 randconfig-a013-20200917
i386                 randconfig-a016-20200917
i386                 randconfig-a012-20200917
i386                 randconfig-a015-20200916
i386                 randconfig-a014-20200916
i386                 randconfig-a011-20200916
i386                 randconfig-a013-20200916
i386                 randconfig-a016-20200916
i386                 randconfig-a012-20200916
riscv                             allnoconfig
riscv                               defconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20200917
x86_64               randconfig-a004-20200917
x86_64               randconfig-a003-20200917
x86_64               randconfig-a002-20200917
x86_64               randconfig-a001-20200917
x86_64               randconfig-a005-20200917
x86_64               randconfig-a014-20200916
x86_64               randconfig-a011-20200916
x86_64               randconfig-a016-20200916
x86_64               randconfig-a012-20200916
x86_64               randconfig-a015-20200916
x86_64               randconfig-a013-20200916

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
