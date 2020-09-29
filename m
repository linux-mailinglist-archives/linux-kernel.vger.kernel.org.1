Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DD927C4EC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 13:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgI2LTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 07:19:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:50504 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728836AbgI2LRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:17:36 -0400
IronPort-SDR: 8Lw8vzdGRWvfy6h7KMEL1Rv+/e0L7YHNF/1QbfxOYvkyVWyapgdXsjGUDwX6Kfc8VNd5S6SfwY
 8K0Q9z7iNJIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="163045192"
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; 
   d="scan'208";a="163045192"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 04:17:32 -0700
IronPort-SDR: omiAHThTU3ZeDKIQDfuT916WwsoRgpfWXyl06oi7vg5CPqn4JVx8R5cI7rOUtM2Hl4MFpO8Syb
 NJSNzy1Kjifg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; 
   d="scan'208";a="415347123"
Received: from lkp-server02.sh.intel.com (HELO dda5aa0886d8) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 29 Sep 2020 04:17:31 -0700
Received: from kbuild by dda5aa0886d8 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kNDdS-000098-Pe; Tue, 29 Sep 2020 11:17:30 +0000
Date:   Tue, 29 Sep 2020 19:16:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:urezki-pcount.2020.09.28f] BUILD SUCCESS
 fb6679eb5fbc57be470508f44642207a15d718c9
Message-ID: <5f731795.fIWDMtQPbCl5OGtK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  urezki-pcount.2020.09.28f
branch HEAD: fb6679eb5fbc57be470508f44642207a15d718c9  EXP Revert "KVM: Check the allocation of pv cpu mask"

elapsed time: 758m

configs tested: 131
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                     haps_hs_smp_defconfig
m68k                          amiga_defconfig
ia64                         bigsur_defconfig
sh                             shx3_defconfig
m68k                        stmark2_defconfig
powerpc                  mpc885_ads_defconfig
nios2                            alldefconfig
m68k                            q40_defconfig
arm                       aspeed_g5_defconfig
arm                         vf610m4_defconfig
powerpc                     tqm8541_defconfig
powerpc64                           defconfig
csky                             alldefconfig
riscv                          rv32_defconfig
sh                          rsk7201_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                      mgcoge_defconfig
mips                        maltaup_defconfig
powerpc                     tqm8548_defconfig
arm                          simpad_defconfig
riscv                    nommu_k210_defconfig
sh                          landisk_defconfig
sh                           se7712_defconfig
sh                        dreamcast_defconfig
ia64                      gensparse_defconfig
i386                             alldefconfig
sh                           se7724_defconfig
riscv                    nommu_virt_defconfig
arm                         mv78xx0_defconfig
powerpc                     kilauea_defconfig
mips                      malta_kvm_defconfig
arm                         s5pv210_defconfig
mips                       bmips_be_defconfig
sh                           se7343_defconfig
arm                           sunxi_defconfig
m68k                          multi_defconfig
powerpc                  storcenter_defconfig
s390                             alldefconfig
arm                       multi_v4t_defconfig
powerpc                      pmac32_defconfig
sh                           se7750_defconfig
mips                           xway_defconfig
arm                        cerfcube_defconfig
arm                  colibri_pxa270_defconfig
mips                      maltaaprp_defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20200928
i386                 randconfig-a002-20200928
i386                 randconfig-a003-20200928
i386                 randconfig-a004-20200928
i386                 randconfig-a005-20200928
i386                 randconfig-a001-20200928
x86_64               randconfig-a011-20200929
x86_64               randconfig-a013-20200929
x86_64               randconfig-a015-20200929
x86_64               randconfig-a014-20200929
x86_64               randconfig-a016-20200929
x86_64               randconfig-a012-20200929
i386                 randconfig-a012-20200928
i386                 randconfig-a016-20200928
i386                 randconfig-a014-20200928
i386                 randconfig-a013-20200928
i386                 randconfig-a015-20200928
i386                 randconfig-a011-20200928
x86_64               randconfig-a005-20200928
x86_64               randconfig-a003-20200928
x86_64               randconfig-a004-20200928
x86_64               randconfig-a002-20200928
x86_64               randconfig-a006-20200928
x86_64               randconfig-a001-20200928
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20200929
x86_64               randconfig-a003-20200929
x86_64               randconfig-a004-20200929
x86_64               randconfig-a002-20200929
x86_64               randconfig-a006-20200929
x86_64               randconfig-a001-20200929
x86_64               randconfig-a005-20200927
x86_64               randconfig-a003-20200927
x86_64               randconfig-a004-20200927
x86_64               randconfig-a002-20200927
x86_64               randconfig-a006-20200927
x86_64               randconfig-a001-20200927
x86_64               randconfig-a011-20200928
x86_64               randconfig-a013-20200928
x86_64               randconfig-a015-20200928

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
