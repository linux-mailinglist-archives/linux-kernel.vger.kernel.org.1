Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D862DB778
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 01:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgLPAA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 19:00:27 -0500
Received: from mga07.intel.com ([134.134.136.100]:31689 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729444AbgLOXUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 18:20:30 -0500
IronPort-SDR: LP3rttp34YRCcIrwj92XWai4hemmfK8YS9bZbgjJr6mst1LubBL4KhiabeA8pCDxz0ll88o1nR
 EachTf8354SA==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="239066203"
X-IronPort-AV: E=Sophos;i="5.78,422,1599548400"; 
   d="scan'208";a="239066203"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 15:18:49 -0800
IronPort-SDR: URbhIQozZpD/zDBKQ1H8lb6SoQWxZE0XYpoZhCxKbKEMvLckgfryLI0kEgh9jYA/2HI9h4foTO
 Zl4RtDFLt/wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,422,1599548400"; 
   d="scan'208";a="488140531"
Received: from lkp-server02.sh.intel.com (HELO a947d92d0467) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Dec 2020 15:18:39 -0800
Received: from kbuild by a947d92d0467 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kpJaZ-00012m-3F; Tue, 15 Dec 2020 23:18:39 +0000
Date:   Wed, 16 Dec 2020 07:18:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:efi/core] BUILD SUCCESS
 3dcb8b53cbd2cc5618863b19ef00f8ea82f27e83
Message-ID: <5fd9444a.b9QTRqbREz5TrAYl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  efi/core
branch HEAD: 3dcb8b53cbd2cc5618863b19ef00f8ea82f27e83  Merge tag 'efi-next-for-v5.11-3' of git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi into efi/core

elapsed time: 720m

configs tested: 176
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                 nsimosci_hs_smp_defconfig
mips                      bmips_stb_defconfig
arm                        realview_defconfig
alpha                               defconfig
sh                                  defconfig
ia64                        generic_defconfig
arm                             ezx_defconfig
mips                   sb1250_swarm_defconfig
mips                     decstation_defconfig
arm64                            alldefconfig
powerpc                       holly_defconfig
powerpc                 mpc837x_mds_defconfig
arm                        shmobile_defconfig
sh                ecovec24-romimage_defconfig
arm                      pxa255-idp_defconfig
sh                         microdev_defconfig
sh                           se7712_defconfig
powerpc                      bamboo_defconfig
m68k                       m5275evb_defconfig
powerpc                  iss476-smp_defconfig
powerpc                           allnoconfig
arm                           efm32_defconfig
powerpc                  mpc885_ads_defconfig
powerpc               mpc834x_itxgp_defconfig
arc                           tb10x_defconfig
powerpc                     ksi8560_defconfig
arm                    vt8500_v6_v7_defconfig
riscv                    nommu_k210_defconfig
mips                            ar7_defconfig
powerpc                       ppc64_defconfig
arm                          ep93xx_defconfig
powerpc                        warp_defconfig
nios2                         10m50_defconfig
mips                       bmips_be_defconfig
mips                     cu1830-neo_defconfig
powerpc                       ebony_defconfig
riscv                            alldefconfig
powerpc                     tqm8540_defconfig
arm                         shannon_defconfig
m68k                          hp300_defconfig
m68k                         apollo_defconfig
powerpc                      walnut_defconfig
arm                      footbridge_defconfig
arm                        cerfcube_defconfig
xtensa                    xip_kc705_defconfig
sh                           se7724_defconfig
arm                            lart_defconfig
um                             i386_defconfig
ia64                         bigsur_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                            qcom_defconfig
ia64                      gensparse_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                        sh7785lcr_defconfig
xtensa                  cadence_csp_defconfig
i386                             alldefconfig
arm                         ebsa110_defconfig
powerpc                     pq2fads_defconfig
mips                        omega2p_defconfig
mips                           ci20_defconfig
powerpc                     asp8347_defconfig
arm                       netwinder_defconfig
h8300                     edosk2674_defconfig
arm                          moxart_defconfig
arc                                 defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                       maple_defconfig
mips                           ip27_defconfig
mips                        bcm47xx_defconfig
sh                           se7722_defconfig
powerpc                      pcm030_defconfig
powerpc                    klondike_defconfig
sh                   secureedge5410_defconfig
powerpc                 mpc834x_mds_defconfig
arm                  colibri_pxa300_defconfig
sh                        edosk7760_defconfig
c6x                                 defconfig
m68k                           sun3_defconfig
arm                     davinci_all_defconfig
powerpc                 linkstation_defconfig
m68k                            mac_defconfig
powerpc64                        alldefconfig
arm                           sunxi_defconfig
arm                            zeus_defconfig
mips                         tb0287_defconfig
powerpc                     sequoia_defconfig
mips                  decstation_64_defconfig
x86_64                           allyesconfig
powerpc                      ppc64e_defconfig
arm                  colibri_pxa270_defconfig
arm                            mps2_defconfig
arm                       mainstone_defconfig
c6x                        evmc6678_defconfig
m68k                          atari_defconfig
m68k                        m5272c3_defconfig
arm                        neponset_defconfig
sh                        dreamcast_defconfig
parisc                              defconfig
s390                             allyesconfig
m68k                        m5407c3_defconfig
sh                               j2_defconfig
parisc                generic-32bit_defconfig
mips                         tb0226_defconfig
arm                           corgi_defconfig
parisc                           alldefconfig
mips                      pic32mzda_defconfig
mips                           xway_defconfig
arm                         mv78xx0_defconfig
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
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a003-20201215
x86_64               randconfig-a006-20201215
x86_64               randconfig-a002-20201215
x86_64               randconfig-a005-20201215
x86_64               randconfig-a004-20201215
x86_64               randconfig-a001-20201215
i386                 randconfig-a001-20201215
i386                 randconfig-a004-20201215
i386                 randconfig-a003-20201215
i386                 randconfig-a002-20201215
i386                 randconfig-a006-20201215
i386                 randconfig-a005-20201215
i386                 randconfig-a014-20201215
i386                 randconfig-a013-20201215
i386                 randconfig-a012-20201215
i386                 randconfig-a011-20201215
i386                 randconfig-a015-20201215
i386                 randconfig-a016-20201215
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
x86_64               randconfig-a016-20201215
x86_64               randconfig-a012-20201215
x86_64               randconfig-a013-20201215
x86_64               randconfig-a015-20201215
x86_64               randconfig-a014-20201215
x86_64               randconfig-a011-20201215

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
