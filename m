Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A98284B45
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 14:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgJFMER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 08:04:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:60846 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgJFMER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 08:04:17 -0400
IronPort-SDR: INIBaHzGf7Kxn1fJfX6CugVg+TzExJkpJKZjrQVKegkxQNCGW+3vaZtfU9D0mNoQECWbTCRi6m
 DtWC3tiGySQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="228596635"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="228596635"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 05:04:16 -0700
IronPort-SDR: pQwxmgfV5hZ96xl9jYVk97PHY5Ri9Ha8tKIH7Ay1QaSyTMfW/zWWfTLUXMkKDpr0gT2ySoLaIA
 mAsANkV6YCJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="348434232"
Received: from lkp-server02.sh.intel.com (HELO b5ae2f167493) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 06 Oct 2020 05:04:14 -0700
Received: from kbuild by b5ae2f167493 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kPlhW-0001BQ-6H; Tue, 06 Oct 2020 12:04:14 +0000
Date:   Tue, 06 Oct 2020 20:04:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/drm/amd/pm/phm_samu_clock] BUILD
 SUCCESS c08b7456c0aed2045d90265baeabeb3cc3dfd752
Message-ID: <5f7c5d3a.ryM4GmZr3e0JeZy+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  testing/drm/amd/pm/phm_samu_clock
branch HEAD: c08b7456c0aed2045d90265baeabeb3cc3dfd752  drm/amd/pm: Replace one-element array with flexible-array in struct phm_samu_clock_voltage_dependency_table

elapsed time: 724m

configs tested: 99
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                                  defconfig
arm                             mxs_defconfig
mips                          malta_defconfig
arm                         assabet_defconfig
arm                          collie_defconfig
mips                           ci20_defconfig
mips                           rs90_defconfig
arm                          exynos_defconfig
mips                          ath79_defconfig
arm                          pxa168_defconfig
m68k                            q40_defconfig
sh                          r7780mp_defconfig
sparc                               defconfig
sparc64                             defconfig
sh                           se7722_defconfig
sh                   secureedge5410_defconfig
m68k                        m5272c3_defconfig
powerpc                 mpc85xx_cds_defconfig
ia64                             allmodconfig
mips                        jmr3927_defconfig
arm                         vf610m4_defconfig
mips                          ath25_defconfig
powerpc                 canyonlands_defconfig
arm                             pxa_defconfig
sh                         ap325rxa_defconfig
powerpc                     powernv_defconfig
mips                     loongson1c_defconfig
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
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201005
i386                 randconfig-a005-20201005
i386                 randconfig-a001-20201005
i386                 randconfig-a004-20201005
i386                 randconfig-a003-20201005
i386                 randconfig-a002-20201005
x86_64               randconfig-a012-20201005
x86_64               randconfig-a015-20201005
x86_64               randconfig-a014-20201005
x86_64               randconfig-a013-20201005
x86_64               randconfig-a011-20201005
x86_64               randconfig-a016-20201005
i386                 randconfig-a014-20201005
i386                 randconfig-a015-20201005
i386                 randconfig-a013-20201005
i386                 randconfig-a016-20201005
i386                 randconfig-a011-20201005
i386                 randconfig-a012-20201005
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
x86_64               randconfig-a004-20201005
x86_64               randconfig-a002-20201005
x86_64               randconfig-a001-20201005
x86_64               randconfig-a003-20201005
x86_64               randconfig-a005-20201005
x86_64               randconfig-a006-20201005

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
