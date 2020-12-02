Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145F12CB2FD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 03:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgLBC53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 21:57:29 -0500
Received: from mga14.intel.com ([192.55.52.115]:17247 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727746AbgLBC53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 21:57:29 -0500
IronPort-SDR: w+Ou/XwjoGrArwDEYZqWOhZw1tmELq7uJBV9V/yWGjUsR78N21BE/j1JOf2gdCg9HUaJAsBBrx
 EyYTK0ku12JQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="172160372"
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="172160372"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 18:56:42 -0800
IronPort-SDR: 64C3q5q/t70hpCgj8mmiOvWJNQb7LMVVvgdbif+GZAfua0JKA8aZQXeykuZ+vPdYy/hPTyMyPB
 fh8piLVFQfGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="539487417"
Received: from lkp-server01.sh.intel.com (HELO 4302fe08fc2a) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 01 Dec 2020 18:56:41 -0800
Received: from kbuild by 4302fe08fc2a with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kkIJt-00000q-8k; Wed, 02 Dec 2020 02:56:41 +0000
Date:   Wed, 02 Dec 2020 10:56:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 4e6680ee5111f78eca62456b82fabe7803c85977
Message-ID: <5fc70262.lTTC9XqdKP+bIxrd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 4e6680ee5111f78eca62456b82fabe7803c85977  Merge branch 'irq/core'

i386-tinyconfig vmlinux size:

+-------+--------------------------------+------------------------------------------+
| DELTA |             SYMBOL             |                  COMMIT                  |
+-------+--------------------------------+------------------------------------------+
| +1479 | TOTAL                          | c84e1efae022..4e6680ee5111 (ALL COMMITS) |
| +1175 | TEXT                           | c84e1efae022..4e6680ee5111 (ALL COMMITS) |
|  +204 | DATA                           | c84e1efae022..4e6680ee5111 (ALL COMMITS) |
|  +344 | arch_do_signal_or_restart()    | c84e1efae022..4e6680ee5111 (ALL COMMITS) |
|  +252 | show_trace_log_lvl()           | c84e1efae022..4e6680ee5111 (ALL COMMITS) |
|  +131 | __kmap_local_pfn_prot()        | c84e1efae022..4e6680ee5111 (ALL COMMITS) |
|  +119 | fixup_vdso_exception()         | c84e1efae022..4e6680ee5111 (ALL COMMITS) |
|  +112 | arch_perf_get_page_size        | c84e1efae022..4e6680ee5111 (ALL COMMITS) |
|  +102 | kunmap_local_indexed()         | c84e1efae022..4e6680ee5111 (ALL COMMITS) |
|  +100 | kmap_get_pte()                 | c84e1efae022..4e6680ee5111 (ALL COMMITS) |
|   +82 | arch/x86/built-in.*            | c84e1efae022..4e6680ee5111 (ALL COMMITS) |
|   +76 | arch/x86/entry/built-in.*      | c84e1efae022..4e6680ee5111 (ALL COMMITS) |
|   +72 | arch/x86/entry/vdso/built-in.* | c84e1efae022..4e6680ee5111 (ALL COMMITS) |
|   +68 | exit_to_user_mode_prepare()    | c84e1efae022..4e6680ee5111 (ALL COMMITS) |
|   +64 | __ia32_sys_mprotect()          | c84e1efae022..4e6680ee5111 (ALL COMMITS) |
|   +64 | init_task                      | c84e1efae022..4e6680ee5111 (ALL COMMITS) |
|   -65 | init.text                      | c84e1efae022..4e6680ee5111 (ALL COMMITS) |
|   -76 | kmap_atomic_prot_pfn()         | c84e1efae022..4e6680ee5111 (ALL COMMITS) |
|   -78 | paging_init()                  | c84e1efae022..4e6680ee5111 (ALL COMMITS) |
|   -81 | iounmap_atomic()               | c84e1efae022..4e6680ee5111 (ALL COMMITS) |
|  -149 | sysrq_timer_list_show()        | c84e1efae022..4e6680ee5111 (ALL COMMITS) |
|  -252 | show_trace_log_lvl()           | c84e1efae022..4e6680ee5111 (ALL COMMITS) |
|  -333 | arch_do_signal()               | c84e1efae022..4e6680ee5111 (ALL COMMITS) |
+-------+--------------------------------+------------------------------------------+

elapsed time: 723m

configs tested: 113
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                         ps3_defconfig
mips                malta_qemu_32r6_defconfig
x86_64                           alldefconfig
mips                          ath25_defconfig
sh                          rsk7201_defconfig
openrisc                         alldefconfig
sh                               j2_defconfig
mips                       capcella_defconfig
arm                           viper_defconfig
c6x                        evmc6474_defconfig
sh                           se7705_defconfig
m68k                         apollo_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                        realview_defconfig
microblaze                          defconfig
s390                       zfcpdump_defconfig
xtensa                generic_kc705_defconfig
ia64                                defconfig
powerpc                    klondike_defconfig
mips                     loongson1c_defconfig
arc                        nsimosci_defconfig
mips                           gcw0_defconfig
xtensa                         virt_defconfig
c6x                        evmc6678_defconfig
sh                             shx3_defconfig
sparc                               defconfig
arm                          pcm027_defconfig
ia64                        generic_defconfig
sh                        dreamcast_defconfig
arm                            mps2_defconfig
arm                          moxart_defconfig
powerpc                    amigaone_defconfig
mips                        maltaup_defconfig
arc                              alldefconfig
microblaze                      mmu_defconfig
arm                     davinci_all_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                    mvme5100_defconfig
sh                        apsh4ad0a_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                          imote2_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                 randconfig-a004-20201201
i386                 randconfig-a005-20201201
i386                 randconfig-a001-20201201
i386                 randconfig-a002-20201201
i386                 randconfig-a006-20201201
i386                 randconfig-a003-20201201
x86_64               randconfig-a016-20201201
x86_64               randconfig-a012-20201201
x86_64               randconfig-a014-20201201
x86_64               randconfig-a013-20201201
x86_64               randconfig-a015-20201201
x86_64               randconfig-a011-20201201
i386                 randconfig-a014-20201201
i386                 randconfig-a013-20201201
i386                 randconfig-a011-20201201
i386                 randconfig-a015-20201201
i386                 randconfig-a012-20201201
i386                 randconfig-a016-20201201
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
x86_64               randconfig-a004-20201201
x86_64               randconfig-a006-20201201
x86_64               randconfig-a001-20201201
x86_64               randconfig-a002-20201201
x86_64               randconfig-a005-20201201
x86_64               randconfig-a003-20201201

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
