Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCFB2D386B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 02:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgLIBv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 20:51:26 -0500
Received: from mga04.intel.com ([192.55.52.120]:63607 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbgLIBvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 20:51:25 -0500
IronPort-SDR: WhCsNp1SlJJ6vFnbi96Imf0ye3Yx/7nTdGxS42sFZOcdhoLlqr57u66ToqZxap2krrPk/peaWr
 2R3FyUh0f5Vg==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="171430553"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="171430553"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 17:50:45 -0800
IronPort-SDR: adVCmc0/DLKgje21CiV9OnQPq3qriqkFrEJaCtpF81oiZsGqWWM6U4klPnLQrItq1wNBhNsdoQ
 sqN2VO+7eTrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="375363584"
Received: from lkp-server01.sh.intel.com (HELO 4e633a5ce5ea) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 08 Dec 2020 17:50:43 -0800
Received: from kbuild by 4e633a5ce5ea with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kmoct-00004Q-66; Wed, 09 Dec 2020 01:50:43 +0000
Date:   Wed, 09 Dec 2020 09:50:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 d55863db1dfec8845067f5625f1b0ab18c8948be
Message-ID: <5fd02d5b.jCWi6BNuwqivoIs4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  perf/core
branch HEAD: d55863db1dfec8845067f5625f1b0ab18c8948be  arm64/mm: Implement pXX_leaf_size() support

elapsed time: 722m

configs tested: 93
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
mips                         tb0287_defconfig
xtensa                         virt_defconfig
powerpc                     tqm5200_defconfig
mips                          ath79_defconfig
sh                         apsh4a3a_defconfig
mips                      bmips_stb_defconfig
arm                          ep93xx_defconfig
mips                  decstation_64_defconfig
arm                           corgi_defconfig
c6x                        evmc6678_defconfig
m68k                         apollo_defconfig
powerpc                     ep8248e_defconfig
sh                           se7343_defconfig
arm                            qcom_defconfig
powerpc                      mgcoge_defconfig
sh                             espt_defconfig
mips                        maltaup_defconfig
m68k                          sun3x_defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20201208
x86_64               randconfig-a006-20201208
x86_64               randconfig-a005-20201208
x86_64               randconfig-a001-20201208
x86_64               randconfig-a002-20201208
x86_64               randconfig-a003-20201208
i386                 randconfig-a004-20201208
i386                 randconfig-a005-20201208
i386                 randconfig-a001-20201208
i386                 randconfig-a002-20201208
i386                 randconfig-a006-20201208
i386                 randconfig-a003-20201208
i386                 randconfig-a013-20201208
i386                 randconfig-a014-20201208
i386                 randconfig-a011-20201208
i386                 randconfig-a015-20201208
i386                 randconfig-a012-20201208
i386                 randconfig-a016-20201208
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
x86_64               randconfig-a016-20201208
x86_64               randconfig-a012-20201208
x86_64               randconfig-a013-20201208
x86_64               randconfig-a014-20201208
x86_64               randconfig-a015-20201208
x86_64               randconfig-a011-20201208

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
