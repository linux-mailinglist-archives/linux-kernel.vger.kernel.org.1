Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814882DD1A3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 13:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgLQMn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 07:43:56 -0500
Received: from mga12.intel.com ([192.55.52.136]:16678 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbgLQMny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 07:43:54 -0500
IronPort-SDR: aelJRs+QPL/6bH4Fcn3a4l6MzxCQ3Ej7rIJ8cshlifL5S8uw3BSush9GulPdgW1c8nT9+IMyg4
 M6GAM4NqKIsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="154468727"
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400"; 
   d="scan'208";a="154468727"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 04:43:14 -0800
IronPort-SDR: dLVxlsq0aw4bUSY2moCWu5FVTfdy98iVa2fdyHU3msD3N5R3e/DF59tzCDOhHL9vCiDd5uzqy0
 adR2ztWkNXcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400"; 
   d="scan'208";a="385452873"
Received: from lkp-server02.sh.intel.com (HELO 070e1a605002) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 17 Dec 2020 04:43:13 -0800
Received: from kbuild by 070e1a605002 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kpsci-0001Bw-Jq; Thu, 17 Dec 2020 12:43:12 +0000
Date:   Thu, 17 Dec 2020 20:43:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:objtool/urgent] BUILD SUCCESS
 44f6a7c0755d8dd453c70557e11687bb080a6f21
Message-ID: <5fdb525c.Q4ZMp4GHILaw2HFt%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  objtool/urgent
branch HEAD: 44f6a7c0755d8dd453c70557e11687bb080a6f21  objtool: Fix seg fault with Clang non-section symbols

elapsed time: 727m

configs tested: 126
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                        workpad_defconfig
mips                           jazz_defconfig
powerpc                      arches_defconfig
powerpc                   currituck_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                         hackkit_defconfig
arm                         socfpga_defconfig
arm                        mvebu_v5_defconfig
m68k                          sun3x_defconfig
mips                       capcella_defconfig
sh                          rsk7264_defconfig
alpha                            alldefconfig
arm                         assabet_defconfig
sh                            hp6xx_defconfig
sh                     magicpanelr2_defconfig
xtensa                generic_kc705_defconfig
arm                        spear6xx_defconfig
arc                 nsimosci_hs_smp_defconfig
m68k                       m5249evb_defconfig
powerpc                      ppc64e_defconfig
mips                 decstation_r4k_defconfig
mips                         rt305x_defconfig
arm                            zeus_defconfig
arc                        vdk_hs38_defconfig
powerpc                      katmai_defconfig
powerpc                 mpc834x_mds_defconfig
h8300                     edosk2674_defconfig
sh                ecovec24-romimage_defconfig
ia64                        generic_defconfig
sh                           sh2007_defconfig
c6x                        evmc6474_defconfig
arc                         haps_hs_defconfig
powerpc                     tqm8548_defconfig
ia64                      gensparse_defconfig
powerpc                        icon_defconfig
nds32                               defconfig
mips                      pic32mzda_defconfig
sh                          sdk7786_defconfig
arm                         mv78xx0_defconfig
arm                          simpad_defconfig
powerpc                   bluestone_defconfig
mips                           mtx1_defconfig
ia64                          tiger_defconfig
powerpc                      ppc6xx_defconfig
powerpc                   motionpro_defconfig
arc                           tb10x_defconfig
i386                                defconfig
alpha                               defconfig
sh                        edosk7705_defconfig
powerpc                       maple_defconfig
arm                         s3c6400_defconfig
powerpc                     ppa8548_defconfig
powerpc                      ppc44x_defconfig
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
nios2                            allyesconfig
csky                                defconfig
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
i386                               tinyconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20201217
x86_64               randconfig-a006-20201217
x86_64               randconfig-a002-20201217
x86_64               randconfig-a005-20201217
x86_64               randconfig-a004-20201217
x86_64               randconfig-a001-20201217
i386                 randconfig-a001-20201217
i386                 randconfig-a004-20201217
i386                 randconfig-a003-20201217
i386                 randconfig-a002-20201217
i386                 randconfig-a006-20201217
i386                 randconfig-a005-20201217
i386                 randconfig-a014-20201217
i386                 randconfig-a013-20201217
i386                 randconfig-a012-20201217
i386                 randconfig-a011-20201217
i386                 randconfig-a015-20201217
i386                 randconfig-a016-20201217
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a016-20201217
x86_64               randconfig-a012-20201217
x86_64               randconfig-a013-20201217
x86_64               randconfig-a015-20201217
x86_64               randconfig-a014-20201217
x86_64               randconfig-a011-20201217

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
