Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E9226F9FD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgIRKLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:11:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:40596 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgIRKLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:11:19 -0400
IronPort-SDR: PxYFcvXh/HIPZDK/o+khfAn2SXGFCgs3saT/ALoZtrWVvl6CHUM82N+p+cLGA6qCreA+X3FDeM
 vU0UOjIsyxZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="221463771"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="221463771"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 03:11:17 -0700
IronPort-SDR: 3sVqC0iYKsT3iYZpfF9OgQCMQw2gfiK2ymtINliV/V7SLJrIueH2Uug4UalU2M9BjtnEN3M04x
 hMdvgz/M9Jkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="303288964"
Received: from lkp-server01.sh.intel.com (HELO a05db971c861) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 18 Sep 2020 03:11:16 -0700
Received: from kbuild by a05db971c861 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kJDMJ-0000VB-Mq; Fri, 18 Sep 2020 10:11:15 +0000
Date:   Fri, 18 Sep 2020 18:10:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 4ad1536d5b19b769f326a2ef9f9572a0084ebefe
Message-ID: <5f6487a3.fvlaTWmtP4ssLl7L%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: 4ad1536d5b19b769f326a2ef9f9572a0084ebefe  rcutorture: Adjust scenarios SRCU-t and SRCU-u to make kconfig happy

elapsed time: 725m

configs tested: 109
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                      axs103_smp_defconfig
powerpc               mpc834x_itxgp_defconfig
xtensa                              defconfig
powerpc                        cell_defconfig
mips                           ip22_defconfig
powerpc                     akebono_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                     rainier_defconfig
mips                       capcella_defconfig
powerpc                     kilauea_defconfig
arm                         ebsa110_defconfig
sh                        edosk7760_defconfig
sparc64                          alldefconfig
m68k                          multi_defconfig
sh                        edosk7705_defconfig
mips                  cavium_octeon_defconfig
nios2                         10m50_defconfig
powerpc                        fsp2_defconfig
mips                       lemote2f_defconfig
powerpc                       maple_defconfig
sh                          rsk7269_defconfig
sh                          sdk7780_defconfig
powerpc                     sbc8548_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                                  defconfig
sh                        sh7763rdp_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                      loongson3_defconfig
sh                            migor_defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20200917
i386                 randconfig-a006-20200917
i386                 randconfig-a003-20200917
i386                 randconfig-a001-20200917
i386                 randconfig-a002-20200917
i386                 randconfig-a005-20200917
x86_64               randconfig-a014-20200917
x86_64               randconfig-a011-20200917
x86_64               randconfig-a016-20200917
x86_64               randconfig-a012-20200917
x86_64               randconfig-a015-20200917
x86_64               randconfig-a013-20200917
i386                 randconfig-a015-20200917
i386                 randconfig-a014-20200917
i386                 randconfig-a011-20200917
i386                 randconfig-a013-20200917
i386                 randconfig-a016-20200917
i386                 randconfig-a012-20200917
i386                 randconfig-a015-20200918
i386                 randconfig-a011-20200918
i386                 randconfig-a014-20200918
i386                 randconfig-a013-20200918
i386                 randconfig-a012-20200918
i386                 randconfig-a016-20200918
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
x86_64               randconfig-a006-20200917
x86_64               randconfig-a004-20200917
x86_64               randconfig-a003-20200917
x86_64               randconfig-a002-20200917
x86_64               randconfig-a001-20200917
x86_64               randconfig-a005-20200917

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
