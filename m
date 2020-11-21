Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C102BBD25
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 06:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgKUFNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 00:13:55 -0500
Received: from mga12.intel.com ([192.55.52.136]:6925 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgKUFNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 00:13:52 -0500
IronPort-SDR: 9IowZq9i1r6V41cnbBzKLFqSj/8jnkypHfHzJ0CbzIqyjdBHs6t0eA4pRIWM1e2qOPgOvOURvd
 scJFEXAEShtA==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="150838794"
X-IronPort-AV: E=Sophos;i="5.78,358,1599548400"; 
   d="scan'208";a="150838794"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 21:13:51 -0800
IronPort-SDR: 12UfYQJ/JnQwc70sNvh0oJ75AE0zW/nNSa7KNB/YuTmSNFaiNnBhkt18IA3DuIw+Hqm0yjfxnG
 pKmV8HkSDmWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,358,1599548400"; 
   d="scan'208";a="535437231"
Received: from lkp-server01.sh.intel.com (HELO 00bc34107a07) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 20 Nov 2020 21:13:50 -0800
Received: from kbuild by 00bc34107a07 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kgLDZ-0000DB-Kx; Sat, 21 Nov 2020 05:13:49 +0000
Date:   Sat, 21 Nov 2020 13:13:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 53f29e8d30d0ce9af81b320b115a4e2956f317b3
Message-ID: <5fb8a207.OMMmm65DjljOgx0/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: 53f29e8d30d0ce9af81b320b115a4e2956f317b3  torture: Make kvm.sh "Test Summary" date be end of test

elapsed time: 832m

configs tested: 120
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                    vt8500_v6_v7_defconfig
sh                                  defconfig
mips                           ip27_defconfig
m68k                            q40_defconfig
ia64                             alldefconfig
sh                         ecovec24_defconfig
arc                        vdk_hs38_defconfig
sh                   sh7724_generic_defconfig
powerpc                 mpc8540_ads_defconfig
riscv                          rv32_defconfig
arm                           efm32_defconfig
mips                         bigsur_defconfig
powerpc                     sequoia_defconfig
sh                            shmin_defconfig
i386                             alldefconfig
sh                          rsk7203_defconfig
arm                         bcm2835_defconfig
sh                          sdk7786_defconfig
m68k                        stmark2_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                  maltasmvp_eva_defconfig
arm                         s3c6400_defconfig
mips                         db1xxx_defconfig
m68k                          sun3x_defconfig
arm                         mv78xx0_defconfig
arm                     eseries_pxa_defconfig
parisc                generic-64bit_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                        warp_defconfig
ia64                      gensparse_defconfig
mips                        vocore2_defconfig
arm                       cns3420vb_defconfig
arm                     am200epdkit_defconfig
mips                           ip32_defconfig
powerpc                     ppa8548_defconfig
sh                           se7780_defconfig
mips                malta_kvm_guest_defconfig
arm                          pxa3xx_defconfig
sh                         apsh4a3a_defconfig
arm                            pleb_defconfig
h8300                               defconfig
mips                   sb1250_swarm_defconfig
sh                           se7705_defconfig
powerpc                      tqm8xx_defconfig
powerpc                      ppc6xx_defconfig
sh                        sh7785lcr_defconfig
arm                           sunxi_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
x86_64               randconfig-a006-20201120
x86_64               randconfig-a003-20201120
x86_64               randconfig-a004-20201120
x86_64               randconfig-a005-20201120
x86_64               randconfig-a001-20201120
x86_64               randconfig-a002-20201120
i386                 randconfig-a004-20201120
i386                 randconfig-a003-20201120
i386                 randconfig-a002-20201120
i386                 randconfig-a005-20201120
i386                 randconfig-a001-20201120
i386                 randconfig-a006-20201120
i386                 randconfig-a012-20201120
i386                 randconfig-a013-20201120
i386                 randconfig-a011-20201120
i386                 randconfig-a016-20201120
i386                 randconfig-a014-20201120
i386                 randconfig-a015-20201120
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20201120
x86_64               randconfig-a011-20201120
x86_64               randconfig-a014-20201120
x86_64               randconfig-a016-20201120
x86_64               randconfig-a012-20201120
x86_64               randconfig-a013-20201120

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
