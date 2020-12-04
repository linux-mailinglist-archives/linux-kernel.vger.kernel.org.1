Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104522CF470
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 19:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbgLDS4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 13:56:03 -0500
Received: from mga17.intel.com ([192.55.52.151]:10293 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729003AbgLDS4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 13:56:02 -0500
IronPort-SDR: bvXZg4t9C9cn3Lz9SYsurXoZm0hCITq1XGA5jFbp93zmw3w1wstmCyLdPSQ0hXPs5YgmMbWZq9
 HsBFHAS4WSuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9825"; a="153245211"
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; 
   d="scan'208";a="153245211"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 10:55:21 -0800
IronPort-SDR: 6p/trx1jfKz1X6Rsnej5E1NnoLcpS1yXszvwxrH+uHFBLyiiY3zOqbPfBTH9zP+QtJ5qLQ6n+s
 jhVMLynMAVLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,393,1599548400"; 
   d="scan'208";a="368962786"
Received: from lkp-server02.sh.intel.com (HELO f74a175f0d75) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 04 Dec 2020 10:55:19 -0800
Received: from kbuild by f74a175f0d75 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1klGEh-0000Km-5X; Fri, 04 Dec 2020 18:55:19 +0000
Date:   Sat, 05 Dec 2020 02:54:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sgx] BUILD SUCCESS
 a4b9c48b96517ff4780b22a784e7537eac5dc21b
Message-ID: <5fca8603.fKaAbePZ931b5QDo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/sgx
branch HEAD: a4b9c48b96517ff4780b22a784e7537eac5dc21b  x86/sgx: Return -EINVAL on a zero length buffer in sgx_ioc_enclave_add_pages()

elapsed time: 772m

configs tested: 142
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 xes_mpc85xx_defconfig
sh                           se7724_defconfig
riscv                            allyesconfig
powerpc                     tqm8548_defconfig
arc                        nsimosci_defconfig
powerpc                  mpc866_ads_defconfig
m68k                          atari_defconfig
mips                      bmips_stb_defconfig
powerpc                     skiroot_defconfig
powerpc                     powernv_defconfig
arm                             mxs_defconfig
arm                         orion5x_defconfig
mips                         tb0219_defconfig
m68k                       m5475evb_defconfig
powerpc                     ep8248e_defconfig
powerpc                     mpc512x_defconfig
powerpc                    socrates_defconfig
um                             i386_defconfig
ia64                          tiger_defconfig
powerpc                      ppc64e_defconfig
powerpc                       eiger_defconfig
arm                         axm55xx_defconfig
mips                     loongson1c_defconfig
arm                     am200epdkit_defconfig
powerpc                   currituck_defconfig
nios2                               defconfig
xtensa                generic_kc705_defconfig
sh                        edosk7760_defconfig
arm                        mini2440_defconfig
alpha                               defconfig
arm                  colibri_pxa300_defconfig
powerpc                      chrp32_defconfig
sh                          urquell_defconfig
arm                       netwinder_defconfig
mips                            gpr_defconfig
sh                          rsk7264_defconfig
arm                         bcm2835_defconfig
arm                            pleb_defconfig
powerpc                     kilauea_defconfig
arc                          axs103_defconfig
arm                            zeus_defconfig
arm                             pxa_defconfig
mips                        workpad_defconfig
mips                          ath25_defconfig
arm                           sunxi_defconfig
arm                         shannon_defconfig
mips                     decstation_defconfig
arm                             ezx_defconfig
arm                         assabet_defconfig
sh                        sh7757lcr_defconfig
sh                        edosk7705_defconfig
arm                    vt8500_v6_v7_defconfig
arm                        keystone_defconfig
sh                           se7343_defconfig
powerpc                     tqm8540_defconfig
arm                           corgi_defconfig
arm                           omap1_defconfig
arm                        vexpress_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                    adder875_defconfig
m68k                       m5249evb_defconfig
arm                         mv78xx0_defconfig
powerpc                     mpc83xx_defconfig
sh                           se7619_defconfig
mips                         db1xxx_defconfig
powerpc                   lite5200b_defconfig
arm                         s3c2410_defconfig
powerpc64                        alldefconfig
mips                       lemote2f_defconfig
sh                     magicpanelr2_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201204
x86_64               randconfig-a006-20201204
x86_64               randconfig-a002-20201204
x86_64               randconfig-a001-20201204
x86_64               randconfig-a005-20201204
x86_64               randconfig-a003-20201204
i386                 randconfig-a005-20201204
i386                 randconfig-a004-20201204
i386                 randconfig-a001-20201204
i386                 randconfig-a002-20201204
i386                 randconfig-a006-20201204
i386                 randconfig-a003-20201204
i386                 randconfig-a014-20201204
i386                 randconfig-a013-20201204
i386                 randconfig-a011-20201204
i386                 randconfig-a015-20201204
i386                 randconfig-a012-20201204
i386                 randconfig-a016-20201204
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
x86_64               randconfig-a016-20201204
x86_64               randconfig-a012-20201204
x86_64               randconfig-a014-20201204
x86_64               randconfig-a013-20201204
x86_64               randconfig-a015-20201204
x86_64               randconfig-a011-20201204

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
