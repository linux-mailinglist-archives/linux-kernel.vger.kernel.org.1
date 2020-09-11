Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88AF22675C7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 00:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgIKWUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 18:20:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:16361 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgIKWTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 18:19:55 -0400
IronPort-SDR: e3hFCevxzdyqtTMUL+TYKqLMZWFZKo7uBff9NX/ofIgDfI4H+nwxC0GhAS6K4opP98z/oD4nqr
 sHA/LkQ/cNsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9741"; a="223050587"
X-IronPort-AV: E=Sophos;i="5.76,417,1592895600"; 
   d="scan'208";a="223050587"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 15:19:53 -0700
IronPort-SDR: ZfRzk4QYNLFsZrAfpQjNUzSsXnoqiOPtK2+t8otn2199WsIADUL/r5AbUoKEOA0zHm5LD2JIAn
 OS7y5CX6kL5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,417,1592895600"; 
   d="scan'208";a="505641810"
Received: from lkp-server01.sh.intel.com (HELO a75722977aa5) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 11 Sep 2020 15:19:52 -0700
Received: from kbuild by a75722977aa5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kGrOZ-0000OD-Ip; Fri, 11 Sep 2020 22:19:51 +0000
Date:   Sat, 12 Sep 2020 06:19:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 33b4711df4c1b3aec7c267c60fc24abccfadd40c
Message-ID: <5f5bf801.yYY7phtvlDN/JbfC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/cpu
branch HEAD: 33b4711df4c1b3aec7c267c60fc24abccfadd40c  x86/cpu/centaur: Add Centaur family >=7 CPUs initialization support

elapsed time: 723m

configs tested: 123
configs skipped: 60

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
sh                          r7780mp_defconfig
arm                          prima2_defconfig
arm64                            alldefconfig
m68k                         amcore_defconfig
mips                        bcm47xx_defconfig
sh                              ul2_defconfig
arc                        vdk_hs38_defconfig
arc                            hsdk_defconfig
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
