Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8F1283FFE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 22:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgJET7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 15:59:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:26270 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729536AbgJET7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 15:59:38 -0400
IronPort-SDR: sUbrchmC6DVrmyO8SEXyE75Md2uc4Ig99/b+7vvKXvEKzcTtQ955dnI25Fv1vGwTkog/TDaCVu
 QEnOd3SR79jg==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="160834148"
X-IronPort-AV: E=Sophos;i="5.77,340,1596524400"; 
   d="scan'208";a="160834148"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 12:59:37 -0700
IronPort-SDR: n7JVIherTd0fTuZ74/GGpA1NMpzfsSN2LbHlTzQGis4x043f5i9OTW9kNQW7MWdeqH8tjYVnZa
 FcnSkeAC36/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,340,1596524400"; 
   d="scan'208";a="314838132"
Received: from lkp-server02.sh.intel.com (HELO b5ae2f167493) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Oct 2020 12:59:23 -0700
Received: from kbuild by b5ae2f167493 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kPWdm-0000vG-Jw; Mon, 05 Oct 2020 19:59:22 +0000
Date:   Tue, 06 Oct 2020 03:59:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 0f33ece60c7308569e1995ef78db71a32bc505d8
Message-ID: <5f7b7b0a.WXQ9+AbCb4injbks%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 0f33ece60c7308569e1995ef78db71a32bc505d8  Merge branch 'core/build'

elapsed time: 725m

configs tested: 186
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     pq2fads_defconfig
riscv                            alldefconfig
mips                           ip32_defconfig
arc                          axs103_defconfig
arm                  colibri_pxa300_defconfig
arc                        nsimosci_defconfig
sh                          rsk7201_defconfig
sh                        sh7763rdp_defconfig
powerpc                     sbc8548_defconfig
mips                      maltasmvp_defconfig
mips                           ci20_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                      katmai_defconfig
mips                          ath79_defconfig
powerpc                     skiroot_defconfig
powerpc                     ksi8560_defconfig
arm                        shmobile_defconfig
powerpc                    socrates_defconfig
mips                        jmr3927_defconfig
arm                         vf610m4_defconfig
arm                        neponset_defconfig
mips                           ip22_defconfig
powerpc                     tqm8541_defconfig
arm                         axm55xx_defconfig
arm                          moxart_defconfig
mips                           xway_defconfig
sh                              ul2_defconfig
riscv                          rv32_defconfig
arm                        clps711x_defconfig
arm                            hisi_defconfig
powerpc                     stx_gp3_defconfig
i386                             alldefconfig
nds32                             allnoconfig
microblaze                          defconfig
powerpc                        icon_defconfig
mips                          rm200_defconfig
mips                      bmips_stb_defconfig
powerpc                          g5_defconfig
arm                           spitz_defconfig
h8300                            alldefconfig
m68k                         apollo_defconfig
arm                        spear6xx_defconfig
sparc                               defconfig
mips                          malta_defconfig
arm                          ep93xx_defconfig
arm                          tango4_defconfig
sh                             espt_defconfig
powerpc                     tqm8548_defconfig
powerpc                      makalu_defconfig
m68k                        mvme16x_defconfig
sh                            titan_defconfig
arc                             nps_defconfig
sh                             shx3_defconfig
powerpc                      ppc44x_defconfig
arm                            zeus_defconfig
mips                         tb0219_defconfig
sh                         apsh4a3a_defconfig
arc                            hsdk_defconfig
arm                        multi_v5_defconfig
xtensa                           alldefconfig
arm                       omap2plus_defconfig
m68k                            q40_defconfig
mips                     decstation_defconfig
openrisc                    or1ksim_defconfig
powerpc                      walnut_defconfig
sh                ecovec24-romimage_defconfig
sh                          r7785rp_defconfig
arm                      footbridge_defconfig
arm                          pxa168_defconfig
arm                           corgi_defconfig
powerpc                      ep88xc_defconfig
arm                            pleb_defconfig
c6x                              alldefconfig
powerpc64                           defconfig
powerpc                      chrp32_defconfig
arm                         palmz72_defconfig
arm                          ixp4xx_defconfig
powerpc                      pcm030_defconfig
arm                        keystone_defconfig
arm                          exynos_defconfig
mips                      pistachio_defconfig
mips                       lemote2f_defconfig
arm                       mainstone_defconfig
arm                         bcm2835_defconfig
sh                          kfr2r09_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                   rts7751r2dplus_defconfig
sh                          urquell_defconfig
riscv                    nommu_virt_defconfig
sh                        apsh4ad0a_defconfig
mips                         mpc30x_defconfig
arm                        spear3xx_defconfig
mips                          ath25_defconfig
powerpc                 canyonlands_defconfig
riscv                    nommu_k210_defconfig
mips                             allmodconfig
arm                            dove_defconfig
sh                           se7619_defconfig
arm                             pxa_defconfig
sh                         ap325rxa_defconfig
powerpc                     powernv_defconfig
parisc                              defconfig
sh                               allmodconfig
mips                     loongson1c_defconfig
mips                  maltasmvp_eva_defconfig
powerpc               mpc834x_itxgp_defconfig
s390                             alldefconfig
arm                           h5000_defconfig
arm                      integrator_defconfig
arm                         orion5x_defconfig
sh                          rsk7264_defconfig
ia64                        generic_defconfig
powerpc                          allmodconfig
arm                           viper_defconfig
arm                        multi_v7_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
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
i386                 randconfig-a014-20201004
i386                 randconfig-a015-20201004
i386                 randconfig-a013-20201004
i386                 randconfig-a016-20201004
i386                 randconfig-a011-20201004
i386                 randconfig-a012-20201004
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201005
x86_64               randconfig-a002-20201005
x86_64               randconfig-a001-20201005
x86_64               randconfig-a003-20201005
x86_64               randconfig-a005-20201005
x86_64               randconfig-a006-20201005

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
