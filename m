Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAEA29551C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 01:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507112AbgJUX2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 19:28:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:23105 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441767AbgJUX2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 19:28:10 -0400
IronPort-SDR: RTim1nK+bc8XspSPjZ86/Zqs7bGjLT2w9TDp3u/3oMGPNzh+8n347+7In8vt0KPis74e5nafVU
 cKBwjIZvY8Ow==
X-IronPort-AV: E=McAfee;i="6000,8403,9781"; a="147306895"
X-IronPort-AV: E=Sophos;i="5.77,402,1596524400"; 
   d="scan'208";a="147306895"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 16:28:07 -0700
IronPort-SDR: HfLePLKe07bd9w9IIzhIED8lDby044hjHdXBHc0i3qA/5TQYKkUvN1i0TsiSgoNqQNbe3HI07G
 lf5n1KRqDRkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,402,1596524400"; 
   d="scan'208";a="422950812"
Received: from lkp-server02.sh.intel.com (HELO 911c2f167757) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 21 Oct 2020 16:28:06 -0700
Received: from kbuild by 911c2f167757 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kVNWX-0000BO-Hb; Wed, 21 Oct 2020 23:28:05 +0000
Date:   Thu, 22 Oct 2020 07:27:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 2ee263eb855963c3ce8d04191c8a92e13e6096f2
Message-ID: <5f90c3e1.FnD/NXlxFVR6Njgf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 2ee263eb855963c3ce8d04191c8a92e13e6096f2  Merge branch 'perf/urgent'

elapsed time: 725m

configs tested: 121
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nds32                            alldefconfig
m68k                          hp300_defconfig
arm                            lart_defconfig
ia64                      gensparse_defconfig
arm                          pxa168_defconfig
powerpc                      pcm030_defconfig
powerpc                        fsp2_defconfig
riscv                               defconfig
powerpc                     kilauea_defconfig
arc                        nsimosci_defconfig
powerpc                     tqm8541_defconfig
c6x                                 defconfig
sparc                            alldefconfig
sh                           sh2007_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     mpc5200_defconfig
nios2                            alldefconfig
powerpc                 mpc8540_ads_defconfig
powerpc                     ppa8548_defconfig
mips                         tb0287_defconfig
sh                          r7785rp_defconfig
arm                         palmz72_defconfig
powerpc                     stx_gp3_defconfig
mips                      maltasmvp_defconfig
powerpc                 mpc834x_itx_defconfig
sparc64                             defconfig
powerpc                     taishan_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                         ecovec24_defconfig
um                            kunit_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                  mpc866_ads_defconfig
sh                          urquell_defconfig
arm                          gemini_defconfig
alpha                               defconfig
powerpc                     tqm8548_defconfig
arm                            qcom_defconfig
powerpc                 mpc8560_ads_defconfig
arm                        neponset_defconfig
sh                             sh03_defconfig
powerpc                          g5_defconfig
m68k                        m5272c3_defconfig
xtensa                           alldefconfig
powerpc                     ksi8560_defconfig
mips                           ip27_defconfig
m68k                            mac_defconfig
mips                         tb0226_defconfig
microblaze                      mmu_defconfig
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
x86_64               randconfig-a001-20201021
x86_64               randconfig-a002-20201021
x86_64               randconfig-a003-20201021
x86_64               randconfig-a006-20201021
x86_64               randconfig-a005-20201021
x86_64               randconfig-a004-20201021
i386                 randconfig-a002-20201021
i386                 randconfig-a005-20201021
i386                 randconfig-a003-20201021
i386                 randconfig-a001-20201021
i386                 randconfig-a006-20201021
i386                 randconfig-a004-20201021
i386                 randconfig-a016-20201021
i386                 randconfig-a014-20201021
i386                 randconfig-a015-20201021
i386                 randconfig-a013-20201021
i386                 randconfig-a012-20201021
i386                 randconfig-a011-20201021
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20201021
x86_64               randconfig-a013-20201021
x86_64               randconfig-a016-20201021
x86_64               randconfig-a015-20201021
x86_64               randconfig-a012-20201021
x86_64               randconfig-a014-20201021

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
