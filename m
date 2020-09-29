Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A29827C858
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbgI2MBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:01:23 -0400
Received: from mga12.intel.com ([192.55.52.136]:25205 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730569AbgI2MBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 08:01:07 -0400
IronPort-SDR: hzTq/ltIWtL0JFO+QutuA8jdYTRhSEwY2Yr9Lg1Y2Ldzax1rz3VCb4YXCU6u6bMzuK339sMpu7
 RFVXvqmkvrfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="141576130"
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; 
   d="scan'208";a="141576130"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 05:01:02 -0700
IronPort-SDR: /yubeeYt08rvwowii5X+c0EBH3Ooe//H+IqTAgKmHHyX9W1xisYA6acACpiEovIGR0YiPigmeP
 E1ga36RyPP3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; 
   d="scan'208";a="457252233"
Received: from lkp-server02.sh.intel.com (HELO dda5aa0886d8) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 29 Sep 2020 05:01:01 -0700
Received: from kbuild by dda5aa0886d8 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kNEJY-0000A0-J3; Tue, 29 Sep 2020 12:01:00 +0000
Date:   Tue, 29 Sep 2020 20:00:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.09.25b] BUILD SUCCESS
 a7ba9904d1df259975dd4e532c7645c79cbe65eb
Message-ID: <5f7321d6.H9WzjGI9yF+/Gci5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.09.25b
branch HEAD: a7ba9904d1df259975dd4e532c7645c79cbe65eb  locktorture: Invoke percpu_free_rwsem() to do percpu-rwsem cleanup

elapsed time: 723m

configs tested: 115
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       imx_v6_v7_defconfig
powerpc                 mpc8560_ads_defconfig
arm                      integrator_defconfig
arm                            lart_defconfig
um                             i386_defconfig
sh                             shx3_defconfig
arm                        oxnas_v6_defconfig
powerpc                  mpc885_ads_defconfig
openrisc                         alldefconfig
arm                         at91_dt_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                   sh7770_generic_defconfig
arm                         assabet_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                   lite5200b_defconfig
m68k                        m5272c3_defconfig
riscv                            allmodconfig
powerpc                    ge_imp3a_defconfig
powerpc                       ebony_defconfig
sh                ecovec24-romimage_defconfig
powerpc                     taishan_defconfig
sh                        edosk7705_defconfig
powerpc                      ppc64e_defconfig
powerpc                      katmai_defconfig
mips                    maltaup_xpa_defconfig
ia64                      gensparse_defconfig
arm                         orion5x_defconfig
arm                          pxa3xx_defconfig
sh                           se7712_defconfig
mips                     loongson1c_defconfig
arm                      footbridge_defconfig
arc                             nps_defconfig
arm                         bcm2835_defconfig
arc                     haps_hs_smp_defconfig
mips                           xway_defconfig
ia64                            zx1_defconfig
arm                          pxa910_defconfig
powerpc                  storcenter_defconfig
s390                             alldefconfig
arm                       multi_v4t_defconfig
powerpc                      pmac32_defconfig
arm                           sunxi_defconfig
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
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
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
x86_64               randconfig-a005-20200929
x86_64               randconfig-a003-20200929
x86_64               randconfig-a004-20200929
x86_64               randconfig-a002-20200929
x86_64               randconfig-a006-20200929
x86_64               randconfig-a001-20200929

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
