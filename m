Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24087304DA1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 01:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732990AbhAZXMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 18:12:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:61983 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729222AbhAZEzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 23:55:02 -0500
IronPort-SDR: +H3ovHtZrGjTPN9o166katm0rqSj8RZOH0gGPBEnFC5/m/OX4KIWw79/xkp7u2crSdTGqxlfG+
 LhVbeBeP+YwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="264671985"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="264671985"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 20:52:03 -0800
IronPort-SDR: 6/kKNhFz8zpv5oTECVJKGEs6wfTMYlrprFmPHg5lvw75vQl22Jw7rFpxfnLAzoI/Af3m5tBo0h
 0UGYrhrRAlSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="387680554"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 25 Jan 2021 20:52:01 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l4GKe-0000Y9-T4; Tue, 26 Jan 2021 04:52:00 +0000
Date:   Tue, 26 Jan 2021 12:51:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:auto-latest] BUILD SUCCESS
 ab9e5c52d7dc6857e8613df317d2ae9d0250bef6
Message-ID: <600f9fb9.OvVX7R+P5jDc/Mh7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git auto-latest
branch HEAD: ab9e5c52d7dc6857e8613df317d2ae9d0250bef6  Merge branch 'locking/core'

elapsed time: 1644m

configs tested: 162
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                    adder875_defconfig
powerpc                      obs600_defconfig
mips                     decstation_defconfig
mips                          rm200_defconfig
mips                  decstation_64_defconfig
arm                       mainstone_defconfig
sh                           se7712_defconfig
arm                        keystone_defconfig
powerpc                     ksi8560_defconfig
sh                          rsk7201_defconfig
sh                           se7722_defconfig
powerpc               mpc834x_itxgp_defconfig
c6x                                 defconfig
sh                   sh7770_generic_defconfig
arm                          badge4_defconfig
sh                        sh7757lcr_defconfig
h8300                     edosk2674_defconfig
arm                         axm55xx_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                   bluestone_defconfig
riscv                             allnoconfig
arm                  colibri_pxa270_defconfig
mips                         db1xxx_defconfig
m68k                       m5249evb_defconfig
powerpc                          g5_defconfig
sh                           se7343_defconfig
powerpc                    klondike_defconfig
arm                         palmz72_defconfig
m68k                        stmark2_defconfig
mips                         rt305x_defconfig
powerpc                      arches_defconfig
mips                        omega2p_defconfig
mips                          ath25_defconfig
powerpc                     skiroot_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                     rainier_defconfig
arc                    vdk_hs38_smp_defconfig
mips                       capcella_defconfig
mips                            gpr_defconfig
s390                             allyesconfig
powerpc                       holly_defconfig
arm                            u300_defconfig
powerpc                     ppa8548_defconfig
nios2                               defconfig
powerpc                   motionpro_defconfig
i386                             alldefconfig
mips                  maltasmvp_eva_defconfig
arm                        realview_defconfig
h8300                               defconfig
powerpc                  iss476-smp_defconfig
sh                           se7705_defconfig
mips                  cavium_octeon_defconfig
powerpc                     tqm5200_defconfig
arm                          lpd270_defconfig
sh                 kfr2r09-romimage_defconfig
arm                            mmp2_defconfig
ia64                      gensparse_defconfig
arm                              alldefconfig
mips                   sb1250_swarm_defconfig
x86_64                              defconfig
powerpc                      acadia_defconfig
powerpc                      pmac32_defconfig
arm                           viper_defconfig
sh                               alldefconfig
sh                               j2_defconfig
mips                      pistachio_defconfig
openrisc                    or1ksim_defconfig
sh                          polaris_defconfig
arm                           corgi_defconfig
powerpc                      walnut_defconfig
arm                        mvebu_v7_defconfig
mips                         mpc30x_defconfig
powerpc                         ps3_defconfig
arm                  colibri_pxa300_defconfig
arm                     eseries_pxa_defconfig
sparc64                          alldefconfig
sh                        dreamcast_defconfig
xtensa                  cadence_csp_defconfig
arc                            hsdk_defconfig
powerpc                     mpc83xx_defconfig
arm                          imote2_defconfig
m68k                            q40_defconfig
mips                malta_qemu_32r6_defconfig
arm                        multi_v7_defconfig
m68k                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
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
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                             allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210125
x86_64               randconfig-a002-20210125
x86_64               randconfig-a001-20210125
x86_64               randconfig-a005-20210125
x86_64               randconfig-a006-20210125
x86_64               randconfig-a004-20210125
i386                 randconfig-a002-20210125
i386                 randconfig-a004-20210125
i386                 randconfig-a005-20210125
i386                 randconfig-a003-20210125
i386                 randconfig-a001-20210125
i386                 randconfig-a006-20210125
x86_64               randconfig-a012-20210126
x86_64               randconfig-a016-20210126
x86_64               randconfig-a015-20210126
x86_64               randconfig-a011-20210126
x86_64               randconfig-a013-20210126
x86_64               randconfig-a014-20210126
i386                 randconfig-a013-20210125
i386                 randconfig-a011-20210125
i386                 randconfig-a012-20210125
i386                 randconfig-a015-20210125
i386                 randconfig-a014-20210125
i386                 randconfig-a016-20210125
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20210125
x86_64               randconfig-a016-20210125
x86_64               randconfig-a015-20210125
x86_64               randconfig-a011-20210125
x86_64               randconfig-a013-20210125
x86_64               randconfig-a014-20210125

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
