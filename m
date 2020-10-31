Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAF22A1749
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 13:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgJaMUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 08:20:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:7498 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726935AbgJaMUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 08:20:39 -0400
IronPort-SDR: s9C9sdTqCWAeVi9ozfqUqDwtdoZQT3xfDZ7tyqSUIQ73sHwpNdAIgM6WDNMKVc/wiBAu5ub9yZ
 kLAd7JVnS+ew==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="168855235"
X-IronPort-AV: E=Sophos;i="5.77,437,1596524400"; 
   d="scan'208";a="168855235"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2020 05:20:38 -0700
IronPort-SDR: px/F/oOO/QdeIpjDYy7FC98KKE76y3PfLkHGjM6hmUEYcgdZ1SVGQ6p2Zc16YQbTAnaKtGQUXG
 mP5F1USWqWNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,437,1596524400"; 
   d="scan'208";a="362119345"
Received: from lkp-server02.sh.intel.com (HELO fcc9f8859912) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Oct 2020 05:20:37 -0700
Received: from kbuild by fcc9f8859912 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kYps4-0000Wv-Oc; Sat, 31 Oct 2020 12:20:36 +0000
Date:   Sat, 31 Oct 2020 20:20:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:for-linus/kspp-fam0] BUILD SUCCESS
 a38283da05d321fa1fce38ea3cf41c9f1dbd1f21
Message-ID: <5f9d5674.KccppqQKe2zyitfb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  for-linus/kspp-fam0
branch HEAD: a38283da05d321fa1fce38ea3cf41c9f1dbd1f21  printk: ringbuffer: Replace zero-length array with flexible-array member

elapsed time: 724m

configs tested: 114
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                             alldefconfig
sh                           se7722_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                        mvme16x_defconfig
mips                      maltasmvp_defconfig
arc                        vdk_hs38_defconfig
arm                          exynos_defconfig
arc                     nsimosci_hs_defconfig
mips                malta_kvm_guest_defconfig
arm                   milbeaut_m10v_defconfig
arm                        keystone_defconfig
h8300                    h8300h-sim_defconfig
arm                          ixp4xx_defconfig
riscv                            alldefconfig
sh                          sdk7786_defconfig
arm                        cerfcube_defconfig
sh                            hp6xx_defconfig
powerpc                 mpc8540_ads_defconfig
mips                           mtx1_defconfig
mips                          rm200_defconfig
arc                         haps_hs_defconfig
arm                        multi_v5_defconfig
powerpc                         ps3_defconfig
arm                         socfpga_defconfig
powerpc                 mpc8560_ads_defconfig
m68k                       bvme6000_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                         lubbock_defconfig
arm                        magician_defconfig
mips                        bcm47xx_defconfig
arc                     haps_hs_smp_defconfig
um                             i386_defconfig
mips                          ath79_defconfig
mips                        workpad_defconfig
arm                         s3c6400_defconfig
arm                            lart_defconfig
powerpc                  iss476-smp_defconfig
mips                     loongson1b_defconfig
riscv                               defconfig
arm                       multi_v4t_defconfig
sparc                            allyesconfig
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
i386                 randconfig-a011-20201030
i386                 randconfig-a014-20201030
i386                 randconfig-a015-20201030
i386                 randconfig-a012-20201030
i386                 randconfig-a013-20201030
i386                 randconfig-a016-20201030
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
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
