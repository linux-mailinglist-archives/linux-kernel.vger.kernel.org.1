Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3792B1203
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 23:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgKLWsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 17:48:02 -0500
Received: from mga18.intel.com ([134.134.136.126]:32655 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgKLWsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 17:48:02 -0500
IronPort-SDR: Wv4GE+4e0ahp6Opl51GXhMNLuOqLgS7uJEBBFDHukSHgpuESzHYh+NyOWWAPjpD0cgUymBZB9g
 ZoMoPTH5qdbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="158171326"
X-IronPort-AV: E=Sophos;i="5.77,473,1596524400"; 
   d="scan'208";a="158171326"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 14:47:59 -0800
IronPort-SDR: J3ZH+wu+pXKfBLm5QNeSUZl8Zj2CfLM0Gj1fhrziWz/8I3BcLaiEIKKIrPjRd5PqawUEcnYPun
 v8a7imDhAurQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,473,1596524400"; 
   d="scan'208";a="357273441"
Received: from lkp-server02.sh.intel.com (HELO 6c110fa9b5d1) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 12 Nov 2020 14:47:58 -0800
Received: from kbuild by 6c110fa9b5d1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kdLNl-000061-IJ; Thu, 12 Nov 2020 22:47:57 +0000
Date:   Fri, 13 Nov 2020 06:47:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/clang/fallthrough] BUILD SUCCESS
 d16b79b21df4c592423c69b59b31a6a9ec6b0fd6
Message-ID: <5fadbb7c.IgA2+RPbbY2LpFGC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  testing/clang/fallthrough
branch HEAD: d16b79b21df4c592423c69b59b31a6a9ec6b0fd6  treewide: Fix fall-through warnings for Clang

elapsed time: 723m

configs tested: 141
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                       ebony_defconfig
m68k                          atari_defconfig
mips                        jmr3927_defconfig
sh                         microdev_defconfig
powerpc                      katmai_defconfig
sh                   sh7770_generic_defconfig
sh                            hp6xx_defconfig
riscv                            allmodconfig
arm                            u300_defconfig
sh                   rts7751r2dplus_defconfig
sh                          lboxre2_defconfig
powerpc                      obs600_defconfig
arm                             rpc_defconfig
arm                        realview_defconfig
arm                           u8500_defconfig
mips                             allmodconfig
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
powerpc                    mvme5100_defconfig
powerpc                   lite5200b_defconfig
arm                       cns3420vb_defconfig
arm                        mvebu_v5_defconfig
csky                             alldefconfig
um                           x86_64_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                         tb0226_defconfig
sh                             shx3_defconfig
powerpc                       maple_defconfig
arm                           h3600_defconfig
m68k                        m5407c3_defconfig
m68k                        mvme16x_defconfig
arm                         shannon_defconfig
powerpc                     asp8347_defconfig
powerpc                         wii_defconfig
sh                           sh2007_defconfig
sh                             sh03_defconfig
arm                   milbeaut_m10v_defconfig
arm                         nhk8815_defconfig
arm                          moxart_defconfig
powerpc                     ep8248e_defconfig
powerpc                   currituck_defconfig
powerpc                 mpc837x_mds_defconfig
m68k                           sun3_defconfig
c6x                        evmc6474_defconfig
sh                           se7705_defconfig
mips                      pistachio_defconfig
arm                          collie_defconfig
mips                         cobalt_defconfig
c6x                        evmc6457_defconfig
powerpc                    socrates_defconfig
powerpc                 mpc832x_rdb_defconfig
m68k                         amcore_defconfig
mips                       lemote2f_defconfig
m68k                          hp300_defconfig
arm                         socfpga_defconfig
m68k                          sun3x_defconfig
m68k                                defconfig
sh                     magicpanelr2_defconfig
powerpc                           allnoconfig
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
