Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69EA2FF75D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 22:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbhAUVeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 16:34:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:55416 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbhAUVbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 16:31:39 -0500
IronPort-SDR: 8xxziGiWGxVlHxcEneHK5vu08PQhMtzPWLwClpsfFhUF5GCHZzWuNB9F2YKek15ovWX7+nJuZV
 vZZNTzLxVg7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="176776860"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="176776860"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 13:30:43 -0800
IronPort-SDR: yBpmXmh61a8QyGVvqGIOvQZ2L3cz3XIb6vE4F5/yqOuyiQ11Q66j+O4AdnhezLzsXYEAmQCzoE
 PFkrxozf8hJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="348053346"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 21 Jan 2021 13:30:41 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l2hXM-0006iu-T5; Thu, 21 Jan 2021 21:30:40 +0000
Date:   Fri, 22 Jan 2021 05:30:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 e2f1899de97ba7e4c6bc2ae48e09d64cd335df06
Message-ID: <6009f27c.4aOOFTxf12T3vYTn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: e2f1899de97ba7e4c6bc2ae48e09d64cd335df06  Merge branch 'irq/urgent'

elapsed time: 731m

configs tested: 135
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       aspeed_g5_defconfig
powerpc                 mpc836x_mds_defconfig
mips                           jazz_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                     sbc8548_defconfig
mips                         tb0226_defconfig
sh                           sh2007_defconfig
openrisc                 simple_smp_defconfig
arm                          moxart_defconfig
powerpc                      acadia_defconfig
powerpc                       eiger_defconfig
arm                          pxa910_defconfig
m68k                        stmark2_defconfig
arm                        multi_v7_defconfig
powerpc                      chrp32_defconfig
sh                          rsk7203_defconfig
arm                           h3600_defconfig
m68k                        m5407c3_defconfig
sh                          sdk7786_defconfig
mips                           ip28_defconfig
sh                               j2_defconfig
arm                         vf610m4_defconfig
ia64                      gensparse_defconfig
parisc                generic-64bit_defconfig
ia64                          tiger_defconfig
mips                      maltaaprp_defconfig
h8300                       h8s-sim_defconfig
mips                        jmr3927_defconfig
mips                    maltaup_xpa_defconfig
sparc64                          alldefconfig
arm                         cm_x300_defconfig
mips                           ip27_defconfig
m68k                         amcore_defconfig
powerpc                     sequoia_defconfig
mips                          ath25_defconfig
arm                         orion5x_defconfig
c6x                         dsk6455_defconfig
powerpc                     pseries_defconfig
mips                           rs90_defconfig
mips                       bmips_be_defconfig
mips                       lemote2f_defconfig
sh                        edosk7705_defconfig
powerpc                     mpc5200_defconfig
powerpc                    mvme5100_defconfig
powerpc                        fsp2_defconfig
powerpc                      ppc44x_defconfig
arm                        spear6xx_defconfig
sh                          r7785rp_defconfig
powerpc                       holly_defconfig
s390                             alldefconfig
sh                  sh7785lcr_32bit_defconfig
mips                malta_kvm_guest_defconfig
arc                          axs101_defconfig
mips                        maltaup_defconfig
powerpc                   currituck_defconfig
powerpc                        cell_defconfig
sh                         ecovec24_defconfig
arm                           omap1_defconfig
arm                       spear13xx_defconfig
powerpc                 mpc8313_rdb_defconfig
sh                        edosk7760_defconfig
m68k                          atari_defconfig
arm                        cerfcube_defconfig
arm                          ixp4xx_defconfig
powerpc                     kmeter1_defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210121
x86_64               randconfig-a003-20210121
x86_64               randconfig-a001-20210121
x86_64               randconfig-a005-20210121
x86_64               randconfig-a006-20210121
x86_64               randconfig-a004-20210121
i386                 randconfig-a001-20210121
i386                 randconfig-a002-20210121
i386                 randconfig-a004-20210121
i386                 randconfig-a006-20210121
i386                 randconfig-a005-20210121
i386                 randconfig-a003-20210121
i386                 randconfig-a013-20210121
i386                 randconfig-a011-20210121
i386                 randconfig-a012-20210121
i386                 randconfig-a014-20210121
i386                 randconfig-a015-20210121
i386                 randconfig-a016-20210121
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
