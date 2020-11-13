Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D38E2B13FE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 02:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgKMBtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 20:49:09 -0500
Received: from mga07.intel.com ([134.134.136.100]:48575 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726005AbgKMBtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 20:49:09 -0500
IronPort-SDR: lMejoCweN5uJIRV2zcT3QmHgOIpeVF2341Xru7heLc0OW/XdZ+npZ7WZBy+IesJx2OGVdYEH+c
 LZMu9aCnVUfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="234571530"
X-IronPort-AV: E=Sophos;i="5.77,473,1596524400"; 
   d="scan'208";a="234571530"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 17:49:07 -0800
IronPort-SDR: RXLUdxjRgBRg08jE5diIaiXN5bevOLD7qtqXCHt2wGxiWX9DdB5GLvlpJJRFcfWMLUJtebd6a2
 bwT+qJ4ETjlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,473,1596524400"; 
   d="scan'208";a="530887031"
Received: from lkp-server02.sh.intel.com (HELO 6c110fa9b5d1) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 12 Nov 2020 17:49:06 -0800
Received: from kbuild by 6c110fa9b5d1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kdOD3-00007u-UC; Fri, 13 Nov 2020 01:49:05 +0000
Date:   Fri, 13 Nov 2020 09:48:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/mm] BUILD SUCCESS
 2a656cad337e0e1ca582f58847d7b0c7eeba4dc8
Message-ID: <5fade5f9.gGMgAbPnRPc+kMXz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  core/mm
branch HEAD: 2a656cad337e0e1ca582f58847d7b0c7eeba4dc8  mm/highmem: Take kmap_high_get() properly into account

elapsed time: 722m

configs tested: 163
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          r7785rp_defconfig
m68k                         amcore_defconfig
sh                   sh7770_generic_defconfig
arm                          collie_defconfig
sh                         microdev_defconfig
powerpc                      katmai_defconfig
sh                            hp6xx_defconfig
riscv                            allmodconfig
sh                           se7206_defconfig
arm                            qcom_defconfig
sh                            titan_defconfig
arm                        mini2440_defconfig
powerpc                     mpc512x_defconfig
sh                          lboxre2_defconfig
mips                        workpad_defconfig
arc                                 defconfig
m68k                         apollo_defconfig
sh                ecovec24-romimage_defconfig
riscv                            alldefconfig
riscv                             allnoconfig
arm                          pxa3xx_defconfig
powerpc                     pq2fads_defconfig
arm                           tegra_defconfig
powerpc                 mpc8315_rdb_defconfig
xtensa                         virt_defconfig
arm                         at91_dt_defconfig
sh                             espt_defconfig
sparc                       sparc64_defconfig
powerpc                       maple_defconfig
arm                           h3600_defconfig
m68k                        m5407c3_defconfig
m68k                        mvme16x_defconfig
m68k                        m5307c3_defconfig
c6x                                 defconfig
sh                   secureedge5410_defconfig
mips                      pistachio_defconfig
ia64                      gensparse_defconfig
powerpc                     tqm8560_defconfig
nds32                            alldefconfig
powerpc64                           defconfig
arm                       imx_v6_v7_defconfig
arm                        cerfcube_defconfig
m68k                        mvme147_defconfig
arm                         shannon_defconfig
powerpc                     asp8347_defconfig
powerpc                         wii_defconfig
sh                           sh2007_defconfig
sh                             sh03_defconfig
arm                   milbeaut_m10v_defconfig
arm                         nhk8815_defconfig
mips                malta_kvm_guest_defconfig
i386                             alldefconfig
mips                        maltaup_defconfig
powerpc                        warp_defconfig
arm                         mv78xx0_defconfig
arm                          moxart_defconfig
powerpc                     ep8248e_defconfig
powerpc                   currituck_defconfig
powerpc                 mpc837x_mds_defconfig
m68k                           sun3_defconfig
c6x                        evmc6474_defconfig
c6x                        evmc6457_defconfig
powerpc                    socrates_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                   lite5200b_defconfig
mips                       lemote2f_defconfig
m68k                             alldefconfig
powerpc                      ep88xc_defconfig
arc                         haps_hs_defconfig
arm                      jornada720_defconfig
m68k                          hp300_defconfig
arm                         socfpga_defconfig
m68k                          sun3x_defconfig
sh                     magicpanelr2_defconfig
powerpc                           allnoconfig
m68k                                defconfig
powerpc                      obs600_defconfig
arm64                            alldefconfig
powerpc                 mpc832x_mds_defconfig
powerpc                     tqm8548_defconfig
sh                        sh7785lcr_defconfig
arm                         orion5x_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
i386                 randconfig-a006-20201112
i386                 randconfig-a005-20201112
i386                 randconfig-a002-20201112
i386                 randconfig-a001-20201112
i386                 randconfig-a003-20201112
i386                 randconfig-a004-20201112
i386                 randconfig-a006-20201111
i386                 randconfig-a005-20201111
i386                 randconfig-a002-20201111
i386                 randconfig-a001-20201111
i386                 randconfig-a003-20201111
i386                 randconfig-a004-20201111
x86_64               randconfig-a015-20201111
x86_64               randconfig-a011-20201111
x86_64               randconfig-a014-20201111
x86_64               randconfig-a013-20201111
x86_64               randconfig-a016-20201111
x86_64               randconfig-a012-20201111
i386                 randconfig-a012-20201111
i386                 randconfig-a014-20201111
i386                 randconfig-a016-20201111
i386                 randconfig-a011-20201111
i386                 randconfig-a015-20201111
i386                 randconfig-a013-20201111
i386                 randconfig-a012-20201112
i386                 randconfig-a014-20201112
i386                 randconfig-a016-20201112
i386                 randconfig-a011-20201112
i386                 randconfig-a015-20201112
i386                 randconfig-a013-20201112
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20201111
x86_64               randconfig-a005-20201111
x86_64               randconfig-a004-20201111
x86_64               randconfig-a002-20201111
x86_64               randconfig-a006-20201111
x86_64               randconfig-a001-20201111

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
