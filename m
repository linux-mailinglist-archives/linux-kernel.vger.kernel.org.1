Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E22F51A08A2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 09:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgDGHuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 03:50:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:62597 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbgDGHuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 03:50:08 -0400
IronPort-SDR: pm6f7THqPho4bo7QAey7AA+9x4HO8kAhCHqYj4Lhs4IgE0WF52zluVHUFIVTdF+RAoC7tpr76Q
 d04bJJd8ql8w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 00:50:06 -0700
IronPort-SDR: mwk3zoqDjCEzhHpNZwcmW7j/MwCVSrT20MG41h/zROG6hkKyhmRGhlvEzZZk7uQuRpOtYcWrt5
 c4pE/sdcbmxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,353,1580803200"; 
   d="scan'208";a="451140446"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 07 Apr 2020 00:50:05 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jLizk-0008Pt-Tr; Tue, 07 Apr 2020 15:50:04 +0800
Date:   Tue, 07 Apr 2020 15:49:35 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.04.05b] BUILD REGRESSION
 805020c8028f6e95a8fc57132af5f896a8ad6391
Message-ID: <5e8c308f.lrYLVBtn3ewBhvpf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.04.05b
branch HEAD: 805020c8028f6e95a8fc57132af5f896a8ad6391  squash! rcu-tasks: Add an RCU Tasks Trace to simplify protection of tracing hooks

Error/Warning in current branch:

kprobes.c:(.text+0x2bc8): undefined reference to `.synchronize_rcu_tasks'
trampoline.c:(.text+0x630): undefined reference to `.synchronize_rcu_tasks'

Error/Warning ids grouped by kconfigs:

recent_errors
`-- powerpc-defconfig
    |-- kprobes.c:(.text):undefined-reference-to-synchronize_rcu_tasks
    `-- trampoline.c:(.text):undefined-reference-to-synchronize_rcu_tasks

elapsed time: 483m

configs tested: 159
configs skipped: 0

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
sh                               allmodconfig
sparc64                             defconfig
i386                                defconfig
openrisc                 simple_smp_defconfig
riscv                               defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
xtensa                       common_defconfig
openrisc                    or1ksim_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a003-20200407
i386                 randconfig-a002-20200407
x86_64               randconfig-a002-20200407
x86_64               randconfig-a001-20200407
i386                 randconfig-a001-20200407
i386                 randconfig-a003-20200407
mips                 randconfig-a001-20200407
nds32                randconfig-a001-20200407
m68k                 randconfig-a001-20200407
parisc               randconfig-a001-20200407
alpha                randconfig-a001-20200407
riscv                randconfig-a001-20200407
alpha                randconfig-a001-20200406
m68k                 randconfig-a001-20200406
nds32                randconfig-a001-20200406
parisc               randconfig-a001-20200406
riscv                randconfig-a001-20200406
sparc64              randconfig-a001-20200406
h8300                randconfig-a001-20200406
nios2                randconfig-a001-20200406
microblaze           randconfig-a001-20200406
c6x                  randconfig-a001-20200406
csky                 randconfig-a001-20200406
openrisc             randconfig-a001-20200406
s390                 randconfig-a001-20200406
sh                   randconfig-a001-20200406
xtensa               randconfig-a001-20200406
s390                 randconfig-a001-20200407
xtensa               randconfig-a001-20200407
csky                 randconfig-a001-20200407
openrisc             randconfig-a001-20200407
sh                   randconfig-a001-20200407
x86_64               randconfig-b001-20200406
x86_64               randconfig-b002-20200406
x86_64               randconfig-b003-20200406
i386                 randconfig-b001-20200406
i386                 randconfig-b002-20200406
i386                 randconfig-b003-20200406
i386                 randconfig-c003-20200407
i386                 randconfig-c001-20200407
x86_64               randconfig-c002-20200407
x86_64               randconfig-c003-20200407
i386                 randconfig-c002-20200407
x86_64               randconfig-c001-20200407
i386                 randconfig-e001-20200407
i386                 randconfig-e003-20200407
x86_64               randconfig-e002-20200407
x86_64               randconfig-e001-20200407
i386                 randconfig-e002-20200407
x86_64               randconfig-e003-20200407
x86_64               randconfig-g003-20200406
i386                 randconfig-g003-20200406
x86_64               randconfig-g002-20200406
i386                 randconfig-g001-20200406
i386                 randconfig-g002-20200406
x86_64               randconfig-g001-20200406
x86_64               randconfig-h002-20200407
i386                 randconfig-h002-20200407
arm64                randconfig-a001-20200406
sparc                randconfig-a001-20200406
ia64                 randconfig-a001-20200406
arc                  randconfig-a001-20200406
arm                  randconfig-a001-20200406
powerpc              randconfig-a001-20200406
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                             alldefconfig
s390                                defconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
