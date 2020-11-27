Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06EF2C603E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 08:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392592AbgK0G7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 01:59:40 -0500
Received: from mga12.intel.com ([192.55.52.136]:27822 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387932AbgK0G7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 01:59:39 -0500
IronPort-SDR: odULs7zRf6ovA5RduRj8A+FQjYsz5yyVd2Uj/7nkniXEABmLWkKNWjCVOfxbQq0PuWcO1vJXti
 DZtEnF+l+xpQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9817"; a="151615635"
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; 
   d="scan'208";a="151615635"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 22:59:39 -0800
IronPort-SDR: Abt2sdJrscM+d9WMzLbQguH+4R3UUC6CZlBCD8dVKI+58xXp3IFhq1nQYH0Kq30D2Dtfhyk5V6
 hRTA8fVXSrEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; 
   d="scan'208";a="359727285"
Received: from lkp-server02.sh.intel.com (HELO c88ef3cb410b) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 26 Nov 2020 22:59:37 -0800
Received: from kbuild by c88ef3cb410b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kiXjF-00000j-5t; Fri, 27 Nov 2020 06:59:37 +0000
Date:   Fri, 27 Nov 2020 14:58:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/platform] BUILD SUCCESS
 caf371103ea17de58251714131b06682d86b0df8
Message-ID: <5fc0a3ac.IgzkX0XZ9KtTl+4P%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/platform
branch HEAD: caf371103ea17de58251714131b06682d86b0df8  x86/platform/uv: Update MAINTAINERS for uv_sysfs driver

elapsed time: 762m

configs tested: 142
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
h8300                       h8s-sim_defconfig
powerpc                 mpc834x_itx_defconfig
sh                          rsk7203_defconfig
arm                         lubbock_defconfig
sparc                       sparc32_defconfig
powerpc                 mpc837x_mds_defconfig
arc                          axs101_defconfig
mips                      pic32mzda_defconfig
arm                       imx_v6_v7_defconfig
powerpc64                        alldefconfig
sh                   sh7724_generic_defconfig
m68k                        m5307c3_defconfig
csky                             alldefconfig
xtensa                          iss_defconfig
sh                                  defconfig
arm                        clps711x_defconfig
mips                          ath25_defconfig
powerpc                 mpc8315_rdb_defconfig
arc                              allyesconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                     mpc83xx_defconfig
arm                           viper_defconfig
s390                                defconfig
sh                         ap325rxa_defconfig
powerpc                      pasemi_defconfig
mips                         bigsur_defconfig
mips                        omega2p_defconfig
xtensa                       common_defconfig
powerpc                     kilauea_defconfig
arm                           corgi_defconfig
sh                            titan_defconfig
mips                   sb1250_swarm_defconfig
arm                          moxart_defconfig
sh                               alldefconfig
powerpc                 mpc8272_ads_defconfig
arm                            dove_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                     mpc5200_defconfig
powerpc                      chrp32_defconfig
arm                      tct_hammer_defconfig
powerpc                     rainier_defconfig
m68k                        mvme147_defconfig
mips                         tb0219_defconfig
powerpc                     tqm8555_defconfig
mips                    maltaup_xpa_defconfig
mips                        bcm47xx_defconfig
c6x                                 defconfig
powerpc                      katmai_defconfig
arm                         assabet_defconfig
c6x                        evmc6474_defconfig
mips                        nlm_xlp_defconfig
mips                           ip28_defconfig
powerpc                       eiger_defconfig
powerpc                      ppc44x_defconfig
mips                         tb0287_defconfig
nios2                         10m50_defconfig
mips                         db1xxx_defconfig
sparc                               defconfig
mips                            gpr_defconfig
arm                              alldefconfig
powerpc                  mpc885_ads_defconfig
sh                         microdev_defconfig
arm                          tango4_defconfig
arc                          axs103_defconfig
mips                     decstation_defconfig
arc                            hsdk_defconfig
powerpc                      ppc40x_defconfig
sh                        dreamcast_defconfig
arm                       spear13xx_defconfig
um                            kunit_defconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
nios2                               defconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201127
i386                 randconfig-a003-20201127
i386                 randconfig-a002-20201127
i386                 randconfig-a005-20201127
i386                 randconfig-a001-20201127
i386                 randconfig-a006-20201127
x86_64               randconfig-a011-20201127
x86_64               randconfig-a012-20201127
x86_64               randconfig-a013-20201127
x86_64               randconfig-a015-20201127
x86_64               randconfig-a014-20201127
x86_64               randconfig-a016-20201127
i386                 randconfig-a012-20201127
i386                 randconfig-a013-20201127
i386                 randconfig-a011-20201127
i386                 randconfig-a016-20201127
i386                 randconfig-a014-20201127
i386                 randconfig-a015-20201127
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20201127
x86_64               randconfig-a003-20201127
x86_64               randconfig-a004-20201127
x86_64               randconfig-a005-20201127
x86_64               randconfig-a002-20201127
x86_64               randconfig-a001-20201127

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
