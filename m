Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC8829470B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 05:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411815AbgJUDlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 23:41:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:29625 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411770AbgJUDlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 23:41:18 -0400
IronPort-SDR: m3sTVFhNTBeJ5IFVUCjETaksMgnVpvDR4LBagPDGwhGhakdoHio7qkSitrqqmefo3BmZxMVARa
 wMj1qq6F4j4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="231503131"
X-IronPort-AV: E=Sophos;i="5.77,400,1596524400"; 
   d="scan'208";a="231503131"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 20:41:17 -0700
IronPort-SDR: jjVDMZMneQBWM2S2qYBI+UHBfK6d8j8NVGHVzKTxDtuQypTg/DwvxCA5Xvr711pcah9isDomPU
 G7X+lQndkayQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,400,1596524400"; 
   d="scan'208";a="466153168"
Received: from lkp-server02.sh.intel.com (HELO fbeef087c6a9) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 20 Oct 2020 20:41:15 -0700
Received: from kbuild by fbeef087c6a9 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kV4zy-00001T-Tp; Wed, 21 Oct 2020 03:41:14 +0000
Date:   Wed, 21 Oct 2020 11:40:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 a4fd8414659bf470e2146b352574bbd274e54b7a
Message-ID: <5f8fada1.yj4yUsVgYUzTV3PW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  timers/urgent
branch HEAD: a4fd8414659bf470e2146b352574bbd274e54b7a  selftests/timens: Add a test for futex()

elapsed time: 724m

