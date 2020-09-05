Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCFE325E8C9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 17:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgIEPjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Sep 2020 11:39:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:31671 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728388AbgIEPiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 11:38:18 -0400
IronPort-SDR: lTOIurTzZn6jWlBIWLKanGIaRP6shr5HSE14uIG+bffG6SjiepmS8Q0P8QwaW82X4/RjwiIUx2
 VhuSUxeWUA/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="145596713"
X-IronPort-AV: E=Sophos;i="5.76,394,1592895600"; 
   d="scan'208";a="145596713"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2020 08:38:08 -0700
IronPort-SDR: tn6T/rRBjIV2vN/X2QfRfL9mT6tkpLh+UxRaqWstkHc6PZc+0K+aOIJFXx8XY39PRJPqPFOph8
 lTnYbGekSGMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,394,1592895600"; 
   d="scan'208";a="447750203"
Received: from lkp-server02.sh.intel.com (HELO c089623da072) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 05 Sep 2020 08:38:07 -0700
Received: from kbuild by c089623da072 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kEaGU-0000Gh-Dq; Sat, 05 Sep 2020 15:38:06 +0000
Date:   Sat, 05 Sep 2020 23:37:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:lkmm] BUILD SUCCESS 0ce0c78eff7d22c8a261de6c4305a5abb638c200
Message-ID: <5f53b0ab.H0L8qxFnKypdTyg0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  lkmm
branch HEAD: 0ce0c78eff7d22c8a261de6c4305a5abb638c200  tools/memory-model: Expand the cheatsheet.txt notion of relaxed

elapsed time: 1067m

configs tested: 141
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                     haps_hs_smp_defconfig
m68k                            q40_defconfig
m68k                       m5208evb_defconfig
m68k                       m5249evb_defconfig
arm                         mv78xx0_defconfig
sh                        edosk7705_defconfig
arc                 nsimosci_hs_smp_defconfig
m68k                          atari_defconfig
mips                     loongson1c_defconfig
mips                       bmips_be_defconfig
xtensa                              defconfig
mips                      maltaaprp_defconfig
arm                         axm55xx_defconfig
xtensa                    xip_kc705_defconfig
powerpc                          allmodconfig
s390                                defconfig
m68k                                defconfig
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
arm                        mvebu_v5_defconfig
mips                          malta_defconfig
openrisc                 simple_smp_defconfig
arm                         nhk8815_defconfig
sh                          rsk7264_defconfig
powerpc                          allyesconfig
m68k                          amiga_defconfig
sh                          r7785rp_defconfig
arm                      tct_hammer_defconfig
sh                             sh03_defconfig
mips                      loongson3_defconfig
powerpc                           allnoconfig
powerpc                     ep8248e_defconfig
sh                        sh7763rdp_defconfig
sh                     sh7710voipgw_defconfig
arm                        trizeps4_defconfig
arm                          imote2_defconfig
arc                              allyesconfig
sh                   sh7724_generic_defconfig
riscv                             allnoconfig
ia64                         bigsur_defconfig
arc                     nsimosci_hs_defconfig
sh                          landisk_defconfig
powerpc                          g5_defconfig
arm                            hisi_defconfig
powerpc                     skiroot_defconfig
xtensa                generic_kc705_defconfig
ia64                          tiger_defconfig
sh                           se7750_defconfig
mips                      fuloong2e_defconfig
powerpc                       ppc64_defconfig
arm                         palmz72_defconfig
s390                             alldefconfig
arm                  colibri_pxa270_defconfig
xtensa                           allyesconfig
mips                            ar7_defconfig
mips                           xway_defconfig
m68k                       m5275evb_defconfig
arm                            qcom_defconfig
openrisc                         alldefconfig
m68k                        stmark2_defconfig
powerpc                      ep88xc_defconfig
mips                          ath25_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                             defconfig
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
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20200904
x86_64               randconfig-a004-20200904
x86_64               randconfig-a003-20200904
x86_64               randconfig-a005-20200904
x86_64               randconfig-a001-20200904
x86_64               randconfig-a002-20200904

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
