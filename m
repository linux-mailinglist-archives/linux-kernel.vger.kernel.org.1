Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC8629E256
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgJ2CNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:13:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:6879 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgJ1VgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:36:16 -0400
IronPort-SDR: Bw8qPSuzUVpSoJ8FRSJzAuH/I5amgM+nVtIn6scFIrawRS+Tx5kTSBTQh2oauQf3/FGVJbVgVb
 iqG13OsJoMVA==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="164842237"
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="164842237"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 14:28:10 -0700
IronPort-SDR: LOIrS8VbJzCmdLh8YEm4AJWF22/IDmQJt3v7fi33ntNx83GTNF7LxRn4PO8l2zvDrPczegW9iA
 EWHazXOqpZrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="351166365"
Received: from lkp-server02.sh.intel.com (HELO 0471ce7c9af6) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 28 Oct 2020 14:28:09 -0700
Received: from kbuild by 0471ce7c9af6 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kXszI-0000BU-HC; Wed, 28 Oct 2020 21:28:08 +0000
Date:   Thu, 29 Oct 2020 05:27:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 6f72faf4a32303c8bdc6491186b79391e9cf0c7e
Message-ID: <5f99e242.JELr6vOyrcFDJ+sy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 6f72faf4a32303c8bdc6491186b79391e9cf0c7e  Merge branch 'locking/urgent'

elapsed time: 721m

configs tested: 94
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                         apollo_defconfig
powerpc                       ebony_defconfig
mips                        jmr3927_defconfig
powerpc                     stx_gp3_defconfig
xtensa                  nommu_kc705_defconfig
arm                         lpc18xx_defconfig
sh                ecovec24-romimage_defconfig
arm                       cns3420vb_defconfig
arm                        mvebu_v7_defconfig
powerpc                      ppc44x_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                   motionpro_defconfig
mips                           gcw0_defconfig
powerpc                 mpc8272_ads_defconfig
sh                          r7780mp_defconfig
mips                            ar7_defconfig
mips                           ip22_defconfig
mips                  maltasmvp_eva_defconfig
mips                      bmips_stb_defconfig
powerpc                 canyonlands_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                 randconfig-a002-20201026
i386                 randconfig-a003-20201026
i386                 randconfig-a005-20201026
i386                 randconfig-a001-20201026
i386                 randconfig-a006-20201026
i386                 randconfig-a004-20201026
x86_64               randconfig-a011-20201028
x86_64               randconfig-a013-20201028
x86_64               randconfig-a016-20201028
x86_64               randconfig-a015-20201028
x86_64               randconfig-a012-20201028
x86_64               randconfig-a014-20201028
i386                 randconfig-a016-20201028
i386                 randconfig-a014-20201028
i386                 randconfig-a015-20201028
i386                 randconfig-a013-20201028
i386                 randconfig-a012-20201028
i386                 randconfig-a011-20201028
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
x86_64               randconfig-a001-20201028
x86_64               randconfig-a002-20201028
x86_64               randconfig-a003-20201028
x86_64               randconfig-a006-20201028
x86_64               randconfig-a005-20201028
x86_64               randconfig-a004-20201028

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
