Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD4C278226
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 10:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgIYIDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 04:03:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:15004 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbgIYIDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 04:03:13 -0400
IronPort-SDR: sygWvN/i5s9WuYSC/yxwLoS/RotrWZYnhIZCs+R60UML6+W1sBwGMPeOS0i6io168mLVw0E2QN
 R7onnXBLv2iQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="225610314"
X-IronPort-AV: E=Sophos;i="5.77,301,1596524400"; 
   d="scan'208";a="225610314"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 01:03:11 -0700
IronPort-SDR: XZMmwcTGWmKC9MqoO45cS2vDvbTmywwEp1+r71ifsnT1KOV1oD5bVzV1oKv0AbbLjGTGTR788o
 ua0apgeXjEOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,301,1596524400"; 
   d="scan'208";a="413692225"
Received: from lkp-server01.sh.intel.com (HELO 2dda29302fe3) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 25 Sep 2020 01:03:09 -0700
Received: from kbuild by 2dda29302fe3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kLihA-00001H-U9; Fri, 25 Sep 2020 08:03:08 +0000
Date:   Fri, 25 Sep 2020 16:02:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/debugobjects] BUILD SUCCESS
 f9e62f318fd706a54b7ce9b28e5c7e49bbde8788
Message-ID: <5f6da408./wckVsfrhqSxbskz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  core/debugobjects
branch HEAD: f9e62f318fd706a54b7ce9b28e5c7e49bbde8788  treewide: Make all debug_obj_descriptors const

elapsed time: 723m

configs tested: 201
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          rsk7203_defconfig
nios2                         10m50_defconfig
powerpc               mpc834x_itxgp_defconfig
m68k                        mvme16x_defconfig
powerpc                       holly_defconfig
mips                  maltasmvp_eva_defconfig
mips                    maltaup_xpa_defconfig
xtensa                  audio_kc705_defconfig
arm                        vexpress_defconfig
powerpc                    gamecube_defconfig
arm                        multi_v7_defconfig
i386                             allyesconfig
sh                          rsk7269_defconfig
ia64                                defconfig
microblaze                    nommu_defconfig
arm                       omap2plus_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                               j2_defconfig
arm                       multi_v4t_defconfig
powerpc                      tqm8xx_defconfig
arm                         bcm2835_defconfig
arm                           stm32_defconfig
arm                          collie_defconfig
mips                         cobalt_defconfig
arm                        clps711x_defconfig
powerpc                      ppc64e_defconfig
h8300                            alldefconfig
arm                        trizeps4_defconfig
powerpc                 mpc85xx_cds_defconfig
mips                         rt305x_defconfig
arm                       mainstone_defconfig
powerpc64                           defconfig
xtensa                              defconfig
m68k                        stmark2_defconfig
arm                            qcom_defconfig
sh                          r7780mp_defconfig
powerpc                       ebony_defconfig
xtensa                    smp_lx200_defconfig
m68k                        m5272c3_defconfig
powerpc                   motionpro_defconfig
sh                          kfr2r09_defconfig
powerpc                 linkstation_defconfig
powerpc                     sbc8548_defconfig
sh                             shx3_defconfig
arm                           efm32_defconfig
powerpc                     akebono_defconfig
sh                         apsh4a3a_defconfig
sh                           se7712_defconfig
sh                        sh7757lcr_defconfig
powerpc                    adder875_defconfig
arc                      axs103_smp_defconfig
m68k                          amiga_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                     tqm8540_defconfig
sh                      rts7751r2d1_defconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
mips                        bcm47xx_defconfig
mips                         tb0226_defconfig
m68k                         apollo_defconfig
powerpc                          g5_defconfig
mips                           rs90_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     stx_gp3_defconfig
powerpc                   bluestone_defconfig
sh                           se7751_defconfig
mips                       capcella_defconfig
parisc                generic-32bit_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                         hackkit_defconfig
um                           x86_64_defconfig
arm                       netwinder_defconfig
arm                        keystone_defconfig
arc                              alldefconfig
mips                           ci20_defconfig
xtensa                         virt_defconfig
arc                        nsim_700_defconfig
m68k                       bvme6000_defconfig
arm                        cerfcube_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     tqm8541_defconfig
powerpc                    socrates_defconfig
arm                         s3c6400_defconfig
mips                        omega2p_defconfig
h8300                               defconfig
powerpc                      pcm030_defconfig
h8300                    h8300h-sim_defconfig
sh                   rts7751r2dplus_defconfig
mips                        bcm63xx_defconfig
arm                         axm55xx_defconfig
sh                          polaris_defconfig
nds32                             allnoconfig
sh                ecovec24-romimage_defconfig
csky                                defconfig
sh                          lboxre2_defconfig
xtensa                           allyesconfig
mips                         bigsur_defconfig
mips                     loongson1c_defconfig
m68k                       m5275evb_defconfig
mips                        workpad_defconfig
powerpc                     ep8248e_defconfig
x86_64                              defconfig
riscv                          rv32_defconfig
powerpc                     ppa8548_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20200924
i386                 randconfig-a006-20200924
i386                 randconfig-a003-20200924
i386                 randconfig-a004-20200924
i386                 randconfig-a005-20200924
i386                 randconfig-a001-20200924
i386                 randconfig-a002-20200923
i386                 randconfig-a006-20200923
i386                 randconfig-a003-20200923
i386                 randconfig-a004-20200923
i386                 randconfig-a005-20200923
i386                 randconfig-a001-20200923
x86_64               randconfig-a011-20200925
x86_64               randconfig-a013-20200925
x86_64               randconfig-a014-20200925
x86_64               randconfig-a015-20200925
x86_64               randconfig-a012-20200925
x86_64               randconfig-a016-20200925
x86_64               randconfig-a011-20200923
x86_64               randconfig-a013-20200923
x86_64               randconfig-a014-20200923
x86_64               randconfig-a015-20200923
x86_64               randconfig-a012-20200923
x86_64               randconfig-a016-20200923
i386                 randconfig-a012-20200925
i386                 randconfig-a014-20200925
i386                 randconfig-a016-20200925
i386                 randconfig-a013-20200925
i386                 randconfig-a011-20200925
i386                 randconfig-a015-20200925
i386                 randconfig-a012-20200923
i386                 randconfig-a014-20200923
i386                 randconfig-a016-20200923
i386                 randconfig-a013-20200923
i386                 randconfig-a011-20200923
i386                 randconfig-a015-20200923
i386                 randconfig-a012-20200924
i386                 randconfig-a014-20200924
i386                 randconfig-a016-20200924
i386                 randconfig-a013-20200924
i386                 randconfig-a011-20200924
i386                 randconfig-a015-20200924
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20200923
x86_64               randconfig-a003-20200923
x86_64               randconfig-a004-20200923
x86_64               randconfig-a002-20200923
x86_64               randconfig-a006-20200923
x86_64               randconfig-a001-20200923
x86_64               randconfig-a005-20200925
x86_64               randconfig-a003-20200925
x86_64               randconfig-a004-20200925
x86_64               randconfig-a002-20200925
x86_64               randconfig-a006-20200925
x86_64               randconfig-a001-20200925

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
