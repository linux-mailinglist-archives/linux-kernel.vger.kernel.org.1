Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD88D28D9AA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 07:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgJNFok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 01:44:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:48431 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbgJNFok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 01:44:40 -0400
IronPort-SDR: ZThkdjVlI+AFNKCv485zqfNVY4a4m8jgDtNket2pMC/L9Nf7CO1rs5ZIs9ANUd9FveIM7VVdzY
 FRs2pu+6SyHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="152978904"
X-IronPort-AV: E=Sophos;i="5.77,373,1596524400"; 
   d="scan'208";a="152978904"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 22:44:40 -0700
IronPort-SDR: SATZSb9Vr00WVif2DflTavc06K6zIzvJjM8HVJrzcqcZuJJCndiO5ew5uX6XeBlMLX/F5rCF81
 fE+g2XhXx+Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,373,1596524400"; 
   d="scan'208";a="356515874"
Received: from lkp-server01.sh.intel.com (HELO 77f7a688d8fd) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Oct 2020 22:44:38 -0700
Received: from kbuild by 77f7a688d8fd with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kSZaY-00002i-5m; Wed, 14 Oct 2020 05:44:38 +0000
Date:   Wed, 14 Oct 2020 13:43:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:auto-latest] BUILD SUCCESS
 f1fd159ac6fa12cc197caae397b36060f41cacef
Message-ID: <5f869009.3y10cLSU9/f1r1Wx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git  auto-latest
branch HEAD: f1fd159ac6fa12cc197caae397b36060f41cacef  Merge branch 'core/rcu'

elapsed time: 1230m

configs tested: 151
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          polaris_defconfig
powerpc                          allyesconfig
mips                    maltaup_xpa_defconfig
powerpc                     mpc83xx_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     tqm5200_defconfig
arc                             nps_defconfig
arm                       versatile_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                        omega2p_defconfig
arm                           stm32_defconfig
sh                            migor_defconfig
arm                         orion5x_defconfig
arc                     nsimosci_hs_defconfig
arm                        spear3xx_defconfig
arm                    vt8500_v6_v7_defconfig
mips                         rt305x_defconfig
arm                        keystone_defconfig
m68k                           sun3_defconfig
powerpc                     stx_gp3_defconfig
sh                          rsk7203_defconfig
powerpc                     powernv_defconfig
sh                        edosk7760_defconfig
arm                        mvebu_v7_defconfig
sh                           se7619_defconfig
m68k                          atari_defconfig
arm                       cns3420vb_defconfig
xtensa                              defconfig
sh                         ecovec24_defconfig
m68k                          multi_defconfig
powerpc                       holly_defconfig
mips                       capcella_defconfig
powerpc                      katmai_defconfig
arm                            hisi_defconfig
arm                          iop32x_defconfig
powerpc                      mgcoge_defconfig
arm                              zx_defconfig
powerpc                   currituck_defconfig
xtensa                           alldefconfig
microblaze                      mmu_defconfig
sh                      rts7751r2d1_defconfig
mips                 pnx8335_stb225_defconfig
sparc                       sparc32_defconfig
powerpc                        icon_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                         axm55xx_defconfig
arm                       aspeed_g5_defconfig
sh                ecovec24-romimage_defconfig
mips                         mpc30x_defconfig
arc                     haps_hs_smp_defconfig
sh                               alldefconfig
powerpc                          g5_defconfig
riscv                    nommu_virt_defconfig
m68k                            mac_defconfig
microblaze                          defconfig
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
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201013
x86_64               randconfig-a002-20201013
x86_64               randconfig-a006-20201013
x86_64               randconfig-a001-20201013
x86_64               randconfig-a003-20201013
x86_64               randconfig-a005-20201013
i386                 randconfig-a005-20201014
i386                 randconfig-a006-20201014
i386                 randconfig-a001-20201014
i386                 randconfig-a003-20201014
i386                 randconfig-a004-20201014
i386                 randconfig-a002-20201014
i386                 randconfig-a005-20201013
i386                 randconfig-a006-20201013
i386                 randconfig-a001-20201013
i386                 randconfig-a003-20201013
i386                 randconfig-a004-20201013
i386                 randconfig-a002-20201013
x86_64               randconfig-a016-20201014
x86_64               randconfig-a012-20201014
x86_64               randconfig-a015-20201014
x86_64               randconfig-a013-20201014
x86_64               randconfig-a014-20201014
x86_64               randconfig-a011-20201014
i386                 randconfig-a016-20201014
i386                 randconfig-a013-20201014
i386                 randconfig-a015-20201014
i386                 randconfig-a011-20201014
i386                 randconfig-a012-20201014
i386                 randconfig-a014-20201014
i386                 randconfig-a016-20201013
i386                 randconfig-a015-20201013
i386                 randconfig-a013-20201013
i386                 randconfig-a012-20201013
i386                 randconfig-a011-20201013
i386                 randconfig-a014-20201013
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-a004-20201014
x86_64               randconfig-a002-20201014
x86_64               randconfig-a006-20201014
x86_64               randconfig-a001-20201014
x86_64               randconfig-a005-20201014
x86_64               randconfig-a003-20201014
x86_64               randconfig-a016-20201013
x86_64               randconfig-a015-20201013
x86_64               randconfig-a012-20201013
x86_64               randconfig-a013-20201013
x86_64               randconfig-a014-20201013
x86_64               randconfig-a011-20201013

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
