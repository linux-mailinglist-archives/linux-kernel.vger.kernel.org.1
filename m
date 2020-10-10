Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3700E289F67
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 10:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgJJIqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 04:46:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:21536 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726340AbgJJInz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 04:43:55 -0400
IronPort-SDR: LM2RMqxCyfptX4Ypgslhn2gyJcfqSNlTbKPOhWw084FOnkbs+7qRyCF8AgbMORjjpyRt6XJiUa
 ZuVP24bWJPoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="164782986"
X-IronPort-AV: E=Sophos;i="5.77,358,1596524400"; 
   d="scan'208";a="164782986"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2020 01:43:13 -0700
IronPort-SDR: FyQsz5atk4zZ2E+6DSePs0scJ3un8El4qKcEx6K4on9TAWzAzeIh7K/QakpATpgJp+h4B8MUFg
 r/yS1NxHh2wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,358,1596524400"; 
   d="scan'208";a="518975238"
Received: from lkp-server02.sh.intel.com (HELO d5d245f0dec0) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 10 Oct 2020 01:43:12 -0700
Received: from kbuild by d5d245f0dec0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kRAT9-00003h-LR; Sat, 10 Oct 2020 08:43:11 +0000
Date:   Sat, 10 Oct 2020 16:42:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:objtool/core] BUILD SUCCESS
 2486baae2cf6df73554144d0a4e40ae8809b54d4
Message-ID: <5f81740f.2duk0gbQIq+m6Inp%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  objtool/core
branch HEAD: 2486baae2cf6df73554144d0a4e40ae8809b54d4  objtool: Allow nested externs to enable BUILD_BUG()

elapsed time: 720m

configs tested: 154
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
c6x                                 defconfig
sparc64                          alldefconfig
arm                          iop32x_defconfig
arc                                 defconfig
riscv                    nommu_virt_defconfig
powerpc                     pq2fads_defconfig
arm                        spear6xx_defconfig
arm                          ep93xx_defconfig
ia64                             alldefconfig
arm                         hackkit_defconfig
sh                             sh03_defconfig
mips                            gpr_defconfig
parisc                           allyesconfig
powerpc                 mpc834x_mds_defconfig
arm                         nhk8815_defconfig
powerpc                      tqm8xx_defconfig
mips                      fuloong2e_defconfig
sh                          sdk7780_defconfig
m68k                          atari_defconfig
mips                     loongson1c_defconfig
powerpc                     mpc83xx_defconfig
arm                             pxa_defconfig
powerpc                      cm5200_defconfig
powerpc                      bamboo_defconfig
powerpc                         wii_defconfig
sh                            shmin_defconfig
powerpc                     kmeter1_defconfig
arc                      axs103_smp_defconfig
arm                           sama5_defconfig
powerpc                    gamecube_defconfig
powerpc                     stx_gp3_defconfig
mips                           ci20_defconfig
nds32                            alldefconfig
powerpc                  mpc866_ads_defconfig
m68k                       m5475evb_defconfig
sh                        sh7763rdp_defconfig
arc                          axs103_defconfig
powerpc                       maple_defconfig
mips                        nlm_xlr_defconfig
um                            kunit_defconfig
openrisc                    or1ksim_defconfig
arm                       mainstone_defconfig
powerpc                     tqm5200_defconfig
um                             i386_defconfig
sparc64                             defconfig
openrisc                 simple_smp_defconfig
sh                        edosk7705_defconfig
sh                 kfr2r09-romimage_defconfig
mips                      pic32mzda_defconfig
arc                            hsdk_defconfig
arm                          lpd270_defconfig
arm                     davinci_all_defconfig
m68k                        m5272c3_defconfig
arm                            u300_defconfig
arm                           viper_defconfig
mips                       lemote2f_defconfig
powerpc                    sam440ep_defconfig
powerpc                      ppc64e_defconfig
mips                       capcella_defconfig
sh                           se7705_defconfig
riscv                    nommu_k210_defconfig
m68k                         amcore_defconfig
arm                             ezx_defconfig
arm                         lpc18xx_defconfig
powerpc                      pasemi_defconfig
riscv                            alldefconfig
powerpc                     tqm8548_defconfig
mips                      loongson3_defconfig
arm                          imote2_defconfig
powerpc                    ge_imp3a_defconfig
arm                      integrator_defconfig
arm                          simpad_defconfig
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
alpha                               defconfig
alpha                            allyesconfig
nds32                               defconfig
csky                                defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
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
i386                 randconfig-a006-20201009
i386                 randconfig-a005-20201009
i386                 randconfig-a001-20201009
i386                 randconfig-a004-20201009
i386                 randconfig-a002-20201009
i386                 randconfig-a003-20201009
x86_64               randconfig-a012-20201009
x86_64               randconfig-a015-20201009
x86_64               randconfig-a013-20201009
x86_64               randconfig-a014-20201009
x86_64               randconfig-a011-20201009
x86_64               randconfig-a016-20201009
x86_64               randconfig-a016-20201010
x86_64               randconfig-a015-20201010
x86_64               randconfig-a012-20201010
x86_64               randconfig-a013-20201010
x86_64               randconfig-a014-20201010
x86_64               randconfig-a011-20201010
i386                 randconfig-a015-20201009
i386                 randconfig-a013-20201009
i386                 randconfig-a014-20201009
i386                 randconfig-a016-20201009
i386                 randconfig-a011-20201009
i386                 randconfig-a012-20201009
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
x86_64               randconfig-a004-20201009
x86_64               randconfig-a003-20201009
x86_64               randconfig-a005-20201009
x86_64               randconfig-a001-20201009
x86_64               randconfig-a002-20201009
x86_64               randconfig-a006-20201009
x86_64               randconfig-a004-20201010
x86_64               randconfig-a002-20201010
x86_64               randconfig-a006-20201010
x86_64               randconfig-a001-20201010
x86_64               randconfig-a003-20201010
x86_64               randconfig-a005-20201010

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
