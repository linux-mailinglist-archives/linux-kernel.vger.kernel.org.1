Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457931C7FED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 04:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgEGCHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 22:07:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:30926 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgEGCHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 22:07:47 -0400
IronPort-SDR: FLajgIDe9kWV+IU30Ao/YcxIiyYCeTPoTC3tByt+cSInSKfrjhIedt2mzg9sXOaXfzxDaWJasn
 YLLqjoTxkEtQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 19:07:47 -0700
IronPort-SDR: /RgcEt39l1yDVLY3139yPdd13Ehwl8pXcEGbOLpdu4F1qgD/vKcI+LUk2J+kUDKvh4jYWkRS5G
 LKwUyTBfzMiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,361,1583222400"; 
   d="scan'208";a="296393612"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 06 May 2020 19:07:45 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jWVwv-000EqI-2q; Thu, 07 May 2020 10:07:45 +0800
Date:   Thu, 07 May 2020 10:07:15 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cache] BUILD SUCCESS
 0c4d5ba1b998e713815b7790d3db6ced0ae49489
Message-ID: <5eb36d53.+UNYFObQAGo/NbBu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cache
branch HEAD: 0c4d5ba1b998e713815b7790d3db6ced0ae49489  x86/resctrl: Support wider MBM counters

elapsed time: 480m

configs tested: 175
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                               allnoconfig
arm                              allmodconfig
sparc                            allyesconfig
m68k                             allyesconfig
ia64                             allyesconfig
csky                             allyesconfig
mips                             allyesconfig
alpha                            allyesconfig
m68k                                defconfig
powerpc                           allnoconfig
c6x                               allnoconfig
powerpc                             defconfig
s390                             alldefconfig
ia64                             alldefconfig
sparc64                          allmodconfig
nds32                               defconfig
i386                             alldefconfig
um                               allmodconfig
ia64                              allnoconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
openrisc                         allyesconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
microblaze                       allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          alldefconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
m68k                 randconfig-a001-20200506
mips                 randconfig-a001-20200506
nds32                randconfig-a001-20200506
parisc               randconfig-a001-20200506
alpha                randconfig-a001-20200506
riscv                randconfig-a001-20200506
m68k                 randconfig-a001-20200507
mips                 randconfig-a001-20200507
nds32                randconfig-a001-20200507
parisc               randconfig-a001-20200507
alpha                randconfig-a001-20200507
riscv                randconfig-a001-20200507
h8300                randconfig-a001-20200506
nios2                randconfig-a001-20200506
microblaze           randconfig-a001-20200506
c6x                  randconfig-a001-20200506
sparc64              randconfig-a001-20200506
h8300                randconfig-a001-20200507
nios2                randconfig-a001-20200507
microblaze           randconfig-a001-20200507
c6x                  randconfig-a001-20200507
sparc64              randconfig-a001-20200507
s390                 randconfig-a001-20200506
xtensa               randconfig-a001-20200506
sh                   randconfig-a001-20200506
openrisc             randconfig-a001-20200506
csky                 randconfig-a001-20200506
xtensa               randconfig-a001-20200507
sh                   randconfig-a001-20200507
openrisc             randconfig-a001-20200507
csky                 randconfig-a001-20200507
x86_64               randconfig-a003-20200506
x86_64               randconfig-a001-20200506
x86_64               randconfig-a002-20200506
i386                 randconfig-a001-20200506
i386                 randconfig-a002-20200506
i386                 randconfig-a003-20200506
i386                 randconfig-b003-20200506
i386                 randconfig-b001-20200506
x86_64               randconfig-b001-20200506
x86_64               randconfig-b003-20200506
i386                 randconfig-b002-20200506
x86_64               randconfig-c002-20200507
x86_64               randconfig-c001-20200507
i386                 randconfig-c002-20200507
i386                 randconfig-c003-20200507
x86_64               randconfig-c003-20200507
i386                 randconfig-c001-20200507
i386                 randconfig-d003-20200506
i386                 randconfig-d001-20200506
x86_64               randconfig-d002-20200506
i386                 randconfig-d002-20200506
x86_64               randconfig-d001-20200507
i386                 randconfig-d003-20200507
i386                 randconfig-d001-20200507
x86_64               randconfig-d003-20200507
x86_64               randconfig-d002-20200507
i386                 randconfig-d002-20200507
i386                 randconfig-e003-20200506
x86_64               randconfig-e003-20200506
x86_64               randconfig-e001-20200506
i386                 randconfig-e002-20200506
i386                 randconfig-e001-20200506
i386                 randconfig-f003-20200507
x86_64               randconfig-f002-20200507
i386                 randconfig-f001-20200507
i386                 randconfig-f002-20200507
i386                 randconfig-f003-20200506
x86_64               randconfig-f001-20200506
x86_64               randconfig-f003-20200506
x86_64               randconfig-f002-20200506
i386                 randconfig-f001-20200506
i386                 randconfig-f002-20200506
x86_64               randconfig-g003-20200506
i386                 randconfig-g003-20200506
i386                 randconfig-g002-20200506
x86_64               randconfig-g001-20200506
i386                 randconfig-g001-20200506
x86_64               randconfig-g002-20200506
i386                 randconfig-h002-20200506
i386                 randconfig-h001-20200506
i386                 randconfig-h003-20200506
x86_64               randconfig-h002-20200506
x86_64               randconfig-h003-20200506
x86_64               randconfig-h001-20200506
ia64                 randconfig-a001-20200506
arm64                randconfig-a001-20200506
arc                  randconfig-a001-20200506
powerpc              randconfig-a001-20200506
arm                  randconfig-a001-20200506
sparc                randconfig-a001-20200506
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                               allyesconfig
um                                  defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
