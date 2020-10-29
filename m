Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730B229F762
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 23:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgJ2WIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 18:08:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:63131 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgJ2WIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 18:08:02 -0400
IronPort-SDR: CfAmf+HFiZ9vLJK7Zlr/ffpWa1A0RAQD0xze5uvLTAFzTAYmzbkXaaQogWbDoRr5PzI3SVj+Uq
 cz2mB397oPow==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="165022446"
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="165022446"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 15:07:52 -0700
IronPort-SDR: lKvicK201KtSDsxVmsdLWK/QaNIgtgLKn/GGgiTxm1qhoDdr2OYRYfb3bUzH2upiZxEA2vDcLG
 MXuIkuAosxbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="323866489"
Received: from lkp-server01.sh.intel.com (HELO c01187be935a) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Oct 2020 15:07:51 -0700
Received: from kbuild by c01187be935a with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kYG5G-0000HX-Pm; Thu, 29 Oct 2020 22:07:50 +0000
Date:   Fri, 30 Oct 2020 06:07:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS WITH WARNING
 d8fcb81f1acf651a0e50eacecca43d0524984f87
Message-ID: <5f9b3d1a.Lkn6xE08JRq0zjIC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  sched/core
branch HEAD: d8fcb81f1acf651a0e50eacecca43d0524984f87  sched/fair: Check for idle core in wake_affine

Warning in current branch:

kernel/sched/cpupri.c:65 convert_prio() error: uninitialized symbol 'cpupri'.

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-randconfig-m001-20201029
    `-- kernel-sched-cpupri.c-convert_prio()-error:uninitialized-symbol-cpupri-.

elapsed time: 724m

configs tested: 149
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
s390                          debug_defconfig
arm                            qcom_defconfig
arm                         at91_dt_defconfig
arm                      tct_hammer_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                           mtx1_defconfig
arm                     davinci_all_defconfig
nios2                         3c120_defconfig
sh                          landisk_defconfig
sh                        sh7785lcr_defconfig
m68k                          amiga_defconfig
powerpc                      ppc64e_defconfig
powerpc                         wii_defconfig
xtensa                           alldefconfig
powerpc                 mpc8315_rdb_defconfig
openrisc                         alldefconfig
powerpc                     powernv_defconfig
arm                             rpc_defconfig
m68k                       bvme6000_defconfig
csky                                defconfig
arm                          pxa910_defconfig
arm                         bcm2835_defconfig
m68k                        m5307c3_defconfig
arm                        mvebu_v7_defconfig
arc                          axs103_defconfig
sh                          lboxre2_defconfig
mips                           ip28_defconfig
sh                ecovec24-romimage_defconfig
powerpc                     pseries_defconfig
sparc64                          alldefconfig
powerpc                     mpc5200_defconfig
powerpc                       maple_defconfig
c6x                        evmc6678_defconfig
powerpc                      arches_defconfig
sh                        apsh4ad0a_defconfig
mips                          rb532_defconfig
arm                         hackkit_defconfig
arm                          gemini_defconfig
powerpc                 mpc8313_rdb_defconfig
sparc                       sparc64_defconfig
sh                        dreamcast_defconfig
sh                        edosk7705_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                        m5407c3_defconfig
arm                        keystone_defconfig
ia64                            zx1_defconfig
powerpc                     tqm8540_defconfig
arm                          pxa168_defconfig
c6x                                 defconfig
mips                       bmips_be_defconfig
ia64                      gensparse_defconfig
sh                           se7780_defconfig
m68k                       m5475evb_defconfig
powerpc                    gamecube_defconfig
powerpc                     stx_gp3_defconfig
s390                             allyesconfig
sh                            shmin_defconfig
c6x                        evmc6472_defconfig
sh                         ecovec24_defconfig
arc                          axs101_defconfig
xtensa                  audio_kc705_defconfig
mips                        nlm_xlp_defconfig
sh                        edosk7760_defconfig
arm                      integrator_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                   motionpro_defconfig
sh                          rsk7203_defconfig
m68k                            q40_defconfig
ia64                         bigsur_defconfig
arm                            dove_defconfig
h8300                            alldefconfig
c6x                        evmc6457_defconfig
mips                malta_qemu_32r6_defconfig
ia64                             alldefconfig
arm                            mps2_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                  iss476-smp_defconfig
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
x86_64               randconfig-a001-20201029
x86_64               randconfig-a002-20201029
x86_64               randconfig-a003-20201029
x86_64               randconfig-a006-20201029
x86_64               randconfig-a005-20201029
x86_64               randconfig-a004-20201029
i386                 randconfig-a002-20201029
i386                 randconfig-a005-20201029
i386                 randconfig-a003-20201029
i386                 randconfig-a001-20201029
i386                 randconfig-a004-20201029
i386                 randconfig-a006-20201029
i386                 randconfig-a016-20201029
i386                 randconfig-a014-20201029
i386                 randconfig-a015-20201029
i386                 randconfig-a013-20201029
i386                 randconfig-a012-20201029
i386                 randconfig-a011-20201029
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
x86_64               randconfig-a011-20201029
x86_64               randconfig-a013-20201029
x86_64               randconfig-a016-20201029
x86_64               randconfig-a015-20201029
x86_64               randconfig-a012-20201029
x86_64               randconfig-a014-20201029

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
