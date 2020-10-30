Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF2529FFE4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 09:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgJ3I2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 04:28:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:10088 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgJ3I2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 04:28:05 -0400
IronPort-SDR: XGTX75eoKYefFyN9is3RzGgNBnU0sLTztEKQZ02HiYxrATGnpjo2lKCIfsbFx9gm2/I25vYHk7
 foItgCRiGFIg==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="165990984"
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="165990984"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 01:28:00 -0700
IronPort-SDR: 2mURADV/3zPx1T70mcvQVDFUOfBWjhQ4SnS+vWR9v7VVd3NQ4Z0r/0FgRoJoez0aYPfWXz3JWb
 HfjmaSTysagw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="351235929"
Received: from lkp-server02.sh.intel.com (HELO fcc9f8859912) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 30 Oct 2020 01:27:58 -0700
Received: from kbuild by fcc9f8859912 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kYPlO-00004B-9u; Fri, 30 Oct 2020 08:27:58 +0000
Date:   Fri, 30 Oct 2020 16:27:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:for-linus/kspp-clang] BUILD SUCCESS
 4169e889e5889405d54cec27d6e9f7f0ce3c7096
Message-ID: <5f9bce77.xAw1nkxxwW5E+YEA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  for-linus/kspp-clang
branch HEAD: 4169e889e5889405d54cec27d6e9f7f0ce3c7096  include: jhash/signal: Fix fall-through warnings for Clang

elapsed time: 723m

configs tested: 139
configs skipped: 2

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
h8300                       h8s-sim_defconfig
powerpc                    socrates_defconfig
mips                      pistachio_defconfig
sh                           se7619_defconfig
mips                         cobalt_defconfig
arm                            pleb_defconfig
sh                           se7712_defconfig
sparc                       sparc64_defconfig
sh                           se7780_defconfig
sh                      rts7751r2d1_defconfig
powerpc                     sequoia_defconfig
powerpc                     tqm8555_defconfig
arm                     am200epdkit_defconfig
arm                          badge4_defconfig
h8300                               defconfig
arm                          pxa3xx_defconfig
mips                        qi_lb60_defconfig
arm                       versatile_defconfig
mips                           ip32_defconfig
sh                           sh2007_defconfig
arm                             pxa_defconfig
powerpc                      chrp32_defconfig
mips                           ip27_defconfig
arm                          gemini_defconfig
sh                           se7751_defconfig
c6x                        evmc6472_defconfig
um                           x86_64_defconfig
arc                            hsdk_defconfig
mips                        bcm47xx_defconfig
m68k                           sun3_defconfig
sh                            migor_defconfig
microblaze                      mmu_defconfig
powerpc                 mpc8540_ads_defconfig
m68k                       m5475evb_defconfig
sh                ecovec24-romimage_defconfig
powerpc                    gamecube_defconfig
powerpc                     stx_gp3_defconfig
openrisc                         alldefconfig
arm                      tct_hammer_defconfig
powerpc                      walnut_defconfig
arm                        mini2440_defconfig
powerpc                 mpc837x_mds_defconfig
c6x                        evmc6457_defconfig
mips                malta_qemu_32r6_defconfig
ia64                             alldefconfig
arm                            mps2_defconfig
arm                        clps711x_defconfig
riscv                            allyesconfig
powerpc                      cm5200_defconfig
mips                           rs90_defconfig
arm                        neponset_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
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
powerpc                          allyesconfig
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
