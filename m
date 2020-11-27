Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42B52C5E74
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 01:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404099AbgK0AP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 19:15:57 -0500
Received: from mga18.intel.com ([134.134.136.126]:20709 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404050AbgK0AP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 19:15:57 -0500
IronPort-SDR: hfK1T77AUBz1CVnh4Yf/dlW9E3CwF/fYO+5BJJboZAbyCyZg4YAbbzM32a/b8dkfwIxB5Yeamn
 MAg+PIt3jj6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9817"; a="160107751"
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; 
   d="scan'208";a="160107751"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 16:15:55 -0800
IronPort-SDR: 2iae+N5/Mtcyo7aMyoiHeLx+z1F10jxW/+sBUscC1LScfRnKSayGz0+olVhutIRXsutu9A/yow
 eQM7Wbf5x73w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; 
   d="scan'208";a="362958169"
Received: from lkp-server02.sh.intel.com (HELO e51121f5de4e) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 26 Nov 2020 16:15:53 -0800
Received: from kbuild by e51121f5de4e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kiRQX-00003q-3W; Fri, 27 Nov 2020 00:15:53 +0000
Date:   Fri, 27 Nov 2020 08:14:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 8539d3f06710a9e91b9968fa736549d7c6b44206
Message-ID: <5fc04501./mSkZ5pWsYcP84Sf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cleanups
branch HEAD: 8539d3f06710a9e91b9968fa736549d7c6b44206  x86/asm: Drop unused RDPID macro

elapsed time: 724m

configs tested: 204
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
h8300                       h8s-sim_defconfig
powerpc                 mpc834x_itx_defconfig
sh                          rsk7203_defconfig
arm                         lubbock_defconfig
sparc                       sparc32_defconfig
powerpc                 mpc837x_mds_defconfig
arc                          axs101_defconfig
mips                      pic32mzda_defconfig
arm                       imx_v6_v7_defconfig
powerpc64                        alldefconfig
mips                     loongson1c_defconfig
arc                        nsim_700_defconfig
parisc                generic-32bit_defconfig
arm                           viper_defconfig
s390                                defconfig
sh                   sh7724_generic_defconfig
m68k                        m5307c3_defconfig
csky                             alldefconfig
xtensa                          iss_defconfig
arc                     haps_hs_smp_defconfig
arm                        mini2440_defconfig
powerpc                   currituck_defconfig
sh                           se7343_defconfig
powerpc                 canyonlands_defconfig
powerpc                      ep88xc_defconfig
powerpc                        fsp2_defconfig
powerpc                      acadia_defconfig
sh                          landisk_defconfig
mips                           jazz_defconfig
sh                            titan_defconfig
powerpc                     mpc83xx_defconfig
xtensa                           alldefconfig
arm                        trizeps4_defconfig
arc                              allyesconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                     powernv_defconfig
sh                             sh03_defconfig
m68k                        m5407c3_defconfig
powerpc                      katmai_defconfig
m68k                        stmark2_defconfig
arm                        mvebu_v7_defconfig
arm                         vf610m4_defconfig
arm                          tango4_defconfig
mips                        nlm_xlr_defconfig
arm                       multi_v4t_defconfig
xtensa                    xip_kc705_defconfig
arm                        magician_defconfig
arm                          moxart_defconfig
sh                               alldefconfig
arm                            dove_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                 mpc8272_ads_defconfig
arm                           efm32_defconfig
xtensa                         virt_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                      maltasmvp_defconfig
m68k                          multi_defconfig
arc                    vdk_hs38_smp_defconfig
arc                           tb10x_defconfig
mips                          rb532_defconfig
powerpc                     kmeter1_defconfig
mips                           ip22_defconfig
powerpc                     mpc5200_defconfig
powerpc                      chrp32_defconfig
arm                      tct_hammer_defconfig
powerpc                     rainier_defconfig
m68k                        mvme147_defconfig
mips                        workpad_defconfig
arm                         at91_dt_defconfig
powerpc                     tqm8555_defconfig
s390                             alldefconfig
powerpc                     mpc512x_defconfig
arm                         orion5x_defconfig
c6x                                 defconfig
arm                         assabet_defconfig
c6x                        evmc6474_defconfig
mips                        nlm_xlp_defconfig
mips                           ip28_defconfig
powerpc                       eiger_defconfig
powerpc                      ppc44x_defconfig
arm                         hackkit_defconfig
sh                          r7780mp_defconfig
powerpc                      arches_defconfig
x86_64                           alldefconfig
sh                             shx3_defconfig
powerpc                        cell_defconfig
mips                 decstation_r4k_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                          pxa3xx_defconfig
mips                       rbtx49xx_defconfig
powerpc                     tqm8540_defconfig
powerpc                     skiroot_defconfig
arm                         nhk8815_defconfig
arm                         ebsa110_defconfig
powerpc                    amigaone_defconfig
powerpc               mpc834x_itxgp_defconfig
arc                     nsimosci_hs_defconfig
xtensa                              defconfig
mips                       lemote2f_defconfig
xtensa                  cadence_csp_defconfig
arm                          pxa168_defconfig
mips                     decstation_defconfig
arc                            hsdk_defconfig
powerpc                      ppc40x_defconfig
sh                        dreamcast_defconfig
arm                       spear13xx_defconfig
um                            kunit_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20201126
x86_64               randconfig-a003-20201126
x86_64               randconfig-a004-20201126
x86_64               randconfig-a005-20201126
x86_64               randconfig-a001-20201126
x86_64               randconfig-a002-20201126
i386                 randconfig-a004-20201127
i386                 randconfig-a003-20201127
i386                 randconfig-a002-20201127
i386                 randconfig-a005-20201127
i386                 randconfig-a001-20201127
i386                 randconfig-a006-20201127
i386                 randconfig-a004-20201126
i386                 randconfig-a003-20201126
i386                 randconfig-a002-20201126
i386                 randconfig-a005-20201126
i386                 randconfig-a001-20201126
i386                 randconfig-a006-20201126
x86_64               randconfig-a015-20201127
x86_64               randconfig-a011-20201127
x86_64               randconfig-a014-20201127
x86_64               randconfig-a016-20201127
x86_64               randconfig-a012-20201127
x86_64               randconfig-a013-20201127
i386                 randconfig-a012-20201126
i386                 randconfig-a013-20201126
i386                 randconfig-a011-20201126
i386                 randconfig-a016-20201126
i386                 randconfig-a014-20201126
i386                 randconfig-a015-20201126
i386                 randconfig-a012-20201127
i386                 randconfig-a013-20201127
i386                 randconfig-a011-20201127
i386                 randconfig-a016-20201127
i386                 randconfig-a014-20201127
i386                 randconfig-a015-20201127
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
x86_64               randconfig-a015-20201126
x86_64               randconfig-a011-20201126
x86_64               randconfig-a014-20201126
x86_64               randconfig-a016-20201126
x86_64               randconfig-a012-20201126
x86_64               randconfig-a013-20201126
x86_64               randconfig-a006-20201127
x86_64               randconfig-a003-20201127
x86_64               randconfig-a004-20201127
x86_64               randconfig-a005-20201127
x86_64               randconfig-a002-20201127
x86_64               randconfig-a001-20201127

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
