Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BEF2E2559
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 09:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgLXH7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 02:59:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:50961 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgLXH7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 02:59:33 -0500
IronPort-SDR: nobqTewoD105/yu9EtJwDa69D6Be+5E1uAPJlBNxa8mlT9nQN4X7y9THoMpele/wyYYPwCg9Ow
 uZQqwNGPX8gw==
X-IronPort-AV: E=McAfee;i="6000,8403,9844"; a="172611212"
X-IronPort-AV: E=Sophos;i="5.78,444,1599548400"; 
   d="scan'208";a="172611212"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2020 23:58:43 -0800
IronPort-SDR: ADAFf99tfICV5nWq9fcbrayHAxY7+1X8LWP4AltqUXRfakkQEQLQ/LT3qnVNNoccoIOjqIpJ8z
 eu51VTP/i2EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,444,1599548400"; 
   d="scan'208";a="398567707"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Dec 2020 23:58:37 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ksLW8-0000px-PP; Thu, 24 Dec 2020 07:58:36 +0000
Date:   Thu, 24 Dec 2020 15:58:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/test] BUILD REGRESSION
 88054dca0f5708bee190e093dce64dc3cb025793
Message-ID: <5fe44a29.6EDShpLPY8f5LVI8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/test
branch HEAD: 88054dca0f5708bee190e093dce64dc3cb025793  ACPI: processor: Fix missing need_resched() check after rcu_idle_enter()

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- nds32-randconfig-r014-20201221
    `-- kernel-rcu-tree_plugin.h:error:struct-task_struct-has-no-member-named-on_cpu

elapsed time: 721m

configs tested: 133
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nds32                             allnoconfig
m68k                        m5407c3_defconfig
openrisc                            defconfig
sh                           se7343_defconfig
mips                      maltasmvp_defconfig
arm                    vt8500_v6_v7_defconfig
mips                     cu1830-neo_defconfig
powerpc                     sbc8548_defconfig
c6x                        evmc6474_defconfig
powerpc                    ge_imp3a_defconfig
arm                           corgi_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                      ppc40x_defconfig
parisc                              defconfig
c6x                                 defconfig
sh                             shx3_defconfig
mips                      loongson3_defconfig
powerpc                 mpc8315_rdb_defconfig
arc                        vdk_hs38_defconfig
arm                          pcm027_defconfig
arm                         mv78xx0_defconfig
arm                        trizeps4_defconfig
sh                          landisk_defconfig
m68k                            q40_defconfig
sh                             sh03_defconfig
m68k                         amcore_defconfig
arc                        nsim_700_defconfig
m68k                            mac_defconfig
mips                malta_kvm_guest_defconfig
s390                          debug_defconfig
mips                           mtx1_defconfig
sparc64                          alldefconfig
arm                        clps711x_defconfig
sh                         ap325rxa_defconfig
xtensa                       common_defconfig
arm                       multi_v4t_defconfig
xtensa                           alldefconfig
mips                        nlm_xlp_defconfig
mips                         db1xxx_defconfig
sh                              ul2_defconfig
powerpc                     skiroot_defconfig
powerpc                        icon_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                              zx_defconfig
powerpc                     taishan_defconfig
powerpc                     mpc83xx_defconfig
h8300                            alldefconfig
powerpc                 mpc834x_mds_defconfig
arm                       omap2plus_defconfig
powerpc                 mpc8560_ads_defconfig
ia64                        generic_defconfig
sparc                       sparc32_defconfig
arm                       spear13xx_defconfig
sh                           se7780_defconfig
arm                             pxa_defconfig
mips                     loongson1b_defconfig
sparc64                             defconfig
alpha                               defconfig
arm                           tegra_defconfig
mips                  decstation_64_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
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
x86_64               randconfig-a001-20201223
x86_64               randconfig-a006-20201223
x86_64               randconfig-a002-20201223
x86_64               randconfig-a004-20201223
x86_64               randconfig-a003-20201223
x86_64               randconfig-a005-20201223
i386                 randconfig-a002-20201223
i386                 randconfig-a005-20201223
i386                 randconfig-a006-20201223
i386                 randconfig-a004-20201223
i386                 randconfig-a003-20201223
i386                 randconfig-a001-20201223
i386                 randconfig-a011-20201223
i386                 randconfig-a016-20201223
i386                 randconfig-a014-20201223
i386                 randconfig-a012-20201223
i386                 randconfig-a015-20201223
i386                 randconfig-a013-20201223
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
x86_64               randconfig-a015-20201223
x86_64               randconfig-a014-20201223
x86_64               randconfig-a016-20201223
x86_64               randconfig-a012-20201223
x86_64               randconfig-a013-20201223
x86_64               randconfig-a011-20201223

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
