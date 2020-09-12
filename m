Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8CE267802
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 07:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbgILFsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 01:48:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:24550 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgILFsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 01:48:22 -0400
IronPort-SDR: NAR9W+HEJTv4AEuQtfiuJmm1JvEJFXwX1pvC1DSdsIpqYhc+Lo6cD8ZO7ggJkvN2TDKXKSX2t1
 nwolT0O55jWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9741"; a="159833246"
X-IronPort-AV: E=Sophos;i="5.76,419,1592895600"; 
   d="scan'208";a="159833246"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 22:48:20 -0700
IronPort-SDR: OYPuI5Q+SCK6CiO8KJI+5DjJlVL7C1HRPgbwcGTXv2cb38i3THJWc3gUukSWjbijKImNzrnr1a
 T+n+NKWklzig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,419,1592895600"; 
   d="scan'208";a="301144280"
Received: from lkp-server01.sh.intel.com (HELO a75722977aa5) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 Sep 2020 22:48:19 -0700
Received: from kbuild by a75722977aa5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kGyOY-0000UG-HC; Sat, 12 Sep 2020 05:48:18 +0000
Date:   Sat, 12 Sep 2020 13:47:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 76dbb9a6a6b514e6881689f8a3e2dd6b51d2681b
Message-ID: <5f5c60e7.GHSzxRLtL8Ek+SWn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 76dbb9a6a6b514e6881689f8a3e2dd6b51d2681b  Merge branch 'perf/core'

elapsed time: 721m

configs tested: 130
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc8540_ads_defconfig
sh                          r7780mp_defconfig
xtensa                          iss_defconfig
sh                        sh7757lcr_defconfig
mips                        nlm_xlp_defconfig
arm                            qcom_defconfig
arm                            pleb_defconfig
sparc64                             defconfig
arm                        mini2440_defconfig
powerpc                    amigaone_defconfig
xtensa                    xip_kc705_defconfig
mips                         db1xxx_defconfig
sh                        sh7763rdp_defconfig
powerpc                      ppc6xx_defconfig
sh                   sh7770_generic_defconfig
powerpc                      pasemi_defconfig
arm                         at91_dt_defconfig
sh                               alldefconfig
m68k                        mvme16x_defconfig
powerpc                        warp_defconfig
arm                           efm32_defconfig
arm                              zx_defconfig
mips                          malta_defconfig
arc                             nps_defconfig
alpha                            allyesconfig
sh                           se7750_defconfig
sh                          rsk7203_defconfig
mips                         tb0219_defconfig
mips                     decstation_defconfig
arm                        vexpress_defconfig
arm                     eseries_pxa_defconfig
arm                        mvebu_v5_defconfig
sh                           sh2007_defconfig
mips                           ci20_defconfig
arm                        trizeps4_defconfig
powerpc                     mpc5200_defconfig
sh                         apsh4a3a_defconfig
ia64                        generic_defconfig
mips                       rbtx49xx_defconfig
arm                         socfpga_defconfig
c6x                        evmc6472_defconfig
powerpc                      pmac32_defconfig
sh                           se7722_defconfig
powerpc                 mpc836x_rdk_defconfig
m68k                       m5249evb_defconfig
riscv                          rv32_defconfig
c6x                        evmc6474_defconfig
sh                          lboxre2_defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20200911
i386                 randconfig-a006-20200911
i386                 randconfig-a001-20200911
i386                 randconfig-a003-20200911
i386                 randconfig-a002-20200911
i386                 randconfig-a005-20200911
i386                 randconfig-a004-20200912
i386                 randconfig-a006-20200912
i386                 randconfig-a003-20200912
i386                 randconfig-a001-20200912
i386                 randconfig-a002-20200912
i386                 randconfig-a005-20200912
x86_64               randconfig-a014-20200911
x86_64               randconfig-a011-20200911
x86_64               randconfig-a012-20200911
x86_64               randconfig-a016-20200911
x86_64               randconfig-a015-20200911
x86_64               randconfig-a013-20200911
i386                 randconfig-a015-20200911
i386                 randconfig-a014-20200911
i386                 randconfig-a011-20200911
i386                 randconfig-a013-20200911
i386                 randconfig-a016-20200911
i386                 randconfig-a012-20200911
i386                 randconfig-a015-20200912
i386                 randconfig-a014-20200912
i386                 randconfig-a011-20200912
i386                 randconfig-a013-20200912
i386                 randconfig-a016-20200912
i386                 randconfig-a012-20200912
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
x86_64               randconfig-a004-20200911
x86_64               randconfig-a006-20200911
x86_64               randconfig-a003-20200911
x86_64               randconfig-a002-20200911
x86_64               randconfig-a005-20200911
x86_64               randconfig-a001-20200911

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
