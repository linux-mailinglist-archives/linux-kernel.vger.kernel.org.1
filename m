Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9FDC29E165
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgJ2CAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:00:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:8640 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728154AbgJ2CAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 22:00:45 -0400
IronPort-SDR: u+1gxMzAhiC3RV/DZwT9EZY5xukIUbzfFVNupoY5Jh37p+YfvgtP8wshe+osFkgRZrCFfgTi/R
 gf06lIrAUKjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="167584496"
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="167584496"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 19:00:44 -0700
IronPort-SDR: XxFghTyA6w8QDfZr+xwlqacxftlr9aeB+qLNteqaBZ9XbJojHNCj03uVZ3Ao1XHL2D373STQj+
 43meZYHGJhuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,428,1596524400"; 
   d="scan'208";a="536474458"
Received: from lkp-server02.sh.intel.com (HELO 0471ce7c9af6) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 28 Oct 2020 19:00:43 -0700
Received: from kbuild by 0471ce7c9af6 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kXxF4-0000JZ-Eh; Thu, 29 Oct 2020 02:00:42 +0000
Date:   Thu, 29 Oct 2020 09:59:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 1fcd009102ee02e217f2e7635ab65517d785da8e
Message-ID: <5f9a221b.ctytuLBG2npby998%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/mm
branch HEAD: 1fcd009102ee02e217f2e7635ab65517d785da8e  x86/mm/ident_map: Check for errors from ident_pud_init()

elapsed time: 726m

configs tested: 105
configs skipped: 58

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                    socrates_defconfig
powerpc64                           defconfig
arm                         nhk8815_defconfig
arm                          pxa3xx_defconfig
ia64                                defconfig
arm                          prima2_defconfig
ia64                        generic_defconfig
mips                          malta_defconfig
sh                          lboxre2_defconfig
powerpc                     mpc5200_defconfig
powerpc                      chrp32_defconfig
arc                     haps_hs_smp_defconfig
m68k                       m5249evb_defconfig
arm                           tegra_defconfig
powerpc                 mpc834x_mds_defconfig
sh                           se7206_defconfig
mips                          rb532_defconfig
sh                           se7343_defconfig
powerpc                      walnut_defconfig
mips                     decstation_defconfig
m68k                        m5407c3_defconfig
mips                            gpr_defconfig
arc                          axs103_defconfig
sh                               j2_defconfig
mips                            e55_defconfig
ia64                      gensparse_defconfig
microblaze                          defconfig
arm                        multi_v7_defconfig
arm                            zeus_defconfig
sh                          rsk7264_defconfig
powerpc                    klondike_defconfig
arm                          pxa168_defconfig
riscv                    nommu_virt_defconfig
ia64                             allmodconfig
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
i386                                defconfig
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
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
