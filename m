Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C02429E597
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 09:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387921AbgJ2H7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:59:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:50261 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389123AbgJ2H6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:58:51 -0400
IronPort-SDR: zJweunFSToz6BAtrpeyBwguVkx5mJ3wTLRX16aKvCsbWpcpCUXPcnytpxN9dkEmJz0lFoM65+7
 32rlO9706n3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="164872542"
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="164872542"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 19:55:32 -0700
IronPort-SDR: AGDVvrz7GtSUj+W6Rnn/mWCXhbO6VcicueMHNgjL3K6JwhjJj1FDbKRR7hcrhKoMheJXRkTuvC
 LBh1Bi7/Jb3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="468976289"
Received: from lkp-server02.sh.intel.com (HELO 72b1a4bebef6) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 28 Oct 2020 19:55:30 -0700
Received: from kbuild by 72b1a4bebef6 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kXy66-00000Y-BM; Thu, 29 Oct 2020 02:55:30 +0000
Date:   Thu, 29 Oct 2020 10:55:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 921c7ebd1337d1a46783d7e15a850e12aed2eaa0
Message-ID: <5f9a2f19.L4jjKIqhNQ/h2dOQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  locking/urgent
branch HEAD: 921c7ebd1337d1a46783d7e15a850e12aed2eaa0  futex: Fix incorrect should_fail_futex() handling

elapsed time: 724m

configs tested: 203
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          landisk_defconfig
arc                      axs103_smp_defconfig
c6x                                 defconfig
powerpc                     taishan_defconfig
powerpc                     ppa8548_defconfig
m68k                        m5307c3_defconfig
s390                             allyesconfig
arm                          prima2_defconfig
ia64                          tiger_defconfig
openrisc                         alldefconfig
powerpc                 mpc8272_ads_defconfig
mips                        maltaup_defconfig
sh                           se7721_defconfig
arc                          axs103_defconfig
powerpc                 mpc836x_rdk_defconfig
sh                            shmin_defconfig
c6x                              alldefconfig
arm                      integrator_defconfig
arm                          pxa3xx_defconfig
ia64                                defconfig
ia64                        generic_defconfig
mips                          malta_defconfig
sh                          lboxre2_defconfig
mips                           gcw0_defconfig
powerpc                       ebony_defconfig
sh                   sh7770_generic_defconfig
arm                          simpad_defconfig
c6x                              allyesconfig
arm                        mvebu_v5_defconfig
m68k                         amcore_defconfig
arm                        mvebu_v7_defconfig
mips                       lemote2f_defconfig
arm                         nhk8815_defconfig
alpha                            alldefconfig
sh                          r7780mp_defconfig
arm                            lart_defconfig
mips                      bmips_stb_defconfig
arm                        magician_defconfig
m68k                        mvme147_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                              zx_defconfig
c6x                         dsk6455_defconfig
parisc                generic-32bit_defconfig
powerpc                    gamecube_defconfig
powerpc                     mpc5200_defconfig
powerpc                      chrp32_defconfig
arc                     haps_hs_smp_defconfig
m68k                       m5249evb_defconfig
arm                           tegra_defconfig
powerpc                 mpc834x_mds_defconfig
arc                                 defconfig
arm                       aspeed_g5_defconfig
powerpc                      katmai_defconfig
mips                          rb532_defconfig
powerpc                      bamboo_defconfig
arm                      pxa255-idp_defconfig
xtensa                           alldefconfig
powerpc                     tqm8560_defconfig
s390                       zfcpdump_defconfig
powerpc                    ge_imp3a_defconfig
mips                      fuloong2e_defconfig
h8300                    h8300h-sim_defconfig
mips                          ath79_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                             sh03_defconfig
mips                           xway_defconfig
powerpc                  storcenter_defconfig
sh                        dreamcast_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                        edosk7760_defconfig
sh                ecovec24-romimage_defconfig
riscv                            alldefconfig
powerpc                     asp8347_defconfig
powerpc                     mpc512x_defconfig
powerpc64                           defconfig
mips                       capcella_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                      walnut_defconfig
mips                     decstation_defconfig
m68k                        m5407c3_defconfig
mips                            gpr_defconfig
mips                      malta_kvm_defconfig
powerpc                 mpc8560_ads_defconfig
arm                        multi_v5_defconfig
arm                         s5pv210_defconfig
arm                          tango4_defconfig
arm                          badge4_defconfig
powerpc                     tqm8540_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                malta_qemu_32r6_defconfig
sh                             espt_defconfig
arm                          ixp4xx_defconfig
um                            kunit_defconfig
m68k                          multi_defconfig
nds32                            alldefconfig
um                           x86_64_defconfig
arm                      tct_hammer_defconfig
mips                       bmips_be_defconfig
arm                           viper_defconfig
powerpc                    sam440ep_defconfig
sh                          urquell_defconfig
sh                          sdk7780_defconfig
powerpc                     pseries_defconfig
sh                              ul2_defconfig
arm                            zeus_defconfig
sh                          rsk7264_defconfig
powerpc                    klondike_defconfig
riscv                    nommu_virt_defconfig
ia64                      gensparse_defconfig
arm                          pxa168_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
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
x86_64               randconfig-a001-20201029
x86_64               randconfig-a002-20201029
x86_64               randconfig-a003-20201029
x86_64               randconfig-a006-20201029
x86_64               randconfig-a005-20201029
x86_64               randconfig-a004-20201029
i386                 randconfig-a002-20201026
i386                 randconfig-a003-20201026
i386                 randconfig-a005-20201026
i386                 randconfig-a001-20201026
i386                 randconfig-a006-20201026
i386                 randconfig-a004-20201026
i386                 randconfig-a002-20201028
i386                 randconfig-a005-20201028
i386                 randconfig-a003-20201028
i386                 randconfig-a001-20201028
i386                 randconfig-a004-20201028
i386                 randconfig-a006-20201028
x86_64               randconfig-a011-20201028
x86_64               randconfig-a013-20201028
x86_64               randconfig-a016-20201028
x86_64               randconfig-a015-20201028
x86_64               randconfig-a012-20201028
x86_64               randconfig-a014-20201028
x86_64               randconfig-a011-20201026
x86_64               randconfig-a013-20201026
x86_64               randconfig-a016-20201026
x86_64               randconfig-a015-20201026
x86_64               randconfig-a012-20201026
x86_64               randconfig-a014-20201026
i386                 randconfig-a016-20201028
i386                 randconfig-a014-20201028
i386                 randconfig-a015-20201028
i386                 randconfig-a013-20201028
i386                 randconfig-a012-20201028
i386                 randconfig-a011-20201028
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-a001-20201028
x86_64               randconfig-a002-20201028
x86_64               randconfig-a003-20201028
x86_64               randconfig-a006-20201028
x86_64               randconfig-a005-20201028
x86_64               randconfig-a004-20201028
x86_64               randconfig-a001-20201026
x86_64               randconfig-a003-20201026
x86_64               randconfig-a002-20201026
x86_64               randconfig-a006-20201026
x86_64               randconfig-a004-20201026
x86_64               randconfig-a005-20201026

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
