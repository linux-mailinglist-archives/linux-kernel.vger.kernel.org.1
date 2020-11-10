Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2802AD0B7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 08:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgKJH5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 02:57:01 -0500
Received: from mga04.intel.com ([192.55.52.120]:56319 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgKJH5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 02:57:01 -0500
IronPort-SDR: Wrlrkqg4GUVGRM3Q9kM/Z/6az0bpIG2f/eBFPiJeeYl1NaHi2u7agAWlgRQBfGyDvWZV15Xw8l
 LAFoUmZnuULQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="167350852"
X-IronPort-AV: E=Sophos;i="5.77,465,1596524400"; 
   d="scan'208";a="167350852"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 23:57:01 -0800
IronPort-SDR: YYnBome3Gk9WqKqU4lSePP2E8UeOnXynJV4Tz5Fw2sN4UItsk23jrEtFcynRZFH7kcPKhT2obw
 QhZ+vAB43ypg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,465,1596524400"; 
   d="scan'208";a="307957961"
Received: from lkp-server02.sh.intel.com (HELO c6c5fbb3488a) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 09 Nov 2020 23:56:59 -0800
Received: from kbuild by c6c5fbb3488a with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kcOWR-00006h-BZ; Tue, 10 Nov 2020 07:56:59 +0000
Date:   Tue, 10 Nov 2020 15:56:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.11.06a] BUILD REGRESSION
 5cec02881428f10c4a1632c3aebb666b12888958
Message-ID: <5faa47b2.vPqa1IkRNFrHHqZM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.11.06a
branch HEAD: 5cec02881428f10c4a1632c3aebb666b12888958  docs: Remove redundant "``" from Requirements.rst

Error/Warning reports:

https://lore.kernel.org/lkml/202011100859.GaVtzgeJ-lkp@intel.com

Error/Warning in current branch:

rdtgroup.c:(.text+0xad8a): undefined reference to `cpulist_parse'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-randconfig-m001-20201109
    `-- rdtgroup.c:(.text):undefined-reference-to-cpulist_parse

elapsed time: 722m

configs tested: 99
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          urquell_defconfig
mips                      malta_kvm_defconfig
powerpc                    gamecube_defconfig
mips                      maltaaprp_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                      tqm8xx_defconfig
sh                             espt_defconfig
arc                        nsim_700_defconfig
i386                                defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                       maple_defconfig
sh                               alldefconfig
sh                ecovec24-romimage_defconfig
m68k                         amcore_defconfig
powerpc                      katmai_defconfig
sh                   sh7770_generic_defconfig
arm                       omap2plus_defconfig
riscv                            alldefconfig
arm                        realview_defconfig
xtensa                  audio_kc705_defconfig
xtensa                              defconfig
sh                          rsk7203_defconfig
arm                       cns3420vb_defconfig
arm                           omap1_defconfig
c6x                        evmc6472_defconfig
arm                          ixp4xx_defconfig
ia64                                defconfig
ia64                             allmodconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20201110
x86_64               randconfig-a005-20201110
x86_64               randconfig-a004-20201110
x86_64               randconfig-a002-20201110
x86_64               randconfig-a006-20201110
x86_64               randconfig-a001-20201110
i386                 randconfig-a004-20201109
i386                 randconfig-a006-20201109
i386                 randconfig-a005-20201109
i386                 randconfig-a001-20201109
i386                 randconfig-a003-20201109
i386                 randconfig-a002-20201109
i386                 randconfig-a012-20201110
i386                 randconfig-a014-20201110
i386                 randconfig-a016-20201110
i386                 randconfig-a011-20201110
i386                 randconfig-a015-20201110
i386                 randconfig-a013-20201110
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
x86_64               randconfig-a015-20201110
x86_64               randconfig-a011-20201110
x86_64               randconfig-a014-20201110
x86_64               randconfig-a013-20201110
x86_64               randconfig-a016-20201110
x86_64               randconfig-a012-20201110

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
