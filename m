Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCFB29D415
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgJ1VtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:49:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:26090 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbgJ1VlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:41:13 -0400
IronPort-SDR: OpC4szz3fHAuD8pqrlHm2exBowQGMMVKZjODEOpn4TCCu55iARHyZz+2+fXx/Z+CEn1oIQyi0I
 FuSKl+K2YnFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="253001487"
X-IronPort-AV: E=Sophos;i="5.77,427,1596524400"; 
   d="scan'208";a="253001487"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 10:37:48 -0700
IronPort-SDR: 6mWnxPAaYOYZ8LJrZSU6NcUbtvGqv6Ftcd9juQdx88HDPXam0oa1RQXzJknkeTsP1sdk8cI5dL
 oUs/+WZa56IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,427,1596524400"; 
   d="scan'208";a="323414392"
Received: from lkp-server02.sh.intel.com (HELO 0471ce7c9af6) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 28 Oct 2020 10:37:47 -0700
Received: from kbuild by 0471ce7c9af6 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kXpOM-00006k-Ts; Wed, 28 Oct 2020 17:37:46 +0000
Date:   Thu, 29 Oct 2020 01:37:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/uapi/ipv4] BUILD SUCCESS
 fcf5365d0c33dedef4d17e545bfa45099ec6c8b7
Message-ID: <5f99ac66.iufpyv3IjodJo6da%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git  testing/uapi/ipv4
branch HEAD: fcf5365d0c33dedef4d17e545bfa45099ec6c8b7  net: ipv4: Replace one-element array with flexible-array member

elapsed time: 720m

configs tested: 108
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                    nommu_k210_defconfig
nds32                             allnoconfig
powerpc                     tqm8555_defconfig
mips                        bcm47xx_defconfig
sh                     sh7710voipgw_defconfig
m68k                         apollo_defconfig
powerpc                       ebony_defconfig
mips                        jmr3927_defconfig
powerpc                     stx_gp3_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                  mpc866_ads_defconfig
arm                         at91_dt_defconfig
powerpc                     pseries_defconfig
arm                        magician_defconfig
arm                           efm32_defconfig
sh                         apsh4a3a_defconfig
powerpc                      arches_defconfig
arm                         s5pv210_defconfig
arm                          pxa168_defconfig
mips                      maltaaprp_defconfig
h8300                       h8s-sim_defconfig
powerpc                      pasemi_defconfig
mips                         bigsur_defconfig
xtensa                    smp_lx200_defconfig
arm                          exynos_defconfig
xtensa                           allyesconfig
sh                          rsk7264_defconfig
arm                         vf610m4_defconfig
nds32                            alldefconfig
um                           x86_64_defconfig
arm                      tct_hammer_defconfig
arm                              zx_defconfig
mips                       bmips_be_defconfig
arm                           viper_defconfig
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
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20201028
i386                 randconfig-a005-20201028
i386                 randconfig-a003-20201028
i386                 randconfig-a001-20201028
i386                 randconfig-a004-20201028
i386                 randconfig-a006-20201028
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
