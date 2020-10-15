Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AFA28ED25
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 08:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgJOGk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 02:40:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:33782 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgJOGk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 02:40:58 -0400
IronPort-SDR: fyqW0vor7nZ++7MUTF2LZfLvuAtXFjStailgUXE6jZouHdJDzeYOYbW6Q14OXGDfLIdJw1mIsx
 O9XsGTEIDOlw==
X-IronPort-AV: E=McAfee;i="6000,8403,9774"; a="230465254"
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; 
   d="scan'208";a="230465254"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2020 23:40:57 -0700
IronPort-SDR: X4u2sBfEkf4dr8YwHod2cWerN9nvQtXlgblrZgjufXFkSjkCFrJ2c55axDyZei5F+BJpfTpoXr
 X+IMBwC3npAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,378,1596524400"; 
   d="scan'208";a="520662428"
Received: from lkp-server02.sh.intel.com (HELO 7220befbd762) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 14 Oct 2020 23:40:55 -0700
Received: from kbuild by 7220befbd762 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kSwwZ-00001E-7n; Thu, 15 Oct 2020 06:40:55 +0000
Date:   Thu, 15 Oct 2020 14:40:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.10.08a] BUILD SUCCESS
 8cf04c6ec9a3344610981bf42ffa19052f1c6bde
Message-ID: <5f87eed4.TciO++Cgv5cmxANY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.10.08a
branch HEAD: 8cf04c6ec9a3344610981bf42ffa19052f1c6bde  rcu: Prevent lockdep-RCU splats on lock acquisition/release

elapsed time: 722m

configs tested: 141
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
mips                         tb0287_defconfig
sh                   sh7724_generic_defconfig
arm                       netwinder_defconfig
xtensa                              defconfig
mips                            e55_defconfig
arm                         cm_x300_defconfig
arm                              zx_defconfig
mips                        jmr3927_defconfig
powerpc                     tqm8555_defconfig
arm                              alldefconfig
powerpc                 mpc8560_ads_defconfig
arm                          pxa3xx_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                 mpc832x_mds_defconfig
sh                        apsh4ad0a_defconfig
mips                          ath79_defconfig
arm                  colibri_pxa300_defconfig
arm                            xcep_defconfig
powerpc                       eiger_defconfig
mips                           ip32_defconfig
alpha                               defconfig
arm                          prima2_defconfig
m68k                             allmodconfig
arm                           tegra_defconfig
mips                      pistachio_defconfig
ia64                      gensparse_defconfig
mips                     decstation_defconfig
ia64                                defconfig
powerpc                     sbc8548_defconfig
powerpc                       holly_defconfig
powerpc                   motionpro_defconfig
mips                          malta_defconfig
arm                         lpc32xx_defconfig
arm                          simpad_defconfig
sh                               allmodconfig
mips                malta_kvm_guest_defconfig
h8300                     edosk2674_defconfig
sh                          rsk7203_defconfig
mips                 pnx8335_stb225_defconfig
mips                       bmips_be_defconfig
arm                            zeus_defconfig
powerpc                      ep88xc_defconfig
sh                               alldefconfig
powerpc                      cm5200_defconfig
arm                          collie_defconfig
powerpc                 linkstation_defconfig
ia64                          tiger_defconfig
mips                    maltaup_xpa_defconfig
arm                        multi_v7_defconfig
powerpc                 mpc836x_rdk_defconfig
sh                           se7206_defconfig
sparc                               defconfig
arm                           u8500_defconfig
h8300                    h8300h-sim_defconfig
mips                            gpr_defconfig
arm                             pxa_defconfig
arm                         bcm2835_defconfig
m68k                         amcore_defconfig
m68k                            q40_defconfig
arm                             rpc_defconfig
arm                        trizeps4_defconfig
arm                         shannon_defconfig
powerpc                    sam440ep_defconfig
m68k                        m5307c3_defconfig
sh                             sh03_defconfig
sh                        edosk7705_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
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
arc                                 defconfig
parisc                              defconfig
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
i386                 randconfig-a005-20201014
i386                 randconfig-a006-20201014
i386                 randconfig-a001-20201014
i386                 randconfig-a003-20201014
i386                 randconfig-a004-20201014
i386                 randconfig-a002-20201014
x86_64               randconfig-a016-20201014
x86_64               randconfig-a012-20201014
x86_64               randconfig-a015-20201014
x86_64               randconfig-a013-20201014
x86_64               randconfig-a014-20201014
x86_64               randconfig-a011-20201014
i386                 randconfig-a016-20201014
i386                 randconfig-a013-20201014
i386                 randconfig-a015-20201014
i386                 randconfig-a011-20201014
i386                 randconfig-a012-20201014
i386                 randconfig-a014-20201014
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201014
x86_64               randconfig-a002-20201014
x86_64               randconfig-a006-20201014
x86_64               randconfig-a001-20201014
x86_64               randconfig-a005-20201014
x86_64               randconfig-a003-20201014
x86_64               randconfig-a016-20201015
x86_64               randconfig-a012-20201015
x86_64               randconfig-a015-20201015
x86_64               randconfig-a013-20201015
x86_64               randconfig-a014-20201015
x86_64               randconfig-a011-20201015

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
