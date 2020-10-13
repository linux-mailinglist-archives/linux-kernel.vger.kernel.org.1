Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBDF28C9B9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 10:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390781AbgJMIDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 04:03:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:8196 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390718AbgJMICz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 04:02:55 -0400
IronPort-SDR: widGY6HnllUU8YE9NOMpnHEoDfRfOq4TEcNOcb/3EomO1jpX5TIPu/J19RLhr78brlFHK33OJF
 id3poWlNsIPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="162406069"
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="162406069"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 01:02:53 -0700
IronPort-SDR: q6YXQhjLdocZBRjJV11X2KMYWY8bKyHpHzhYWvYNJlidELNEYQWOZC1FO2VV/4LBkpLq0NyigQ
 ikVQs2IQ4ZKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,369,1596524400"; 
   d="scan'208";a="299531283"
Received: from lkp-server02.sh.intel.com (HELO b65d7201e80c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 13 Oct 2020 01:02:52 -0700
Received: from kbuild by b65d7201e80c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kSFGl-00003P-Cc; Tue, 13 Oct 2020 08:02:51 +0000
Date:   Tue, 13 Oct 2020 16:02:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/kprobes] BUILD SUCCESS
 6e426e0fcd20ce144bb93e00b70df51e9f2e08c3
Message-ID: <5f855f22.XrwxZVM8quhmzYRm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  perf/kprobes
branch HEAD: 6e426e0fcd20ce144bb93e00b70df51e9f2e08c3  kprobes: Replace rp->free_instance with freelist

elapsed time: 723m

configs tested: 116
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                    sam440ep_defconfig
sh                          rsk7264_defconfig
powerpc                       ebony_defconfig
arm                            mmp2_defconfig
arm                           spitz_defconfig
powerpc                  iss476-smp_defconfig
s390                          debug_defconfig
powerpc                      cm5200_defconfig
sh                          rsk7201_defconfig
arm                       mainstone_defconfig
csky                                defconfig
openrisc                 simple_smp_defconfig
h8300                            allyesconfig
arc                 nsimosci_hs_smp_defconfig
sh                   sh7770_generic_defconfig
arm                         palmz72_defconfig
arm                      integrator_defconfig
arm                        multi_v7_defconfig
arm                              alldefconfig
arm                      tct_hammer_defconfig
mips                         db1xxx_defconfig
arm                        realview_defconfig
mips                           ip32_defconfig
powerpc                 mpc834x_mds_defconfig
arm                            qcom_defconfig
sh                        sh7785lcr_defconfig
m68k                        stmark2_defconfig
xtensa                  cadence_csp_defconfig
arm                             pxa_defconfig
sh                          rsk7203_defconfig
mips                            ar7_defconfig
powerpc                   motionpro_defconfig
mips                        workpad_defconfig
parisc                              defconfig
sh                   rts7751r2dplus_defconfig
powerpc                  mpc866_ads_defconfig
arm                         at91_dt_defconfig
m68k                         amcore_defconfig
sh                          lboxre2_defconfig
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
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
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
i386                 randconfig-a005-20201012
i386                 randconfig-a006-20201012
i386                 randconfig-a001-20201012
i386                 randconfig-a003-20201012
i386                 randconfig-a004-20201012
i386                 randconfig-a002-20201012
x86_64               randconfig-a016-20201012
x86_64               randconfig-a015-20201012
x86_64               randconfig-a012-20201012
x86_64               randconfig-a013-20201012
x86_64               randconfig-a014-20201012
x86_64               randconfig-a011-20201012
i386                 randconfig-a016-20201012
i386                 randconfig-a015-20201012
i386                 randconfig-a013-20201012
i386                 randconfig-a012-20201012
i386                 randconfig-a011-20201012
i386                 randconfig-a014-20201012
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
x86_64               randconfig-a004-20201012
x86_64               randconfig-a002-20201012
x86_64               randconfig-a006-20201012
x86_64               randconfig-a001-20201012
x86_64               randconfig-a003-20201012
x86_64               randconfig-a005-20201012
x86_64               randconfig-a016-20201013
x86_64               randconfig-a015-20201013
x86_64               randconfig-a012-20201013
x86_64               randconfig-a013-20201013
x86_64               randconfig-a014-20201013
x86_64               randconfig-a011-20201013

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
