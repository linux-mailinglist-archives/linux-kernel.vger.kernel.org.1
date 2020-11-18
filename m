Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1572B759F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 06:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgKRFQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 00:16:44 -0500
Received: from mga07.intel.com ([134.134.136.100]:42279 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgKRFQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 00:16:44 -0500
IronPort-SDR: xjXRBaMNVJP7w/sh/ibLxwYvWh4bczz+SSs82TKUvPrIeq4l7us0ohx6fBovY/MrTAt3fJCDtX
 EfuXpnKKAQlQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="235215517"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="235215517"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 21:16:43 -0800
IronPort-SDR: N2RmUknB/UqXNNelT89ADqKsGE8049IrhzExxO+Bsasf71uyro6YnsH8UoJzi5jI02gQBo9bAi
 5JEYyu5h4jFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="330328098"
Received: from lkp-server01.sh.intel.com (HELO 34cd9d7151aa) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 17 Nov 2020 21:16:41 -0800
Received: from kbuild by 34cd9d7151aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kfFph-00002v-7P; Wed, 18 Nov 2020 05:16:41 +0000
Date:   Wed, 18 Nov 2020 13:16:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/clang-ft/for-linus] BUILD SUCCESS
 60c3fe4030afca9f560eb513ff1411c7779fa5b8
Message-ID: <5fb4ae2f.q5Q7yDlrvGZip85/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  testing/clang-ft/for-linus
branch HEAD: 60c3fe4030afca9f560eb513ff1411c7779fa5b8  HID: input: Fix fall-through warnings for Clang

elapsed time: 726m

configs tested: 124
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                         10m50_defconfig
powerpc                       eiger_defconfig
m68k                        mvme147_defconfig
xtensa                          iss_defconfig
mips                           ci20_defconfig
powerpc                      mgcoge_defconfig
mips                           mtx1_defconfig
m68k                             allmodconfig
sh                          landisk_defconfig
sh                         apsh4a3a_defconfig
powerpc                        warp_defconfig
arm                            u300_defconfig
arm                         axm55xx_defconfig
arm                         lpc18xx_defconfig
arm                          moxart_defconfig
arm                           u8500_defconfig
m68k                            mac_defconfig
arm                              alldefconfig
arm                         shannon_defconfig
h8300                       h8s-sim_defconfig
sh                   sh7724_generic_defconfig
powerpc                    klondike_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                    gamecube_defconfig
arm                       mainstone_defconfig
mips                       bmips_be_defconfig
xtensa                       common_defconfig
arm                        neponset_defconfig
mips                malta_kvm_guest_defconfig
powerpc                     redwood_defconfig
mips                          rb532_defconfig
h8300                    h8300h-sim_defconfig
arc                          axs103_defconfig
arm                            zeus_defconfig
arm                        clps711x_defconfig
sh                         ap325rxa_defconfig
mips                     cu1000-neo_defconfig
sh                  sh7785lcr_32bit_defconfig
nios2                               defconfig
powerpc                    adder875_defconfig
m68k                         amcore_defconfig
mips                            e55_defconfig
sh                            migor_defconfig
arm                      tct_hammer_defconfig
mips                         mpc30x_defconfig
riscv                               defconfig
powerpc                     skiroot_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
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
i386                 randconfig-a006-20201117
i386                 randconfig-a005-20201117
i386                 randconfig-a001-20201117
i386                 randconfig-a002-20201117
i386                 randconfig-a004-20201117
i386                 randconfig-a003-20201117
x86_64               randconfig-a015-20201115
x86_64               randconfig-a011-20201115
x86_64               randconfig-a014-20201115
x86_64               randconfig-a013-20201115
x86_64               randconfig-a016-20201115
x86_64               randconfig-a012-20201115
i386                 randconfig-a012-20201117
i386                 randconfig-a014-20201117
i386                 randconfig-a016-20201117
i386                 randconfig-a011-20201117
i386                 randconfig-a015-20201117
i386                 randconfig-a013-20201117
riscv                    nommu_k210_defconfig
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
x86_64               randconfig-a003-20201117
x86_64               randconfig-a005-20201117
x86_64               randconfig-a004-20201117
x86_64               randconfig-a002-20201117
x86_64               randconfig-a001-20201117
x86_64               randconfig-a006-20201117
x86_64               randconfig-a015-20201116
x86_64               randconfig-a011-20201116
x86_64               randconfig-a014-20201116
x86_64               randconfig-a013-20201116
x86_64               randconfig-a016-20201116
x86_64               randconfig-a012-20201116

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
