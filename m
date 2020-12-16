Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7410E2DBAE0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 06:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgLPFy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 00:54:59 -0500
Received: from mga18.intel.com ([134.134.136.126]:29525 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725274AbgLPFy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 00:54:59 -0500
IronPort-SDR: rgE91HC20ZY2paODOHxMtEuxck8DizA0UcSK7GRLOyKVLSopXtSMwbII+0KHpL8L+HR4yTmAsJ
 Z9m9wKmrUUKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="162756295"
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="162756295"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 21:54:17 -0800
IronPort-SDR: cuPKbCiHyfNmoyUKXqVQJcH80Lf/zOB0NsJR/rpDIdREJJ2H+H7G0Oe7CmQJg0uJrfsM/DhEER
 XN1r8ryfwVug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,423,1599548400"; 
   d="scan'208";a="384170710"
Received: from lkp-server02.sh.intel.com (HELO a947d92d0467) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 15 Dec 2020 21:54:16 -0800
Received: from kbuild by a947d92d0467 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kpPlP-0001Aq-Qn; Wed, 16 Dec 2020 05:54:15 +0000
Date:   Wed, 16 Dec 2020 13:54:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/urgent] BUILD SUCCESS
 1b04fa9900263b4e217ca2509fd778b32c2b4eb2
Message-ID: <5fd9a0fe.sYRiw6QQOO/dWUK0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/urgent
branch HEAD: 1b04fa9900263b4e217ca2509fd778b32c2b4eb2  rcu-tasks: Move RCU-tasks initialization to before early_initcall()

elapsed time: 723m

configs tested: 151
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
sh                                  defconfig
ia64                        generic_defconfig
arm                             ezx_defconfig
mips                   sb1250_swarm_defconfig
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
powerpc                     sbc8548_defconfig
powerpc                       holly_defconfig
powerpc                     skiroot_defconfig
alpha                            alldefconfig
mips                           mtx1_defconfig
powerpc                     taishan_defconfig
mips                          rb532_defconfig
mips                      loongson3_defconfig
powerpc                     mpc512x_defconfig
powerpc                       eiger_defconfig
arm                            u300_defconfig
arm                        neponset_defconfig
powerpc                 mpc834x_mds_defconfig
riscv                            allmodconfig
arm                             pxa_defconfig
sh                          urquell_defconfig
mips                         bigsur_defconfig
mips                          ath79_defconfig
mips                        vocore2_defconfig
arm                        multi_v7_defconfig
xtensa                    xip_kc705_defconfig
sh                           se7724_defconfig
arm                            lart_defconfig
um                             i386_defconfig
ia64                         bigsur_defconfig
powerpc                 mpc85xx_cds_defconfig
i386                             alldefconfig
arm                         ebsa110_defconfig
powerpc                     pq2fads_defconfig
mips                        omega2p_defconfig
arm                      footbridge_defconfig
mips                           ci20_defconfig
arm                        clps711x_defconfig
powerpc                     ep8248e_defconfig
arm                       netwinder_defconfig
arm                           h5000_defconfig
powerpc                     kmeter1_defconfig
arm                      integrator_defconfig
h8300                     edosk2674_defconfig
arm                          moxart_defconfig
arc                                 defconfig
powerpc                 mpc8315_rdb_defconfig
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
parisc                              defconfig
s390                             allyesconfig
sh                        dreamcast_defconfig
m68k                          hp300_defconfig
powerpc                      arches_defconfig
arm                        magician_defconfig
openrisc                    or1ksim_defconfig
m68k                        m5407c3_defconfig
sh                               j2_defconfig
parisc                generic-32bit_defconfig
alpha                            allyesconfig
mips                         tb0226_defconfig
powerpc                 mpc832x_mds_defconfig
arm                           u8500_defconfig
powerpc                     tqm8560_defconfig
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
powerpc                           allnoconfig
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
