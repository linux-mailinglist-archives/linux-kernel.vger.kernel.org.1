Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6128226D082
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 03:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgIQBTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 21:19:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:63717 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgIQBTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 21:19:51 -0400
IronPort-SDR: nTaEnIbghPhQPXblRFpbJUOMrgKBhByY5dkpJZMhjS/JujZA4pJAvsXBe+uGKm+5V4TJpbpmRy
 OWK+qyjGe0WQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="244435243"
X-IronPort-AV: E=Sophos;i="5.76,434,1592895600"; 
   d="scan'208";a="244435243"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 18:12:45 -0700
IronPort-SDR: ULLVDtr54XNknEtX7yPohPIr1xHjQYckQS5oQeGc7nfr+CtECQBmwzayDWFFGfLEWYTTyrvnYc
 QoJ73hArZWtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,434,1592895600"; 
   d="scan'208";a="287390048"
Received: from lkp-server02.sh.intel.com (HELO bdcb92cf8b4e) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 16 Sep 2020 18:12:44 -0700
Received: from kbuild by bdcb92cf8b4e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kIiTb-0000LG-6u; Thu, 17 Sep 2020 01:12:43 +0000
Date:   Thu, 17 Sep 2020 09:12:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/pti] BUILD SUCCESS WITH WARNING
 767d46ab566dd489733666efe48732d523c8c332
Message-ID: <5f62b7f2.Q9ixRaxJwQpWTURd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/pti
branch HEAD: 767d46ab566dd489733666efe48732d523c8c332  Documentation: Add L1D flushing Documentation

Warning in current branch:

arch/x86/mm/tlb.c:426:36: sparse:     expected void const [noderef] __percpu *__vpp_verify
arch/x86/mm/tlb.c:426:36: sparse:     got bool *
arch/x86/mm/tlb.c:426:36: sparse: sparse: incorrect type in initializer (different address spaces)

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- i386-randconfig-s002-20200916
    |-- arch-x86-mm-tlb.c:sparse:expected-void-const-noderef-__percpu-__vpp_verify
    |-- arch-x86-mm-tlb.c:sparse:got-bool
    `-- arch-x86-mm-tlb.c:sparse:sparse:incorrect-type-in-initializer-(different-address-spaces)-expected-void-const-noderef-__percpu-__vpp_verify-got-bool

elapsed time: 722m

configs tested: 152
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                        mvme16x_defconfig
sh                ecovec24-romimage_defconfig
sh                        sh7763rdp_defconfig
arm                          pxa168_defconfig
arm                      integrator_defconfig
arc                     nsimosci_hs_defconfig
arc                          axs101_defconfig
sh                          landisk_defconfig
m68k                          atari_defconfig
arm                  colibri_pxa270_defconfig
sh                          rsk7264_defconfig
mips                      bmips_stb_defconfig
powerpc                        fsp2_defconfig
arc                             nps_defconfig
arm                            dove_defconfig
sh                     sh7710voipgw_defconfig
arm                         socfpga_defconfig
sh                          r7785rp_defconfig
s390                             alldefconfig
mips                        nlm_xlp_defconfig
microblaze                    nommu_defconfig
sh                           se7780_defconfig
mips                     decstation_defconfig
mips                      malta_kvm_defconfig
arm                          pcm027_defconfig
powerpc                  storcenter_defconfig
mips                         cobalt_defconfig
arm                         axm55xx_defconfig
mips                          rm200_defconfig
m68k                        stmark2_defconfig
powerpc                  mpc885_ads_defconfig
sh                          kfr2r09_defconfig
c6x                        evmc6678_defconfig
c6x                                 defconfig
arm                           stm32_defconfig
mips                           ci20_defconfig
m68k                       m5475evb_defconfig
arm                          tango4_defconfig
sh                  sh7785lcr_32bit_defconfig
xtensa                    xip_kc705_defconfig
powerpc                     tqm5200_defconfig
arm                        spear6xx_defconfig
mips                           jazz_defconfig
powerpc                     rainier_defconfig
powerpc                      ppc64e_defconfig
nios2                            allyesconfig
arm                           sama5_defconfig
arm                           efm32_defconfig
mips                         tb0287_defconfig
mips                         db1xxx_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                      tqm8xx_defconfig
powerpc                      katmai_defconfig
sh                        apsh4ad0a_defconfig
powerpc                         wii_defconfig
arm                          exynos_defconfig
ia64                         bigsur_defconfig
mips                         rt305x_defconfig
powerpc                  mpc866_ads_defconfig
alpha                            alldefconfig
m68k                         apollo_defconfig
alpha                               defconfig
powerpc                      walnut_defconfig
riscv                    nommu_virt_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                    klondike_defconfig
c6x                        evmc6472_defconfig
arc                        nsimosci_defconfig
mips                         tb0219_defconfig
arm                        mini2440_defconfig
arm                          lpd270_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                   sb1250_swarm_defconfig
sh                         apsh4a3a_defconfig
powerpc                       eiger_defconfig
powerpc                mpc7448_hpc2_defconfig
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
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20200916
x86_64               randconfig-a004-20200916
x86_64               randconfig-a003-20200916
x86_64               randconfig-a002-20200916
x86_64               randconfig-a001-20200916
x86_64               randconfig-a005-20200916
i386                 randconfig-a004-20200916
i386                 randconfig-a006-20200916
i386                 randconfig-a003-20200916
i386                 randconfig-a001-20200916
i386                 randconfig-a002-20200916
i386                 randconfig-a005-20200916
i386                 randconfig-a004-20200917
i386                 randconfig-a006-20200917
i386                 randconfig-a003-20200917
i386                 randconfig-a001-20200917
i386                 randconfig-a002-20200917
i386                 randconfig-a005-20200917
i386                 randconfig-a015-20200916
i386                 randconfig-a014-20200916
i386                 randconfig-a011-20200916
i386                 randconfig-a013-20200916
i386                 randconfig-a016-20200916
i386                 randconfig-a012-20200916
riscv                            allyesconfig
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
x86_64               randconfig-a014-20200916
x86_64               randconfig-a011-20200916
x86_64               randconfig-a016-20200916
x86_64               randconfig-a012-20200916
x86_64               randconfig-a015-20200916
x86_64               randconfig-a013-20200916

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
