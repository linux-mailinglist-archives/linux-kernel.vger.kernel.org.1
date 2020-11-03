Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC732A4D2D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 18:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgKCRhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 12:37:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:54345 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbgKCRhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 12:37:47 -0500
IronPort-SDR: EIeQjmezlqvNmQflk2HkM8pmgGaN+H5AY5OWmx161xu3UjF/UrsbXNRmOPXLt/LWdzw4SbbHJV
 064NSRBNfR/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="148948709"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="148948709"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 09:37:47 -0800
IronPort-SDR: OlYDv4DCyMDK8xLnuzjXbpt259rLbyYpEk76dCuXhiBmdryRIOZ6KAP+g2MhXDPBcedZFvPtrD
 /gmNdIkAnMCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="320518698"
Received: from lkp-server02.sh.intel.com (HELO e61783667810) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 03 Nov 2020 09:37:46 -0800
Received: from kbuild by e61783667810 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ka0Fd-0000PB-IK; Tue, 03 Nov 2020 17:37:45 +0000
Date:   Wed, 04 Nov 2020 01:36:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/uapi/netfilter] BUILD SUCCESS
 91b7283a05efa53a50234852de97827317e4f98b
Message-ID: <5fa1952d.Lqwof52xsJ+/znoZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  testing/uapi/netfilter
branch HEAD: 91b7283a05efa53a50234852de97827317e4f98b  uapi: netfilter/nf_nat: Avoid the use of one-element array

elapsed time: 724m

configs tested: 150
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                  cavium_octeon_defconfig
mips                     loongson1b_defconfig
arm                           h3600_defconfig
powerpc                     sequoia_defconfig
sh                        sh7757lcr_defconfig
arm                        spear3xx_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                       rbtx49xx_defconfig
arm                          exynos_defconfig
arm                        neponset_defconfig
arm                        oxnas_v6_defconfig
arc                     nsimosci_hs_defconfig
sh                          rsk7269_defconfig
powerpc                      obs600_defconfig
powerpc                mpc7448_hpc2_defconfig
ia64                             alldefconfig
riscv                            alldefconfig
powerpc                      arches_defconfig
powerpc                    gamecube_defconfig
powerpc                     redwood_defconfig
arm                        shmobile_defconfig
mips                      bmips_stb_defconfig
arm                         lubbock_defconfig
arm                        vexpress_defconfig
powerpc                     mpc512x_defconfig
powerpc                    ge_imp3a_defconfig
sh                          rsk7264_defconfig
powerpc                     asp8347_defconfig
powerpc                        fsp2_defconfig
arm                          ep93xx_defconfig
powerpc                  iss476-smp_defconfig
sh                          rsk7203_defconfig
powerpc                    adder875_defconfig
powerpc                      cm5200_defconfig
arm                        mvebu_v5_defconfig
m68k                          sun3x_defconfig
arm                            zeus_defconfig
mips                      malta_kvm_defconfig
sh                         apsh4a3a_defconfig
powerpc                     ep8248e_defconfig
arm                          pcm027_defconfig
powerpc                     stx_gp3_defconfig
m68k                          hp300_defconfig
powerpc                      walnut_defconfig
arm                         s5pv210_defconfig
arm                            dove_defconfig
mips                            e55_defconfig
openrisc                    or1ksim_defconfig
powerpc64                           defconfig
arm                       imx_v6_v7_defconfig
um                             i386_defconfig
sh                   sh7770_generic_defconfig
mips                           ip32_defconfig
arm                             mxs_defconfig
openrisc                            defconfig
powerpc                       holly_defconfig
arm                        mvebu_v7_defconfig
sh                           se7722_defconfig
m68k                        mvme16x_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                ecovec24-romimage_defconfig
powerpc                      tqm8xx_defconfig
powerpc                      ep88xc_defconfig
mips                     cu1000-neo_defconfig
powerpc                    sam440ep_defconfig
arm                       spear13xx_defconfig
arm                          pxa168_defconfig
xtensa                  nommu_kc705_defconfig
arm                         lpc18xx_defconfig
sh                            shmin_defconfig
powerpc                 mpc834x_mds_defconfig
nds32                             allnoconfig
ia64                                defconfig
mips                         tb0287_defconfig
arm                              zx_defconfig
m68k                       m5249evb_defconfig
arm                         mv78xx0_defconfig
mips                          ath79_defconfig
ia64                             allmodconfig
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
x86_64               randconfig-a004-20201103
x86_64               randconfig-a005-20201103
x86_64               randconfig-a003-20201103
x86_64               randconfig-a002-20201103
x86_64               randconfig-a006-20201103
x86_64               randconfig-a001-20201103
i386                 randconfig-a004-20201103
i386                 randconfig-a006-20201103
i386                 randconfig-a005-20201103
i386                 randconfig-a001-20201103
i386                 randconfig-a002-20201103
i386                 randconfig-a003-20201103
i386                 randconfig-a013-20201103
i386                 randconfig-a015-20201103
i386                 randconfig-a014-20201103
i386                 randconfig-a016-20201103
i386                 randconfig-a011-20201103
i386                 randconfig-a012-20201103
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
x86_64               randconfig-a012-20201103
x86_64               randconfig-a015-20201103
x86_64               randconfig-a011-20201103
x86_64               randconfig-a013-20201103
x86_64               randconfig-a014-20201103
x86_64               randconfig-a016-20201103

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
