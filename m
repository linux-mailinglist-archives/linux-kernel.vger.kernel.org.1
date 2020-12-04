Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9F72CE5A5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 03:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgLDCXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 21:23:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:25679 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgLDCXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 21:23:16 -0500
IronPort-SDR: LttShEv9CRpCm4UQiHF3x7gC0bplAOcD6u/3WYuU1nF9JJ8sL4oTkw6ixoRz/uTHQj0fyY2Fz6
 fDi8DboTJH8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="237433272"
X-IronPort-AV: E=Sophos;i="5.78,391,1599548400"; 
   d="scan'208";a="237433272"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 18:22:34 -0800
IronPort-SDR: FmaFXUHTT5qp/e7MHrSGA/1JndkR8j7f+4LM0eQrxxZhNQmyofLZwGHVN8R2sV00Z8+y/I/upt
 ACA2UgbpJ3aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,391,1599548400"; 
   d="scan'208";a="538639020"
Received: from lkp-server01.sh.intel.com (HELO 14e4acb3e84f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 03 Dec 2020 18:22:33 -0800
Received: from kbuild by 14e4acb3e84f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kl0jw-00000q-Hd; Fri, 04 Dec 2020 02:22:32 +0000
Date:   Fri, 04 Dec 2020 10:22:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 c88a82f668cff457561272632a06a4a63dbf2fe0
Message-ID: <5fc99d5f.mLnKIlIhZsyGemfE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  perf/core
branch HEAD: c88a82f668cff457561272632a06a4a63dbf2fe0  powerpc/8xx: Implement pXX_leaf_size() support

elapsed time: 1024m

configs tested: 138
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                   motionpro_defconfig
mips                     cu1830-neo_defconfig
sh                        sh7763rdp_defconfig
powerpc                   lite5200b_defconfig
powerpc                     sbc8548_defconfig
arm                      footbridge_defconfig
h8300                       h8s-sim_defconfig
arm                       aspeed_g4_defconfig
powerpc                    klondike_defconfig
arm                       imx_v6_v7_defconfig
arc                           tb10x_defconfig
powerpc                 mpc8315_rdb_defconfig
riscv                            alldefconfig
powerpc                      ppc6xx_defconfig
arm                            hisi_defconfig
arm                            dove_defconfig
arc                     nsimosci_hs_defconfig
arm                          imote2_defconfig
sh                          r7780mp_defconfig
sh                           se7712_defconfig
sh                                  defconfig
sh                          r7785rp_defconfig
powerpc                      arches_defconfig
arm                            xcep_defconfig
arm                             ezx_defconfig
powerpc                      walnut_defconfig
arm                        spear6xx_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                    mvme5100_defconfig
powerpc                       eiger_defconfig
mips                      malta_kvm_defconfig
c6x                                 defconfig
arm                          pcm027_defconfig
arm                          tango4_defconfig
mips                         tb0226_defconfig
s390                       zfcpdump_defconfig
powerpc                     mpc5200_defconfig
powerpc                     pq2fads_defconfig
arm                        cerfcube_defconfig
sh                          sdk7786_defconfig
powerpc                 mpc832x_mds_defconfig
ia64                            zx1_defconfig
arm                            mps2_defconfig
arm                          simpad_defconfig
arm                          collie_defconfig
arm                         ebsa110_defconfig
arc                      axs103_smp_defconfig
h8300                    h8300h-sim_defconfig
mips                          ath25_defconfig
sh                        edosk7705_defconfig
arm                        multi_v5_defconfig
mips                  decstation_64_defconfig
xtensa                           alldefconfig
arm                           h3600_defconfig
mips                          malta_defconfig
powerpc                     sequoia_defconfig
um                            kunit_defconfig
mips                      fuloong2e_defconfig
m68k                            mac_defconfig
m68k                          hp300_defconfig
arm                             pxa_defconfig
mips                      loongson3_defconfig
powerpc64                        alldefconfig
xtensa                  cadence_csp_defconfig
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
i386                 randconfig-a004-20201203
i386                 randconfig-a005-20201203
i386                 randconfig-a001-20201203
i386                 randconfig-a002-20201203
i386                 randconfig-a006-20201203
i386                 randconfig-a003-20201203
x86_64               randconfig-a016-20201203
x86_64               randconfig-a012-20201203
x86_64               randconfig-a014-20201203
x86_64               randconfig-a013-20201203
x86_64               randconfig-a015-20201203
x86_64               randconfig-a011-20201203
i386                 randconfig-a014-20201203
i386                 randconfig-a013-20201203
i386                 randconfig-a011-20201203
i386                 randconfig-a015-20201203
i386                 randconfig-a012-20201203
i386                 randconfig-a016-20201203
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
x86_64               randconfig-a004-20201203
x86_64               randconfig-a006-20201203
x86_64               randconfig-a001-20201203
x86_64               randconfig-a002-20201203
x86_64               randconfig-a005-20201203
x86_64               randconfig-a003-20201203

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
