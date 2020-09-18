Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CF827081D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 23:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgIRVXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 17:23:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:30530 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgIRVXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 17:23:20 -0400
IronPort-SDR: fxC7SXrarpOq+U6apISYKjP4IoxV6YOSnXFcT/RY6PvCtZi60kCCewfPMJ7O5xxmxRh7Bb55Ml
 hoyFqj2UQdZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="140038404"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="140038404"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 14:23:12 -0700
IronPort-SDR: E4O70SdwH/h4fga7YxE5s4WD699jIA4E4g6SUpbnGyogXLrLGXkmAzaC8E9FehAl4fF0R5w3ex
 dF9ISRd/nFAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="452917411"
Received: from lkp-server01.sh.intel.com (HELO a05db971c861) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 18 Sep 2020 14:23:11 -0700
Received: from kbuild by a05db971c861 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kJNqY-0000hN-KV; Fri, 18 Sep 2020 21:23:10 +0000
Date:   Sat, 19 Sep 2020 05:22:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:efi/core] BUILD SUCCESS
 744de4180a43cb5264c1ba39d98c9eadcb228491
Message-ID: <5f65250d.gqTSiY+TCeTgHib+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  efi/core
branch HEAD: 744de4180a43cb5264c1ba39d98c9eadcb228491  cper,edac,efi: Memory Error Record: bank group/address and chip id

elapsed time: 2939m

