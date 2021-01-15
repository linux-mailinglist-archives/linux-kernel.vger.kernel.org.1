Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBF62F85D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 20:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388217AbhAOT57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 14:57:59 -0500
Received: from mga05.intel.com ([192.55.52.43]:56609 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733119AbhAOT55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:57:57 -0500
IronPort-SDR: t9j2Eer/vqToew0e3FotXJ0qPk+Bs8JzuoLtjJkTEjDevpOhxmeKx2rfD+uwJIOVdByziDcfVT
 gevXOi7NMlCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="263395644"
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="263395644"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 11:57:16 -0800
IronPort-SDR: jh9wUPlwJdgNY7iokT0+w3hK0wdVmD/1af31DWuTA21ukm5ACYQ5q+ccQMfGnw40VYacII6HyD
 tbPWP8N6YejQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="401398810"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jan 2021 11:57:15 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l0VDe-0000Vt-Re; Fri, 15 Jan 2021 19:57:14 +0000
Date:   Sat, 16 Jan 2021 03:56:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 b86cb29287be07041b81f5611e37ae9ffabff876
Message-ID: <6001f360.pTRgQ7MYWHswa6XL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: b86cb29287be07041b81f5611e37ae9ffabff876  x86: Remove definition of DEBUG

i386-tinyconfig vmlinux size:

====================================================================================================================
 TOTAL  TEXT  init.text  check_iommu_entries()                                                                      
====================================================================================================================
     0     0          0                      0  4af0e6e39b7e x86/mm: Remove duplicate definition of _PAGE_PAT_LARGE 
    +1     0          0                      0  11aa1415d8bd x86/entry: Remove now unused do_IRQ() declaration      
   -76   -76        -76                    -76  b86cb29287be x86: Remove definition of DEBUG                        
   -75   -76        -76                    -76  5c8fe583cce5..b86cb29287be (ALL COMMITS)                            
====================================================================================================================

elapsed time: 728m

configs tested: 117
configs skipped: 80

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                             alldefconfig
powerpc                   bluestone_defconfig
sh                          urquell_defconfig
arm                             mxs_defconfig
ia64                            zx1_defconfig
arm                          ixp4xx_defconfig
powerpc               mpc834x_itxgp_defconfig
um                             i386_defconfig
mips                      malta_kvm_defconfig
sh                ecovec24-romimage_defconfig
arm                           viper_defconfig
sh                          rsk7201_defconfig
arm                         bcm2835_defconfig
sh                             sh03_defconfig
powerpc                     tqm8555_defconfig
mips                           ip32_defconfig
sh                                  defconfig
mips                           ip27_defconfig
m68k                       m5249evb_defconfig
powerpc                       ppc64_defconfig
arm                        multi_v5_defconfig
arm                         s3c2410_defconfig
arm                       imx_v4_v5_defconfig
arm                         socfpga_defconfig
m68k                         amcore_defconfig
powerpc                     sbc8548_defconfig
s390                                defconfig
arm                        vexpress_defconfig
powerpc                 canyonlands_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                           ci20_defconfig
openrisc                    or1ksim_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                     tqm8541_defconfig
arm                         lpc18xx_defconfig
sh                          kfr2r09_defconfig
sh                             espt_defconfig
m68k                           sun3_defconfig
powerpc                     ksi8560_defconfig
arm                       mainstone_defconfig
arm                            xcep_defconfig
mips                      maltaaprp_defconfig
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
x86_64               randconfig-a004-20210115
x86_64               randconfig-a006-20210115
x86_64               randconfig-a001-20210115
x86_64               randconfig-a003-20210115
x86_64               randconfig-a005-20210115
x86_64               randconfig-a002-20210115
i386                 randconfig-a002-20210115
i386                 randconfig-a005-20210115
i386                 randconfig-a006-20210115
i386                 randconfig-a001-20210115
i386                 randconfig-a003-20210115
i386                 randconfig-a004-20210115
i386                 randconfig-a012-20210115
i386                 randconfig-a011-20210115
i386                 randconfig-a016-20210115
i386                 randconfig-a015-20210115
i386                 randconfig-a013-20210115
i386                 randconfig-a014-20210115
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
x86_64               randconfig-a015-20210115
x86_64               randconfig-a012-20210115
x86_64               randconfig-a013-20210115
x86_64               randconfig-a016-20210115
x86_64               randconfig-a014-20210115
x86_64               randconfig-a011-20210115

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
