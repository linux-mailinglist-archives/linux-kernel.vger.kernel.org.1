Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06CF2B8596
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 21:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgKRU3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:29:10 -0500
Received: from mga12.intel.com ([192.55.52.136]:38622 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgKRU3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:29:09 -0500
IronPort-SDR: TT2jCCmbE6xz/g9jF0ueOkW0aUdEP/pYdhGypLtVse2c1s6g74+4UIZZr+VFk1ZnD4HqkGBQq9
 0dMOEnh4z4Qg==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="150450806"
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="150450806"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 12:29:08 -0800
IronPort-SDR: coBb5xF+nYH3t359RAJRLcKpUvuthuLi1YFJjIVgHGbHCsoBiLPFqYoBVMtkgrIx9FprbEVALv
 M5ij8UBDNm5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="325721422"
Received: from lkp-server02.sh.intel.com (HELO 67996b229c47) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 18 Nov 2020 12:29:06 -0800
Received: from kbuild by 67996b229c47 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kfU4f-0000Er-Ut; Wed, 18 Nov 2020 20:29:05 +0000
Date:   Thu, 19 Nov 2020 04:28:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 fdcb36cc2bcc096224298d286b8f3d983953548c
Message-ID: <5fb58408.ONBa8vHwKEBX7Tqw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: fdcb36cc2bcc096224298d286b8f3d983953548c  torture: Prepare for splitting qemu execution from kvm-test-1-run.sh

elapsed time: 723m

configs tested: 143
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          rsk7269_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                        edosk7760_defconfig
sh                         microdev_defconfig
sh                            shmin_defconfig
sh                            migor_defconfig
sh                                  defconfig
powerpc                   bluestone_defconfig
powerpc                    amigaone_defconfig
xtensa                    xip_kc705_defconfig
powerpc64                        alldefconfig
nios2                            alldefconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     taishan_defconfig
powerpc                     skiroot_defconfig
sh                   sh7724_generic_defconfig
arm                         s3c6400_defconfig
m68k                        mvme16x_defconfig
mips                        omega2p_defconfig
mips                    maltaup_xpa_defconfig
mips                       bmips_be_defconfig
arc                         haps_hs_defconfig
sh                   sh7770_generic_defconfig
arm                          tango4_defconfig
mips                      loongson3_defconfig
arm                            mps2_defconfig
arc                     nsimosci_hs_defconfig
powerpc                      arches_defconfig
arm                          pcm027_defconfig
mips                           ip32_defconfig
sh                          urquell_defconfig
powerpc                      obs600_defconfig
arm                             mxs_defconfig
c6x                        evmc6472_defconfig
mips                  decstation_64_defconfig
powerpc                     mpc5200_defconfig
powerpc                    adder875_defconfig
x86_64                           allyesconfig
powerpc                 mpc8272_ads_defconfig
m68k                           sun3_defconfig
arm                      tct_hammer_defconfig
powerpc                          g5_defconfig
arm                          badge4_defconfig
sh                     sh7710voipgw_defconfig
arm                        oxnas_v6_defconfig
arm                        trizeps4_defconfig
arm                         socfpga_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                               j2_defconfig
arm                          exynos_defconfig
xtensa                  cadence_csp_defconfig
mips                         rt305x_defconfig
sh                               alldefconfig
sh                             sh03_defconfig
sh                          polaris_defconfig
arm                            lart_defconfig
arm                          prima2_defconfig
powerpc                    gamecube_defconfig
h8300                            alldefconfig
mips                      bmips_stb_defconfig
i386                                defconfig
s390                             alldefconfig
arm                           h5000_defconfig
arm                        neponset_defconfig
sh                           se7705_defconfig
arm                         cm_x300_defconfig
sh                          r7780mp_defconfig
arc                              alldefconfig
powerpc                     mpc83xx_defconfig
powerpc                     tqm8540_defconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20201118
x86_64               randconfig-a003-20201118
x86_64               randconfig-a004-20201118
x86_64               randconfig-a002-20201118
x86_64               randconfig-a006-20201118
x86_64               randconfig-a001-20201118
i386                 randconfig-a006-20201118
i386                 randconfig-a005-20201118
i386                 randconfig-a002-20201118
i386                 randconfig-a001-20201118
i386                 randconfig-a003-20201118
i386                 randconfig-a004-20201118
i386                 randconfig-a012-20201118
i386                 randconfig-a014-20201118
i386                 randconfig-a016-20201118
i386                 randconfig-a011-20201118
i386                 randconfig-a013-20201118
i386                 randconfig-a015-20201118
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
x86_64               randconfig-a015-20201118
x86_64               randconfig-a014-20201118
x86_64               randconfig-a011-20201118
x86_64               randconfig-a013-20201118
x86_64               randconfig-a016-20201118
x86_64               randconfig-a012-20201118

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
