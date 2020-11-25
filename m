Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6E12C406D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 13:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgKYMn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 07:43:59 -0500
Received: from mga11.intel.com ([192.55.52.93]:47116 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgKYMn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:43:58 -0500
IronPort-SDR: ymprIJab7MDdn0gszI8b25fzaz+oaRBy8SKHG4hAZceCwrF2loHvCxJwdRmRS5jIYt1g04PXuG
 3qQ+0E+kk3Ew==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="168615335"
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="168615335"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 04:43:58 -0800
IronPort-SDR: /igehquc6ybVgPPki8ytgCizE4yCkaxHg7tPtbpTF0KWXYVPL2RnqXsn+CnNRGaMiDw4/QN31Y
 SAqtEKN1ccsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="313628533"
Received: from lkp-server01.sh.intel.com (HELO f59a693d3a73) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 25 Nov 2020 04:43:57 -0800
Received: from kbuild by f59a693d3a73 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1khu9M-00007H-Ua; Wed, 25 Nov 2020 12:43:56 +0000
Date:   Wed, 25 Nov 2020 20:43:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 7032908cd5842af9710de4815a456241b5e6d2d1
Message-ID: <5fbe5157.Zc/EOFMxZtmztFy8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  irq/urgent
branch HEAD: 7032908cd5842af9710de4815a456241b5e6d2d1  Merge tag 'irqchip-fixes-5.10-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

elapsed time: 722m

configs tested: 150
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      tqm8xx_defconfig
m68k                       m5475evb_defconfig
mips                           jazz_defconfig
c6x                        evmc6474_defconfig
powerpc                      makalu_defconfig
sh                         ap325rxa_defconfig
arm                         at91_dt_defconfig
m68k                        mvme147_defconfig
sh                        dreamcast_defconfig
powerpc                     kmeter1_defconfig
arm                           corgi_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                               allmodconfig
powerpc                     ep8248e_defconfig
powerpc                   lite5200b_defconfig
ia64                          tiger_defconfig
nios2                         3c120_defconfig
powerpc                      pasemi_defconfig
arm                           sama5_defconfig
mips                          rm200_defconfig
powerpc                  iss476-smp_defconfig
arc                        vdk_hs38_defconfig
mips                         db1xxx_defconfig
arm                          prima2_defconfig
powerpc                  storcenter_defconfig
arm                             ezx_defconfig
sh                           se7722_defconfig
arm                      tct_hammer_defconfig
sh                           se7721_defconfig
mips                      maltaaprp_defconfig
arm                         nhk8815_defconfig
arm                       aspeed_g4_defconfig
sh                           se7724_defconfig
powerpc                 mpc8313_rdb_defconfig
s390                             alldefconfig
sh                     sh7710voipgw_defconfig
sh                         microdev_defconfig
ia64                         bigsur_defconfig
mips                            ar7_defconfig
sh                            titan_defconfig
powerpc                     mpc83xx_defconfig
powerpc                          allmodconfig
m68k                        stmark2_defconfig
m68k                         apollo_defconfig
mips                           rs90_defconfig
nios2                               defconfig
riscv                               defconfig
arm                            pleb_defconfig
x86_64                           alldefconfig
arm                        neponset_defconfig
sh                            migor_defconfig
s390                                defconfig
sh                          rsk7203_defconfig
arm                        mvebu_v7_defconfig
mips                 decstation_r4k_defconfig
parisc                           alldefconfig
sh                   sh7770_generic_defconfig
powerpc                    gamecube_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                 mpc834x_itx_defconfig
arm                            qcom_defconfig
arc                            hsdk_defconfig
m68k                       m5275evb_defconfig
arm                        multi_v5_defconfig
sh                           se7780_defconfig
mips                  cavium_octeon_defconfig
sh                 kfr2r09-romimage_defconfig
arm                         mv78xx0_defconfig
mips                      maltasmvp_defconfig
m68k                                defconfig
arm                       imx_v4_v5_defconfig
arm                         ebsa110_defconfig
powerpc                        fsp2_defconfig
mips                        jmr3927_defconfig
arc                        nsim_700_defconfig
h8300                            alldefconfig
powerpc                      walnut_defconfig
powerpc                     sbc8548_defconfig
mips                           ip27_defconfig
powerpc                     mpc512x_defconfig
sh                          rsk7201_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
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
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201125
i386                 randconfig-a003-20201125
i386                 randconfig-a002-20201125
i386                 randconfig-a005-20201125
i386                 randconfig-a001-20201125
i386                 randconfig-a006-20201125
x86_64               randconfig-a015-20201125
x86_64               randconfig-a011-20201125
x86_64               randconfig-a014-20201125
x86_64               randconfig-a016-20201125
x86_64               randconfig-a012-20201125
x86_64               randconfig-a013-20201125
i386                 randconfig-a012-20201125
i386                 randconfig-a013-20201125
i386                 randconfig-a011-20201125
i386                 randconfig-a016-20201125
i386                 randconfig-a014-20201125
i386                 randconfig-a015-20201125
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
x86_64               randconfig-a006-20201125
x86_64               randconfig-a003-20201125
x86_64               randconfig-a004-20201125
x86_64               randconfig-a005-20201125
x86_64               randconfig-a002-20201125
x86_64               randconfig-a001-20201125

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
