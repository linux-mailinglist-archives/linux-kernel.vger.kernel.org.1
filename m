Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E942DDC78
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 01:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbgLRAyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 19:54:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:37776 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731513AbgLRAyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 19:54:12 -0500
IronPort-SDR: jbCvelfvc1yHM+Qr0v35q4q8CX8CgSbCW74rkZEq92eSw+58U/9jDswyW2Q1JQkBN8WmjFVkPO
 cBMRsz0fX7UQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9838"; a="162404360"
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400"; 
   d="scan'208";a="162404360"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 16:53:31 -0800
IronPort-SDR: j4oe7e70GCzvSJzw1yF56r4LeOXmUKC1Cn5kSHF1+t4xV8+EBrm4ezOO5LqLcLPnxnsBz1j68p
 aaqTkakOxFbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400"; 
   d="scan'208";a="489518952"
Received: from lkp-server02.sh.intel.com (HELO 070e1a605002) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 17 Dec 2020 16:53:30 -0800
Received: from kbuild by 070e1a605002 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kq41R-0001R2-PR; Fri, 18 Dec 2020 00:53:29 +0000
Date:   Fri, 18 Dec 2020 08:52:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 01428e8d731bdc366e3c3538b28ae886109f9f28
Message-ID: <5fdbfd5a.0ce+5WxggzElMDld%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 01428e8d731bdc366e3c3538b28ae886109f9f28  Merge branch 'irq/core'

i386-tinyconfig vmlinux size:

======================================================================================================
 TOTAL  TEXT  devm_platform_get_irqs_affinity()  built-in.*                                           
======================================================================================================
     0     0                                        +139196  90dfbe8a1041 Merge branch 'efi/core'     
  +103  +104                               +142              148842c98a24..01428e8d731b (ALL COMMITS) 
======================================================================================================

elapsed time: 721m

configs tested: 110
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
arm64                               defconfig
arm                       omap2plus_defconfig
sh                                  defconfig
powerpc                 mpc8540_ads_defconfig
arm                        vexpress_defconfig
arm                        cerfcube_defconfig
m68k                          hp300_defconfig
s390                          debug_defconfig
xtensa                    smp_lx200_defconfig
arm                         palmz72_defconfig
mips                        nlm_xlp_defconfig
powerpc                  mpc885_ads_defconfig
sh                          landisk_defconfig
arm                        shmobile_defconfig
m68k                          sun3x_defconfig
powerpc                      tqm8xx_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                             alldefconfig
arm                           h5000_defconfig
powerpc                       ebony_defconfig
m68k                        mvme16x_defconfig
arm                       netwinder_defconfig
arc                     nsimosci_hs_defconfig
powerpc                      pcm030_defconfig
powerpc                     powernv_defconfig
arm                           h3600_defconfig
arm                   milbeaut_m10v_defconfig
arm                          tango4_defconfig
arm                         orion5x_defconfig
powerpc                      chrp32_defconfig
powerpc                      pasemi_defconfig
mips                        omega2p_defconfig
mips                         mpc30x_defconfig
mips                       bmips_be_defconfig
mips                         cobalt_defconfig
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
i386                               tinyconfig
i386                                defconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20201217
i386                 randconfig-a004-20201217
i386                 randconfig-a003-20201217
i386                 randconfig-a002-20201217
i386                 randconfig-a006-20201217
i386                 randconfig-a005-20201217
i386                 randconfig-a014-20201217
i386                 randconfig-a013-20201217
i386                 randconfig-a012-20201217
i386                 randconfig-a011-20201217
i386                 randconfig-a015-20201217
i386                 randconfig-a016-20201217
x86_64               randconfig-a003-20201217
x86_64               randconfig-a006-20201217
x86_64               randconfig-a002-20201217
x86_64               randconfig-a005-20201217
x86_64               randconfig-a004-20201217
x86_64               randconfig-a001-20201217
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a016-20201217
x86_64               randconfig-a012-20201217
x86_64               randconfig-a013-20201217
x86_64               randconfig-a015-20201217
x86_64               randconfig-a014-20201217
x86_64               randconfig-a011-20201217

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
