Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8F52F6F1E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 00:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbhANXtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 18:49:11 -0500
Received: from mga01.intel.com ([192.55.52.88]:34774 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731021AbhANXtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 18:49:10 -0500
IronPort-SDR: wNHsn9QiFCwsN3sW4IeqsiOzNqCnPep4vfM04h2jRGKZckO+9/XHQbLcbVX5bmm1OolebnYjqV
 ZwoRnhNH8HXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="197124043"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="197124043"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 15:48:30 -0800
IronPort-SDR: I596id391bhz15WlPqQ24RYE40H7zCX2zzRH1RfaZPl1g3BqHZ2GV8vVC9fudC/s5ykxe3vfr2
 xRzS61MXF6uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="425106888"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 14 Jan 2021 15:48:28 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l0CLs-00000l-32; Thu, 14 Jan 2021 23:48:28 +0000
Date:   Fri, 15 Jan 2021 07:48:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 1eb8f690bcb565a6600f8b6dcc78f7b239ceba17
Message-ID: <6000d833.J+Ni4btj1lhW5zp7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: 1eb8f690bcb565a6600f8b6dcc78f7b239ceba17  x86/topology: Make __max_die_per_package available unconditionally

elapsed time: 725m

configs tested: 115
configs skipped: 74

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                          moxart_defconfig
x86_64                           allyesconfig
m68k                          amiga_defconfig
sparc                       sparc32_defconfig
powerpc                        icon_defconfig
arm                       imx_v4_v5_defconfig
arc                      axs103_smp_defconfig
sh                          r7785rp_defconfig
m68k                        m5272c3_defconfig
arm                        oxnas_v6_defconfig
mips                           gcw0_defconfig
openrisc                         alldefconfig
arm                        multi_v5_defconfig
powerpc                      ppc44x_defconfig
arc                        nsimosci_defconfig
sh                      rts7751r2d1_defconfig
sh                           se7751_defconfig
parisc                generic-32bit_defconfig
arc                     nsimosci_hs_defconfig
riscv                          rv32_defconfig
mips                         cobalt_defconfig
m68k                             alldefconfig
arm                         at91_dt_defconfig
m68k                        m5407c3_defconfig
mips                      bmips_stb_defconfig
powerpc                      ppc6xx_defconfig
sh                            migor_defconfig
powerpc                     mpc5200_defconfig
mips                        workpad_defconfig
arm                             ezx_defconfig
mips                  decstation_64_defconfig
arm                          pxa168_defconfig
sh                          sdk7786_defconfig
sh                   sh7770_generic_defconfig
arm                            hisi_defconfig
mips                      maltaaprp_defconfig
mips                         bigsur_defconfig
arc                              alldefconfig
um                            kunit_defconfig
powerpc                     kilauea_defconfig
m68k                        stmark2_defconfig
sh                           se7705_defconfig
c6x                        evmc6457_defconfig
sh                           se7724_defconfig
arm                            mmp2_defconfig
arm                        vexpress_defconfig
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
i386                 randconfig-a002-20210114
i386                 randconfig-a005-20210114
i386                 randconfig-a006-20210114
i386                 randconfig-a001-20210114
i386                 randconfig-a003-20210114
i386                 randconfig-a004-20210114
x86_64               randconfig-a015-20210114
x86_64               randconfig-a012-20210114
x86_64               randconfig-a013-20210114
x86_64               randconfig-a016-20210114
x86_64               randconfig-a014-20210114
x86_64               randconfig-a011-20210114
i386                 randconfig-a012-20210114
i386                 randconfig-a011-20210114
i386                 randconfig-a016-20210114
i386                 randconfig-a015-20210114
i386                 randconfig-a013-20210114
i386                 randconfig-a014-20210114
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210114
x86_64               randconfig-a006-20210114
x86_64               randconfig-a001-20210114
x86_64               randconfig-a003-20210114
x86_64               randconfig-a005-20210114
x86_64               randconfig-a002-20210114

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
