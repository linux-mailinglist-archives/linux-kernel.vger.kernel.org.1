Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABEFE19FB30
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 19:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgDFRSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 13:18:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:15572 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgDFRSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 13:18:00 -0400
IronPort-SDR: kXB5UC6Y02J6rMODQPV8guTy1mLJP2kkUj1cV8f7zzoNEyn8q0WST4NJXcoS7G6wHZmohhzExK
 NF+qb4JBQ3lg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2020 10:17:59 -0700
IronPort-SDR: m8cvggJnMhz6VrEUbS/+FwryRqRjk047z9lN/WkzePle68Casc1iPSgI5wjlFg2g5QfX9JRRl3
 N2GQFo9z2zcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,351,1580803200"; 
   d="scan'208";a="254175368"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Apr 2020 10:17:57 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jLVNl-000Are-2y; Tue, 07 Apr 2020 01:17:57 +0800
Date:   Tue, 07 Apr 2020 01:17:43 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:urgent-for-mingo] BUILD SUCCESS
 bf37da98c51825c90432d340e135cced37a7460d
Message-ID: <5e8b6437.ow8BEdP6EtsP+qXE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  urgent-for-mingo
branch HEAD: bf37da98c51825c90432d340e135cced37a7460d  rcu: Don't acquire lock in NMI handler in rcu_nmi_enter_common()

elapsed time: 1187m

configs tested: 140
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
sparc                            allyesconfig
arm                        multi_v7_defconfig
sh                                allnoconfig
sh                            titan_defconfig
um                                  defconfig
csky                                defconfig
mips                             allyesconfig
c6x                        evmc6678_defconfig
s390                             allmodconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
nds32                               defconfig
nds32                             allnoconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                                 defconfig
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
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
sparc64              randconfig-a001-20200405
h8300                randconfig-a001-20200405
nios2                randconfig-a001-20200405
c6x                  randconfig-a001-20200405
csky                 randconfig-a001-20200405
openrisc             randconfig-a001-20200405
s390                 randconfig-a001-20200405
sh                   randconfig-a001-20200405
xtensa               randconfig-a001-20200405
x86_64               randconfig-c001-20200405
x86_64               randconfig-c002-20200405
x86_64               randconfig-c003-20200405
i386                 randconfig-c001-20200405
i386                 randconfig-c002-20200405
i386                 randconfig-c003-20200405
x86_64               randconfig-d003-20200406
x86_64               randconfig-d001-20200406
i386                 randconfig-d003-20200406
i386                 randconfig-d001-20200406
x86_64               randconfig-d002-20200406
i386                 randconfig-d002-20200406
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
x86_64               randconfig-g001-20200406
x86_64               randconfig-g002-20200406
x86_64               randconfig-g003-20200406
i386                 randconfig-g001-20200406
i386                 randconfig-g002-20200406
i386                 randconfig-g003-20200406
x86_64               randconfig-g003-20200405
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
s390                             alldefconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                  sh7785lcr_32bit_defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
