Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494202BBB69
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 02:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgKUBKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 20:10:32 -0500
Received: from mga17.intel.com ([192.55.52.151]:52785 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbgKUBKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 20:10:31 -0500
IronPort-SDR: 8D3BQer7cZ86Q4/00URUa7hczlvEjaYKAmAVUJFpWl+Q24TlgM7fzXNSeIPuJq8hln7UnpUsYg
 GS3anzrj/L1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="151409917"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="151409917"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 17:10:31 -0800
IronPort-SDR: ShAD/KeKZ6HL62QzP8EUKW/asGkhS+bZATT6b2e7fuxrHMUykOgOZ6tHD6zAbKTA843dwwvHtj
 PvF/sPUCi7qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="312229584"
Received: from lkp-server01.sh.intel.com (HELO 00bc34107a07) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 20 Nov 2020 17:10:30 -0800
Received: from kbuild by 00bc34107a07 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kgHQ5-00008y-Ar; Sat, 21 Nov 2020 01:10:29 +0000
Date:   Sat, 21 Nov 2020 09:10:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 6d4d56573fae75bf0f878d0fcf564e5709ea117b
Message-ID: <5fb868ec.MVGM3m2U0VYSn/+v%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 6d4d56573fae75bf0f878d0fcf564e5709ea117b  Merge branch 'core/entry'

elapsed time: 721m

configs tested: 107
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                     haps_hs_smp_defconfig
mips                         db1xxx_defconfig
mips                      malta_kvm_defconfig
m68k                          sun3x_defconfig
s390                                defconfig
arm                           h3600_defconfig
arm                        cerfcube_defconfig
sh                        sh7757lcr_defconfig
sh                          rsk7201_defconfig
arm                              alldefconfig
sh                   sh7724_generic_defconfig
arm                         palmz72_defconfig
mips                          ath25_defconfig
powerpc                        cell_defconfig
powerpc                     tqm8560_defconfig
arm                          pxa168_defconfig
sh                        sh7785lcr_defconfig
m68k                            q40_defconfig
powerpc               mpc834x_itxgp_defconfig
m68k                       m5275evb_defconfig
h8300                       h8s-sim_defconfig
sh                         ap325rxa_defconfig
powerpc                    socrates_defconfig
um                           x86_64_defconfig
m68k                        mvme16x_defconfig
h8300                            alldefconfig
mips                            ar7_defconfig
arm                        mvebu_v5_defconfig
sparc                       sparc64_defconfig
m68k                        m5307c3_defconfig
arm                       aspeed_g5_defconfig
sh                             espt_defconfig
arm                         lubbock_defconfig
xtensa                       common_defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
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
x86_64               randconfig-a006-20201120
x86_64               randconfig-a003-20201120
x86_64               randconfig-a004-20201120
x86_64               randconfig-a005-20201120
x86_64               randconfig-a001-20201120
x86_64               randconfig-a002-20201120
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
x86_64               randconfig-a011-20201120
x86_64               randconfig-a014-20201120
x86_64               randconfig-a012-20201120
x86_64               randconfig-a013-20201120
x86_64               randconfig-a015-20201120
x86_64               randconfig-a016-20201120

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
