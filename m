Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76E02D5458
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 08:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732544AbgLJHI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 02:08:26 -0500
Received: from mga05.intel.com ([192.55.52.43]:7028 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbgLJHIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 02:08:18 -0500
IronPort-SDR: gEjzh5Fer/L0YGkCOpUPU712M4FagGwyfgy+RRmjRzoMgku2UUzqFYbOO8zeaf4EE3m3faIbeY
 GyQeSZTbPzJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="258925816"
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="258925816"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 23:07:34 -0800
IronPort-SDR: b70CbR8qt3LOvjE6W0wdqhMaTzLtw01Fpyb2BfuRX1xRptzH/Zcp2Y4K81ZNgyceyqk1rLNVpu
 yfeOQ5w4bpPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="375811504"
Received: from lkp-server01.sh.intel.com (HELO ecc0cebe68d1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 09 Dec 2020 23:07:32 -0800
Received: from kbuild by ecc0cebe68d1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1knG30-00007o-Pq; Thu, 10 Dec 2020 07:07:30 +0000
Date:   Thu, 10 Dec 2020 15:07:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cache] BUILD SUCCESS WITH WARNING
 2ba836dbe2467d31fffb439258c2f454c6f1a317
Message-ID: <5fd1c92a.Ih3xkMwbJGiSyEGH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cache
branch HEAD: 2ba836dbe2467d31fffb439258c2f454c6f1a317  x86/resctrl: Fix incorrect local bandwidth when mba_sc is enabled

Warning reports:

https://lore.kernel.org/lkml/202012100516.H7sTNehL-lkp@intel.com

Warning in current branch:

arch/x86/kernel/cpu/resctrl/monitor.c:291:6: warning: variable 'chunks' set but not used [-Wunused-but-set-variable]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-allyesconfig
|   `-- arch-x86-kernel-cpu-resctrl-monitor.c:warning:variable-chunks-set-but-not-used
|-- i386-randconfig-a001-20201209
|   `-- arch-x86-kernel-cpu-resctrl-monitor.c:warning:variable-chunks-set-but-not-used
|-- i386-randconfig-a002-20201209
|   `-- arch-x86-kernel-cpu-resctrl-monitor.c:warning:variable-chunks-set-but-not-used
|-- i386-randconfig-a002-20201210
|   `-- arch-x86-kernel-cpu-resctrl-monitor.c:warning:variable-chunks-set-but-not-used
|-- i386-randconfig-a004-20201210
|   `-- arch-x86-kernel-cpu-resctrl-monitor.c:warning:variable-chunks-set-but-not-used
|-- i386-randconfig-a006-20201210
|   `-- arch-x86-kernel-cpu-resctrl-monitor.c:warning:variable-chunks-set-but-not-used
|-- i386-randconfig-a012-20201209
|   `-- arch-x86-kernel-cpu-resctrl-monitor.c:warning:variable-chunks-set-but-not-used
|-- i386-randconfig-a014-20201209
|   `-- arch-x86-kernel-cpu-resctrl-monitor.c:warning:variable-chunks-set-but-not-used
|-- i386-randconfig-a016-20201209
|   `-- arch-x86-kernel-cpu-resctrl-monitor.c:warning:variable-chunks-set-but-not-used
|-- i386-randconfig-c001-20201209
|   `-- arch-x86-kernel-cpu-resctrl-monitor.c:warning:variable-chunks-set-but-not-used
|-- i386-randconfig-c001-20201210
|   `-- arch-x86-kernel-cpu-resctrl-monitor.c:warning:variable-chunks-set-but-not-used
|-- i386-randconfig-s001-20201209
|   `-- arch-x86-kernel-cpu-resctrl-monitor.c:warning:variable-chunks-set-but-not-used
|-- i386-randconfig-s002-20201209
|   `-- arch-x86-kernel-cpu-resctrl-monitor.c:warning:variable-chunks-set-but-not-used
|-- x86_64-allmodconfig
|   `-- arch-x86-kernel-cpu-resctrl-monitor.c:warning:variable-chunks-set-but-not-used
|-- x86_64-allyesconfig
|   `-- arch-x86-kernel-cpu-resctrl-monitor.c:warning:variable-chunks-set-but-not-used
|-- x86_64-randconfig-a011-20201209
|   `-- arch-x86-kernel-cpu-resctrl-monitor.c:warning:variable-chunks-set-but-not-used
|-- x86_64-randconfig-a013-20201209
|   `-- arch-x86-kernel-cpu-resctrl-monitor.c:warning:variable-chunks-set-but-not-used
|-- x86_64-randconfig-a014-20201209
|   `-- arch-x86-kernel-cpu-resctrl-monitor.c:warning:variable-chunks-set-but-not-used
|-- x86_64-randconfig-p002-20201209
|   `-- arch-x86-kernel-cpu-resctrl-monitor.c:warning:variable-chunks-set-but-not-used
|-- x86_64-randconfig-r023-20201209
|   `-- arch-x86-kernel-cpu-resctrl-monitor.c:warning:variable-chunks-set-but-not-used
|-- x86_64-randconfig-r024-20201209
|   `-- arch-x86-kernel-cpu-resctrl-monitor.c:warning:variable-chunks-set-but-not-used
|-- x86_64-randconfig-s021-20201209
|   `-- arch-x86-kernel-cpu-resctrl-monitor.c:warning:variable-chunks-set-but-not-used
|-- x86_64-randconfig-s022-20201209
|   `-- arch-x86-kernel-cpu-resctrl-monitor.c:warning:variable-chunks-set-but-not-used
|-- x86_64-randconfig-s022-20201210
|   `-- arch-x86-kernel-cpu-resctrl-monitor.c:warning:variable-chunks-set-but-not-used
|-- x86_64-rhel
|   `-- arch-x86-kernel-cpu-resctrl-monitor.c:warning:variable-chunks-set-but-not-used
|-- x86_64-rhel-7.6-kselftests
|   `-- arch-x86-kernel-cpu-resctrl-monitor.c:warning:variable-chunks-set-but-not-used
`-- x86_64-rhel-8.3
    `-- arch-x86-kernel-cpu-resctrl-monitor.c:warning:variable-chunks-set-but-not-used


i386-tinyconfig vmlinux size:

+-------+------------------------------+------------------------------------------+
| DELTA |            SYMBOL            |                  COMMIT                  |
+-------+------------------------------+------------------------------------------+
| +1718 | TOTAL                        | 3650b228f83a..2ba836dbe246 (ALL COMMITS) |
| +1647 | TEXT                         | 3650b228f83a..2ba836dbe246 (ALL COMMITS) |
|   +68 | BSS                          | 3650b228f83a..2ba836dbe246 (ALL COMMITS) |
|  +774 | seq_read_iter()              | 3650b228f83a..2ba836dbe246 (ALL COMMITS) |
|  +250 | __invalidate_mapping_pages() | 3650b228f83a..2ba836dbe246 (ALL COMMITS) |
|  +225 | intel_pmu_drain_pebs_icl()   | 3650b228f83a..2ba836dbe246 (ALL COMMITS) |
|  +218 | intel_pmu_drain_pebs_nhm()   | 3650b228f83a..2ba836dbe246 (ALL COMMITS) |
|  +201 | intel_pmu_drain_pebs_core()  | 3650b228f83a..2ba836dbe246 (ALL COMMITS) |
|  +117 | init.text                    | 3650b228f83a..2ba836dbe246 (ALL COMMITS) |
|   +68 | dummy_iregs                  | 3650b228f83a..2ba836dbe246 (ALL COMMITS) |
|   +66 | perf_event_aux_event()       | 3650b228f83a..2ba836dbe246 (ALL COMMITS) |
|   +66 | perf_log_throttle()          | 3650b228f83a..2ba836dbe246 (ALL COMMITS) |
|   -69 | __sb_start_write()           | 3650b228f83a..2ba836dbe246 (ALL COMMITS) |
|   -78 | __ptrace_may_access()        | 3650b228f83a..2ba836dbe246 (ALL COMMITS) |
|  -250 | __invalidate_mapping_pages() | 3650b228f83a..2ba836dbe246 (ALL COMMITS) |
|  -356 | __intel_pmu_pebs_event()     | 3650b228f83a..2ba836dbe246 (ALL COMMITS) |
|  -470 | seq_read()                   | 3650b228f83a..2ba836dbe246 (ALL COMMITS) |
+-------+------------------------------+------------------------------------------+

elapsed time: 721m

configs tested: 132
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      tqm8xx_defconfig
arc                        vdk_hs38_defconfig
powerpc                      walnut_defconfig
ia64                         bigsur_defconfig
powerpc                     tqm8555_defconfig
m68k                         apollo_defconfig
riscv                            allmodconfig
m68k                        mvme16x_defconfig
mips                        omega2p_defconfig
ia64                        generic_defconfig
um                             i386_defconfig
mips                           gcw0_defconfig
sh                          kfr2r09_defconfig
sh                           se7724_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                           viper_defconfig
arm                         socfpga_defconfig
alpha                            alldefconfig
arm                        vexpress_defconfig
powerpc                      makalu_defconfig
arm                    vt8500_v6_v7_defconfig
mips                  maltasmvp_eva_defconfig
sh                        edosk7760_defconfig
arm                       imx_v6_v7_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                         tb0219_defconfig
mips                     cu1000-neo_defconfig
powerpc                     rainier_defconfig
arm                          pcm027_defconfig
mips                          ath25_defconfig
powerpc                 mpc834x_mds_defconfig
arm                        oxnas_v6_defconfig
s390                                defconfig
arm                        spear6xx_defconfig
arm                         s3c6400_defconfig
mips                         db1xxx_defconfig
mips                            ar7_defconfig
arm                       versatile_defconfig
powerpc                        icon_defconfig
nios2                            alldefconfig
arm                       aspeed_g5_defconfig
powerpc                 canyonlands_defconfig
sh                      rts7751r2d1_defconfig
mips                         bigsur_defconfig
mips                           xway_defconfig
mips                         cobalt_defconfig
mips                        nlm_xlp_defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201209
i386                 randconfig-a005-20201209
i386                 randconfig-a001-20201209
i386                 randconfig-a002-20201209
i386                 randconfig-a006-20201209
i386                 randconfig-a003-20201209
i386                 randconfig-a001-20201210
i386                 randconfig-a004-20201210
i386                 randconfig-a003-20201210
i386                 randconfig-a002-20201210
i386                 randconfig-a005-20201210
i386                 randconfig-a006-20201210
x86_64               randconfig-a016-20201209
x86_64               randconfig-a012-20201209
x86_64               randconfig-a013-20201209
x86_64               randconfig-a014-20201209
x86_64               randconfig-a015-20201209
x86_64               randconfig-a011-20201209
i386                 randconfig-a013-20201209
i386                 randconfig-a014-20201209
i386                 randconfig-a011-20201209
i386                 randconfig-a015-20201209
i386                 randconfig-a012-20201209
i386                 randconfig-a016-20201209
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201209
x86_64               randconfig-a006-20201209
x86_64               randconfig-a005-20201209
x86_64               randconfig-a001-20201209
x86_64               randconfig-a002-20201209
x86_64               randconfig-a003-20201209
x86_64               randconfig-a003-20201210
x86_64               randconfig-a006-20201210
x86_64               randconfig-a002-20201210
x86_64               randconfig-a005-20201210
x86_64               randconfig-a004-20201210
x86_64               randconfig-a001-20201210

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
