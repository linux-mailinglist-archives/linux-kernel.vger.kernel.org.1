Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121BE2C3418
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 23:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389738AbgKXWgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 17:36:04 -0500
Received: from mga12.intel.com ([192.55.52.136]:33178 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730041AbgKXWgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 17:36:04 -0500
IronPort-SDR: A5G1RpF+pCDsFpTuSgzHueJ83ZYgIt4s1hdAkfii+WfBiKJgZRetbkUWXJ1imzVA22kyjcDVS1
 byNP+tCVzz/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="151286810"
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="151286810"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 14:36:03 -0800
IronPort-SDR: D7mBL79UqXqIHebMS83RhBY9sTtANuXbgEblMf+XoNocU0hJG2y6S53NBjnuaITDbfPmdSo/fK
 Vm2ZpOk6VPZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,367,1599548400"; 
   d="scan'208";a="313404354"
Received: from lkp-server01.sh.intel.com (HELO 6cfd01e9568c) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 24 Nov 2020 14:36:01 -0800
Received: from kbuild by 6cfd01e9568c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1khgul-00008v-Uh; Tue, 24 Nov 2020 22:35:59 +0000
Date:   Wed, 25 Nov 2020 06:35:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sgx] BUILD SUCCESS
 afe76eca862ccde2a0c30105fc97a46a0b59339b
Message-ID: <5fbd8ab8.dyDjd/tzlMNFdXX9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/sgx
branch HEAD: afe76eca862ccde2a0c30105fc97a46a0b59339b  x86/sgx: Fix sgx_ioc_enclave_provision() kernel-doc comment

elapsed time: 724m

configs tested: 170
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
c6x                        evmc6678_defconfig
mips                          malta_defconfig
m68k                            q40_defconfig
powerpc                      walnut_defconfig
powerpc                      katmai_defconfig
mips                         mpc30x_defconfig
arm                         assabet_defconfig
arm                    vt8500_v6_v7_defconfig
mips                      malta_kvm_defconfig
riscv                               defconfig
mips                          ath25_defconfig
powerpc                 mpc837x_mds_defconfig
microblaze                      mmu_defconfig
powerpc                 mpc8540_ads_defconfig
arm                        spear6xx_defconfig
powerpc                    mvme5100_defconfig
parisc                generic-32bit_defconfig
c6x                        evmc6472_defconfig
arm                       multi_v4t_defconfig
arc                              allyesconfig
sh                         microdev_defconfig
c6x                         dsk6455_defconfig
powerpc                     tqm8560_defconfig
sh                   rts7751r2dplus_defconfig
mips                         bigsur_defconfig
mips                           jazz_defconfig
powerpc                      pmac32_defconfig
mips                       lemote2f_defconfig
mips                      maltasmvp_defconfig
powerpc                      ppc44x_defconfig
arm                       aspeed_g4_defconfig
powerpc                    ge_imp3a_defconfig
mips                           ip27_defconfig
powerpc                    socrates_defconfig
mips                     loongson1b_defconfig
arm                           sama5_defconfig
arc                            hsdk_defconfig
mips                       rbtx49xx_defconfig
m68k                        m5272c3_defconfig
powerpc                      ep88xc_defconfig
parisc                              defconfig
powerpc                     rainier_defconfig
powerpc                      acadia_defconfig
ia64                             alldefconfig
powerpc                 mpc832x_mds_defconfig
arm                          badge4_defconfig
powerpc                     stx_gp3_defconfig
arm                      integrator_defconfig
sh                         ecovec24_defconfig
powerpc                     akebono_defconfig
sparc                               defconfig
sh                             shx3_defconfig
xtensa                         virt_defconfig
mips                          ath79_defconfig
mips                        vocore2_defconfig
sh                           se7750_defconfig
arm                       imx_v6_v7_defconfig
sh                          sdk7786_defconfig
sh                            titan_defconfig
xtensa                       common_defconfig
m68k                        stmark2_defconfig
powerpc                      tqm8xx_defconfig
openrisc                         alldefconfig
powerpc                     tqm8555_defconfig
ia64                      gensparse_defconfig
arm                       mainstone_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                        edosk7760_defconfig
arm                           h5000_defconfig
arm                        oxnas_v6_defconfig
mips                         tb0287_defconfig
powerpc                   bluestone_defconfig
mips                         tb0219_defconfig
arm                             rpc_defconfig
arm                        trizeps4_defconfig
arm                          gemini_defconfig
sh                               alldefconfig
m68k                        m5407c3_defconfig
arm                        cerfcube_defconfig
arm                        neponset_defconfig
powerpc                     kmeter1_defconfig
sh                          rsk7203_defconfig
m68k                          amiga_defconfig
arm                           stm32_defconfig
h8300                     edosk2674_defconfig
powerpc                      obs600_defconfig
arm                         vf610m4_defconfig
arm                  colibri_pxa270_defconfig
mips                  decstation_64_defconfig
sh                        sh7757lcr_defconfig
m68k                          multi_defconfig
arm                           corgi_defconfig
arm                            mmp2_defconfig
arm                          tango4_defconfig
xtensa                    xip_kc705_defconfig
mips                            ar7_defconfig
arm                     am200epdkit_defconfig
arm                         orion5x_defconfig
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
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
