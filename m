Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3CB2675CB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 00:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgIKWUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 18:20:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:21776 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgIKWT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 18:19:57 -0400
IronPort-SDR: MENACvQq7MeSA5yA1r0aa+Ha30tNdZsPEuATySo5IQnfRwwIKedLgVeitmvPnHdz0LnmjVmIze
 sPpL/QavCf/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9741"; a="243688141"
X-IronPort-AV: E=Sophos;i="5.76,417,1592895600"; 
   d="scan'208";a="243688141"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 15:19:53 -0700
IronPort-SDR: FGVxPQWEe7QSSMY87rMn6CXZaH9HHfIWsKn2HCTnO7g8GX+WVY6zMMZByG0UvPtryEcn1dcT3e
 cfmUaaxmrjPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,417,1592895600"; 
   d="scan'208";a="337624399"
Received: from lkp-server01.sh.intel.com (HELO a75722977aa5) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 11 Sep 2020 15:19:52 -0700
Received: from kbuild by a75722977aa5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kGrOZ-0000OG-Kv; Fri, 11 Sep 2020 22:19:51 +0000
Date:   Sat, 12 Sep 2020 06:19:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:ras/core] BUILD SUCCESS
 e2def7d49d0812ea40a224161b2001b2e815dce2
Message-ID: <5f5bf7fe.dchg1T3uszaX4hPj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  ras/core
branch HEAD: e2def7d49d0812ea40a224161b2001b2e815dce2  x86/mce: Make mce_rdmsrl() panic on an inaccessible MSR

elapsed time: 723m

configs tested: 131
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                  mpc866_ads_defconfig
powerpc                      pcm030_defconfig
arm                          gemini_defconfig
mips                      malta_kvm_defconfig
sh                            titan_defconfig
mips                           ci20_defconfig
powerpc                 mpc8540_ads_defconfig
xtensa                          iss_defconfig
sh                        sh7757lcr_defconfig
mips                        nlm_xlp_defconfig
arm                            lart_defconfig
mips                        qi_lb60_defconfig
mips                            e55_defconfig
powerpc                     ksi8560_defconfig
ia64                             alldefconfig
sh                          lboxre2_defconfig
mips                         rt305x_defconfig
alpha                            alldefconfig
arm                       imx_v6_v7_defconfig
powerpc                  iss476-smp_defconfig
powerpc                     akebono_defconfig
powerpc                      ppc64e_defconfig
sparc                       sparc64_defconfig
arm                            hisi_defconfig
arm                     am200epdkit_defconfig
mips                        maltaup_defconfig
arc                            hsdk_defconfig
m68k                        m5272c3_defconfig
m68k                          multi_defconfig
sh                          r7780mp_defconfig
arm                          prima2_defconfig
arm64                            alldefconfig
m68k                         amcore_defconfig
mips                        bcm47xx_defconfig
sh                              ul2_defconfig
arc                        vdk_hs38_defconfig
powerpc                        icon_defconfig
powerpc                      ppc44x_defconfig
powerpc                 mpc85xx_cds_defconfig
h8300                     edosk2674_defconfig
powerpc                   bluestone_defconfig
arm                         lubbock_defconfig
powerpc                 mpc837x_mds_defconfig
arm                            u300_defconfig
xtensa                           alldefconfig
arm                         socfpga_defconfig
sh                   sh7770_generic_defconfig
c6x                        evmc6472_defconfig
powerpc                      pmac32_defconfig
sh                           se7722_defconfig
powerpc64                           defconfig
powerpc                     ep8248e_defconfig
powerpc                     taishan_defconfig
mips                      loongson3_defconfig
microblaze                    nommu_defconfig
arc                          axs103_defconfig
powerpc                 mpc836x_rdk_defconfig
m68k                       m5249evb_defconfig
riscv                          rv32_defconfig
c6x                        evmc6474_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20200911
i386                 randconfig-a006-20200911
i386                 randconfig-a001-20200911
i386                 randconfig-a003-20200911
i386                 randconfig-a002-20200911
i386                 randconfig-a005-20200911
x86_64               randconfig-a014-20200911
x86_64               randconfig-a011-20200911
x86_64               randconfig-a012-20200911
x86_64               randconfig-a016-20200911
x86_64               randconfig-a015-20200911
x86_64               randconfig-a013-20200911
i386                 randconfig-a015-20200911
i386                 randconfig-a014-20200911
i386                 randconfig-a011-20200911
i386                 randconfig-a013-20200911
i386                 randconfig-a016-20200911
i386                 randconfig-a012-20200911
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
x86_64               randconfig-a004-20200911
x86_64               randconfig-a006-20200911
x86_64               randconfig-a003-20200911
x86_64               randconfig-a002-20200911
x86_64               randconfig-a005-20200911
x86_64               randconfig-a001-20200911

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
