Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AB82A00A6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgJ3JED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:04:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:20718 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgJ3JED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:04:03 -0400
IronPort-SDR: 1PHdhGy754pCQfc8KbpwyKGTm6QOX0oWUrfJptjAaRcfXAarLaXuQ3bzy0NafLlDA1dz5jQTOs
 EGeW8NwVNZKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="155554201"
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="155554201"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 02:04:02 -0700
IronPort-SDR: b1FKXdl9EWg3JRzD5xiNfHzBd0/lYorI5TCvOXWeRHNOJKGxlUa9156j41jXXOnl/lWuhvU7LZ
 eAayuDK+1gUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="361788578"
Received: from lkp-server02.sh.intel.com (HELO fcc9f8859912) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Oct 2020 02:04:00 -0700
Received: from kbuild by fcc9f8859912 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kYQKG-00004o-31; Fri, 30 Oct 2020 09:04:00 +0000
Date:   Fri, 30 Oct 2020 17:03:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/build] BUILD SUCCESS
 ea3186b9572a1b0299448697cfc44920061872cf
Message-ID: <5f9bd6d0.yCWPZYnDe215cxOd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/build
branch HEAD: ea3186b9572a1b0299448697cfc44920061872cf  x86/build: Fix vmlinux size check on 64-bit

elapsed time: 725m

configs tested: 143
configs skipped: 63

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                   motionpro_defconfig
c6x                        evmc6678_defconfig
arm                        mvebu_v5_defconfig
xtensa                    smp_lx200_defconfig
h8300                     edosk2674_defconfig
powerpc                    klondike_defconfig
sh                             espt_defconfig
m68k                         amcore_defconfig
arm                         s3c2410_defconfig
sh                             sh03_defconfig
sh                             shx3_defconfig
sh                        sh7785lcr_defconfig
sh                           se7780_defconfig
openrisc                         alldefconfig
sh                          kfr2r09_defconfig
sh                        sh7763rdp_defconfig
c6x                        evmc6472_defconfig
h8300                       h8s-sim_defconfig
powerpc                    socrates_defconfig
mips                      pistachio_defconfig
sh                           se7619_defconfig
mips                         cobalt_defconfig
arm                            pleb_defconfig
sh                           se7712_defconfig
sparc                       sparc64_defconfig
sh                      rts7751r2d1_defconfig
powerpc                     sequoia_defconfig
powerpc                     tqm8555_defconfig
arm                     am200epdkit_defconfig
arm                          badge4_defconfig
h8300                               defconfig
arm                         cm_x300_defconfig
xtensa                  audio_kc705_defconfig
sh                            shmin_defconfig
ia64                            zx1_defconfig
mips                        bcm63xx_defconfig
powerpc                       maple_defconfig
arm                         socfpga_defconfig
powerpc                          allyesconfig
arm                       imx_v6_v7_defconfig
powerpc                     kmeter1_defconfig
arc                     nsimosci_hs_defconfig
mips                        qi_lb60_defconfig
sh                              ul2_defconfig
um                            kunit_defconfig
openrisc                    or1ksim_defconfig
arm                              alldefconfig
arm                             pxa_defconfig
powerpc                      chrp32_defconfig
mips                           ip27_defconfig
arm                          gemini_defconfig
sh                           se7751_defconfig
um                           x86_64_defconfig
arc                            hsdk_defconfig
mips                        bcm47xx_defconfig
m68k                           sun3_defconfig
sh                            migor_defconfig
microblaze                      mmu_defconfig
arm                      tct_hammer_defconfig
powerpc                      walnut_defconfig
arm                        mini2440_defconfig
powerpc                 mpc837x_mds_defconfig
arm                        clps711x_defconfig
riscv                            allyesconfig
powerpc                      cm5200_defconfig
mips                           rs90_defconfig
arm                        neponset_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
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
x86_64               randconfig-a005-20201030
x86_64               randconfig-a001-20201030
x86_64               randconfig-a002-20201030
x86_64               randconfig-a003-20201030
x86_64               randconfig-a006-20201030
x86_64               randconfig-a004-20201030
i386                 randconfig-a005-20201030
i386                 randconfig-a003-20201030
i386                 randconfig-a002-20201030
i386                 randconfig-a001-20201030
i386                 randconfig-a006-20201030
i386                 randconfig-a004-20201030
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
x86_64               randconfig-a013-20201030
x86_64               randconfig-a014-20201030
x86_64               randconfig-a015-20201030
x86_64               randconfig-a016-20201030
x86_64               randconfig-a011-20201030
x86_64               randconfig-a012-20201030

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
