Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E8E2934B2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 08:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403803AbgJTGRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 02:17:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:27136 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392062AbgJTGRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 02:17:09 -0400
IronPort-SDR: gDr8HXeUtIUiuM5yM0wiPdGRuFJyI7bW5t/8ALVlTECro/B3nyqPZe5Hx1TS/yiAqHvsq6BR/W
 91frKvh7TdPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="167251310"
X-IronPort-AV: E=Sophos;i="5.77,396,1596524400"; 
   d="scan'208";a="167251310"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 23:17:08 -0700
IronPort-SDR: P9zN814Dr8h++thS1aPMfQDNY+hVXzMrKP8om8ABBCjXcHPWrf3f3pZG2vs9xadi/nTK1UFcsw
 gM31vG0xs1UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,396,1596524400"; 
   d="scan'208";a="353229070"
Received: from lkp-server01.sh.intel.com (HELO 88424da292e0) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 19 Oct 2020 23:17:07 -0700
Received: from kbuild by 88424da292e0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kUkxG-0000QV-El; Tue, 20 Oct 2020 06:17:06 +0000
Date:   Tue, 20 Oct 2020 14:16:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/urgent] BUILD SUCCESS
 f3d301c1f2f5676465cdf3259737ea19cc82731f
Message-ID: <5f8e80c9.VpmIE6ZPfz+vFaPW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  perf/urgent
branch HEAD: f3d301c1f2f5676465cdf3259737ea19cc82731f  perf: correct SNOOPX field offset

elapsed time: 721m

configs tested: 143
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nds32                            alldefconfig
c6x                        evmc6457_defconfig
powerpc                     redwood_defconfig
parisc                generic-32bit_defconfig
arm                     am200epdkit_defconfig
mips                malta_qemu_32r6_defconfig
riscv                    nommu_virt_defconfig
mips                  decstation_64_defconfig
powerpc                 mpc837x_mds_defconfig
m68k                             allmodconfig
powerpc                      mgcoge_defconfig
arm                           spitz_defconfig
xtensa                  audio_kc705_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                     kmeter1_defconfig
nios2                               defconfig
powerpc                     mpc5200_defconfig
arm                          pxa3xx_defconfig
sh                          landisk_defconfig
openrisc                    or1ksim_defconfig
arm                         nhk8815_defconfig
nios2                         3c120_defconfig
mips                      malta_kvm_defconfig
arm                           sama5_defconfig
sh                            migor_defconfig
powerpc                      makalu_defconfig
powerpc                      tqm8xx_defconfig
sh                               alldefconfig
m68k                          sun3x_defconfig
powerpc                       holly_defconfig
mips                       lemote2f_defconfig
sh                         ap325rxa_defconfig
arm                          moxart_defconfig
powerpc                      pasemi_defconfig
um                             i386_defconfig
arm                             rpc_defconfig
mips                            e55_defconfig
mips                         tb0287_defconfig
arm                            hisi_defconfig
arm                          badge4_defconfig
h8300                            alldefconfig
alpha                            alldefconfig
arm                          pcm027_defconfig
sh                            shmin_defconfig
arm                           sunxi_defconfig
arm                           efm32_defconfig
powerpc                    amigaone_defconfig
powerpc                     powernv_defconfig
sh                               j2_defconfig
mips                         tb0226_defconfig
powerpc                         ps3_defconfig
sh                          rsk7269_defconfig
arm                        mvebu_v7_defconfig
m68k                        mvme147_defconfig
arc                              allyesconfig
powerpc                    socrates_defconfig
c6x                        evmc6678_defconfig
mips                     cu1000-neo_defconfig
powerpc                     skiroot_defconfig
powerpc                  mpc866_ads_defconfig
mips                        nlm_xlp_defconfig
arm                    vt8500_v6_v7_defconfig
mips                        workpad_defconfig
mips                     loongson1b_defconfig
arm                  colibri_pxa300_defconfig
powerpc                    ge_imp3a_defconfig
mips                             allmodconfig
mips                         mpc30x_defconfig
alpha                               defconfig
mips                         tb0219_defconfig
sh                          urquell_defconfig
nios2                         10m50_defconfig
sparc64                             defconfig
arm                           omap1_defconfig
mips                    maltaup_xpa_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
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
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201019
x86_64               randconfig-a002-20201019
x86_64               randconfig-a006-20201019
x86_64               randconfig-a003-20201019
x86_64               randconfig-a005-20201019
x86_64               randconfig-a001-20201019
i386                 randconfig-a006-20201019
i386                 randconfig-a005-20201019
i386                 randconfig-a001-20201019
i386                 randconfig-a003-20201019
i386                 randconfig-a004-20201019
i386                 randconfig-a002-20201019
i386                 randconfig-a015-20201019
i386                 randconfig-a013-20201019
i386                 randconfig-a016-20201019
i386                 randconfig-a012-20201019
i386                 randconfig-a011-20201019
i386                 randconfig-a014-20201019
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-a016-20201019
x86_64               randconfig-a015-20201019
x86_64               randconfig-a012-20201019
x86_64               randconfig-a013-20201019
x86_64               randconfig-a011-20201019
x86_64               randconfig-a014-20201019

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
