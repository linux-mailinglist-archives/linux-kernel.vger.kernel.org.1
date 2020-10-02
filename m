Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50783280D87
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 08:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgJBGgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 02:36:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:14916 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgJBGgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 02:36:06 -0400
IronPort-SDR: UNZ3GynhKkAvUYkJmduLzt3xt/cnliKCtUj21AmR3lqlpTHTTzs/xglZBvyyCGkENtePJoeZmT
 2h2n/fMyEjMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="163007528"
X-IronPort-AV: E=Sophos;i="5.77,326,1596524400"; 
   d="scan'208";a="163007528"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 23:36:02 -0700
IronPort-SDR: wxevtzfYTb66fJENTqXAVRtHmeJ0z5+GgXGNH8i6KFtqt5jP+SHL7DuHXBuqogszYMShoVgDtl
 ZHwTXWoijPQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,326,1596524400"; 
   d="scan'208";a="352275621"
Received: from lkp-server02.sh.intel.com (HELO de448af6ea1b) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 01 Oct 2020 23:35:59 -0700
Received: from kbuild by de448af6ea1b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kOEff-0000s8-16; Fri, 02 Oct 2020 06:35:59 +0000
Date:   Fri, 02 Oct 2020 14:35:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/platform] BUILD SUCCESS
 a0947081af2ac9549e6ba19877456730713bde23
Message-ID: <5f76ca1a.HmqDd6Z2WdjgxI0E%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/platform
branch HEAD: a0947081af2ac9549e6ba19877456730713bde23  x86/uv/time: Use a flexible array in struct uv_rtc_timer_head

elapsed time: 722m

configs tested: 115
configs skipped: 62

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          landisk_defconfig
sh                             sh03_defconfig
arm64                            alldefconfig
powerpc                 mpc832x_mds_defconfig
powerpc                     rainier_defconfig
m68k                        mvme147_defconfig
m68k                          hp300_defconfig
arm                          gemini_defconfig
arc                      axs103_smp_defconfig
csky                             alldefconfig
sh                            shmin_defconfig
powerpc                        cell_defconfig
arm                           efm32_defconfig
arm                   milbeaut_m10v_defconfig
h8300                            alldefconfig
arm                           viper_defconfig
i386                             alldefconfig
parisc                              defconfig
powerpc                    klondike_defconfig
xtensa                              defconfig
sh                   rts7751r2dplus_defconfig
powerpc                 mpc85xx_cds_defconfig
h8300                     edosk2674_defconfig
sh                                  defconfig
arm                           omap1_defconfig
mips                   sb1250_swarm_defconfig
nios2                               defconfig
riscv                            alldefconfig
arm                         palmz72_defconfig
xtensa                  audio_kc705_defconfig
powerpc                     ksi8560_defconfig
sh                        sh7785lcr_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                    mvme5100_defconfig
powerpc                      ppc6xx_defconfig
s390                             alldefconfig
arm                          pxa910_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
i386                 randconfig-a003-20200930
i386                 randconfig-a002-20200930
i386                 randconfig-a006-20200930
i386                 randconfig-a005-20200930
i386                 randconfig-a004-20200930
i386                 randconfig-a001-20200930
x86_64               randconfig-a015-20200930
x86_64               randconfig-a013-20200930
x86_64               randconfig-a012-20200930
x86_64               randconfig-a016-20200930
x86_64               randconfig-a014-20200930
x86_64               randconfig-a011-20200930
i386                 randconfig-a011-20200930
i386                 randconfig-a015-20200930
i386                 randconfig-a012-20200930
i386                 randconfig-a014-20200930
i386                 randconfig-a016-20200930
i386                 randconfig-a013-20200930
i386                 randconfig-a014-20201001
i386                 randconfig-a015-20201001
i386                 randconfig-a013-20201001
i386                 randconfig-a016-20201001
i386                 randconfig-a011-20201001
i386                 randconfig-a012-20201001
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
x86_64               randconfig-a001-20200930
x86_64               randconfig-a005-20200930
x86_64               randconfig-a003-20200930
x86_64               randconfig-a004-20200930
x86_64               randconfig-a002-20200930
x86_64               randconfig-a006-20200930

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
