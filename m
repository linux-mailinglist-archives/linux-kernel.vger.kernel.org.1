Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A75276C6B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 10:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbgIXIw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 04:52:29 -0400
Received: from mga05.intel.com ([192.55.52.43]:48417 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbgIXIw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 04:52:29 -0400
IronPort-SDR: nlwlr5snH/5RJfZDL2eB7CE70QfqR90IucEIsPJFshJn2q5EbccHgIPs0K76VQVnrhYcxkVAzA
 AcQ9tg3LAq9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9753"; a="245938022"
X-IronPort-AV: E=Sophos;i="5.77,296,1596524400"; 
   d="scan'208";a="245938022"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 01:52:28 -0700
IronPort-SDR: yA3j/QbryO/25wfHmpD5ciUFDUStje5OvHJa3zbUBSWwUfpQ9D7PJVPcunVkR1bRkgQT68WDyI
 y5qf6OH5ckgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,296,1596524400"; 
   d="scan'208";a="382973301"
Received: from lkp-server01.sh.intel.com (HELO 9f27196b5390) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 Sep 2020 01:52:27 -0700
Received: from kbuild by 9f27196b5390 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kLMzK-0000cv-LX; Thu, 24 Sep 2020 08:52:26 +0000
Date:   Thu, 24 Sep 2020 16:51:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 86a82ae0b5095ea24c55898a3f025791e7958b21
Message-ID: <5f6c5e28.nM5u590AluD+xdRc%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: 86a82ae0b5095ea24c55898a3f025791e7958b21  x86/ioapic: Unbreak check_timer()

elapsed time: 723m

configs tested: 113
configs skipped: 60

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
h8300                       h8s-sim_defconfig
sh                             espt_defconfig
arm                          iop32x_defconfig
arm                       spear13xx_defconfig
arm                          simpad_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                      tqm8xx_defconfig
powerpc                    ge_imp3a_defconfig
mips                          rm200_defconfig
csky                                defconfig
i386                                defconfig
arm                          lpd270_defconfig
sh                          rsk7264_defconfig
arm                        neponset_defconfig
powerpc                      makalu_defconfig
arm                       aspeed_g4_defconfig
arm                         axm55xx_defconfig
m68k                            q40_defconfig
sh                           se7712_defconfig
sh                           se7206_defconfig
m68k                         apollo_defconfig
arc                            hsdk_defconfig
mips                          ath79_defconfig
arc                     nsimosci_hs_defconfig
arm                          imote2_defconfig
mips                      malta_kvm_defconfig
arm                             mxs_defconfig
powerpc                      katmai_defconfig
openrisc                 simple_smp_defconfig
arm                          pxa910_defconfig
sh                                  defconfig
arc                             nps_defconfig
mips                          ath25_defconfig
mips                        nlm_xlp_defconfig
sh                           se7721_defconfig
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
i386                 randconfig-a002-20200923
i386                 randconfig-a006-20200923
i386                 randconfig-a003-20200923
i386                 randconfig-a004-20200923
i386                 randconfig-a005-20200923
i386                 randconfig-a001-20200923
x86_64               randconfig-a011-20200923
x86_64               randconfig-a013-20200923
x86_64               randconfig-a014-20200923
x86_64               randconfig-a015-20200923
x86_64               randconfig-a012-20200923
x86_64               randconfig-a016-20200923
i386                 randconfig-a012-20200923
i386                 randconfig-a014-20200923
i386                 randconfig-a016-20200923
i386                 randconfig-a013-20200923
i386                 randconfig-a011-20200923
i386                 randconfig-a015-20200923
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
x86_64               randconfig-a005-20200923
x86_64               randconfig-a003-20200923
x86_64               randconfig-a004-20200923
x86_64               randconfig-a002-20200923
x86_64               randconfig-a006-20200923
x86_64               randconfig-a001-20200923
x86_64               randconfig-a011-20200924
x86_64               randconfig-a013-20200924
x86_64               randconfig-a014-20200924
x86_64               randconfig-a015-20200924
x86_64               randconfig-a012-20200924
x86_64               randconfig-a016-20200924

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
