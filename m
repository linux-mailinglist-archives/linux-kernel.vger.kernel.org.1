Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CE22AC109
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 17:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730662AbgKIQgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 11:36:31 -0500
Received: from mga03.intel.com ([134.134.136.65]:18903 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730632AbgKIQga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:36:30 -0500
IronPort-SDR: QAFiAhyOmNvDUVo74GmAiEOpr1z8NzZLWAgPgxH1kASsh/mGLSx66ewh96a2sqITbul9IT0Yj4
 YXqdkf7VOKQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="169942949"
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="169942949"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 08:36:28 -0800
IronPort-SDR: qczp0MkYauECyqcVNXi2CbmNJculueMF5pLD6HSKYaMTl8Ejzv9yVK4rG1wO9RB4VdKSLNxlhP
 Suyc7W6yQDJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="308037728"
Received: from lkp-server01.sh.intel.com (HELO d0be80f1a028) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 09 Nov 2020 08:36:27 -0800
Received: from kbuild by d0be80f1a028 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kcA9a-0000II-Od; Mon, 09 Nov 2020 16:36:26 +0000
Date:   Tue, 10 Nov 2020 00:36:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/kprobes] BUILD SUCCESS
 a70a04b3844f59c29573a8581d5c263225060dd6
Message-ID: <5fa97003.pZdb53hq9vm78aYy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  perf/kprobes
branch HEAD: a70a04b3844f59c29573a8581d5c263225060dd6  locking/atomics: Regenerate the atomics-check SHA1's

elapsed time: 723m

configs tested: 126
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                        nsim_700_defconfig
powerpc                       holly_defconfig
xtensa                  audio_kc705_defconfig
sh                           se7343_defconfig
arm                  colibri_pxa270_defconfig
nds32                            alldefconfig
arm                            hisi_defconfig
arm                         assabet_defconfig
m68k                        m5272c3_defconfig
arm                          pxa910_defconfig
x86_64                           allyesconfig
openrisc                 simple_smp_defconfig
xtensa                  cadence_csp_defconfig
mips                      maltaaprp_defconfig
powerpc                    sam440ep_defconfig
powerpc                     pseries_defconfig
m68k                         amcore_defconfig
arm                         s5pv210_defconfig
mips                  cavium_octeon_defconfig
m68k                             alldefconfig
nios2                         10m50_defconfig
powerpc                     tqm8548_defconfig
c6x                        evmc6474_defconfig
sh                          rsk7201_defconfig
nios2                         3c120_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                          badge4_defconfig
arm                       multi_v4t_defconfig
h8300                               defconfig
arm                          collie_defconfig
arc                                 defconfig
mips                      fuloong2e_defconfig
sh                         microdev_defconfig
arm                            mmp2_defconfig
sh                        sh7757lcr_defconfig
um                           x86_64_defconfig
mips                          rm200_defconfig
powerpc                      bamboo_defconfig
arm                            u300_defconfig
arm                       omap2plus_defconfig
mips                           ip27_defconfig
powerpc                 mpc8560_ads_defconfig
mips                        qi_lb60_defconfig
powerpc                 mpc836x_mds_defconfig
m68k                        m5307c3_defconfig
arm                             rpc_defconfig
c6x                              alldefconfig
powerpc                      pmac32_defconfig
arm                          imote2_defconfig
arc                        vdk_hs38_defconfig
arm                          pcm027_defconfig
arm                        realview_defconfig
mips                          rb532_defconfig
mips                        nlm_xlr_defconfig
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
x86_64               randconfig-a004-20201109
x86_64               randconfig-a002-20201109
x86_64               randconfig-a003-20201109
x86_64               randconfig-a005-20201109
x86_64               randconfig-a006-20201109
x86_64               randconfig-a001-20201109
i386                 randconfig-a004-20201109
i386                 randconfig-a006-20201109
i386                 randconfig-a005-20201109
i386                 randconfig-a001-20201109
i386                 randconfig-a003-20201109
i386                 randconfig-a002-20201109
i386                 randconfig-a014-20201109
i386                 randconfig-a015-20201109
i386                 randconfig-a013-20201109
i386                 randconfig-a016-20201109
i386                 randconfig-a011-20201109
i386                 randconfig-a012-20201109
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20201109
x86_64               randconfig-a015-20201109
x86_64               randconfig-a013-20201109
x86_64               randconfig-a011-20201109
x86_64               randconfig-a014-20201109
x86_64               randconfig-a016-20201109

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
