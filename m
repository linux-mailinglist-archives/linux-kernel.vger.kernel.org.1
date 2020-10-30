Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F382A01CA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgJ3JuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:50:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:17305 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgJ3JuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:50:06 -0400
IronPort-SDR: N+1SDYy7UBRofwXQb7rCA+N+35zTlWAnvTzYEs1Xb4S05n3Iajna7sfBS1JXEMzwtG1LmQiurS
 IOywScAFfFhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="165999109"
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="165999109"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 02:50:04 -0700
IronPort-SDR: SYmJp47hSbgRSOFUDaoMUFXSY55CTZ/IidE8d8fEkBCNsXEGb16jf5IT0rKhrug9QidrhEGR9C
 pYRa/Xmol6nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="469477731"
Received: from lkp-server02.sh.intel.com (HELO fcc9f8859912) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 30 Oct 2020 02:50:02 -0700
Received: from kbuild by fcc9f8859912 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kYR2o-00005m-5x; Fri, 30 Oct 2020 09:50:02 +0000
Date:   Fri, 30 Oct 2020 17:49:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:for-next/kspp] BUILD SUCCESS
 080bd2ae9a6c831578c1140ab9f1546f599c9daf
Message-ID: <5f9be19e.HyUayqAQkklQ16P8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  for-next/kspp
branch HEAD: 080bd2ae9a6c831578c1140ab9f1546f599c9daf  printk: ringbuffer: Replace zero-length array with flexible-array member

elapsed time: 722m

configs tested: 151
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          rsk7203_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                        omega2p_defconfig
powerpc                     pseries_defconfig
arc                        nsim_700_defconfig
microblaze                          defconfig
sh                             sh03_defconfig
sh                             shx3_defconfig
sh                        sh7785lcr_defconfig
sh                           se7780_defconfig
powerpc                      pasemi_defconfig
arc                         haps_hs_defconfig
arm                            pleb_defconfig
sh                        apsh4ad0a_defconfig
xtensa                  nommu_kc705_defconfig
openrisc                         alldefconfig
sh                          kfr2r09_defconfig
sh                        sh7763rdp_defconfig
c6x                        evmc6472_defconfig
h8300                       h8s-sim_defconfig
powerpc                    socrates_defconfig
powerpc                    klondike_defconfig
mips                      pistachio_defconfig
sh                           se7619_defconfig
mips                         cobalt_defconfig
powerpc                      pcm030_defconfig
m68k                          amiga_defconfig
m68k                       m5249evb_defconfig
powerpc                     sbc8548_defconfig
mips                  decstation_64_defconfig
sh                      rts7751r2d1_defconfig
powerpc                     sequoia_defconfig
powerpc                     tqm8555_defconfig
arm                     am200epdkit_defconfig
arm                          badge4_defconfig
h8300                               defconfig
arm                         cm_x300_defconfig
m68k                         amcore_defconfig
xtensa                  audio_kc705_defconfig
sh                            shmin_defconfig
ia64                            zx1_defconfig
mips                        bcm63xx_defconfig
powerpc                       maple_defconfig
arm                         socfpga_defconfig
powerpc                          allyesconfig
arm                       imx_v6_v7_defconfig
powerpc                     kmeter1_defconfig
arc                     nsimosci_hs_defconfig
mips                        qi_lb60_defconfig
sh                              ul2_defconfig
um                            kunit_defconfig
openrisc                    or1ksim_defconfig
arm                              alldefconfig
arm                           efm32_defconfig
arm                          pxa3xx_defconfig
sh                           se7206_defconfig
arm                           h3600_defconfig
s390                             alldefconfig
um                           x86_64_defconfig
arc                            hsdk_defconfig
mips                        bcm47xx_defconfig
m68k                           sun3_defconfig
sh                            migor_defconfig
microblaze                      mmu_defconfig
powerpc                        warp_defconfig
sh                     sh7710voipgw_defconfig
mips                 decstation_r4k_defconfig
powerpc                 mpc8315_rdb_defconfig
nds32                               defconfig
arm                        clps711x_defconfig
riscv                            allyesconfig
powerpc                      cm5200_defconfig
mips                           rs90_defconfig
arm                        neponset_defconfig
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
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                                defconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20201030
x86_64               randconfig-a001-20201030
x86_64               randconfig-a002-20201030
x86_64               randconfig-a003-20201030
x86_64               randconfig-a006-20201030
x86_64               randconfig-a004-20201030
i386                 randconfig-a005-20201030
i386                 randconfig-a003-20201030
i386                 randconfig-a002-20201030
i386                 randconfig-a001-20201030
i386                 randconfig-a006-20201030
i386                 randconfig-a004-20201030
i386                 randconfig-a011-20201030
i386                 randconfig-a014-20201030
i386                 randconfig-a015-20201030
i386                 randconfig-a012-20201030
i386                 randconfig-a013-20201030
i386                 randconfig-a016-20201030
i386                 randconfig-a016-20201029
i386                 randconfig-a014-20201029
i386                 randconfig-a015-20201029
i386                 randconfig-a013-20201029
i386                 randconfig-a012-20201029
i386                 randconfig-a011-20201029
riscv                    nommu_k210_defconfig
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
x86_64               randconfig-a013-20201030
x86_64               randconfig-a014-20201030
x86_64               randconfig-a015-20201030
x86_64               randconfig-a016-20201030
x86_64               randconfig-a011-20201030
x86_64               randconfig-a012-20201030

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
