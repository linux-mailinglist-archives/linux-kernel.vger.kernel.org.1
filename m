Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7EE2B8866
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 00:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgKRX2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 18:28:17 -0500
Received: from mga06.intel.com ([134.134.136.31]:37734 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgKRX2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 18:28:17 -0500
IronPort-SDR: s5hiKwCdXJ6dyvAjHsRQG6Llk3veuoHLV9nTuzrYIZZ6adXqltLYjwM1JIBxXX3rOjj7D7ulVo
 0Tm0ISPOOV9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="232815216"
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="232815216"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 15:28:16 -0800
IronPort-SDR: Fbx7aYIbVIkL+Su1Qz1A60CDtL2IXFMxyxQE96/QxiYBYg2UWbPamtPe4i3OfSiR/W+Epbgv19
 3PJgnNLWzQ5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="368543482"
Received: from lkp-server02.sh.intel.com (HELO 67996b229c47) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Nov 2020 15:28:15 -0800
Received: from kbuild by 67996b229c47 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kfWs2-0000Ha-VK; Wed, 18 Nov 2020 23:28:14 +0000
Date:   Thu, 19 Nov 2020 07:27:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/clang-ft/for-linus] BUILD SUCCESS
 85aa52dc00c533c6442225af118f85f7e310a7a6
Message-ID: <5fb5ade6.i855/vkp6QUteOdx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  testing/clang-ft/for-linus
branch HEAD: 85aa52dc00c533c6442225af118f85f7e310a7a6  HID: input: Fix fall-through warnings for Clang

elapsed time: 720m

configs tested: 123
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          rsk7269_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                        edosk7760_defconfig
sh                         microdev_defconfig
sh                            shmin_defconfig
sh                            migor_defconfig
m68k                          sun3x_defconfig
arc                        nsim_700_defconfig
mips                      loongson3_defconfig
arm                           sunxi_defconfig
nios2                            alldefconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     taishan_defconfig
powerpc                     skiroot_defconfig
sh                          kfr2r09_defconfig
powerpc                          g5_defconfig
powerpc                    gamecube_defconfig
arc                        nsimosci_defconfig
powerpc                      arches_defconfig
arm                          pcm027_defconfig
mips                           ip32_defconfig
mips                  cavium_octeon_defconfig
ia64                        generic_defconfig
mips                        nlm_xlr_defconfig
powerpc                     tqm8540_defconfig
powerpc                     tqm8560_defconfig
mips                        bcm63xx_defconfig
sh                          urquell_defconfig
powerpc                      obs600_defconfig
arm                             mxs_defconfig
sh                   sh7770_generic_defconfig
powerpc                  mpc885_ads_defconfig
sh                           se7722_defconfig
powerpc                     stx_gp3_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                         socfpga_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                               j2_defconfig
arm                          exynos_defconfig
xtensa                  cadence_csp_defconfig
nios2                         10m50_defconfig
um                           x86_64_defconfig
arm                       netwinder_defconfig
arm                         s3c2410_defconfig
mips                      bmips_stb_defconfig
i386                                defconfig
s390                             alldefconfig
arm                           h5000_defconfig
arm                        neponset_defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20201118
x86_64               randconfig-a003-20201118
x86_64               randconfig-a004-20201118
x86_64               randconfig-a002-20201118
x86_64               randconfig-a006-20201118
x86_64               randconfig-a001-20201118
i386                 randconfig-a006-20201118
i386                 randconfig-a005-20201118
i386                 randconfig-a002-20201118
i386                 randconfig-a001-20201118
i386                 randconfig-a003-20201118
i386                 randconfig-a004-20201118
i386                 randconfig-a012-20201118
i386                 randconfig-a014-20201118
i386                 randconfig-a016-20201118
i386                 randconfig-a011-20201118
i386                 randconfig-a013-20201118
i386                 randconfig-a015-20201118
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
x86_64               randconfig-a015-20201118
x86_64               randconfig-a014-20201118
x86_64               randconfig-a011-20201118
x86_64               randconfig-a013-20201118
x86_64               randconfig-a016-20201118
x86_64               randconfig-a012-20201118

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
