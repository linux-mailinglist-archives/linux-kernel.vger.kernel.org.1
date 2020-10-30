Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACC72A0582
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 13:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgJ3MeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 08:34:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:52812 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgJ3MeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 08:34:16 -0400
IronPort-SDR: 15RDWgYcRM+7WseqXgC+YICIsEb+1wMC2sIhITfqCJaSF4ekybA6UdDWfoWgyLn8e0Q5VyVmOT
 EEc9H6+ARoBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="186404738"
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="186404738"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 05:34:16 -0700
IronPort-SDR: 8ndeOHPXP/p2j7jyqdebHIOVZANShPLPqsgfyhKI8zvHnHWW/bp7Z1z/Eo5yahtVwntVX5uWDj
 OtqgKUHJk/qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="537051199"
Received: from lkp-server02.sh.intel.com (HELO fcc9f8859912) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 30 Oct 2020 05:34:14 -0700
Received: from kbuild by fcc9f8859912 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kYTbi-00008U-72; Fri, 30 Oct 2020 12:34:14 +0000
Date:   Fri, 30 Oct 2020 20:33:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:for-linus/kspp-fam0] BUILD SUCCESS
 8fdaabe1c9b3226172ba2e9e525627219be6d29a
Message-ID: <5f9c080d.ZKRe5hf67vhcPxCp%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  for-linus/kspp-fam0
branch HEAD: 8fdaabe1c9b3226172ba2e9e525627219be6d29a  scsi: target: tcmu: Replace zero-length array with flexible-array member

elapsed time: 720m

configs tested: 133
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
h8300                     edosk2674_defconfig
powerpc                    klondike_defconfig
sh                             espt_defconfig
m68k                         amcore_defconfig
arm                         s3c2410_defconfig
sh                          rsk7203_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                        omega2p_defconfig
powerpc                     pseries_defconfig
arc                        nsim_700_defconfig
microblaze                          defconfig
h8300                       h8s-sim_defconfig
powerpc                    socrates_defconfig
mips                      pistachio_defconfig
sh                           se7619_defconfig
mips                         cobalt_defconfig
arm                            pleb_defconfig
sh                           se7712_defconfig
sparc                       sparc64_defconfig
sh                           se7780_defconfig
powerpc                      pcm030_defconfig
m68k                          amiga_defconfig
m68k                       m5249evb_defconfig
powerpc                     sbc8548_defconfig
mips                  decstation_64_defconfig
sh                      rts7751r2d1_defconfig
powerpc                     sequoia_defconfig
powerpc                     tqm8555_defconfig
arm                     am200epdkit_defconfig
arm                          badge4_defconfig
h8300                               defconfig
mips                        qi_lb60_defconfig
sh                              ul2_defconfig
um                            kunit_defconfig
openrisc                    or1ksim_defconfig
arm                              alldefconfig
arm                             pxa_defconfig
powerpc                      chrp32_defconfig
mips                           ip27_defconfig
arm                          gemini_defconfig
sh                           se7751_defconfig
c6x                        evmc6472_defconfig
arm                           corgi_defconfig
sh                          kfr2r09_defconfig
arm                      tct_hammer_defconfig
xtensa                  audio_kc705_defconfig
mips                      maltaaprp_defconfig
nds32                               defconfig
powerpc                        warp_defconfig
sh                     sh7710voipgw_defconfig
mips                 decstation_r4k_defconfig
powerpc                 mpc8315_rdb_defconfig
openrisc                         alldefconfig
powerpc                      walnut_defconfig
arm                        mini2440_defconfig
powerpc                 mpc837x_mds_defconfig
arm                        clps711x_defconfig
riscv                            allyesconfig
powerpc                      cm5200_defconfig
mips                           rs90_defconfig
arm                        neponset_defconfig
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
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
parisc                              defconfig
s390                                defconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20201030
x86_64               randconfig-a001-20201030
x86_64               randconfig-a002-20201030
x86_64               randconfig-a003-20201030
x86_64               randconfig-a006-20201030
x86_64               randconfig-a004-20201030
i386                 randconfig-a005-20201030
i386                 randconfig-a003-20201030
i386                 randconfig-a002-20201030
i386                 randconfig-a001-20201030
i386                 randconfig-a006-20201030
i386                 randconfig-a004-20201030
i386                 randconfig-a011-20201030
i386                 randconfig-a014-20201030
i386                 randconfig-a015-20201030
i386                 randconfig-a012-20201030
i386                 randconfig-a013-20201030
i386                 randconfig-a016-20201030
riscv                    nommu_k210_defconfig
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
x86_64               randconfig-a013-20201030
x86_64               randconfig-a014-20201030
x86_64               randconfig-a015-20201030
x86_64               randconfig-a016-20201030
x86_64               randconfig-a011-20201030
x86_64               randconfig-a012-20201030

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
