Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B68D28EE97
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 10:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbgJOIfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 04:35:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:56228 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbgJOIf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 04:35:27 -0400
IronPort-SDR: 54Bvb2z4CFz/1DZmeCIvScceUKT7VgF8wkyKT6Xbv/a+QyMOYHu1YLzbdxBVANYb5RdM0zE/Hh
 Q+Cih+Y4vkBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="250985387"
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; 
   d="scan'208";a="250985387"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2020 01:35:27 -0700
IronPort-SDR: pA0PLV+O441DMCqV3JeoVd4XlZoEUa83RxqHlAhWAQK34sDUCMHa9MJYnUnxS9q+++i9XPRrQR
 fuw44RDnlo8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; 
   d="scan'208";a="521765734"
Received: from lkp-server02.sh.intel.com (HELO 7220befbd762) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 15 Oct 2020 01:35:26 -0700
Received: from kbuild by 7220befbd762 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kSyjN-00003k-Jw; Thu, 15 Oct 2020 08:35:25 +0000
Date:   Thu, 15 Oct 2020 16:34:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 a73f863af4ce9730795eab7097fb2102e6854365
Message-ID: <5f8809b0.1sQTJBp8G1uuFlNg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  sched/urgent
branch HEAD: a73f863af4ce9730795eab7097fb2102e6854365  sched/features: Fix !CONFIG_JUMP_LABEL case

elapsed time: 724m

configs tested: 128
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                           corgi_defconfig
mips                             allyesconfig
mips                      pistachio_defconfig
riscv                               defconfig
powerpc                 mpc836x_mds_defconfig
arm                         cm_x300_defconfig
arm                              zx_defconfig
mips                        jmr3927_defconfig
powerpc                     tqm8555_defconfig
arm                              alldefconfig
powerpc                 mpc8560_ads_defconfig
arm                          pxa3xx_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                 mpc832x_mds_defconfig
sh                        apsh4ad0a_defconfig
xtensa                              defconfig
mips                          ath79_defconfig
arm                  colibri_pxa300_defconfig
arm                            xcep_defconfig
alpha                               defconfig
powerpc                       eiger_defconfig
mips                           ip32_defconfig
arm                          prima2_defconfig
m68k                             allmodconfig
arm                           tegra_defconfig
ia64                      gensparse_defconfig
powerpc                   motionpro_defconfig
mips                          malta_defconfig
arm                         lpc32xx_defconfig
arm                          simpad_defconfig
sh                               allmodconfig
mips                malta_kvm_guest_defconfig
h8300                     edosk2674_defconfig
sh                          rsk7203_defconfig
mips                 pnx8335_stb225_defconfig
mips                       bmips_be_defconfig
arc                                 defconfig
powerpc                     sbc8548_defconfig
sh                              ul2_defconfig
mips                   sb1250_swarm_defconfig
arm                            zeus_defconfig
powerpc                      ep88xc_defconfig
sh                               alldefconfig
powerpc                      cm5200_defconfig
arm                          collie_defconfig
arm                         lpc18xx_defconfig
sh                          kfr2r09_defconfig
um                           x86_64_defconfig
mips                  maltasmvp_eva_defconfig
mips                          rm200_defconfig
powerpc                     mpc5200_defconfig
arm                       imx_v4_v5_defconfig
powerpc                       ebony_defconfig
arm                            pleb_defconfig
sh                   sh7770_generic_defconfig
sh                          lboxre2_defconfig
m68k                            q40_defconfig
powerpc                 linkstation_defconfig
arm                             rpc_defconfig
arm                        trizeps4_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
sparc                            allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20201014
i386                 randconfig-a006-20201014
i386                 randconfig-a001-20201014
i386                 randconfig-a003-20201014
i386                 randconfig-a004-20201014
i386                 randconfig-a002-20201014
x86_64               randconfig-a016-20201014
x86_64               randconfig-a012-20201014
x86_64               randconfig-a015-20201014
x86_64               randconfig-a013-20201014
x86_64               randconfig-a014-20201014
x86_64               randconfig-a011-20201014
i386                 randconfig-a016-20201014
i386                 randconfig-a013-20201014
i386                 randconfig-a015-20201014
i386                 randconfig-a011-20201014
i386                 randconfig-a012-20201014
i386                 randconfig-a014-20201014
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
x86_64               randconfig-a004-20201014
x86_64               randconfig-a002-20201014
x86_64               randconfig-a006-20201014
x86_64               randconfig-a001-20201014
x86_64               randconfig-a005-20201014
x86_64               randconfig-a003-20201014

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
