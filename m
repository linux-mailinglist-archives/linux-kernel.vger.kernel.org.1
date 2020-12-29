Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF112E6E53
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 06:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgL2Fdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 00:33:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:8672 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgL2Fdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 00:33:36 -0500
IronPort-SDR: Nsw0qDX3EFQ4S1K5LEL56VWwdXvFXrOudI4Enki8jrm3jTkqfTW6AzcnXvivBjYRTNMhgrPWla
 L81yE5qV5fnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="240542779"
X-IronPort-AV: E=Sophos;i="5.78,457,1599548400"; 
   d="scan'208";a="240542779"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 21:32:55 -0800
IronPort-SDR: PaItSioK26rQevqqV4/NMQbrWnKv0LbpVa8h7TRSf2O6XQ6E6EIBok7f6RLNq2THPZyJ4VzxKu
 STg03Jz2QUug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,457,1599548400"; 
   d="scan'208";a="459993826"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 28 Dec 2020 21:32:54 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ku7cr-0003Mf-Oi; Tue, 29 Dec 2020 05:32:53 +0000
Date:   Tue, 29 Dec 2020 13:32:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/build] BUILD SUCCESS
 ac5d08870d0b94cbfa8103c9e294de2b96f249bc
Message-ID: <5feabf72.vNrqWFqYKWGhmhhH%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/build
branch HEAD: ac5d08870d0b94cbfa8103c9e294de2b96f249bc  x86/build: Realign archhelp

elapsed time: 721m

configs tested: 130
configs skipped: 55

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                          hp300_defconfig
powerpc                    ge_imp3a_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                    klondike_defconfig
powerpc                     taishan_defconfig
powerpc                     tqm8541_defconfig
sh                           se7722_defconfig
sh                 kfr2r09-romimage_defconfig
sh                         ap325rxa_defconfig
arm                       imx_v6_v7_defconfig
h8300                       h8s-sim_defconfig
arm                            qcom_defconfig
sh                               j2_defconfig
csky                                defconfig
sparc                       sparc32_defconfig
powerpc                      pmac32_defconfig
powerpc                    adder875_defconfig
arm                           tegra_defconfig
mips                            gpr_defconfig
arm                           sunxi_defconfig
arm                           h5000_defconfig
sh                        dreamcast_defconfig
powerpc                      makalu_defconfig
sh                           se7751_defconfig
arm                             mxs_defconfig
powerpc                     pseries_defconfig
powerpc                     tqm8555_defconfig
arm                        multi_v7_defconfig
powerpc                 mpc836x_mds_defconfig
mips                malta_kvm_guest_defconfig
arc                     haps_hs_smp_defconfig
powerpc                     powernv_defconfig
mips                      fuloong2e_defconfig
arm                      jornada720_defconfig
powerpc                     mpc5200_defconfig
h8300                     edosk2674_defconfig
arm                         bcm2835_defconfig
mips                      malta_kvm_defconfig
sh                           se7780_defconfig
powerpc64                           defconfig
arm                            lart_defconfig
m68k                          atari_defconfig
powerpc                     ep8248e_defconfig
powerpc                          allmodconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
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
i386                               tinyconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20201228
i386                 randconfig-a002-20201228
i386                 randconfig-a004-20201228
i386                 randconfig-a006-20201228
i386                 randconfig-a003-20201228
i386                 randconfig-a001-20201228
x86_64               randconfig-a014-20201228
x86_64               randconfig-a015-20201228
x86_64               randconfig-a016-20201228
x86_64               randconfig-a012-20201228
x86_64               randconfig-a011-20201228
x86_64               randconfig-a013-20201228
i386                 randconfig-a011-20201227
i386                 randconfig-a016-20201227
i386                 randconfig-a012-20201227
i386                 randconfig-a014-20201227
i386                 randconfig-a015-20201227
i386                 randconfig-a013-20201227
i386                 randconfig-a014-20201228
i386                 randconfig-a012-20201228
i386                 randconfig-a016-20201228
i386                 randconfig-a011-20201228
i386                 randconfig-a015-20201228
i386                 randconfig-a013-20201228
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20201228
x86_64               randconfig-a006-20201228
x86_64               randconfig-a002-20201228
x86_64               randconfig-a004-20201228
x86_64               randconfig-a003-20201228
x86_64               randconfig-a005-20201228
x86_64               randconfig-a015-20201227
x86_64               randconfig-a014-20201227
x86_64               randconfig-a016-20201227
x86_64               randconfig-a012-20201227
x86_64               randconfig-a013-20201227
x86_64               randconfig-a011-20201227

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
