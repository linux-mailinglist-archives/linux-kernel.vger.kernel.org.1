Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5662D386E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 02:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgLIBvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 20:51:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:50279 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbgLIBv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 20:51:26 -0500
IronPort-SDR: qRiumOC68OzkaQ6R9y8JKqtfjsDD47lQCYHHAiFeV+tXfHPZvtC2U7tX2yVbxRF9rcCX8kiN4q
 Q87hCMNb9PzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="170493288"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="170493288"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 17:50:45 -0800
IronPort-SDR: p/ncTIdi+1bLAXRyGr5c4rYDBvyH5k9HaRYhhjxrgUJJoUMQ2+F+gEFMTP+wKThCUyDIwsLnSv
 J5B3O8L5PtZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="483837578"
Received: from lkp-server01.sh.intel.com (HELO 4e633a5ce5ea) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 08 Dec 2020 17:50:44 -0800
Received: from kbuild by 4e633a5ce5ea with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kmoct-00004H-25; Wed, 09 Dec 2020 01:50:43 +0000
Date:   Wed, 09 Dec 2020 09:50:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/misc] BUILD SUCCESS
 f77f420d34754b8d08ac6ebf094ff7193023196a
Message-ID: <5fd02d5c.eBx2R3MPZxdvxGyQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/misc
branch HEAD: f77f420d34754b8d08ac6ebf094ff7193023196a  x86/msr: Add a pointer to an URL which contains further details

elapsed time: 722m

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
powerpc                          g5_defconfig
powerpc                     skiroot_defconfig
sh                   rts7751r2dplus_defconfig
sh                     magicpanelr2_defconfig
powerpc64                           defconfig
powerpc                     pseries_defconfig
powerpc                 canyonlands_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                         wii_defconfig
powerpc                     mpc83xx_defconfig
powerpc                     mpc5200_defconfig
sh                      rts7751r2d1_defconfig
sh                          polaris_defconfig
arm                        keystone_defconfig
ia64                            zx1_defconfig
arm                          simpad_defconfig
sh                         apsh4a3a_defconfig
mips                      bmips_stb_defconfig
arm                          ep93xx_defconfig
mips                  decstation_64_defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
sh                             espt_defconfig
x86_64                           alldefconfig
mips                        jmr3927_defconfig
xtensa                         virt_defconfig
m68k                       m5475evb_defconfig
mips                         mpc30x_defconfig
h8300                               defconfig
openrisc                 simple_smp_defconfig
s390                       zfcpdump_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                      ppc64e_defconfig
arm                         lubbock_defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201208
x86_64               randconfig-a006-20201208
x86_64               randconfig-a005-20201208
x86_64               randconfig-a001-20201208
x86_64               randconfig-a002-20201208
x86_64               randconfig-a003-20201208
i386                 randconfig-a004-20201208
i386                 randconfig-a005-20201208
i386                 randconfig-a001-20201208
i386                 randconfig-a002-20201208
i386                 randconfig-a006-20201208
i386                 randconfig-a003-20201208
i386                 randconfig-a013-20201208
i386                 randconfig-a014-20201208
i386                 randconfig-a011-20201208
i386                 randconfig-a015-20201208
i386                 randconfig-a012-20201208
i386                 randconfig-a016-20201208
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
x86_64               randconfig-a016-20201208
x86_64               randconfig-a012-20201208
x86_64               randconfig-a013-20201208
x86_64               randconfig-a014-20201208
x86_64               randconfig-a015-20201208
x86_64               randconfig-a011-20201208

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
