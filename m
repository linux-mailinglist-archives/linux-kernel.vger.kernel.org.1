Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1062E0576
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 05:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgLVElR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 23:41:17 -0500
Received: from mga12.intel.com ([192.55.52.136]:14686 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgLVElQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 23:41:16 -0500
IronPort-SDR: eo8TqR+XHfZuh0v5D8G2hgoSjf09copDNEqqOBkUn6QkoZgB2Uphe+BeKMJT5y+CZGezUuDIFA
 MZFdyYKnDbiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9842"; a="155033635"
X-IronPort-AV: E=Sophos;i="5.78,438,1599548400"; 
   d="scan'208";a="155033635"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 20:40:35 -0800
IronPort-SDR: ufAiMYL5Lx+RTpHKDfizMLNs++16pdRvw0EZlci2Ml/HXEiijn8+GKV7/Dl6yWF/hrv798Ef50
 /J2kUZDpEV0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,438,1599548400"; 
   d="scan'208";a="382352934"
Received: from lkp-server01.sh.intel.com (HELO 65587561063d) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 21 Dec 2020 20:40:33 -0800
Received: from kbuild by 65587561063d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1krZTN-0001IB-0A; Tue, 22 Dec 2020 04:40:33 +0000
Date:   Tue, 22 Dec 2020 12:39:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/test] BUILD SUCCESS
 4c4c8e04a7f8522de634aa062f4cd6b8b80c151b
Message-ID: <5fe17890.DgAUduMCiEob9Doo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/test
branch HEAD: 4c4c8e04a7f8522de634aa062f4cd6b8b80c151b  Merge commit 'e37b12e4bb21e7c81732370b0a2b34bd196f380b' into rcu/test

elapsed time: 720m

configs tested: 100
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                             allyesconfig
mips                     cu1000-neo_defconfig
sh                            titan_defconfig
mips                        bcm47xx_defconfig
sh                        dreamcast_defconfig
arm                           viper_defconfig
arm                         socfpga_defconfig
powerpc                     pq2fads_defconfig
ia64                        generic_defconfig
mips                       lemote2f_defconfig
sh                   sh7724_generic_defconfig
c6x                                 defconfig
xtensa                  audio_kc705_defconfig
mips                        nlm_xlr_defconfig
arm                        neponset_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                    ge_imp3a_defconfig
m68k                            q40_defconfig
powerpc                 mpc8313_rdb_defconfig
parisc                           allyesconfig
powerpc                     kilauea_defconfig
h8300                     edosk2674_defconfig
sh                          rsk7269_defconfig
powerpc                 linkstation_defconfig
riscv                               defconfig
powerpc64                        alldefconfig
arm                          lpd270_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20201221
x86_64               randconfig-a006-20201221
x86_64               randconfig-a002-20201221
x86_64               randconfig-a004-20201221
x86_64               randconfig-a003-20201221
x86_64               randconfig-a005-20201221
i386                 randconfig-a005-20201222
i386                 randconfig-a002-20201222
i386                 randconfig-a006-20201222
i386                 randconfig-a004-20201222
i386                 randconfig-a003-20201222
i386                 randconfig-a001-20201222
i386                 randconfig-a011-20201221
i386                 randconfig-a016-20201221
i386                 randconfig-a014-20201221
i386                 randconfig-a012-20201221
i386                 randconfig-a015-20201221
i386                 randconfig-a013-20201221
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
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
x86_64               randconfig-a015-20201221
x86_64               randconfig-a014-20201221
x86_64               randconfig-a016-20201221
x86_64               randconfig-a012-20201221
x86_64               randconfig-a013-20201221
x86_64               randconfig-a011-20201221

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
