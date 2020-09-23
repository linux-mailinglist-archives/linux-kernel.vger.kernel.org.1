Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3668E27522A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 09:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgIWHMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 03:12:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:53779 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726557AbgIWHMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 03:12:08 -0400
IronPort-SDR: 1evR14QMrRszgAqOoPVzIhiQabbqunzdzNo1X2IWpmEATBL1b15jKCOnbazD/IzQ4j7LmRahhG
 Y603GmA9nfCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="161750423"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="161750423"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2020 00:12:05 -0700
IronPort-SDR: lVgISsAsR1pRDj/UDWPnlp30IMc0xQm3XunUJ3SEKkK1NQLXwtN8AyU5RAe8ggZWijBGxhuail
 +Dja4Z3bDb1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; 
   d="scan'208";a="347244275"
Received: from lkp-server01.sh.intel.com (HELO 9f27196b5390) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Sep 2020 00:12:04 -0700
Received: from kbuild by 9f27196b5390 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kKywd-00002p-FR; Wed, 23 Sep 2020 07:12:03 +0000
Date:   Wed, 23 Sep 2020 15:11:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.09.19a] BUILD SUCCESS
 e4b70593d9681a2d10a84681dc16a31a9d1bde05
Message-ID: <5f6af53c.8h4w7HMBJ6TPbCxj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.09.19a
branch HEAD: e4b70593d9681a2d10a84681dc16a31a9d1bde05  torture: Force weak-hashed pointers on console log

elapsed time: 851m

configs tested: 155
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                          pcm027_defconfig
arm                         vf610m4_defconfig
arm                           viper_defconfig
arm                      jornada720_defconfig
powerpc                 mpc837x_rdb_defconfig
nios2                         3c120_defconfig
powerpc                     tqm8555_defconfig
arm                          iop32x_defconfig
ia64                         bigsur_defconfig
sh                     magicpanelr2_defconfig
h8300                     edosk2674_defconfig
powerpc                 xes_mpc85xx_defconfig
ia64                                defconfig
arm                            lart_defconfig
riscv                    nommu_virt_defconfig
powerpc                        warp_defconfig
powerpc                       maple_defconfig
sh                             sh03_defconfig
mips                          rm200_defconfig
mips                       bmips_be_defconfig
powerpc                   currituck_defconfig
mips                           gcw0_defconfig
sh                           se7722_defconfig
arm                      tct_hammer_defconfig
powerpc                       ebony_defconfig
arm                          tango4_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      obs600_defconfig
m68k                          amiga_defconfig
m68k                       m5275evb_defconfig
sh                           sh2007_defconfig
c6x                        evmc6457_defconfig
arm                           sama5_defconfig
x86_64                           alldefconfig
arm                         s5pv210_defconfig
powerpc                      chrp32_defconfig
arm                         axm55xx_defconfig
um                            kunit_defconfig
arm                       mainstone_defconfig
sh                          rsk7269_defconfig
sh                               alldefconfig
arc                     haps_hs_smp_defconfig
powerpc                        fsp2_defconfig
arm                         cm_x300_defconfig
powerpc                  mpc866_ads_defconfig
sh                           se7206_defconfig
arm                        shmobile_defconfig
mips                      bmips_stb_defconfig
mips                        bcm63xx_defconfig
arm                       imx_v4_v5_defconfig
arm                         ebsa110_defconfig
arm                     am200epdkit_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                           efm32_defconfig
m68k                            q40_defconfig
powerpc                 mpc8313_rdb_defconfig
m68k                       m5249evb_defconfig
powerpc                      cm5200_defconfig
mips                   sb1250_swarm_defconfig
ia64                             allmodconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20200921
i386                 randconfig-a006-20200921
i386                 randconfig-a003-20200921
i386                 randconfig-a004-20200921
i386                 randconfig-a005-20200921
i386                 randconfig-a001-20200921
i386                 randconfig-a002-20200923
i386                 randconfig-a006-20200923
i386                 randconfig-a003-20200923
i386                 randconfig-a004-20200923
i386                 randconfig-a005-20200923
i386                 randconfig-a001-20200923
i386                 randconfig-a002-20200922
i386                 randconfig-a006-20200922
i386                 randconfig-a003-20200922
i386                 randconfig-a004-20200922
i386                 randconfig-a005-20200922
i386                 randconfig-a001-20200922
x86_64               randconfig-a011-20200923
x86_64               randconfig-a013-20200923
x86_64               randconfig-a014-20200923
x86_64               randconfig-a015-20200923
x86_64               randconfig-a012-20200923
x86_64               randconfig-a016-20200923
i386                 randconfig-a012-20200923
i386                 randconfig-a014-20200923
i386                 randconfig-a016-20200923
i386                 randconfig-a013-20200923
i386                 randconfig-a011-20200923
i386                 randconfig-a015-20200923
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
x86_64               randconfig-a005-20200923
x86_64               randconfig-a003-20200923
x86_64               randconfig-a004-20200923
x86_64               randconfig-a002-20200923
x86_64               randconfig-a006-20200923
x86_64               randconfig-a001-20200923
x86_64               randconfig-a011-20200922
x86_64               randconfig-a013-20200922
x86_64               randconfig-a014-20200922
x86_64               randconfig-a015-20200922
x86_64               randconfig-a012-20200922
x86_64               randconfig-a016-20200922
x86_64               randconfig-a011-20200920
x86_64               randconfig-a013-20200920
x86_64               randconfig-a014-20200920
x86_64               randconfig-a015-20200920
x86_64               randconfig-a012-20200920
x86_64               randconfig-a016-20200920

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
