Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60BF299AE3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407517AbgJZXmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:42:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:45727 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407494AbgJZXmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:42:02 -0400
IronPort-SDR: aU37S1vDSkcyl+pJKFMKBDuMXVG4S/Xp8se7YuwdCWx/DmZzEYB51IH5dLXLz7g181vvKqQPQs
 5nkBYcJdLxXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="147286203"
X-IronPort-AV: E=Sophos;i="5.77,421,1596524400"; 
   d="scan'208";a="147286203"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 16:42:01 -0700
IronPort-SDR: ragBzivSQp7xUs++pc1Gr4Thg/o/pVGF+Dd0tzL+dqlgWsRAsXmkwq2bJJ4h0DT3ebOxciiP24
 NaeP1CvwoWqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,421,1596524400"; 
   d="scan'208";a="360547951"
Received: from lkp-server01.sh.intel.com (HELO ca9e3ad0a302) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Oct 2020 16:41:59 -0700
Received: from kbuild by ca9e3ad0a302 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kXC7i-0000Da-GY; Mon, 26 Oct 2020 23:41:58 +0000
Date:   Tue, 27 Oct 2020 07:41:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 633cdaf29ec4aae29868320adb3a4f1c5b8c0eac
Message-ID: <5f975ec3.U999/5JorTvCmYcG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  ras/core
branch HEAD: 633cdaf29ec4aae29868320adb3a4f1c5b8c0eac  x86/mce: Remove unneeded break

elapsed time: 725m

configs tested: 130
configs skipped: 62

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         tb0287_defconfig
mips                        workpad_defconfig
ia64                                defconfig
m68k                         amcore_defconfig
arm                          badge4_defconfig
powerpc                     stx_gp3_defconfig
nios2                         10m50_defconfig
mips                     decstation_defconfig
arm                       aspeed_g5_defconfig
arm                        realview_defconfig
mips                          ath79_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                    amigaone_defconfig
powerpc                     rainier_defconfig
powerpc                      ppc64e_defconfig
sh                         ecovec24_defconfig
powerpc                      ppc44x_defconfig
nios2                            alldefconfig
arm                            lart_defconfig
mips                            e55_defconfig
microblaze                          defconfig
arc                          axs103_defconfig
arm                         shannon_defconfig
nds32                               defconfig
arm                         s3c6400_defconfig
arm                         assabet_defconfig
sh                            shmin_defconfig
arm                         axm55xx_defconfig
um                           x86_64_defconfig
mips                      malta_kvm_defconfig
mips                         tb0226_defconfig
mips                        nlm_xlr_defconfig
sh                        edosk7705_defconfig
arm                         socfpga_defconfig
sh                        sh7763rdp_defconfig
arm                        mini2440_defconfig
arm                           spitz_defconfig
m68k                          multi_defconfig
arm                      jornada720_defconfig
xtensa                generic_kc705_defconfig
sh                          polaris_defconfig
powerpc                      ep88xc_defconfig
sh                          rsk7269_defconfig
m68k                       bvme6000_defconfig
mips                      pistachio_defconfig
sh                   sh7724_generic_defconfig
powerpc                 linkstation_defconfig
powerpc                      pmac32_defconfig
arm                          collie_defconfig
arm                         cm_x300_defconfig
riscv                            alldefconfig
powerpc                     pseries_defconfig
mips                       bmips_be_defconfig
mips                      fuloong2e_defconfig
powerpc                       ebony_defconfig
mips                        qi_lb60_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                         cobalt_defconfig
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
x86_64               randconfig-a001-20201026
x86_64               randconfig-a003-20201026
x86_64               randconfig-a002-20201026
x86_64               randconfig-a006-20201026
x86_64               randconfig-a004-20201026
x86_64               randconfig-a005-20201026

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
