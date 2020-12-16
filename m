Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5BA62DC0C7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgLPNIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:08:20 -0500
Received: from mga01.intel.com ([192.55.52.88]:48149 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgLPNIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:08:20 -0500
IronPort-SDR: LbEu3zOg+dwSZlfSfC7JGBA5UpOy2I/VEhTvxC2LTlQywquWXByAu3mDiY9YtUBjvtfA/8vLs/
 T6QviwIniLcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="193442218"
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="193442218"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 05:07:39 -0800
IronPort-SDR: jgGKXLwg6biaL4NO/8qwkfPmTOfdsRJ23dHp7/QFRmxbkyZivJICZwlF/xStbP6yWC0kpyHaXv
 OzfeBaNrllxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,424,1599548400"; 
   d="scan'208";a="384550844"
Received: from lkp-server02.sh.intel.com (HELO 070e1a605002) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 16 Dec 2020 05:07:38 -0800
Received: from kbuild by 070e1a605002 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kpWWn-00003D-G8; Wed, 16 Dec 2020 13:07:37 +0000
Date:   Wed, 16 Dec 2020 21:07:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2020.12.15a] BUILD SUCCESS WITH WARNING
 22a5aeecf105617107dc7f8ee4f6cb1231630a15
Message-ID: <5fda0682.EYAoGCbr77yWVAcw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  dev.2020.12.15a
branch HEAD: 22a5aeecf105617107dc7f8ee4f6cb1231630a15  tools/rcutorture: Support nocb toggle in TREE01

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- i386-randconfig-s032-20201215
    `-- kernel-rcu-tree_plugin.h:sparse:sparse:context-imbalance-in-__rcu_nocb_rdp_deoffload-wrong-count-at-exit

elapsed time: 721m

configs tested: 128
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7750_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                           se7751_defconfig
arm                            xcep_defconfig
arc                         haps_hs_defconfig
sh                           se7712_defconfig
powerpc                mpc7448_hpc2_defconfig
riscv                               defconfig
mips                            gpr_defconfig
powerpc                     tqm8560_defconfig
arm                            zeus_defconfig
xtensa                         virt_defconfig
powerpc                    klondike_defconfig
m68k                            mac_defconfig
mips                      maltasmvp_defconfig
sparc64                             defconfig
sparc                       sparc32_defconfig
mips                          ath79_defconfig
mips                        workpad_defconfig
s390                             alldefconfig
mips                           ip32_defconfig
s390                                defconfig
sh                           se7705_defconfig
arm                         ebsa110_defconfig
sh                          urquell_defconfig
powerpc                     redwood_defconfig
arm                            dove_defconfig
arm                           viper_defconfig
powerpc                       maple_defconfig
mips                           ip27_defconfig
nds32                             allnoconfig
arm64                            alldefconfig
arm                             ezx_defconfig
mips                        bcm47xx_defconfig
powerpc                      mgcoge_defconfig
sh                         apsh4a3a_defconfig
mips                malta_qemu_32r6_defconfig
m68k                       bvme6000_defconfig
arm                        cerfcube_defconfig
h8300                    h8300h-sim_defconfig
arm                     davinci_all_defconfig
x86_64                           allyesconfig
powerpc                      ppc64e_defconfig
arm                  colibri_pxa270_defconfig
arm                            mps2_defconfig
arm                       omap2plus_defconfig
powerpc                 mpc834x_itx_defconfig
sh                        sh7763rdp_defconfig
xtensa                          iss_defconfig
sh                           sh2007_defconfig
parisc                              defconfig
s390                             allyesconfig
sh                        dreamcast_defconfig
powerpc                 mpc85xx_cds_defconfig
m68k                        m5407c3_defconfig
sh                               j2_defconfig
parisc                generic-32bit_defconfig
mips                         tb0226_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
parisc                           allyesconfig
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
x86_64               randconfig-a003-20201215
x86_64               randconfig-a006-20201215
x86_64               randconfig-a002-20201215
x86_64               randconfig-a005-20201215
x86_64               randconfig-a004-20201215
x86_64               randconfig-a001-20201215
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                      rhel-8.3-kbuiltin

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
