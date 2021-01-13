Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6199A2F4B3E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 13:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbhAMM0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:26:08 -0500
Received: from mga09.intel.com ([134.134.136.24]:63581 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbhAMM0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:26:07 -0500
IronPort-SDR: axDOEIoqfkW3tneU7SVzRrfW0Uv+XpQVOiIaw0u0N11io+h3TZv6gAvwX3hII456Pqz2l90lLH
 DRQWXgrS8WOA==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="178341217"
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="178341217"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 04:25:25 -0800
IronPort-SDR: rISMRmg+ev1LjHKhloRX3c7W58lmgmb03fBF/sfXYfPUI2zPps1/uPMjXu9Wx7N+TKgWu826yp
 6i84Am5dJNLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="400524502"
Received: from lkp-server01.sh.intel.com (HELO d5d1a9a2c6bb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jan 2021 04:25:24 -0800
Received: from kbuild by d5d1a9a2c6bb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kzfDI-0000DZ-04; Wed, 13 Jan 2021 12:25:24 +0000
Date:   Wed, 13 Jan 2021 20:24:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS WITH WARNING
 f81f6edb74f27c5c8917d20a2bc128aca39aae11
Message-ID: <5ffee678.hGIGL5g5dXHl2qP9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: f81f6edb74f27c5c8917d20a2bc128aca39aae11  rcu: Remove spurious instrumentation_end() in rcu_nmi_enter()

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- h8300-randconfig-c003-20210112
|   `-- kernel-rcu-rcutorture.c:WARNING-kmalloc-is-used-to-allocate-this-memory-at-line
|-- i386-randconfig-c001-20210112
|   `-- kernel-rcu-rcutorture.c:WARNING-kmalloc-is-used-to-allocate-this-memory-at-line
`-- powerpc-randconfig-c004-20210112
    `-- kernel-rcu-rcutorture.c:WARNING-kmalloc-is-used-to-allocate-this-memory-at-line

elapsed time: 722m

configs tested: 164
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         shannon_defconfig
powerpc                       maple_defconfig
arm                              zx_defconfig
mips                            e55_defconfig
arm                       spear13xx_defconfig
arm                  colibri_pxa300_defconfig
sh                           se7206_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                   lite5200b_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                       lemote2f_defconfig
sh                      rts7751r2d1_defconfig
m68k                        m5272c3_defconfig
sh                            migor_defconfig
powerpc                        icon_defconfig
sh                               alldefconfig
mips                     cu1000-neo_defconfig
arm                       cns3420vb_defconfig
mips                 decstation_r4k_defconfig
arm                           corgi_defconfig
arm                     eseries_pxa_defconfig
ia64                          tiger_defconfig
powerpc                      pasemi_defconfig
mips                         bigsur_defconfig
mips                       rbtx49xx_defconfig
c6x                              alldefconfig
mips                     decstation_defconfig
sh                   sh7770_generic_defconfig
arm                            hisi_defconfig
c6x                        evmc6472_defconfig
microblaze                          defconfig
xtensa                  cadence_csp_defconfig
powerpc                    mvme5100_defconfig
m68k                         amcore_defconfig
mips                        bcm47xx_defconfig
mips                        workpad_defconfig
h8300                     edosk2674_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                           xway_defconfig
arc                           tb10x_defconfig
sh                           se7721_defconfig
arm                         axm55xx_defconfig
m68k                            q40_defconfig
arm                        mini2440_defconfig
powerpc                     tqm8560_defconfig
sh                         ecovec24_defconfig
c6x                        evmc6457_defconfig
arm                        mvebu_v7_defconfig
mips                      pistachio_defconfig
m68k                          multi_defconfig
s390                       zfcpdump_defconfig
xtensa                    smp_lx200_defconfig
h8300                    h8300h-sim_defconfig
arm                       multi_v4t_defconfig
arm                     davinci_all_defconfig
sh                          r7780mp_defconfig
arm                        keystone_defconfig
ia64                            zx1_defconfig
mips                      maltaaprp_defconfig
sh                           se7724_defconfig
sh                          urquell_defconfig
sparc                            alldefconfig
arm                        multi_v5_defconfig
powerpc                      pmac32_defconfig
powerpc                     ksi8560_defconfig
powerpc                    amigaone_defconfig
arc                     haps_hs_smp_defconfig
csky                                defconfig
um                            kunit_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                      mgcoge_defconfig
ia64                        generic_defconfig
powerpc                      bamboo_defconfig
arm                      pxa255-idp_defconfig
sh                           se7705_defconfig
parisc                              defconfig
m68k                        m5407c3_defconfig
m68k                          atari_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                        fsp2_defconfig
m68k                       m5275evb_defconfig
powerpc                      ppc44x_defconfig
arm                            qcom_defconfig
sh                ecovec24-romimage_defconfig
arm                          tango4_defconfig
mips                          ath25_defconfig
sh                           sh2007_defconfig
arm                         socfpga_defconfig
m68k                       m5249evb_defconfig
mips                  decstation_64_defconfig
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
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
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
x86_64               randconfig-a006-20210113
x86_64               randconfig-a004-20210113
x86_64               randconfig-a001-20210113
x86_64               randconfig-a005-20210113
x86_64               randconfig-a003-20210113
x86_64               randconfig-a002-20210113
i386                 randconfig-a002-20210113
i386                 randconfig-a005-20210113
i386                 randconfig-a006-20210113
i386                 randconfig-a003-20210113
i386                 randconfig-a001-20210113
i386                 randconfig-a004-20210113
i386                 randconfig-a012-20210113
i386                 randconfig-a011-20210113
i386                 randconfig-a016-20210113
i386                 randconfig-a013-20210113
i386                 randconfig-a015-20210113
i386                 randconfig-a014-20210113
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210113
x86_64               randconfig-a012-20210113
x86_64               randconfig-a013-20210113
x86_64               randconfig-a016-20210113
x86_64               randconfig-a014-20210113
x86_64               randconfig-a011-20210113

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
