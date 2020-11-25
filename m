Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8AB62C36C6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 03:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgKYC1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 21:27:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:52412 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbgKYC1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 21:27:24 -0500
IronPort-SDR: SpLcjNXQ/HvI7SGVMvZlBJYS/uv8tTwL5i+htTjbDPyETNhpPsVJYPbOTVH4w+iJIQjEE30fW/
 fZwJOuGuM0xA==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="151310286"
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="151310286"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 18:27:24 -0800
IronPort-SDR: dn43/80W+0gm1i9oAWiqZYjphtHCMHTrAOqCo3p2vOGNf5XilEtdv6xo5239EvUa9/WQblNJX7
 6RDHMbL4fk5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="547090088"
Received: from lkp-server01.sh.intel.com (HELO 6cfd01e9568c) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Nov 2020 18:27:23 -0800
Received: from kbuild by 6cfd01e9568c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1khkWg-0000Ev-DR; Wed, 25 Nov 2020 02:27:22 +0000
Date:   Wed, 25 Nov 2020 10:27:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/mm] BUILD SUCCESS
 7e015a279853e747f5d4f957855ec5310848c501
Message-ID: <5fbdc107.RM5h4Y1AjdvxT6gv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  core/mm
branch HEAD: 7e015a279853e747f5d4f957855ec5310848c501  x86/crashdump/32: Simplify copy_oldmem_page()

elapsed time: 724m

configs tested: 140
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc8540_ads_defconfig
arm                        spear6xx_defconfig
powerpc                    mvme5100_defconfig
parisc                generic-32bit_defconfig
c6x                        evmc6472_defconfig
arm                       multi_v4t_defconfig
m68k                       m5249evb_defconfig
sparc                            alldefconfig
arm                  colibri_pxa270_defconfig
arm                          ixp4xx_defconfig
arc                     haps_hs_smp_defconfig
mips                           jazz_defconfig
mips                            ar7_defconfig
arm                         lubbock_defconfig
parisc                           allyesconfig
sh                        sh7757lcr_defconfig
arm                       aspeed_g4_defconfig
powerpc                    ge_imp3a_defconfig
mips                           ip27_defconfig
powerpc                    socrates_defconfig
arm                        shmobile_defconfig
arm                           h3600_defconfig
arm                        magician_defconfig
sh                          rsk7201_defconfig
arm                             pxa_defconfig
mips                          rb532_defconfig
mips                       bmips_be_defconfig
sh                         ecovec24_defconfig
mips                   sb1250_swarm_defconfig
arm                            pleb_defconfig
x86_64                           alldefconfig
arm                        neponset_defconfig
sh                            migor_defconfig
mips                      maltaaprp_defconfig
parisc                           alldefconfig
c6x                                 defconfig
sh                          sdk7786_defconfig
arm                     am200epdkit_defconfig
powerpc                      ppc44x_defconfig
arm                      jornada720_defconfig
mips                         tb0287_defconfig
powerpc                   bluestone_defconfig
mips                         tb0219_defconfig
m68k                            q40_defconfig
arm                             rpc_defconfig
arm                        trizeps4_defconfig
arm                          gemini_defconfig
sh                               alldefconfig
m68k                        m5407c3_defconfig
arm                        cerfcube_defconfig
powerpc                     kmeter1_defconfig
sh                          rsk7203_defconfig
mips                  decstation_64_defconfig
sh                   rts7751r2dplus_defconfig
m68k                          multi_defconfig
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
x86_64               randconfig-a006-20201124
x86_64               randconfig-a003-20201124
x86_64               randconfig-a004-20201124
x86_64               randconfig-a005-20201124
x86_64               randconfig-a001-20201124
x86_64               randconfig-a002-20201124
i386                 randconfig-a004-20201124
i386                 randconfig-a003-20201124
i386                 randconfig-a002-20201124
i386                 randconfig-a005-20201124
i386                 randconfig-a001-20201124
i386                 randconfig-a006-20201124
x86_64               randconfig-a015-20201125
x86_64               randconfig-a011-20201125
x86_64               randconfig-a014-20201125
x86_64               randconfig-a016-20201125
x86_64               randconfig-a012-20201125
x86_64               randconfig-a013-20201125
i386                 randconfig-a012-20201124
i386                 randconfig-a013-20201124
i386                 randconfig-a011-20201124
i386                 randconfig-a016-20201124
i386                 randconfig-a014-20201124
i386                 randconfig-a015-20201124
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
x86_64               randconfig-a015-20201124
x86_64               randconfig-a011-20201124
x86_64               randconfig-a014-20201124
x86_64               randconfig-a016-20201124
x86_64               randconfig-a012-20201124
x86_64               randconfig-a013-20201124
x86_64               randconfig-a006-20201125
x86_64               randconfig-a003-20201125
x86_64               randconfig-a004-20201125
x86_64               randconfig-a005-20201125
x86_64               randconfig-a002-20201125
x86_64               randconfig-a001-20201125

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