configs tested: 238
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                   bluestone_defconfig
sh                          rsk7203_defconfig
arc                 nsimosci_hs_smp_defconfig
sparc                            alldefconfig
m68k                          sun3x_defconfig
arm                         palmz72_defconfig
arc                     haps_hs_smp_defconfig
c6x                                 defconfig
um                            kunit_defconfig
mips                        nlm_xlp_defconfig
c6x                        evmc6457_defconfig
powerpc                     redwood_defconfig
powerpc                    mvme5100_defconfig
arc                        nsim_700_defconfig
mips                           ip32_defconfig
microblaze                      mmu_defconfig
arm                  colibri_pxa300_defconfig
sh                           se7722_defconfig
sh                          kfr2r09_defconfig
mips                  maltasmvp_eva_defconfig
m68k                         apollo_defconfig
arm                       aspeed_g5_defconfig
arm                         ebsa110_defconfig
powerpc                      obs600_defconfig
sh                             sh03_defconfig
nds32                            alldefconfig
m68k                          hp300_defconfig
arm                            lart_defconfig
ia64                      gensparse_defconfig
arm                          pxa168_defconfig
arm                         hackkit_defconfig
um                             i386_defconfig
openrisc                 simple_smp_defconfig
powerpc                      chrp32_defconfig
arc                        vdk_hs38_defconfig
powerpc                       ebony_defconfig
arm                           spitz_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                    sam440ep_defconfig
powerpc                    klondike_defconfig
sh                ecovec24-romimage_defconfig
arm                       spear13xx_defconfig
sh                        sh7757lcr_defconfig
h8300                            allyesconfig
arm                         socfpga_defconfig
sh                           se7712_defconfig
arm                        multi_v7_defconfig
sh                        edosk7705_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                    maltaup_xpa_defconfig
mips                      pistachio_defconfig
mips                 decstation_r4k_defconfig
sh                     magicpanelr2_defconfig
alpha                            alldefconfig
mips                      fuloong2e_defconfig
mips                      pic32mzda_defconfig
powerpc                 mpc834x_mds_defconfig
mips                     loongson1c_defconfig
mips                       capcella_defconfig
arc                              alldefconfig
powerpc                      ppc40x_defconfig
mips                           ci20_defconfig
powerpc                 mpc836x_rdk_defconfig
s390                          debug_defconfig
powerpc                       ppc64_defconfig
sh                            shmin_defconfig
arm                           viper_defconfig
powerpc                  iss476-smp_defconfig
sh                          rsk7264_defconfig
mips                          rm200_defconfig
powerpc                     ep8248e_defconfig
arm                        magician_defconfig
arm                            dove_defconfig
sparc                            allyesconfig
s390                       zfcpdump_defconfig
arm                        clps711x_defconfig
sh                   sh7724_generic_defconfig
m68k                        m5307c3_defconfig
m68k                         amcore_defconfig
arc                           tb10x_defconfig
mips                         tb0287_defconfig
sh                          r7785rp_defconfig
powerpc                     stx_gp3_defconfig
mips                      maltasmvp_defconfig
sh                          landisk_defconfig
arm                             pxa_defconfig
powerpc                     tqm8540_defconfig
powerpc                      pmac32_defconfig
powerpc                 mpc834x_itx_defconfig
sparc64                             defconfig
powerpc                     taishan_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                         ecovec24_defconfig
x86_64                           allyesconfig
powerpc                 mpc832x_rdb_defconfig
parisc                generic-64bit_defconfig
arm                            mps2_defconfig
arm                       omap2plus_defconfig
powerpc                      acadia_defconfig
arm                       mainstone_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                          g5_defconfig
powerpc                     tqm8555_defconfig
xtensa                         virt_defconfig
arm                     eseries_pxa_defconfig
sh                            titan_defconfig
arm                         assabet_defconfig
sh                            migor_defconfig
ia64                             alldefconfig
arm                    vt8500_v6_v7_defconfig
openrisc                            defconfig
mips                          malta_defconfig
xtensa                    xip_kc705_defconfig
m68k                          amiga_defconfig
arc                     nsimosci_hs_defconfig
mips                  cavium_octeon_defconfig
sh                          polaris_defconfig
arm                     am200epdkit_defconfig
mips                        nlm_xlr_defconfig
arm                      integrator_defconfig
sh                               alldefconfig
powerpc                      cm5200_defconfig
arm                         vf610m4_defconfig
mips                         rt305x_defconfig
m68k                       m5249evb_defconfig
xtensa                          iss_defconfig
powerpc                  mpc866_ads_defconfig
ia64                        generic_defconfig
arm                       versatile_defconfig
powerpc                        cell_defconfig
sh                          lboxre2_defconfig
arm                          pxa3xx_defconfig
nios2                            alldefconfig
powerpc                 mpc8560_ads_defconfig
arm                         s3c6400_defconfig
powerpc                     sequoia_defconfig
arm                        oxnas_v6_defconfig
sh                          rsk7201_defconfig
arm                            zeus_defconfig
xtensa                  cadence_csp_defconfig
arc                              allyesconfig
mips                           ip27_defconfig
m68k                            mac_defconfig
mips                         tb0226_defconfig
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
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20201021
x86_64               randconfig-a002-20201021
x86_64               randconfig-a003-20201021
x86_64               randconfig-a006-20201021
x86_64               randconfig-a005-20201021
x86_64               randconfig-a004-20201021
i386                 randconfig-a002-20201020
i386                 randconfig-a005-20201020
i386                 randconfig-a003-20201020
i386                 randconfig-a001-20201020
i386                 randconfig-a006-20201020
i386                 randconfig-a004-20201020
i386                 randconfig-a002-20201021
i386                 randconfig-a005-20201021
i386                 randconfig-a003-20201021
i386                 randconfig-a001-20201021
i386                 randconfig-a006-20201021
i386                 randconfig-a004-20201021
x86_64               randconfig-a011-20201020
x86_64               randconfig-a013-20201020
x86_64               randconfig-a016-20201020
x86_64               randconfig-a015-20201020
x86_64               randconfig-a012-20201020
x86_64               randconfig-a014-20201020
i386                 randconfig-a016-20201020
i386                 randconfig-a014-20201020
i386                 randconfig-a015-20201020
i386                 randconfig-a013-20201020
i386                 randconfig-a012-20201020
i386                 randconfig-a011-20201020
i386                 randconfig-a016-20201021
i386                 randconfig-a014-20201021
i386                 randconfig-a015-20201021
i386                 randconfig-a013-20201021
i386                 randconfig-a012-20201021
i386                 randconfig-a011-20201021
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20201020
x86_64               randconfig-a002-20201020
x86_64               randconfig-a003-20201020
x86_64               randconfig-a006-20201020
x86_64               randconfig-a005-20201020
x86_64               randconfig-a004-20201020
x86_64               randconfig-a011-20201021
x86_64               randconfig-a013-20201021
x86_64               randconfig-a016-20201021
x86_64               randconfig-a015-20201021
x86_64               randconfig-a012-20201021
x86_64               randconfig-a014-20201021

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
