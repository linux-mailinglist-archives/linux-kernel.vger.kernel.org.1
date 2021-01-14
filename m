Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57122F56BA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbhANBwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:52:24 -0500
Received: from mga05.intel.com ([192.55.52.43]:47711 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729721AbhANAFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 19:05:45 -0500
IronPort-SDR: msxixhFI5Alohq9vx5cB/QFryzTfWgnifdjFWi5uR0D+qW5Ip2ZMJQmyAcyzcsCS1/3At1l76I
 CzHO0yXWz7dQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="263076604"
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; 
   d="scan'208";a="263076604"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 16:04:55 -0800
IronPort-SDR: JCFTtKesH+ftdFU3ItTYyoPT0bdtqjqkn8tNHI21jxfVvnTWvwxB4VtEaXDXEsyNJZbHJxQ+kg
 oZG6F8dMsaRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; 
   d="scan'208";a="353678010"
Received: from lkp-server01.sh.intel.com (HELO d5d1a9a2c6bb) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 13 Jan 2021 16:04:53 -0800
Received: from kbuild by d5d1a9a2c6bb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kzq8D-0000Pi-4i; Thu, 14 Jan 2021 00:04:53 +0000
Date:   Thu, 14 Jan 2021 08:04:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/entry] BUILD SUCCESS
 bde718b7e154afc99e1956b18a848401ce8e1f8e
Message-ID: <5fff8a74.wrO40EvpifSUim6P%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/entry
branch HEAD: bde718b7e154afc99e1956b18a848401ce8e1f8e  x86/entry: Emit a symbol for register restoring thunk

elapsed time: 727m

configs tested: 146
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
m68k                          hp300_defconfig
powerpc64                           defconfig
ia64                             allyesconfig
m68k                          multi_defconfig
powerpc                      pasemi_defconfig
mips                         bigsur_defconfig
mips                       rbtx49xx_defconfig
c6x                              alldefconfig
sparc                            alldefconfig
powerpc                      ppc64e_defconfig
sh                   sh7770_generic_defconfig
powerpc                         wii_defconfig
arm                        magician_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                         lubbock_defconfig
arm                        vexpress_defconfig
mips                         tb0226_defconfig
arc                     nsimosci_hs_defconfig
c6x                        evmc6474_defconfig
arm                      jornada720_defconfig
arm                         shannon_defconfig
sh                          sdk7786_defconfig
mips                      bmips_stb_defconfig
powerpc                     ksi8560_defconfig
arm                         axm55xx_defconfig
m68k                            q40_defconfig
arm                        mini2440_defconfig
powerpc                     tqm8560_defconfig
sh                         ecovec24_defconfig
sh                         ap325rxa_defconfig
sh                           se7751_defconfig
arm                       versatile_defconfig
mips                          ath79_defconfig
arm                  colibri_pxa300_defconfig
powerpc                  mpc866_ads_defconfig
um                           x86_64_defconfig
mips                          malta_defconfig
parisc                              defconfig
powerpc                      walnut_defconfig
c6x                         dsk6455_defconfig
m68k                          sun3x_defconfig
arm                          collie_defconfig
mips                           xway_defconfig
arm                           u8500_defconfig
sh                           se7343_defconfig
sh                     sh7710voipgw_defconfig
sh                        sh7785lcr_defconfig
mips                     cu1830-neo_defconfig
powerpc                     tqm5200_defconfig
riscv                    nommu_virt_defconfig
mips                      maltasmvp_defconfig
arc                        nsimosci_defconfig
m68k                        m5307c3_defconfig
arc                      axs103_smp_defconfig
m68k                        mvme16x_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     akebono_defconfig
sh                         microdev_defconfig
sh                        apsh4ad0a_defconfig
mips                        vocore2_defconfig
riscv                            allmodconfig
powerpc                      ppc44x_defconfig
sh                           se7722_defconfig
mips                     loongson1b_defconfig
powerpc                    mvme5100_defconfig
powerpc                 canyonlands_defconfig
xtensa                         virt_defconfig
parisc                generic-64bit_defconfig
mips                           rs90_defconfig
ia64                         bigsur_defconfig
arm                          ixp4xx_defconfig
powerpc                      tqm8xx_defconfig
mips                      pic32mzda_defconfig
arm                     am200epdkit_defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210113
x86_64               randconfig-a004-20210113
x86_64               randconfig-a001-20210113
x86_64               randconfig-a005-20210113
x86_64               randconfig-a003-20210113
x86_64               randconfig-a002-20210113
i386                 randconfig-a002-20210113
i386                 randconfig-a005-20210113
i386                 randconfig-a006-20210113
i386                 randconfig-a003-20210113
i386                 randconfig-a001-20210113
i386                 randconfig-a004-20210113
i386                 randconfig-a012-20210113
i386                 randconfig-a011-20210113
i386                 randconfig-a016-20210113
i386                 randconfig-a013-20210113
i386                 randconfig-a015-20210113
i386                 randconfig-a014-20210113
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-a015-20210113
x86_64               randconfig-a012-20210113
x86_64               randconfig-a013-20210113
x86_64               randconfig-a016-20210113
x86_64               randconfig-a014-20210113
x86_64               randconfig-a011-20210113

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
