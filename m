Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B14F019EC5B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Apr 2020 17:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgDEPeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Apr 2020 11:34:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:56129 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbgDEPeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 11:34:25 -0400
IronPort-SDR: k0qOzFgeInnsDS6GkkAT69DmQR328U6i1JEfGOJmkdhgURbX4coXam4VRrvz5cuZKE+WiRX2nn
 qOcgsPHAWfww==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2020 08:34:22 -0700
IronPort-SDR: CLuEgbkA5qUwF8/jReNZ7qDc/tJIbB6NjQxhrBZiASVSGBox3c8lc1oZ4DKHZyr8CoUBlv1aml
 4CTsPtRS+qJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,348,1580803200"; 
   d="scan'208";a="329652369"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 05 Apr 2020 08:34:21 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jL7Hx-000CTO-5a; Sun, 05 Apr 2020 23:34:21 +0800
Date:   Sun, 05 Apr 2020 23:34:01 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 760a53768610d427990192b5cfdb71310e1373db
Message-ID: <5e89fa69.y+aLG6oOcmhYpaM5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  timers/urgent
branch HEAD: 760a53768610d427990192b5cfdb71310e1373db  clocksource/drivers/timer-vf-pit: Add missing parenthesis

elapsed time: 481m

configs tested: 165
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
powerpc                             defconfig
c6x                        evmc6678_defconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
i386                              debian-10.3
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
arm                              allmodconfig
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
arc                                 defconfig
arc                              allyesconfig
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
x86_64               randconfig-a003-20200405
i386                 randconfig-a002-20200405
x86_64               randconfig-a002-20200405
x86_64               randconfig-a001-20200405
i386                 randconfig-a001-20200405
i386                 randconfig-a003-20200405
mips                 randconfig-a001-20200405
nds32                randconfig-a001-20200405
m68k                 randconfig-a001-20200405
parisc               randconfig-a001-20200405
alpha                randconfig-a001-20200405
riscv                randconfig-a001-20200405
sparc64              randconfig-a001-20200405
h8300                randconfig-a001-20200405
nios2                randconfig-a001-20200405
c6x                  randconfig-a001-20200405
microblaze           randconfig-a001-20200405
s390                 randconfig-a001-20200405
xtensa               randconfig-a001-20200405
csky                 randconfig-a001-20200405
openrisc             randconfig-a001-20200405
sh                   randconfig-a001-20200405
x86_64               randconfig-b001-20200405
x86_64               randconfig-b002-20200405
x86_64               randconfig-b003-20200405
i386                 randconfig-b001-20200405
i386                 randconfig-b002-20200405
i386                 randconfig-b003-20200405
x86_64               randconfig-c001-20200405
x86_64               randconfig-c002-20200405
x86_64               randconfig-c003-20200405
i386                 randconfig-c001-20200405
i386                 randconfig-c002-20200405
i386                 randconfig-c003-20200405
x86_64               randconfig-d003-20200405
i386                 randconfig-d003-20200405
i386                 randconfig-d001-20200405
x86_64               randconfig-d002-20200405
i386                 randconfig-d002-20200405
x86_64               randconfig-d001-20200405
x86_64               randconfig-e001-20200405
x86_64               randconfig-e002-20200405
x86_64               randconfig-e003-20200405
i386                 randconfig-e001-20200405
i386                 randconfig-e002-20200405
i386                 randconfig-e003-20200405
i386                 randconfig-f001-20200405
x86_64               randconfig-f003-20200405
i386                 randconfig-f003-20200405
x86_64               randconfig-f001-20200405
x86_64               randconfig-f002-20200405
i386                 randconfig-f002-20200405
x86_64               randconfig-g003-20200405
i386                 randconfig-g003-20200405
x86_64               randconfig-g002-20200405
i386                 randconfig-g001-20200405
i386                 randconfig-g002-20200405
x86_64               randconfig-g001-20200405
x86_64               randconfig-h002-20200405
i386                 randconfig-h002-20200405
i386                 randconfig-h003-20200405
i386                 randconfig-h001-20200405
x86_64               randconfig-h003-20200405
x86_64               randconfig-h001-20200405
arc                  randconfig-a001-20200405
arm                  randconfig-a001-20200405
arm64                randconfig-a001-20200405
ia64                 randconfig-a001-20200405
powerpc              randconfig-a001-20200405
sparc                randconfig-a001-20200405
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
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                             defconfig
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
