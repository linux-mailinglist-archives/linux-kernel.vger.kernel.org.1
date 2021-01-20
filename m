Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CB52FC63D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 02:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbhATBGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 20:06:10 -0500
Received: from mga17.intel.com ([192.55.52.151]:10574 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730094AbhATBF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 20:05:59 -0500
IronPort-SDR: OmZ2S+uf5vksU/xb2mKMZKOpUqAg/IdpxkyT+awZtUwZJpNwuQ07uTGUuCiyO7HeNLHjjkMcaw
 XbSSMeuRqp8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="158798433"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="158798433"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 17:05:16 -0800
IronPort-SDR: QRE6rijDARh2k1plvr8FaDEht5WMTFSQshigNDzA0AAnAxgYM93txdKp1M3N8pjDlJPrNX3P8l
 VIvesA8thmqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="355848257"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 19 Jan 2021 17:05:14 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l21vu-0005Rn-91; Wed, 20 Jan 2021 01:05:14 +0000
Date:   Wed, 20 Jan 2021 09:05:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/entry] BUILD SUCCESS
 0bab9cb2d980d7c075cffb9216155f7835237f98
Message-ID: <600781c0.5sypKmj/i5y+OTgt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/entry
branch HEAD: 0bab9cb2d980d7c075cffb9216155f7835237f98  x86/entry: Remove put_ret_addr_in_rdi THUNK macro argument

elapsed time: 721m

configs tested: 131
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                        mvme16x_defconfig
arc                         haps_hs_defconfig
mips                         mpc30x_defconfig
alpha                               defconfig
arm                           viper_defconfig
arm                      jornada720_defconfig
arm                             pxa_defconfig
powerpc64                           defconfig
xtensa                  audio_kc705_defconfig
powerpc                        cell_defconfig
arc                          axs103_defconfig
arm                            zeus_defconfig
powerpc                       maple_defconfig
powerpc                      ep88xc_defconfig
arm                           h3600_defconfig
arm                             ezx_defconfig
mips                      maltasmvp_defconfig
mips                     loongson1b_defconfig
mips                           jazz_defconfig
mips                        omega2p_defconfig
powerpc                 canyonlands_defconfig
m68k                          atari_defconfig
arm                          tango4_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     kmeter1_defconfig
mips                   sb1250_swarm_defconfig
parisc                generic-32bit_defconfig
arm                          pxa168_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                        spear6xx_defconfig
openrisc                            defconfig
powerpc                     skiroot_defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210119
x86_64               randconfig-a006-20210119
x86_64               randconfig-a001-20210119
x86_64               randconfig-a003-20210119
x86_64               randconfig-a005-20210119
x86_64               randconfig-a002-20210119
i386                 randconfig-a002-20210119
i386                 randconfig-a005-20210119
i386                 randconfig-a006-20210119
i386                 randconfig-a001-20210119
i386                 randconfig-a003-20210119
i386                 randconfig-a004-20210119
i386                 randconfig-a001-20210120
i386                 randconfig-a002-20210120
i386                 randconfig-a004-20210120
i386                 randconfig-a006-20210120
i386                 randconfig-a005-20210120
i386                 randconfig-a003-20210120
x86_64               randconfig-a012-20210120
x86_64               randconfig-a015-20210120
x86_64               randconfig-a016-20210120
x86_64               randconfig-a011-20210120
x86_64               randconfig-a013-20210120
x86_64               randconfig-a014-20210120
i386                 randconfig-a013-20210120
i386                 randconfig-a011-20210120
i386                 randconfig-a012-20210120
i386                 randconfig-a014-20210120
i386                 randconfig-a015-20210120
i386                 randconfig-a016-20210120
i386                 randconfig-a011-20210119
i386                 randconfig-a012-20210119
i386                 randconfig-a016-20210119
i386                 randconfig-a015-20210119
i386                 randconfig-a013-20210119
i386                 randconfig-a014-20210119
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
x86_64               randconfig-a002-20210120
x86_64               randconfig-a003-20210120
x86_64               randconfig-a001-20210120
x86_64               randconfig-a005-20210120
x86_64               randconfig-a006-20210120
x86_64               randconfig-a004-20210120
x86_64               randconfig-a015-20210119
x86_64               randconfig-a013-20210119
x86_64               randconfig-a012-20210119
x86_64               randconfig-a016-20210119
x86_64               randconfig-a011-20210119
x86_64               randconfig-a014-20210119

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
