Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD8019C71C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 18:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388416AbgDBQb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 12:31:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:14837 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732569AbgDBQb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:31:56 -0400
IronPort-SDR: DGdlAtuC4RY4me/TepBYDXgQI4Bg7rZuUN8dBAARdmA7A173D3uP5sG87Q4n4/+Q/8M7MH/q1k
 qsIXo7e+5bzQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 09:31:55 -0700
IronPort-SDR: yMhx5BpJGPCrcKNsgH7MZX+o+HbRoyvQiYwv4QH042Z8i6B9PkvvZ5RJs0m6KcG6NnRWc9BN7/
 NuALdQI3mlPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; 
   d="scan'208";a="450989371"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 02 Apr 2020 09:31:53 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jK2kz-000Fz9-9p; Fri, 03 Apr 2020 00:31:53 +0800
Date:   Fri, 03 Apr 2020 00:31:22 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 ee8bac724cc7767dcf9480afb656318994f22c3d
Message-ID: <5e86135a.62xQyte+l5F0YmUl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: ee8bac724cc7767dcf9480afb656318994f22c3d  Merge branch 'irq/urgent'

elapsed time: 485m

configs tested: 152
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

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
sh                  sh7785lcr_32bit_defconfig
arc                                 defconfig
c6x                        evmc6678_defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
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
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
x86_64               randconfig-a001-20200402
x86_64               randconfig-a002-20200402
x86_64               randconfig-a003-20200402
i386                 randconfig-a001-20200402
i386                 randconfig-a002-20200402
i386                 randconfig-a003-20200402
alpha                randconfig-a001-20200402
m68k                 randconfig-a001-20200402
mips                 randconfig-a001-20200402
nds32                randconfig-a001-20200402
parisc               randconfig-a001-20200402
riscv                randconfig-a001-20200402
sparc64              randconfig-a001-20200402
h8300                randconfig-a001-20200402
nios2                randconfig-a001-20200402
microblaze           randconfig-a001-20200402
c6x                  randconfig-a001-20200402
s390                 randconfig-a001-20200402
xtensa               randconfig-a001-20200402
csky                 randconfig-a001-20200402
openrisc             randconfig-a001-20200402
sh                   randconfig-a001-20200402
i386                 randconfig-b003-20200402
x86_64               randconfig-b002-20200402
x86_64               randconfig-b003-20200402
x86_64               randconfig-b001-20200402
i386                 randconfig-b001-20200402
i386                 randconfig-b002-20200402
x86_64               randconfig-d001-20200402
x86_64               randconfig-d002-20200402
x86_64               randconfig-d003-20200402
i386                 randconfig-d001-20200402
i386                 randconfig-d002-20200402
i386                 randconfig-d003-20200402
x86_64               randconfig-e001-20200402
x86_64               randconfig-e002-20200402
x86_64               randconfig-e003-20200402
i386                 randconfig-e001-20200402
i386                 randconfig-e002-20200402
i386                 randconfig-e003-20200402
x86_64               randconfig-f001-20200402
x86_64               randconfig-f002-20200402
x86_64               randconfig-f003-20200402
i386                 randconfig-f001-20200402
i386                 randconfig-f002-20200402
i386                 randconfig-f003-20200402
x86_64               randconfig-g001-20200402
x86_64               randconfig-g002-20200402
x86_64               randconfig-g003-20200402
i386                 randconfig-g001-20200402
i386                 randconfig-g002-20200402
i386                 randconfig-g003-20200402
arc                  randconfig-a001-20200402
arm                  randconfig-a001-20200402
arm64                randconfig-a001-20200402
ia64                 randconfig-a001-20200402
powerpc              randconfig-a001-20200402
sparc                randconfig-a001-20200402
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                             alldefconfig
s390                                defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
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
