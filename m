Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC75A2C2848
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388456AbgKXNju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:39:50 -0500
Received: from mga05.intel.com ([192.55.52.43]:62890 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387693AbgKXNju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:39:50 -0500
IronPort-SDR: VyzJjyOeK9PX4g2rntJG5vqnzhoFyVVnNm2PpR1zummy+pBnqqxakmtBYwH+/PwBdRWBv0FTdJ
 uXTHbjTng6VQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="256653375"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="256653375"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 05:39:49 -0800
IronPort-SDR: YCXRuCNNw1dQdGJKNy/is8CdJS10ofKjh31wKJGNEfuOUEfO8doTfJqOFT6I1WVcOw2FtNfsdj
 TltA/NXsQA6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="327584115"
Received: from lkp-server01.sh.intel.com (HELO 2820ec516a85) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Nov 2020 05:39:48 -0800
Received: from kbuild by 2820ec516a85 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1khYXr-00007Q-JV; Tue, 24 Nov 2020 13:39:47 +0000
Date:   Tue, 24 Nov 2020 21:38:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.11.20a] BUILD SUCCESS
 d489098d76d8c7d7c6f8df6d8a572d29687e6028
Message-ID: <5fbd0ced.T7PMbd12aywXXgFS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.11.20a
branch HEAD: d489098d76d8c7d7c6f8df6d8a572d29687e6028  fixup! srcu: Provide polling interfaces for Tiny SRCU grace periods

elapsed time: 723m

configs tested: 132
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                          axs101_defconfig
c6x                        evmc6678_defconfig
mips                          malta_defconfig
arc                              allyesconfig
sh                         microdev_defconfig
c6x                         dsk6455_defconfig
powerpc                     tqm8560_defconfig
sh                   rts7751r2dplus_defconfig
mips                         bigsur_defconfig
mips                           jazz_defconfig
powerpc                      pmac32_defconfig
mips                       lemote2f_defconfig
mips                      maltasmvp_defconfig
powerpc                      ppc44x_defconfig
mips                     loongson1b_defconfig
arm                           sama5_defconfig
arc                            hsdk_defconfig
mips                       rbtx49xx_defconfig
m68k                        m5272c3_defconfig
powerpc                  mpc866_ads_defconfig
mips                           ip32_defconfig
arm                        multi_v5_defconfig
powerpc                 mpc837x_mds_defconfig
sh                           se7619_defconfig
m68k                        m5307c3_defconfig
mips                      bmips_stb_defconfig
m68k                         amcore_defconfig
powerpc                     tqm8540_defconfig
powerpc                     akebono_defconfig
sh                             shx3_defconfig
sparc                               defconfig
m68k                        m5407c3_defconfig
arm                            lart_defconfig
m68k                          amiga_defconfig
powerpc                        fsp2_defconfig
powerpc                      ppc40x_defconfig
powerpc                      makalu_defconfig
h8300                     edosk2674_defconfig
sh                          kfr2r09_defconfig
arm                           stm32_defconfig
m68k                       m5275evb_defconfig
mips                          rb532_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20201124
x86_64               randconfig-a003-20201124
x86_64               randconfig-a004-20201124
x86_64               randconfig-a005-20201124
x86_64               randconfig-a001-20201124
x86_64               randconfig-a002-20201124
i386                 randconfig-a004-20201123
i386                 randconfig-a003-20201123
i386                 randconfig-a002-20201123
i386                 randconfig-a005-20201123
i386                 randconfig-a001-20201123
i386                 randconfig-a006-20201123
i386                 randconfig-a004-20201124
i386                 randconfig-a003-20201124
i386                 randconfig-a002-20201124
i386                 randconfig-a005-20201124
i386                 randconfig-a001-20201124
i386                 randconfig-a006-20201124
x86_64               randconfig-a015-20201123
x86_64               randconfig-a011-20201123
x86_64               randconfig-a014-20201123
x86_64               randconfig-a016-20201123
x86_64               randconfig-a012-20201123
x86_64               randconfig-a013-20201123
i386                 randconfig-a012-20201124
i386                 randconfig-a013-20201124
i386                 randconfig-a011-20201124
i386                 randconfig-a016-20201124
i386                 randconfig-a014-20201124
i386                 randconfig-a015-20201124
i386                 randconfig-a012-20201123
i386                 randconfig-a013-20201123
i386                 randconfig-a011-20201123
i386                 randconfig-a014-20201123
i386                 randconfig-a015-20201123
i386                 randconfig-a016-20201123
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
x86_64               randconfig-a015-20201124
x86_64               randconfig-a011-20201124
x86_64               randconfig-a014-20201124
x86_64               randconfig-a016-20201124
x86_64               randconfig-a012-20201124
x86_64               randconfig-a013-20201124

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
