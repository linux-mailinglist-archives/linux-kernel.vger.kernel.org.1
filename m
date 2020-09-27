Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C24279DB0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 05:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbgI0DRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 23:17:01 -0400
Received: from mga02.intel.com ([134.134.136.20]:39352 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgI0DRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 23:17:01 -0400
IronPort-SDR: P+Pt6ptW9laexv7cYR4V2K076H9M7pk6XAqOI8aUrvfu3AP5SUoG1IwnbHwYpzkPvXlg7jI+0j
 xoeyzTgh5wNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9756"; a="149493636"
X-IronPort-AV: E=Sophos;i="5.77,308,1596524400"; 
   d="scan'208";a="149493636"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2020 20:17:00 -0700
IronPort-SDR: 5SBKAul5jDuwdEWWy5/Vwx9BDIJFRkCKpvN3sTzqDJFrDZfy+OjAhQrLhIx3yg6LRVGXBDqmGN
 SjO2iDFL3oQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,308,1596524400"; 
   d="scan'208";a="311356186"
Received: from lkp-server01.sh.intel.com (HELO 2dda29302fe3) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Sep 2020 20:16:58 -0700
Received: from kbuild by 2dda29302fe3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kMNBK-0000fC-7d; Sun, 27 Sep 2020 03:16:58 +0000
Date:   Sun, 27 Sep 2020 11:16:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:master] BUILD SUCCESS
 6beb1792a233851a1ee0e555e9395909ed3ae7e9
Message-ID: <5f700423.2besPXm981e4o2TF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  master
branch HEAD: 6beb1792a233851a1ee0e555e9395909ed3ae7e9  Merge branch 'rtt-speedup.2020.09.16a' into HEAD

elapsed time: 721m

configs tested: 190
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      pcm030_defconfig
powerpc                       holly_defconfig
mips                       rbtx49xx_defconfig
powerpc                      pmac32_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                       maple_defconfig
arm                       imx_v4_v5_defconfig
openrisc                         alldefconfig
sh                           se7724_defconfig
powerpc                      cm5200_defconfig
powerpc                         ps3_defconfig
powerpc                     akebono_defconfig
powerpc                  mpc866_ads_defconfig
arc                        vdk_hs38_defconfig
mips                        nlm_xlp_defconfig
sh                          rsk7264_defconfig
sh                          sdk7786_defconfig
mips                    maltaup_xpa_defconfig
arm                         lpc32xx_defconfig
powerpc                     tqm8548_defconfig
arc                          axs101_defconfig
mips                  maltasmvp_eva_defconfig
s390                             allyesconfig
powerpc                       ppc64_defconfig
powerpc                     sequoia_defconfig
mips                           ip28_defconfig
m68k                        m5407c3_defconfig
arm                              zx_defconfig
powerpc                          g5_defconfig
csky                             alldefconfig
microblaze                    nommu_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                        omega2p_defconfig
c6x                         dsk6455_defconfig
arm                          collie_defconfig
powerpc                        icon_defconfig
mips                        bcm63xx_defconfig
arm                         axm55xx_defconfig
arm                        spear6xx_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                            lart_defconfig
arm                          pxa3xx_defconfig
arm                            qcom_defconfig
arm                           corgi_defconfig
arm                      tct_hammer_defconfig
powerpc                     rainier_defconfig
mips                         tb0226_defconfig
sh                            hp6xx_defconfig
powerpc                      tqm8xx_defconfig
powerpc                      chrp32_defconfig
mips                             allyesconfig
arm                         lubbock_defconfig
arm                            u300_defconfig
sh                          urquell_defconfig
powerpc                 mpc8540_ads_defconfig
riscv                             allnoconfig
powerpc                     kilauea_defconfig
powerpc               mpc834x_itxgp_defconfig
sparc                            alldefconfig
arc                           tb10x_defconfig
arm                        keystone_defconfig
xtensa                generic_kc705_defconfig
arm                          tango4_defconfig
mips                          ath79_defconfig
openrisc                    or1ksim_defconfig
powerpc                    mvme5100_defconfig
mips                           ip22_defconfig
sh                           se7705_defconfig
m68k                          hp300_defconfig
powerpc                    ge_imp3a_defconfig
sh                   sh7770_generic_defconfig
powerpc                     skiroot_defconfig
sh                           se7721_defconfig
arm                         bcm2835_defconfig
c6x                              allyesconfig
riscv                          rv32_defconfig
sh                         microdev_defconfig
sh                            shmin_defconfig
arm                          ixp4xx_defconfig
arm                     eseries_pxa_defconfig
c6x                        evmc6678_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     tqm8540_defconfig
mips                 decstation_r4k_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
h8300                            allyesconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20200925
i386                 randconfig-a006-20200925
i386                 randconfig-a003-20200925
i386                 randconfig-a004-20200925
i386                 randconfig-a005-20200925
i386                 randconfig-a001-20200925
i386                 randconfig-a002-20200927
i386                 randconfig-a006-20200927
i386                 randconfig-a003-20200927
i386                 randconfig-a004-20200927
i386                 randconfig-a005-20200927
i386                 randconfig-a001-20200927
i386                 randconfig-a002-20200926
i386                 randconfig-a006-20200926
i386                 randconfig-a003-20200926
i386                 randconfig-a004-20200926
i386                 randconfig-a005-20200926
i386                 randconfig-a001-20200926
x86_64               randconfig-a011-20200927
x86_64               randconfig-a013-20200927
x86_64               randconfig-a014-20200927
x86_64               randconfig-a015-20200927
x86_64               randconfig-a012-20200927
x86_64               randconfig-a016-20200927
x86_64               randconfig-a011-20200925
x86_64               randconfig-a013-20200925
x86_64               randconfig-a014-20200925
x86_64               randconfig-a015-20200925
x86_64               randconfig-a012-20200925
x86_64               randconfig-a016-20200925
i386                 randconfig-a012-20200926
i386                 randconfig-a014-20200926
i386                 randconfig-a016-20200926
i386                 randconfig-a013-20200926
i386                 randconfig-a011-20200926
i386                 randconfig-a015-20200926
i386                 randconfig-a012-20200927
i386                 randconfig-a014-20200927
i386                 randconfig-a016-20200927
i386                 randconfig-a013-20200927
i386                 randconfig-a011-20200927
i386                 randconfig-a015-20200927
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a005-20200927
x86_64               randconfig-a003-20200927
x86_64               randconfig-a004-20200927
x86_64               randconfig-a002-20200927
x86_64               randconfig-a006-20200927
x86_64               randconfig-a001-20200927
x86_64               randconfig-a011-20200926
x86_64               randconfig-a013-20200926
x86_64               randconfig-a014-20200926
x86_64               randconfig-a015-20200926
x86_64               randconfig-a012-20200926
x86_64               randconfig-a016-20200926
x86_64               randconfig-a005-20200925
x86_64               randconfig-a003-20200925
x86_64               randconfig-a004-20200925
x86_64               randconfig-a002-20200925
x86_64               randconfig-a006-20200925
x86_64               randconfig-a001-20200925

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
