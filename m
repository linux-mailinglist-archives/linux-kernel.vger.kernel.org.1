Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25552858BA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 08:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgJGGgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 02:36:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:11310 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgJGGgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 02:36:45 -0400
IronPort-SDR: WeYdbDJqDCxEB3wWkiakYsTANTKJsvz30BMLj6NQaxdmTCXWakyYhEi6jxLQqccbNPIhd2IPKs
 ddl+MVEpyzgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="182309562"
X-IronPort-AV: E=Sophos;i="5.77,345,1596524400"; 
   d="scan'208";a="182309562"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 23:36:45 -0700
IronPort-SDR: DWkEmoqJ1vOJpDRhqouSLv3Ait5n5XlWEs52tiZ9crL8dHdtm1HCxZKlvalFnd9huWwy6JSivU
 H3dxwrFvc0cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,345,1596524400"; 
   d="scan'208";a="354769926"
Received: from lkp-server02.sh.intel.com (HELO b5ae2f167493) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 06 Oct 2020 23:36:44 -0700
Received: from kbuild by b5ae2f167493 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kQ347-0001VZ-Ej; Wed, 07 Oct 2020 06:36:43 +0000
Date:   Wed, 07 Oct 2020 14:36:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/drm/amd/pm/phm_ppt_v1] BUILD SUCCESS
 dc151e43a9835a68c4c612dfa38b5c6b7d99079e
Message-ID: <5f7d61e0.v9KLCggmoFLqcNyG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  testing/drm/amd/pm/phm_ppt_v1
branch HEAD: dc151e43a9835a68c4c612dfa38b5c6b7d99079e  drm/amd/pm: Replace one-element array with flexible-array in struct phm_ppt_v1_clock_voltage_dependency_table

elapsed time: 722m

configs tested: 94
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     mpc5200_defconfig
arm                            zeus_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      obs600_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                     sh7710voipgw_defconfig
arc                          axs101_defconfig
arm                         lpc18xx_defconfig
alpha                            allyesconfig
arm                          exynos_defconfig
powerpc                     ppa8548_defconfig
m68k                          hp300_defconfig
arm                         mv78xx0_defconfig
mips                            e55_defconfig
mips                 decstation_r4k_defconfig
sh                        edosk7705_defconfig
mips                  cavium_octeon_defconfig
sh                          landisk_defconfig
arm                           sama5_defconfig
sh                        sh7785lcr_defconfig
powerpc                  iss476-smp_defconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201005
i386                 randconfig-a005-20201005
i386                 randconfig-a001-20201005
i386                 randconfig-a004-20201005
i386                 randconfig-a003-20201005
i386                 randconfig-a002-20201005
x86_64               randconfig-a012-20201005
x86_64               randconfig-a015-20201005
x86_64               randconfig-a014-20201005
x86_64               randconfig-a013-20201005
x86_64               randconfig-a011-20201005
x86_64               randconfig-a016-20201005
i386                 randconfig-a014-20201005
i386                 randconfig-a015-20201005
i386                 randconfig-a013-20201005
i386                 randconfig-a016-20201005
i386                 randconfig-a011-20201005
i386                 randconfig-a012-20201005
x86_64               randconfig-a004-20201006
x86_64               randconfig-a002-20201006
x86_64               randconfig-a001-20201006
x86_64               randconfig-a005-20201006
x86_64               randconfig-a003-20201006
x86_64               randconfig-a006-20201006
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
