Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996A62BBD16
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 05:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgKUExv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 23:53:51 -0500
Received: from mga11.intel.com ([192.55.52.93]:43700 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbgKUExu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 23:53:50 -0500
IronPort-SDR: oM7AQvOMcZ9Pb5eJ6bp6q4WNg7iB7JcqYezHRYqohe+utScDDPRC1RJ2tugqEo19xp4xvrcJlh
 CkL5Sj/LSZlw==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="168064571"
X-IronPort-AV: E=Sophos;i="5.78,358,1599548400"; 
   d="scan'208";a="168064571"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 20:53:50 -0800
IronPort-SDR: dS3lO8JAs3Jmra5M5IJGqdlxvKJHTtx6YPcv8FAqKD1L2CEaicbsVA9f66SsZqszRgp/nvN0wM
 vSqAwZkrjDGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,358,1599548400"; 
   d="scan'208";a="533803770"
Received: from lkp-server01.sh.intel.com (HELO 00bc34107a07) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 20 Nov 2020 20:53:48 -0800
Received: from kbuild by 00bc34107a07 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kgKuC-0000Ch-Bn; Sat, 21 Nov 2020 04:53:48 +0000
Date:   Sat, 21 Nov 2020 12:53:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 61b39ad9a7d26fe14a2f5f23e5e940e7f9664d41
Message-ID: <5fb89d2f.M8DVYi/2df+Y3gDt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cleanups
branch HEAD: 61b39ad9a7d26fe14a2f5f23e5e940e7f9664d41  x86/head64: Remove duplicate include

elapsed time: 722m

configs tested: 139
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc836x_rdk_defconfig
arm                            qcom_defconfig
arm                     eseries_pxa_defconfig
powerpc                      walnut_defconfig
mips                          rm200_defconfig
arm                       netwinder_defconfig
arm                             mxs_defconfig
powerpc                     mpc83xx_defconfig
mips                           ip32_defconfig
arm                          badge4_defconfig
powerpc                     tqm8540_defconfig
sh                           se7721_defconfig
arc                        vdk_hs38_defconfig
sh                   sh7724_generic_defconfig
powerpc                 mpc8540_ads_defconfig
riscv                          rv32_defconfig
mips                  maltasmvp_eva_defconfig
arm                         s3c6400_defconfig
mips                         db1xxx_defconfig
m68k                          sun3x_defconfig
arm                         mv78xx0_defconfig
openrisc                            defconfig
mips                     loongson1c_defconfig
arm                            hisi_defconfig
arm                         assabet_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                     mpc5200_defconfig
arm                           corgi_defconfig
powerpc                     powernv_defconfig
mips                      pic32mzda_defconfig
arm                         hackkit_defconfig
mips                      fuloong2e_defconfig
arm                          simpad_defconfig
arm                        trizeps4_defconfig
arc                        nsimosci_defconfig
mips                     loongson1b_defconfig
powerpc64                           defconfig
arc                         haps_hs_defconfig
arm                       aspeed_g5_defconfig
arm                      integrator_defconfig
m68k                        stmark2_defconfig
arm                       cns3420vb_defconfig
arm                     am200epdkit_defconfig
powerpc                     ppa8548_defconfig
sh                           se7780_defconfig
xtensa                generic_kc705_defconfig
sh                          landisk_defconfig
um                             i386_defconfig
ia64                         bigsur_defconfig
arm                      footbridge_defconfig
arm                          tango4_defconfig
powerpc                 mpc834x_mds_defconfig
openrisc                 simple_smp_defconfig
c6x                                 defconfig
arm                     davinci_all_defconfig
powerpc                 mpc832x_rdb_defconfig
xtensa                    smp_lx200_defconfig
xtensa                              defconfig
sh                           se7750_defconfig
powerpc                      obs600_defconfig
mips                        maltaup_defconfig
arm                           tegra_defconfig
arm                           omap1_defconfig
ia64                      gensparse_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                 mpc836x_mds_defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20201120
x86_64               randconfig-a003-20201120
x86_64               randconfig-a004-20201120
x86_64               randconfig-a005-20201120
x86_64               randconfig-a001-20201120
x86_64               randconfig-a002-20201120
i386                 randconfig-a004-20201120
i386                 randconfig-a003-20201120
i386                 randconfig-a002-20201120
i386                 randconfig-a005-20201120
i386                 randconfig-a001-20201120
i386                 randconfig-a006-20201120
i386                 randconfig-a012-20201120
i386                 randconfig-a013-20201120
i386                 randconfig-a011-20201120
i386                 randconfig-a016-20201120
i386                 randconfig-a014-20201120
i386                 randconfig-a015-20201120
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-a015-20201120
x86_64               randconfig-a011-20201120
x86_64               randconfig-a014-20201120
x86_64               randconfig-a016-20201120
x86_64               randconfig-a012-20201120
x86_64               randconfig-a013-20201120

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
