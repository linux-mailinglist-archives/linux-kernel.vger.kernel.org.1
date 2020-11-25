Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987BE2C4114
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 14:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgKYNYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 08:24:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:47145 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbgKYNYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 08:24:03 -0500
IronPort-SDR: rVtaG10lPphPrs09WHoltFmohRVjlH8EHXconGY13aoWC+34Kq0JirUSFVZIDK7k3T7tK21guW
 +Y1Y0hP7l6SA==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="169569588"
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="169569588"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 05:24:02 -0800
IronPort-SDR: KXm7p5+B+VPW98+6ANFSUEG0mkAaVSFlnkmIbYjRWjyYmwXMmG/+8eYfd/P8iL32gzROl6ep5m
 GeH2FIpE1PHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="370768743"
Received: from lkp-server01.sh.intel.com (HELO f59a693d3a73) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 25 Nov 2020 05:24:00 -0800
Received: from kbuild by f59a693d3a73 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1khum8-00008L-5U; Wed, 25 Nov 2020 13:24:00 +0000
Date:   Wed, 25 Nov 2020 21:23:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/entry] BUILD SUCCESS
 5903f61e035320104394f721f74cd22171636f63
Message-ID: <5fbe5ad9.aMmyuRVc4jca9C4B%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  core/entry
branch HEAD: 5903f61e035320104394f721f74cd22171636f63  entry: Fix boot for !CONFIG_GENERIC_ENTRY

elapsed time: 722m

configs tested: 130
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
arm                       aspeed_g4_defconfig
sh                           se7724_defconfig
powerpc                 mpc8313_rdb_defconfig
s390                             alldefconfig
sh                     sh7710voipgw_defconfig
sh                         microdev_defconfig
ia64                         bigsur_defconfig
nios2                               defconfig
m68k                         apollo_defconfig
mips                           rs90_defconfig
riscv                               defconfig
arm                            pleb_defconfig
x86_64                           alldefconfig
arm                        neponset_defconfig
sh                            migor_defconfig
mips                      maltaaprp_defconfig
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
arm                       imx_v4_v5_defconfig
powerpc                        fsp2_defconfig
mips                        jmr3927_defconfig
arc                        nsim_700_defconfig
h8300                            alldefconfig
powerpc                      walnut_defconfig
mips                            ar7_defconfig
powerpc                     sbc8548_defconfig
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
powerpc                          allmodconfig
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
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
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
