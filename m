Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F0B28FAE5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 23:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbgJOVtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 17:49:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:11206 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgJOVtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 17:49:03 -0400
IronPort-SDR: GD+bI61nEYg+ZkkrLrd926iYy4XHs3QmXd3rSSZzpUE/lXEuKz2bU0Md5ZuBtlhNOVA0FFXYJn
 xBIA9s6w5j5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="145771639"
X-IronPort-AV: E=Sophos;i="5.77,380,1596524400"; 
   d="scan'208";a="145771639"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 14:49:01 -0700
IronPort-SDR: hhPsZAC2E2NtMr0LwzCxn3JnzFibJB8Q2XKl0NU/jZ5vTmZ3hClX97bIwVxYokyj0FbhjDam02
 Zm6XzGy8msiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,380,1596524400"; 
   d="scan'208";a="357866576"
Received: from lkp-server01.sh.intel.com (HELO 5003fa193bf3) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 15 Oct 2020 14:48:58 -0700
Received: from kbuild by 5003fa193bf3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kTB7J-00007f-MQ; Thu, 15 Oct 2020 21:48:57 +0000
Date:   Fri, 16 Oct 2020 05:48:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 3c095241232f26d9ca68df129cd6fa4e95bbfc31
Message-ID: <5f88c3aa.THidqarxaUfvFnge%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 3c095241232f26d9ca68df129cd6fa4e95bbfc31  Merge branch 'linus'

elapsed time: 724m

configs tested: 145
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                           sama5_defconfig
sparc                       sparc32_defconfig
arm                        multi_v5_defconfig
mips                            gpr_defconfig
arm                          pxa168_defconfig
powerpc                 mpc834x_mds_defconfig
arm                         cm_x300_defconfig
arm                              zx_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                     tqm8555_defconfig
arm                              alldefconfig
mips                        jmr3927_defconfig
arm                  colibri_pxa300_defconfig
arm                            xcep_defconfig
alpha                               defconfig
powerpc                       eiger_defconfig
mips                           ip32_defconfig
powerpc                   motionpro_defconfig
mips                          malta_defconfig
arm                         lpc32xx_defconfig
arm                          simpad_defconfig
arm                         at91_dt_defconfig
arm                            lart_defconfig
parisc                generic-64bit_defconfig
x86_64                           alldefconfig
riscv                               defconfig
riscv                    nommu_k210_defconfig
mips                           ip28_defconfig
i386                             alldefconfig
arc                        vdk_hs38_defconfig
powerpc                      pmac32_defconfig
powerpc                     sbc8548_defconfig
sh                              ul2_defconfig
mips                   sb1250_swarm_defconfig
arm                            zeus_defconfig
powerpc                      ep88xc_defconfig
sh                               alldefconfig
powerpc                      cm5200_defconfig
arm                          collie_defconfig
mips                         tb0287_defconfig
powerpc                      mgcoge_defconfig
arm                      tct_hammer_defconfig
arm                        vexpress_defconfig
powerpc                     tqm8540_defconfig
arm                         nhk8815_defconfig
arm                         lubbock_defconfig
sparc                       sparc64_defconfig
arm                      pxa255-idp_defconfig
s390                       zfcpdump_defconfig
sh                           se7705_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                          ep93xx_defconfig
arm                        spear3xx_defconfig
powerpc                  mpc885_ads_defconfig
sh                          polaris_defconfig
powerpc                     powernv_defconfig
sh                ecovec24-romimage_defconfig
powerpc                      ppc6xx_defconfig
arm                        magician_defconfig
sh                            migor_defconfig
arm                           viper_defconfig
sh                     sh7710voipgw_defconfig
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
i386                 randconfig-a005-20201015
i386                 randconfig-a006-20201015
i386                 randconfig-a001-20201015
i386                 randconfig-a003-20201015
i386                 randconfig-a004-20201015
i386                 randconfig-a002-20201015
i386                 randconfig-a005-20201014
i386                 randconfig-a006-20201014
i386                 randconfig-a001-20201014
i386                 randconfig-a003-20201014
i386                 randconfig-a004-20201014
i386                 randconfig-a002-20201014
x86_64               randconfig-a016-20201014
x86_64               randconfig-a012-20201014
x86_64               randconfig-a015-20201014
x86_64               randconfig-a013-20201014
x86_64               randconfig-a014-20201014
x86_64               randconfig-a011-20201014
i386                 randconfig-a016-20201015
i386                 randconfig-a013-20201015
i386                 randconfig-a015-20201015
i386                 randconfig-a011-20201015
i386                 randconfig-a012-20201015
i386                 randconfig-a014-20201015
i386                 randconfig-a016-20201014
i386                 randconfig-a013-20201014
i386                 randconfig-a015-20201014
i386                 randconfig-a011-20201014
i386                 randconfig-a012-20201014
i386                 randconfig-a014-20201014
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201014
x86_64               randconfig-a002-20201014
x86_64               randconfig-a006-20201014
x86_64               randconfig-a001-20201014
x86_64               randconfig-a005-20201014
x86_64               randconfig-a003-20201014

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
