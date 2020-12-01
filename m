Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3802C99A8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 09:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgLAIhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 03:37:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:29608 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727391AbgLAIhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 03:37:09 -0500
IronPort-SDR: rVhIn17sh5sntEci+EnFQO/LSTe6feJ0nf8BHaWWUxNW3bd+4EcbilVHJrTfJr6h/yLPJ6s3s7
 hoFyXEuKKwjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="172949757"
X-IronPort-AV: E=Sophos;i="5.78,384,1599548400"; 
   d="scan'208";a="172949757"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 00:36:28 -0800
IronPort-SDR: T+1s6vcfeFIpgbyg4Qz7eJDQUCreaSn18469V4nuYszHM8/Tct22T8WxCWoSVUONIn+tKPrXF0
 C+15EiPDZqLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,384,1599548400"; 
   d="scan'208";a="372822205"
Received: from lkp-server01.sh.intel.com (HELO 70b44b587200) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Dec 2020 00:36:26 -0800
Received: from kbuild by 70b44b587200 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kk197-0000C7-Dv; Tue, 01 Dec 2020 08:36:25 +0000
Date:   Tue, 01 Dec 2020 16:35:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.11.27a] BUILD SUCCESS
 253d2df24d9b489825ad22b6c191a42d2a83343e
Message-ID: <5fc60060.YAJ8aQUmMS14lU7J%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.11.27a
branch HEAD: 253d2df24d9b489825ad22b6c191a42d2a83343e  fixup! torture: Make torture.sh throttle VERBOSE_TOROUT_*() for refscale

elapsed time: 723m

configs tested: 122
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
h8300                     edosk2674_defconfig
sh                          rsk7203_defconfig
arm                       imx_v6_v7_defconfig
arc                            hsdk_defconfig
ia64                            zx1_defconfig
sh                              ul2_defconfig
powerpc                    sam440ep_defconfig
nds32                            alldefconfig
arm                            qcom_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                           xway_defconfig
powerpc                       maple_defconfig
xtensa                    xip_kc705_defconfig
sh                         apsh4a3a_defconfig
c6x                         dsk6455_defconfig
powerpc                      ppc64e_defconfig
openrisc                 simple_smp_defconfig
s390                       zfcpdump_defconfig
mips                           gcw0_defconfig
arm                      pxa255-idp_defconfig
arm                        multi_v7_defconfig
m68k                                defconfig
powerpc                    adder875_defconfig
sh                               j2_defconfig
sh                   secureedge5410_defconfig
powerpc                      katmai_defconfig
arc                           tb10x_defconfig
mips                      fuloong2e_defconfig
m68k                         apollo_defconfig
arm                           spitz_defconfig
arm                         vf610m4_defconfig
arm                          lpd270_defconfig
xtensa                           allyesconfig
powerpc                        fsp2_defconfig
mips                       capcella_defconfig
powerpc                      ppc44x_defconfig
arm                          imote2_defconfig
powerpc                       ebony_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                      malta_kvm_defconfig
arm                       netwinder_defconfig
powerpc                     tqm8555_defconfig
mips                        nlm_xlp_defconfig
mips                     cu1830-neo_defconfig
c6x                        evmc6678_defconfig
powerpc                      walnut_defconfig
mips                      loongson3_defconfig
arc                              allyesconfig
m68k                        mvme16x_defconfig
mips                          rm200_defconfig
m68k                       bvme6000_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
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
i386                 randconfig-a004-20201130
i386                 randconfig-a002-20201130
i386                 randconfig-a003-20201130
i386                 randconfig-a005-20201130
i386                 randconfig-a006-20201130
i386                 randconfig-a001-20201130
x86_64               randconfig-a014-20201130
x86_64               randconfig-a015-20201130
x86_64               randconfig-a016-20201130
x86_64               randconfig-a011-20201130
x86_64               randconfig-a012-20201130
x86_64               randconfig-a013-20201130
i386                 randconfig-a013-20201130
i386                 randconfig-a012-20201130
i386                 randconfig-a011-20201130
i386                 randconfig-a016-20201130
i386                 randconfig-a015-20201130
i386                 randconfig-a014-20201130
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
x86_64               randconfig-a002-20201130
x86_64               randconfig-a006-20201130
x86_64               randconfig-a005-20201130
x86_64               randconfig-a004-20201130
x86_64               randconfig-a001-20201130
x86_64               randconfig-a003-20201130

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
