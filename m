Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255A325E8C8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 17:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgIEPiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Sep 2020 11:38:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:22322 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728393AbgIEPiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 11:38:20 -0400
IronPort-SDR: fHbcNCBYuKCv/q2Yi1cUxj7yP5+VughgCRhoSEwt73s5tMtR48VpZiTSmRSuWuINMuVOmKWsvd
 AcC1Aj2mbtig==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="175917818"
X-IronPort-AV: E=Sophos;i="5.76,394,1592895600"; 
   d="scan'208";a="175917818"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2020 08:38:08 -0700
IronPort-SDR: jDJvUIOJU/mAajdKYsDVEFlR5ZIWvGcNxlvPEeHbUiw1BKRBeQc5lPYy+DvIdiZQ2+7Fz8yhRA
 M3BS99+uUnZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,394,1592895600"; 
   d="scan'208";a="332511477"
Received: from lkp-server02.sh.intel.com (HELO c089623da072) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 05 Sep 2020 08:38:07 -0700
Received: from kbuild by c089623da072 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kEaGU-0000Gb-DB; Sat, 05 Sep 2020 15:38:06 +0000
Date:   Sat, 05 Sep 2020 23:37:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 93921baa3f6ff77e57d7e772165aa7bd709b5387
Message-ID: <5f53b0ad.Vq1kD7A7C6rV+jo3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cleanups
branch HEAD: 93921baa3f6ff77e57d7e772165aa7bd709b5387  x86/resctrl: Fix spelling in user-visible warning messages

elapsed time: 732m

configs tested: 90
configs skipped: 78

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                               defconfig
sh                           se7751_defconfig
m68k                         apollo_defconfig
sh                        edosk7760_defconfig
arc                         haps_hs_defconfig
arm                              zx_defconfig
powerpc                      ppc64e_defconfig
arm                       imx_v6_v7_defconfig
parisc                           allyesconfig
sh                         ecovec24_defconfig
h8300                            allyesconfig
arm                      footbridge_defconfig
arm                          iop32x_defconfig
xtensa                       common_defconfig
sh                           se7750_defconfig
mips                      fuloong2e_defconfig
powerpc                       ppc64_defconfig
arm                         palmz72_defconfig
s390                             alldefconfig
arm                  colibri_pxa270_defconfig
arm                            qcom_defconfig
openrisc                         alldefconfig
m68k                        stmark2_defconfig
powerpc                      ep88xc_defconfig
m68k                          atari_defconfig
mips                          ath25_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20200905
x86_64               randconfig-a004-20200905
x86_64               randconfig-a003-20200905
x86_64               randconfig-a005-20200905
x86_64               randconfig-a001-20200905
x86_64               randconfig-a002-20200905
i386                 randconfig-a004-20200904
i386                 randconfig-a005-20200904
i386                 randconfig-a006-20200904
i386                 randconfig-a002-20200904
i386                 randconfig-a003-20200904
i386                 randconfig-a001-20200904
x86_64               randconfig-a013-20200904
x86_64               randconfig-a011-20200904
x86_64               randconfig-a016-20200904
x86_64               randconfig-a012-20200904
x86_64               randconfig-a015-20200904
x86_64               randconfig-a014-20200904
i386                 randconfig-a016-20200904
i386                 randconfig-a015-20200904
i386                 randconfig-a011-20200904
i386                 randconfig-a013-20200904
i386                 randconfig-a014-20200904
i386                 randconfig-a012-20200904
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
