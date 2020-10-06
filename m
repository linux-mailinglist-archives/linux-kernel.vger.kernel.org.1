Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDC42852FC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 22:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgJFUSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 16:18:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:21950 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgJFUSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 16:18:22 -0400
IronPort-SDR: X5ZB9hfg02FzlABxv71FDo1jIIbZRVb7aw/go3rIoT2VA2irUmhHjL5eFo+hjmhyp49jkGDtct
 3jc1OA0Gxygw==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="249379229"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="249379229"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 13:18:21 -0700
IronPort-SDR: YXh3fFCC5SZPXQasRy/ew8DF+7lA0h1Or0uv88RRQxnR/zpEWsg69HBqUONFKQDn0ZmkvtDBvn
 7QIFuiX3Vq1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="348660920"
Received: from lkp-server02.sh.intel.com (HELO b5ae2f167493) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 06 Oct 2020 13:18:20 -0700
Received: from kbuild by b5ae2f167493 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kPtPf-0001Jn-Hi; Tue, 06 Oct 2020 20:18:19 +0000
Date:   Wed, 07 Oct 2020 04:17:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 dc4d7783d8030ff1cfe63d7f6843fa216386af59
Message-ID: <5f7cd0d1.Vh+lv5v+Z9BcQuja%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: dc4d7783d8030ff1cfe63d7f6843fa216386af59  Merge branch 'linus'

elapsed time: 721m

configs tested: 214
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                            qcom_defconfig
sh                               j2_defconfig
mips                  cavium_octeon_defconfig
sh                           se7724_defconfig
mips                      pic32mzda_defconfig
m68k                       m5275evb_defconfig
powerpc                     rainier_defconfig
arm                          ixp4xx_defconfig
mips                        bcm63xx_defconfig
mips                           ip28_defconfig
mips                        omega2p_defconfig
mips                      pistachio_defconfig
sh                           se7721_defconfig
sh                   sh7724_generic_defconfig
m68k                          atari_defconfig
arc                            hsdk_defconfig
mips                        qi_lb60_defconfig
mips                      maltaaprp_defconfig
sh                                  defconfig
arm                             mxs_defconfig
mips                          malta_defconfig
arm                         assabet_defconfig
arm                          collie_defconfig
mips                           ci20_defconfig
mips                           rs90_defconfig
arm                          exynos_defconfig
mips                          ath79_defconfig
arm                          pxa168_defconfig
m68k                                defconfig
arm                         cm_x300_defconfig
powerpc                      pasemi_defconfig
mips                      bmips_stb_defconfig
powerpc                      cm5200_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     mpc5200_defconfig
arm                            zeus_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      obs600_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                     sh7710voipgw_defconfig
mips                         bigsur_defconfig
arm                           stm32_defconfig
arm                          iop32x_defconfig
arm                          tango4_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                        nlm_xlp_defconfig
arm64                            alldefconfig
powerpc                          g5_defconfig
arm                           sunxi_defconfig
powerpc                 mpc8272_ads_defconfig
arm                        magician_defconfig
arm                         lpc32xx_defconfig
mips                      fuloong2e_defconfig
sh                         microdev_defconfig
arm                       versatile_defconfig
powerpc                     skiroot_defconfig
nds32                               defconfig
m68k                          amiga_defconfig
arm                       imx_v6_v7_defconfig
powerpc                     tqm8555_defconfig
ia64                         bigsur_defconfig
ia64                             allyesconfig
arm                        mvebu_v5_defconfig
mips                            e55_defconfig
sh                        apsh4ad0a_defconfig
mips                        vocore2_defconfig
c6x                        evmc6474_defconfig
openrisc                    or1ksim_defconfig
sh                          lboxre2_defconfig
arm                         lpc18xx_defconfig
powerpc                     ppa8548_defconfig
m68k                            q40_defconfig
sh                          r7780mp_defconfig
sparc64                             defconfig
sparc                               defconfig
sh                         apsh4a3a_defconfig
arm                        multi_v5_defconfig
xtensa                           alldefconfig
h8300                       h8s-sim_defconfig
powerpc                    ge_imp3a_defconfig
mips                      malta_kvm_defconfig
csky                             alldefconfig
parisc                generic-32bit_defconfig
powerpc                         ps3_defconfig
powerpc                  mpc885_ads_defconfig
sh                          rsk7269_defconfig
m68k                            mac_defconfig
powerpc                     tqm8540_defconfig
h8300                            alldefconfig
sh                           se7705_defconfig
sh                               alldefconfig
arm                      footbridge_defconfig
c6x                        evmc6472_defconfig
sh                         ecovec24_defconfig
m68k                          hp300_defconfig
arm                         mv78xx0_defconfig
mips                 decstation_r4k_defconfig
sh                        edosk7705_defconfig
nios2                            alldefconfig
m68k                       m5208evb_defconfig
powerpc                       eiger_defconfig
mips                         tb0226_defconfig
mips                        nlm_xlr_defconfig
sh                           se7722_defconfig
sh                   secureedge5410_defconfig
m68k                        m5272c3_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                      ep88xc_defconfig
powerpc                     redwood_defconfig
arm                              alldefconfig
powerpc                      pcm030_defconfig
arm                        keystone_defconfig
mips                       lemote2f_defconfig
arm                       mainstone_defconfig
arm                         bcm2835_defconfig
sh                          kfr2r09_defconfig
sh                        sh7763rdp_defconfig
sh                   rts7751r2dplus_defconfig
arm                    vt8500_v6_v7_defconfig
sh                             espt_defconfig
m68k                       bvme6000_defconfig
arm                         palmz72_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                             pxa_defconfig
sh                         ap325rxa_defconfig
powerpc                     powernv_defconfig
sh                               allmodconfig
mips                     loongson1c_defconfig
parisc                              defconfig
arc                          axs101_defconfig
sh                          landisk_defconfig
arm                           sama5_defconfig
sh                        sh7785lcr_defconfig
powerpc                  iss476-smp_defconfig
sh                          rsk7264_defconfig
arm                        spear6xx_defconfig
ia64                        generic_defconfig
arm                           viper_defconfig
arm                        multi_v7_defconfig
powerpc                          allmodconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201006
x86_64               randconfig-a002-20201006
x86_64               randconfig-a001-20201006
x86_64               randconfig-a005-20201006
x86_64               randconfig-a003-20201006
x86_64               randconfig-a006-20201006
i386                 randconfig-a006-20201005
i386                 randconfig-a005-20201005
i386                 randconfig-a001-20201005
i386                 randconfig-a004-20201005
i386                 randconfig-a003-20201005
i386                 randconfig-a002-20201005
x86_64               randconfig-a012-20201005
x86_64               randconfig-a015-20201005
x86_64               randconfig-a014-20201005
x86_64               randconfig-a013-20201005
x86_64               randconfig-a011-20201005
x86_64               randconfig-a016-20201005
i386                 randconfig-a014-20201005
i386                 randconfig-a015-20201005
i386                 randconfig-a013-20201005
i386                 randconfig-a016-20201005
i386                 randconfig-a011-20201005
i386                 randconfig-a012-20201005
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
x86_64               randconfig-a004-20201005
x86_64               randconfig-a002-20201005
x86_64               randconfig-a001-20201005
x86_64               randconfig-a003-20201005
x86_64               randconfig-a005-20201005
x86_64               randconfig-a006-20201005

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
