Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69B02997DF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 21:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbgJZUWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 16:22:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:49019 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731295AbgJZUWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 16:22:41 -0400
IronPort-SDR: 31sTotroQxzJ7Bxqkhu1ElU6d+AzfoxOCk+XbCyEGyYZj+RCMJuKa8QNBN9OZqI+RuvxCFQUlr
 LsxgI3M/42IQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="167200854"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="167200854"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 13:22:40 -0700
IronPort-SDR: wNr4HzRUABjV6CbJ9bqY2HqIG44SM+pXSrGMaOSZ24remKQDZ9xzpe2/iroE7py2sv4ahOVK5A
 l5xFZAvCQN6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="394232242"
Received: from lkp-server01.sh.intel.com (HELO ca9e3ad0a302) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 26 Oct 2020 13:22:39 -0700
Received: from kbuild by ca9e3ad0a302 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kX90o-00008G-KY; Mon, 26 Oct 2020 20:22:38 +0000
Date:   Tue, 27 Oct 2020 04:22:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 ebf2d3f07491cba7ad8ba10fc9ae43c693cd0332
Message-ID: <5f973000.QMkObY1DZluFBM13%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: ebf2d3f07491cba7ad8ba10fc9ae43c693cd0332  Merge branch 'linus'

elapsed time: 725m

configs tested: 156
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nds32                            alldefconfig
arm                     davinci_all_defconfig
arm                         hackkit_defconfig
powerpc                      acadia_defconfig
um                            kunit_defconfig
sh                           se7705_defconfig
arm                        spear6xx_defconfig
arm                              zx_defconfig
mips                          malta_defconfig
alpha                               defconfig
arm                         mv78xx0_defconfig
xtensa                generic_kc705_defconfig
arm                            qcom_defconfig
arm                           h3600_defconfig
arm                           sama5_defconfig
arm                         s3c2410_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                         tb0287_defconfig
mips                        workpad_defconfig
ia64                                defconfig
m68k                         amcore_defconfig
arm                          badge4_defconfig
powerpc                     stx_gp3_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      ppc6xx_defconfig
m68k                       bvme6000_defconfig
sh                          rsk7264_defconfig
riscv                            allyesconfig
powerpc                     sbc8548_defconfig
arm                          exynos_defconfig
arm                            zeus_defconfig
mips                         mpc30x_defconfig
sh                           se7780_defconfig
arm                  colibri_pxa300_defconfig
arm                         ebsa110_defconfig
sparc64                             defconfig
mips                         tb0226_defconfig
powerpc                     tqm8540_defconfig
arm                          collie_defconfig
arm                         shannon_defconfig
nds32                               defconfig
arm                         s3c6400_defconfig
arm                         assabet_defconfig
sh                            shmin_defconfig
arm                    vt8500_v6_v7_defconfig
c6x                        evmc6457_defconfig
sh                             espt_defconfig
arm                           u8500_defconfig
m68k                       m5275evb_defconfig
powerpc                      ppc40x_defconfig
arm                         socfpga_defconfig
sh                        sh7763rdp_defconfig
arm                        mini2440_defconfig
arm                           spitz_defconfig
m68k                          multi_defconfig
arm                      jornada720_defconfig
arm                          pxa3xx_defconfig
mips                         tb0219_defconfig
arc                                 defconfig
powerpc                          g5_defconfig
mips                        nlm_xlp_defconfig
powerpc                 mpc837x_rdb_defconfig
x86_64                           allyesconfig
powerpc                      walnut_defconfig
c6x                        evmc6472_defconfig
arc                        nsimosci_defconfig
mips                  cavium_octeon_defconfig
ia64                        generic_defconfig
powerpc                     pseries_defconfig
arm                           sunxi_defconfig
sh                   sh7724_generic_defconfig
powerpc                 linkstation_defconfig
powerpc                      pmac32_defconfig
sh                   secureedge5410_defconfig
arm                         cm_x300_defconfig
riscv                            alldefconfig
powerpc                     rainier_defconfig
mips                       bmips_be_defconfig
mips                      fuloong2e_defconfig
mips                           mtx1_defconfig
m68k                            mac_defconfig
sh                        dreamcast_defconfig
powerpc                     ppa8548_defconfig
powerpc                 mpc836x_mds_defconfig
mips                         rt305x_defconfig
sh                          rsk7203_defconfig
arm64                            alldefconfig
ia64                      gensparse_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
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
i386                 randconfig-a002-20201026
i386                 randconfig-a003-20201026
i386                 randconfig-a005-20201026
i386                 randconfig-a001-20201026
i386                 randconfig-a006-20201026
i386                 randconfig-a004-20201026
x86_64               randconfig-a011-20201026
x86_64               randconfig-a013-20201026
x86_64               randconfig-a016-20201026
x86_64               randconfig-a015-20201026
x86_64               randconfig-a012-20201026
x86_64               randconfig-a014-20201026
i386                 randconfig-a016-20201026
i386                 randconfig-a015-20201026
i386                 randconfig-a014-20201026
i386                 randconfig-a012-20201026
i386                 randconfig-a013-20201026
i386                 randconfig-a011-20201026
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20201026
x86_64               randconfig-a003-20201026
x86_64               randconfig-a002-20201026
x86_64               randconfig-a006-20201026
x86_64               randconfig-a004-20201026
x86_64               randconfig-a005-20201026

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