configs tested: 255
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7750_defconfig
powerpc                      arches_defconfig
arm                        mini2440_defconfig
mips                        omega2p_defconfig
arm                         lubbock_defconfig
arm                           spitz_defconfig
powerpc                        warp_defconfig
sh                        dreamcast_defconfig
m68k                          amiga_defconfig
powerpc                 mpc832x_mds_defconfig
ia64                             alldefconfig
powerpc                      pcm030_defconfig
arm                            lart_defconfig
powerpc                    mvme5100_defconfig
powerpc                     sbc8548_defconfig
sparc                       sparc64_defconfig
arm                   milbeaut_m10v_defconfig
arm                       imx_v6_v7_defconfig
arm                             rpc_defconfig
c6x                              allyesconfig
arm                            u300_defconfig
arm                       omap2plus_defconfig
m68k                             alldefconfig
mips                          malta_defconfig
arm                          pxa910_defconfig
mips                        vocore2_defconfig
arm                        mvebu_v7_defconfig
powerpc                       eiger_defconfig
powerpc                     tqm8548_defconfig
sh                         ecovec24_defconfig
nds32                            alldefconfig
powerpc                 linkstation_defconfig
parisc                generic-64bit_defconfig
arm                      pxa255-idp_defconfig
ia64                         bigsur_defconfig
powerpc                      makalu_defconfig
arm                          pxa3xx_defconfig
powerpc                      mgcoge_defconfig
parisc                generic-32bit_defconfig
m68k                        m5272c3_defconfig
sh                     magicpanelr2_defconfig
arm                         nhk8815_defconfig
powerpc                       maple_defconfig
riscv                            alldefconfig
mips                     loongson1c_defconfig
arc                     nsimosci_hs_defconfig
riscv                          rv32_defconfig
xtensa                           allyesconfig
powerpc                  mpc866_ads_defconfig
sh                          rsk7269_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                        cell_defconfig
mips                        nlm_xlp_defconfig
xtensa                         virt_defconfig
arm                           corgi_defconfig
arc                        vdk_hs38_defconfig
powerpc                          allyesconfig
arm                        mvebu_v5_defconfig
m68k                            mac_defconfig
mips                 decstation_r4k_defconfig
arm                         at91_dt_defconfig
arm                     am200epdkit_defconfig
arm                          iop32x_defconfig
mips                        nlm_xlr_defconfig
sh                   sh7724_generic_defconfig
m68k                          sun3x_defconfig
powerpc                  storcenter_defconfig
sh                        edosk7705_defconfig
powerpc                    gamecube_defconfig
xtensa                          iss_defconfig
mips                      loongson3_defconfig
mips                         cobalt_defconfig
nios2                         3c120_defconfig
sh                        sh7763rdp_defconfig
sh                      rts7751r2d1_defconfig
sh                          urquell_defconfig
powerpc                     rainier_defconfig
arm                            hisi_defconfig
powerpc                      chrp32_defconfig
mips                     cu1830-neo_defconfig
powerpc                      bamboo_defconfig
arm                      integrator_defconfig
arm                           efm32_defconfig
arm                             mxs_defconfig
arc                            hsdk_defconfig
arm                           u8500_defconfig
mips                     decstation_defconfig
powerpc                   lite5200b_defconfig
sh                           sh2007_defconfig
sh                        sh7757lcr_defconfig
powerpc                  iss476-smp_defconfig
powerpc                    sam440ep_defconfig
arm                         axm55xx_defconfig
parisc                           allyesconfig
powerpc                     kilauea_defconfig
arm                          imote2_defconfig
sh                           se7712_defconfig
powerpc                      katmai_defconfig
mips                  cavium_octeon_defconfig
nios2                         10m50_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                        fsp2_defconfig
mips                       lemote2f_defconfig
arm                  colibri_pxa300_defconfig
mips                  maltasmvp_eva_defconfig
sh                         microdev_defconfig
arm                    vt8500_v6_v7_defconfig
arm                         mv78xx0_defconfig
arm                          badge4_defconfig
m68k                        stmark2_defconfig
sh                           se7780_defconfig
mips                         tb0287_defconfig
mips                         db1xxx_defconfig
arc                             nps_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc836x_mds_defconfig
mips                         rt305x_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                    maltaup_xpa_defconfig
alpha                            alldefconfig
m68k                         apollo_defconfig
alpha                               defconfig
powerpc                     tqm5200_defconfig
powerpc                    klondike_defconfig
arc                         haps_hs_defconfig
arm                          lpd270_defconfig
arm                          simpad_defconfig
mips                           ci20_defconfig
arc                      axs103_smp_defconfig
sh                           se7343_defconfig
powerpc                 mpc85xx_cds_defconfig
riscv                             allnoconfig
m68k                             allyesconfig
arm                           tegra_defconfig
arm                         s3c2410_defconfig
ia64                            zx1_defconfig
sh                            migor_defconfig
powerpc                     ppa8548_defconfig
powerpc                     pq2fads_defconfig
um                           x86_64_defconfig
sh                              ul2_defconfig
ia64                      gensparse_defconfig
arm                         shannon_defconfig
sparc                            allyesconfig
powerpc                     mpc83xx_defconfig
arm                          collie_defconfig
powerpc                     tqm8541_defconfig
sh                          kfr2r09_defconfig
sparc64                             defconfig
arm                          ixp4xx_defconfig
powerpc                    adder875_defconfig
arm                        neponset_defconfig
sh                           se7721_defconfig
arm                       mainstone_defconfig
powerpc                       holly_defconfig
microblaze                          defconfig
powerpc                     ksi8560_defconfig
openrisc                         alldefconfig
sh                               j2_defconfig
powerpc                       ppc64_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
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
x86_64               randconfig-a014-20200917
x86_64               randconfig-a011-20200917
x86_64               randconfig-a016-20200917
x86_64               randconfig-a012-20200917
x86_64               randconfig-a015-20200917
x86_64               randconfig-a013-20200917
x86_64               randconfig-a004-20200918
x86_64               randconfig-a006-20200918
x86_64               randconfig-a003-20200918
x86_64               randconfig-a002-20200918
x86_64               randconfig-a005-20200918
x86_64               randconfig-a001-20200918
i386                 randconfig-a015-20200917
i386                 randconfig-a014-20200917
i386                 randconfig-a011-20200917
i386                 randconfig-a013-20200917
i386                 randconfig-a016-20200917
i386                 randconfig-a012-20200917
i386                 randconfig-a015-20200918
i386                 randconfig-a011-20200918
i386                 randconfig-a014-20200918
i386                 randconfig-a013-20200918
i386                 randconfig-a012-20200918
i386                 randconfig-a016-20200918
i386                 randconfig-a015-20200916
i386                 randconfig-a014-20200916
i386                 randconfig-a011-20200916
i386                 randconfig-a013-20200916
i386                 randconfig-a016-20200916
i386                 randconfig-a012-20200916
riscv                            allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20200917
x86_64               randconfig-a004-20200917
x86_64               randconfig-a003-20200917
x86_64               randconfig-a002-20200917
x86_64               randconfig-a001-20200917
x86_64               randconfig-a005-20200917

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
