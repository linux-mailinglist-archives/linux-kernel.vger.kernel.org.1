Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B24D22B92B2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 13:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgKSMn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 07:43:26 -0500
Received: from mga12.intel.com ([192.55.52.136]:47183 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbgKSMnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 07:43:25 -0500
IronPort-SDR: 9D51fmJJQHp7vyLr2wSnWuIIfgDXFXNzkopfq8PJMchmZ5ySYqoOeXX8Yb5YRxPlAoBBtj4Q48
 boem6BPRZboQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="150550278"
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="150550278"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 04:43:25 -0800
IronPort-SDR: ca3YWcpWWf4MiZI2AkFW7p27fwL5t+6oel7nwYIhCCciSlAEqLanofl3zUOrhEAMM7FaGpzYAo
 fPXX/l3UX04A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="533161160"
Received: from lkp-server01.sh.intel.com (HELO 1b817e3f8ad2) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 19 Nov 2020 04:43:23 -0800
Received: from kbuild by 1b817e3f8ad2 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kfjHX-000022-7C; Thu, 19 Nov 2020 12:43:23 +0000
Date:   Thu, 19 Nov 2020 20:43:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/clang-ft/for-next] BUILD SUCCESS
 4785df3608c3ae5eab604cc067dd1c34d2176c79
Message-ID: <5fb6685e.AVeG4gWhr3qk572w%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  testing/clang-ft/for-next
branch HEAD: 4785df3608c3ae5eab604cc067dd1c34d2176c79  zd1201: Fix fall-through warnings for Clang

elapsed time: 724m

configs tested: 157
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         mpc30x_defconfig
sh                           se7780_defconfig
nios2                               defconfig
powerpc                    socrates_defconfig
um                           x86_64_defconfig
powerpc                        fsp2_defconfig
powerpc                      ppc6xx_defconfig
arm                            mps2_defconfig
mips                        workpad_defconfig
sh                         ap325rxa_defconfig
powerpc                 mpc8560_ads_defconfig
arm                           sunxi_defconfig
powerpc                     akebono_defconfig
powerpc                 linkstation_defconfig
arm                            xcep_defconfig
arc                     nsimosci_hs_defconfig
arm                     davinci_all_defconfig
powerpc                    klondike_defconfig
arm                            mmp2_defconfig
arm                          pcm027_defconfig
parisc                generic-32bit_defconfig
arm                         shannon_defconfig
arc                          axs101_defconfig
mips                         db1xxx_defconfig
m68k                          amiga_defconfig
sh                ecovec24-romimage_defconfig
arm                            zeus_defconfig
powerpc                      ep88xc_defconfig
arm                           sama5_defconfig
powerpc                      cm5200_defconfig
arm                        realview_defconfig
powerpc                     rainier_defconfig
xtensa                           alldefconfig
powerpc                     stx_gp3_defconfig
sh                           se7206_defconfig
powerpc                   lite5200b_defconfig
powerpc                          g5_defconfig
arm                           omap1_defconfig
arm                       versatile_defconfig
sh                            hp6xx_defconfig
mips                     loongson1c_defconfig
mips                        jmr3927_defconfig
arm                        oxnas_v6_defconfig
sh                           se7712_defconfig
sh                   sh7770_generic_defconfig
sh                        apsh4ad0a_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                    vt8500_v6_v7_defconfig
nios2                         10m50_defconfig
sh                          sdk7786_defconfig
sparc                            alldefconfig
arc                            hsdk_defconfig
ia64                      gensparse_defconfig
arm                  colibri_pxa300_defconfig
arm                        magician_defconfig
powerpc                     kmeter1_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc836x_mds_defconfig
mips                   sb1250_swarm_defconfig
sh                        sh7763rdp_defconfig
arm                           u8500_defconfig
arm                         lubbock_defconfig
arm                       multi_v4t_defconfig
powerpc                 mpc834x_mds_defconfig
arm                       aspeed_g4_defconfig
powerpc                 mpc8540_ads_defconfig
sparc                               defconfig
sh                        sh7757lcr_defconfig
mips                         tb0287_defconfig
sh                          kfr2r09_defconfig
sh                            titan_defconfig
sparc64                             defconfig
mips                            gpr_defconfig
powerpc                     skiroot_defconfig
powerpc                    ge_imp3a_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                        spear6xx_defconfig
arc                    vdk_hs38_smp_defconfig
h8300                    h8300h-sim_defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201119
i386                 randconfig-a005-20201119
i386                 randconfig-a002-20201119
i386                 randconfig-a001-20201119
i386                 randconfig-a003-20201119
i386                 randconfig-a004-20201119
x86_64               randconfig-a015-20201119
x86_64               randconfig-a014-20201119
x86_64               randconfig-a011-20201119
x86_64               randconfig-a013-20201119
x86_64               randconfig-a016-20201119
x86_64               randconfig-a012-20201119
i386                 randconfig-a012-20201119
i386                 randconfig-a014-20201119
i386                 randconfig-a016-20201119
i386                 randconfig-a011-20201119
i386                 randconfig-a013-20201119
i386                 randconfig-a015-20201119
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
x86_64               randconfig-a005-20201119
x86_64               randconfig-a003-20201119
x86_64               randconfig-a004-20201119
x86_64               randconfig-a002-20201119
x86_64               randconfig-a006-20201119
x86_64               randconfig-a001-20201119
x86_64               randconfig-a015-20201118
x86_64               randconfig-a014-20201118
x86_64               randconfig-a011-20201118
x86_64               randconfig-a013-20201118
x86_64               randconfig-a016-20201118
x86_64               randconfig-a012-20201118

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
