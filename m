Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18412D3FBB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 11:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbgLIKQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 05:16:50 -0500
Received: from mga01.intel.com ([192.55.52.88]:36189 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729070AbgLIKQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:16:50 -0500
IronPort-SDR: AWi/57SkyOHGPzC9jk3sG0S2da4GbhlN7Qxxy3EqNgVAIUonD35/fvlmzRyVUu6AwLyCthumUY
 rciJBiW6kP4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="192355618"
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="192355618"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 02:16:09 -0800
IronPort-SDR: LG0PBRXXmboPnL0g7o72spN92+ZycWKaf56q6UL2C7omZoHsoE1efeBS/TIecmuzCKhwGi6QLL
 x41RqmK58PfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="370766766"
Received: from lkp-server01.sh.intel.com (HELO 2bbb63443648) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 09 Dec 2020 02:16:08 -0800
Received: from kbuild by 2bbb63443648 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kmwVz-0000Dt-Qn; Wed, 09 Dec 2020 10:16:07 +0000
Date:   Wed, 09 Dec 2020 18:15:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.12.08a] BUILD REGRESSION
 c5c1f436c5434ca260106aa0713ec8e4de3cba22
Message-ID: <5fd0a3dd.BI23IEe9vDoOWhIF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.12.08a
branch HEAD: c5c1f436c5434ca260106aa0713ec8e4de3cba22  EXP rcuscale: Crude tests for kmalloc_debug_print_provenance()

Error/Warning reports:

https://lore.kernel.org/lkml/202012090722.a8hLT2LU-lkp@intel.com
https://lore.kernel.org/lkml/202012090911.RsNVbBXp-lkp@intel.com

Error/Warning in current branch:

(.text+0x184): undefined reference to `kmem_struct_debug_provenance'
(.text+0xa0): undefined reference to `kmem_struct_debug_provenance'
(.text+0xa8): undefined reference to `kmem_struct_debug_provenance'
mm/slab_common.c:583: undefined reference to `kmem_struct_debug_provenance'

possible Error/Warning in current branch:

arc-elf-ld: slab_common.c:(.text+0xbc): undefined reference to `kmem_struct_debug_provenance'
ld.lld: error: undefined symbol: kmem_struct_debug_provenance
nds32le-linux-ld: slab_common.c:(.text+0x22e0): undefined reference to `kmem_struct_debug_provenance'
slab_common.c:(.text+0x22dc): undefined reference to `kmem_struct_debug_provenance'
slab_common.c:(.text+0x530): undefined reference to `kmem_struct_debug_provenance'
slab_common.c:(.text+0x644): undefined reference to `kmem_struct_debug_provenance'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-defconfig
|   `-- arc-elf-ld:slab_common.c:(.text):undefined-reference-to-kmem_struct_debug_provenance
|-- arm-lpc32xx_defconfig
|   `-- slab_common.c:(.text):undefined-reference-to-kmem_struct_debug_provenance
|-- i386-randconfig-a005-20201208
|   `-- mm-slab_common.c:undefined-reference-to-kmem_struct_debug_provenance
|-- i386-randconfig-a012-20201208
|   `-- mm-slab_common.c:undefined-reference-to-kmem_struct_debug_provenance
|-- i386-randconfig-a016-20201208
|   `-- mm-slab_common.c:undefined-reference-to-kmem_struct_debug_provenance
|-- i386-randconfig-c001-20201208
|   `-- mm-slab_common.c:undefined-reference-to-kmem_struct_debug_provenance
|-- i386-randconfig-s002-20201208
|   `-- mm-slab_common.c:undefined-reference-to-kmem_struct_debug_provenance
|-- m68k-defconfig
|   `-- slab_common.c:(.text):undefined-reference-to-kmem_struct_debug_provenance
|-- mips-maltaup_defconfig
|   `-- (.text):undefined-reference-to-kmem_struct_debug_provenance
|-- mips-maltaup_xpa_defconfig
|   `-- (.text):undefined-reference-to-kmem_struct_debug_provenance
|-- mips-tb0219_defconfig
|   `-- (.text):undefined-reference-to-kmem_struct_debug_provenance
|-- nds32-randconfig-r034-20201208
|   |-- nds32le-linux-ld:slab_common.c:(.text):undefined-reference-to-kmem_struct_debug_provenance
|   `-- slab_common.c:(.text):undefined-reference-to-kmem_struct_debug_provenance
|-- parisc-defconfig
|   `-- (.text):undefined-reference-to-kmem_struct_debug_provenance
|-- x86_64-randconfig-a002-20201208
|   `-- mm-slab_common.c:undefined-reference-to-kmem_struct_debug_provenance
|-- x86_64-randconfig-a004-20201208
|   `-- mm-slab_common.c:undefined-reference-to-kmem_struct_debug_provenance
`-- x86_64-randconfig-a006-20201208
    `-- mm-slab_common.c:undefined-reference-to-kmem_struct_debug_provenance

clang_recent_errors
|-- x86_64-randconfig-a015-20201208
|   `-- ld.lld:error:undefined-symbol:kmem_struct_debug_provenance
`-- x86_64-randconfig-r023-20201208
    `-- ld.lld:error:undefined-symbol:kmem_struct_debug_provenance

elapsed time: 720m

configs tested: 106
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         tb0219_defconfig
arm                          moxart_defconfig
arm                           h3600_defconfig
sh                         microdev_defconfig
mips                        maltaup_defconfig
arm                         cm_x300_defconfig
i386                             alldefconfig
arm                           sunxi_defconfig
sh                          rsk7201_defconfig
m68k                        mvme16x_defconfig
arc                         haps_hs_defconfig
c6x                         dsk6455_defconfig
c6x                        evmc6472_defconfig
mips                       lemote2f_defconfig
arc                        vdk_hs38_defconfig
powerpc                    mvme5100_defconfig
mips                    maltaup_xpa_defconfig
arm                         lpc32xx_defconfig
openrisc                 simple_smp_defconfig
arm                        oxnas_v6_defconfig
arm                     davinci_all_defconfig
sh                           se7724_defconfig
arm                        spear6xx_defconfig
arm                   milbeaut_m10v_defconfig
sh                     magicpanelr2_defconfig
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
i386                 randconfig-a004-20201208
i386                 randconfig-a005-20201208
i386                 randconfig-a001-20201208
i386                 randconfig-a002-20201208
i386                 randconfig-a006-20201208
i386                 randconfig-a003-20201208
i386                 randconfig-a013-20201208
i386                 randconfig-a014-20201208
i386                 randconfig-a011-20201208
i386                 randconfig-a015-20201208
i386                 randconfig-a012-20201208
i386                 randconfig-a016-20201208
i386                 randconfig-a013-20201209
i386                 randconfig-a014-20201209
i386                 randconfig-a011-20201209
i386                 randconfig-a015-20201209
i386                 randconfig-a012-20201209
i386                 randconfig-a016-20201209
x86_64               randconfig-a004-20201208
x86_64               randconfig-a006-20201208
x86_64               randconfig-a005-20201208
x86_64               randconfig-a001-20201208
x86_64               randconfig-a002-20201208
x86_64               randconfig-a003-20201208
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
x86_64               randconfig-a016-20201208
x86_64               randconfig-a012-20201208
x86_64               randconfig-a013-20201208
x86_64               randconfig-a014-20201208
x86_64               randconfig-a015-20201208
x86_64               randconfig-a011-20201208

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
