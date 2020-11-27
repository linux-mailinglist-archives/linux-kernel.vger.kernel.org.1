Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A692C5F16
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 04:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392350AbgK0DwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 22:52:25 -0500
Received: from mga11.intel.com ([192.55.52.93]:35460 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388970AbgK0DwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 22:52:25 -0500
IronPort-SDR: ej6IHgqXd7DoEv31o5YfbD4f3KmOjQteqGEgTK7unS20ijj0j3/4KB+WQrFlfhNuQjwclY8GQv
 pnfwAqe73jgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9817"; a="168846385"
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; 
   d="scan'208";a="168846385"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 19:52:24 -0800
IronPort-SDR: LY20OFqENuXV4bADZiwIckHrsNtX2QvZCPYjHRdiGZzsaBxC97MKJEkPn+UDDVU6tJQrlc5+Mi
 AwNqT008Cwxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; 
   d="scan'208";a="333549361"
Received: from lkp-server01.sh.intel.com (HELO fe15a1cd36f8) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Nov 2020 19:52:23 -0800
Received: from kbuild by fe15a1cd36f8 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kiUo2-00000M-Oe; Fri, 27 Nov 2020 03:52:22 +0000
Date:   Fri, 27 Nov 2020 11:51:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 94908c81576bf30b2e0c8276444f589d3504216f
Message-ID: <5fc077ca.ZDfB/untJH1UfN2/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 94908c81576bf30b2e0c8276444f589d3504216f  Merge branch 'core/entry'

elapsed time: 727m

configs tested: 138
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                          axs101_defconfig
mips                      pic32mzda_defconfig
arm                       imx_v6_v7_defconfig
powerpc64                        alldefconfig
sh                   sh7724_generic_defconfig
m68k                        m5307c3_defconfig
csky                             alldefconfig
xtensa                          iss_defconfig
powerpc                      ep88xc_defconfig
powerpc                        fsp2_defconfig
powerpc                      acadia_defconfig
arc                              allyesconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                     mpc83xx_defconfig
arm                           viper_defconfig
s390                                defconfig
xtensa                    xip_kc705_defconfig
parisc                generic-32bit_defconfig
arm                        magician_defconfig
arm                          moxart_defconfig
sh                               alldefconfig
arm                            dove_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     mpc5200_defconfig
powerpc                      chrp32_defconfig
arm                      tct_hammer_defconfig
powerpc                     rainier_defconfig
m68k                        mvme147_defconfig
c6x                                 defconfig
powerpc                      katmai_defconfig
arm                         assabet_defconfig
c6x                        evmc6474_defconfig
mips                        nlm_xlp_defconfig
powerpc                     akebono_defconfig
arm                     davinci_all_defconfig
powerpc                   bluestone_defconfig
mips                          rb532_defconfig
mips                           ip32_defconfig
h8300                       h8s-sim_defconfig
arm                         hackkit_defconfig
sh                          r7780mp_defconfig
m68k                        m5407c3_defconfig
arm                         lubbock_defconfig
powerpc                      arches_defconfig
x86_64                           alldefconfig
sh                             shx3_defconfig
powerpc                        cell_defconfig
mips                 decstation_r4k_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                          pxa3xx_defconfig
mips                       rbtx49xx_defconfig
powerpc                     tqm8540_defconfig
powerpc                     skiroot_defconfig
arm                        trizeps4_defconfig
arm                         nhk8815_defconfig
powerpc                 mpc8272_ads_defconfig
xtensa                              defconfig
mips                       lemote2f_defconfig
xtensa                  cadence_csp_defconfig
mips                     decstation_defconfig
arc                            hsdk_defconfig
powerpc                      ppc40x_defconfig
sh                        dreamcast_defconfig
arm                       spear13xx_defconfig
um                            kunit_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201127
i386                 randconfig-a003-20201127
i386                 randconfig-a002-20201127
i386                 randconfig-a005-20201127
i386                 randconfig-a001-20201127
i386                 randconfig-a006-20201127
x86_64               randconfig-a015-20201127
x86_64               randconfig-a011-20201127
x86_64               randconfig-a014-20201127
x86_64               randconfig-a016-20201127
x86_64               randconfig-a012-20201127
x86_64               randconfig-a013-20201127
i386                 randconfig-a012-20201127
i386                 randconfig-a013-20201127
i386                 randconfig-a011-20201127
i386                 randconfig-a016-20201127
i386                 randconfig-a014-20201127
i386                 randconfig-a015-20201127
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
x86_64               randconfig-a006-20201127
x86_64               randconfig-a003-20201127
x86_64               randconfig-a004-20201127
x86_64               randconfig-a005-20201127
x86_64               randconfig-a002-20201127
x86_64               randconfig-a001-20201127

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
