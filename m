Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F11C26B7EF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgIPAcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:32:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:12686 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgIONnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:43:52 -0400
IronPort-SDR: 5VUYrtk3rIMvv4isXiWS5/yKWxMoKTGl521tkVHPEbbfSmhYreBd0SxeHlIPa/s2kQHs2jKj4b
 mTrXyr8zaxHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="220812028"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="220812028"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2020 06:43:32 -0700
IronPort-SDR: Z3Fv20sJmew1RWHSqC5FzzVcov16F7xeFZ+n7CyLRceIWwEA9CG+uC5vSOL+36RFfE67OB38cK
 t1t7G8Uda+CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; 
   d="scan'208";a="306627993"
Received: from lkp-server01.sh.intel.com (HELO 96654786cb26) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 15 Sep 2020 06:43:30 -0700
Received: from kbuild by 96654786cb26 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kIBF4-00008g-4n; Tue, 15 Sep 2020 13:43:30 +0000
Date:   Tue, 15 Sep 2020 21:42:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/seves] BUILD SUCCESS WITH WARNING
 e6eb15c9ba3165698488ae5c34920eea20eaa38e
Message-ID: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  x86/seves
branch HEAD: e6eb15c9ba3165698488ae5c34920eea20eaa38e  KVM: nSVM: Avoid freeing uninitialized pointers in svm_set_nested_state()

Warning in current branch:

arch/x86/kernel/sev-es.o: warning: objtool: ist_exc_vmm_communication()+0x12: unreachable instruction

Warning ids grouped by kconfigs:

clang_recent_errors
`-- x86_64-randconfig-r001-20200913
    `-- arch-x86-kernel-sev-es.o:warning:objtool:ist_exc_vmm_communication():unreachable-instruction

elapsed time: 1267m

configs tested: 106
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                          hp300_defconfig
sh                          sdk7786_defconfig
powerpc                          g5_defconfig
arm                           tegra_defconfig
openrisc                 simple_smp_defconfig
powerpc                        icon_defconfig
sh                          r7780mp_defconfig
powerpc                    mvme5100_defconfig
um                             i386_defconfig
arc                            hsdk_defconfig
powerpc                    gamecube_defconfig
powerpc                 mpc836x_mds_defconfig
arm                         shannon_defconfig
powerpc                      pcm030_defconfig
parisc                generic-64bit_defconfig
sh                        dreamcast_defconfig
arm                            mps2_defconfig
arm                       aspeed_g4_defconfig
arm                            pleb_defconfig
ia64                             allyesconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
arm                       aspeed_g5_defconfig
sparc                       sparc64_defconfig
powerpc                     tqm8560_defconfig
riscv                            allmodconfig
arm                        spear3xx_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                        m5307c3_defconfig
c6x                              alldefconfig
arm                        trizeps4_defconfig
arm                        multi_v7_defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                                defconfig
nios2                               defconfig
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
arc                              allyesconfig
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
x86_64               randconfig-a004-20200914
x86_64               randconfig-a006-20200914
x86_64               randconfig-a003-20200914
x86_64               randconfig-a002-20200914
x86_64               randconfig-a001-20200914
x86_64               randconfig-a005-20200914
i386                 randconfig-a004-20200914
i386                 randconfig-a006-20200914
i386                 randconfig-a001-20200914
i386                 randconfig-a003-20200914
i386                 randconfig-a002-20200914
i386                 randconfig-a005-20200914
i386                 randconfig-a015-20200914
i386                 randconfig-a014-20200914
i386                 randconfig-a011-20200914
i386                 randconfig-a013-20200914
i386                 randconfig-a016-20200914
i386                 randconfig-a012-20200914
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20200913
x86_64               randconfig-a004-20200913
x86_64               randconfig-a003-20200913
x86_64               randconfig-a002-20200913
x86_64               randconfig-a005-20200913
x86_64               randconfig-a001-20200913
x86_64               randconfig-a014-20200914
x86_64               randconfig-a011-20200914
x86_64               randconfig-a016-20200914
x86_64               randconfig-a012-20200914
x86_64               randconfig-a015-20200914
x86_64               randconfig-a013-20200914

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
