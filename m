Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E7E2021BC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 07:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgFTFsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jun 2020 01:48:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:20806 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgFTFsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 01:48:24 -0400
IronPort-SDR: j7T4VYqnTYhxiwWyWUWovylsoMjBCKJSYuihpA6ESiJjzSBcyntZi4HczxgtrQBQ37Q1krGPEj
 u0EjpVYIAC5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9657"; a="123490410"
X-IronPort-AV: E=Sophos;i="5.75,258,1589266800"; 
   d="scan'208";a="123490410"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 22:48:23 -0700
IronPort-SDR: B10AkWxWL/N1VZVG4hqLIs9LO3xf6Cab6J5D0JriY9CoWsJ4+GnYKPSKDF0ID6LJFRJyDn3Xty
 j2XVcH5OjGkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,258,1589266800"; 
   d="scan'208";a="278219531"
Received: from lkp-server02.sh.intel.com (HELO 3aa54c81372e) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 19 Jun 2020 22:48:21 -0700
Received: from kbuild by 3aa54c81372e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jmWMX-00012r-0m; Sat, 20 Jun 2020 05:48:21 +0000
Date:   Sat, 20 Jun 2020 13:47:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 eacb0c101a0bdf14de77cc9d107493e2d8d6389c
Message-ID: <5eeda301.dF/kXm21bsWWp+p5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cleanups
branch HEAD: eacb0c101a0bdf14de77cc9d107493e2d8d6389c  initrd: Remove erroneous comment

elapsed time: 722m

configs tested: 140
configs skipped: 13

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                         s3c6400_defconfig
m68k                       bvme6000_defconfig
arm                         mv78xx0_defconfig
i386                             alldefconfig
powerpc64                           defconfig
arm                  colibri_pxa270_defconfig
arc                        vdk_hs38_defconfig
arm                        spear6xx_defconfig
csky                             allyesconfig
mips                         tb0226_defconfig
sh                          r7780mp_defconfig
s390                             allyesconfig
csky                                defconfig
powerpc                     mpc5200_defconfig
mips                         rt305x_defconfig
riscv                    nommu_virt_defconfig
arm                         s5pv210_defconfig
arm                        mini2440_defconfig
sh                                  defconfig
arm                       mainstone_defconfig
m68k                       m5475evb_defconfig
powerpc                          g5_defconfig
mips                      pistachio_defconfig
arm                        trizeps4_defconfig
arm                     davinci_all_defconfig
nios2                         3c120_defconfig
mips                           ip27_defconfig
powerpc                      ep88xc_defconfig
s390                             allmodconfig
microblaze                        allnoconfig
m68k                        mvme16x_defconfig
mips                        qi_lb60_defconfig
x86_64                              defconfig
arc                              alldefconfig
arc                        nsimosci_defconfig
s390                              allnoconfig
mips                     cu1000-neo_defconfig
sh                   secureedge5410_defconfig
arm                           u8500_defconfig
sh                        edosk7705_defconfig
arm                        spear3xx_defconfig
h8300                            allmodconfig
sh                               j2_defconfig
arm                           h5000_defconfig
powerpc                      chrp32_defconfig
arm                        clps711x_defconfig
powerpc                  storcenter_defconfig
xtensa                           alldefconfig
powerpc                      pmac32_defconfig
i386                              allnoconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
nds32                             allnoconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a002-20200619
i386                 randconfig-a006-20200619
i386                 randconfig-a001-20200619
i386                 randconfig-a005-20200619
i386                 randconfig-a003-20200619
i386                 randconfig-a004-20200619
x86_64               randconfig-a015-20200619
x86_64               randconfig-a016-20200619
x86_64               randconfig-a011-20200619
x86_64               randconfig-a012-20200619
x86_64               randconfig-a014-20200619
x86_64               randconfig-a013-20200619
i386                 randconfig-a011-20200619
i386                 randconfig-a015-20200619
i386                 randconfig-a014-20200619
i386                 randconfig-a013-20200619
i386                 randconfig-a016-20200619
i386                 randconfig-a012-20200619
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
um                               allmodconfig
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
