Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0B82C3A43
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 08:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgKYHph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 02:45:37 -0500
Received: from mga12.intel.com ([192.55.52.136]:39445 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgKYHph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 02:45:37 -0500
IronPort-SDR: vWVIrJnh7oolokEGp7uAuyzIlMx7NDQRRWpDZTFno7nZPCPSkb2oqd/7/nOU8GZvH20maQ42/G
 zLVuMidkX8Lg==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="151342638"
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="151342638"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 23:45:36 -0800
IronPort-SDR: NTM4/HLQJP/ne6NIbcYrnQ+hyXlQzXLvG2E2QUb4ZxJ9p8S68ao4WV51kcTZHbB6iNRZzeEDUD
 hmImXUZcjdOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="343477295"
Received: from lkp-server01.sh.intel.com (HELO 9276051a5e67) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 24 Nov 2020 23:45:35 -0800
Received: from kbuild by 9276051a5e67 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1khpUc-00001c-DF; Wed, 25 Nov 2020 07:45:34 +0000
Date:   Wed, 25 Nov 2020 15:45:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:for-mingo-rcu] BUILD SUCCESS
 7fc91fc8450655e7ba941d61663afcaf65cefb78
Message-ID: <5fbe0b8b.SMg7NKFDda+l8jFJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  for-mingo-rcu
branch HEAD: 7fc91fc8450655e7ba941d61663afcaf65cefb78  Merge branches 'cpuinfo.2020.11.06a', 'doc.2020.11.06a', 'fixes.2020.11.19b', 'lockdep.2020.11.02a', 'tasks.2020.11.06a' and 'torture.2020.11.06a' into HEAD

elapsed time: 727m

configs tested: 163
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
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
arc                        vdk_hs38_defconfig
powerpc                      pasemi_defconfig
mips                         db1xxx_defconfig
arm                          prima2_defconfig
powerpc                  storcenter_defconfig
arm                             ezx_defconfig
arm                       aspeed_g4_defconfig
powerpc                    ge_imp3a_defconfig
mips                           ip27_defconfig
powerpc                    socrates_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                      ep88xc_defconfig
parisc                              defconfig
powerpc                     rainier_defconfig
powerpc                      acadia_defconfig
ia64                             alldefconfig
sh                           se7724_defconfig
powerpc                 mpc8313_rdb_defconfig
s390                             alldefconfig
sh                     sh7710voipgw_defconfig
m68k                        m5307c3_defconfig
sh                          sdk7780_defconfig
x86_64                           alldefconfig
arm                           omap1_defconfig
m68k                       m5275evb_defconfig
arm                            pleb_defconfig
arm                        neponset_defconfig
sh                            migor_defconfig
s390                                defconfig
mips                      maltaaprp_defconfig
parisc                           alldefconfig
mips                          rm200_defconfig
sh                   sh7770_generic_defconfig
powerpc                    gamecube_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc836x_mds_defconfig
arm                       imx_v4_v5_defconfig
arm                         ebsa110_defconfig
powerpc                        fsp2_defconfig
mips                malta_kvm_guest_defconfig
mips                          ath25_defconfig
microblaze                          defconfig
powerpc                 mpc834x_mds_defconfig
arc                        nsimosci_defconfig
arm                       omap2plus_defconfig
sh                                  defconfig
um                           x86_64_defconfig
sh                            hp6xx_defconfig
powerpc                      walnut_defconfig
powerpc                     sbc8548_defconfig
sh                          rsk7203_defconfig
mips                     cu1000-neo_defconfig
arm                   milbeaut_m10v_defconfig
arm                        shmobile_defconfig
sh                               j2_defconfig
parisc                generic-64bit_defconfig
ia64                            zx1_defconfig
sh                              ul2_defconfig
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
s390                             allyesconfig
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
i386                 randconfig-a004-20201125
i386                 randconfig-a003-20201125
i386                 randconfig-a002-20201125
i386                 randconfig-a005-20201125
i386                 randconfig-a001-20201125
i386                 randconfig-a006-20201125
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
i386                 randconfig-a012-20201125
i386                 randconfig-a013-20201125
i386                 randconfig-a011-20201125
i386                 randconfig-a016-20201125
i386                 randconfig-a014-20201125
i386                 randconfig-a015-20201125
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
x86_64               randconfig-a006-20201125
x86_64               randconfig-a003-20201125
x86_64               randconfig-a004-20201125
x86_64               randconfig-a005-20201125
x86_64               randconfig-a002-20201125
x86_64               randconfig-a001-20201125
x86_64               randconfig-a015-20201124
x86_64               randconfig-a011-20201124
x86_64               randconfig-a014-20201124
x86_64               randconfig-a016-20201124
x86_64               randconfig-a012-20201124
x86_64               randconfig-a013-20201124

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
