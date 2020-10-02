Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B67280BA7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 02:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733288AbgJBAaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 20:30:19 -0400
Received: from mga14.intel.com ([192.55.52.115]:55450 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbgJBAaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 20:30:19 -0400
IronPort-SDR: s/WSo4wfgufbm0yU5kgSj9o9XXZiF/5IRaakrESFdxJBl4hNKJXghpxoWBGUkRT6sRINLIvP9s
 sBFw4PbtlFcA==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="162110764"
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="162110764"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 17:30:16 -0700
IronPort-SDR: v4IjWldxZDi6/GNa22v1PYSiiZ+TnU+vGg3F9hW23pCukdeWk29SbWsgwarbStBYvfGIrYxBhi
 ZJQTcrfmJ26A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="346274301"
Received: from lkp-server02.sh.intel.com (HELO de448af6ea1b) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 01 Oct 2020 17:30:14 -0700
Received: from kbuild by de448af6ea1b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kO8xh-0000nU-Md; Fri, 02 Oct 2020 00:30:13 +0000
Date:   Fri, 02 Oct 2020 08:29:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/asm] BUILD SUCCESS
 aa5cacdc29d76a005cbbee018a47faa6e724dd2d
Message-ID: <5f767487.R0/MigPAzy4eRq5e%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/asm
branch HEAD: aa5cacdc29d76a005cbbee018a47faa6e724dd2d  x86/asm: Replace __force_order with a memory clobber

elapsed time: 722m

configs tested: 156
configs skipped: 68

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
arm                          gemini_defconfig
mips                malta_qemu_32r6_defconfig
mips                          malta_defconfig
riscv                             allnoconfig
arm                              alldefconfig
mips                         tb0287_defconfig
arm                       cns3420vb_defconfig
arm                        realview_defconfig
csky                                defconfig
arm                         assabet_defconfig
mips                       rbtx49xx_defconfig
mips                malta_kvm_guest_defconfig
um                           x86_64_defconfig
sh                           se7724_defconfig
xtensa                    smp_lx200_defconfig
arm                     am200epdkit_defconfig
powerpc                 mpc834x_mds_defconfig
nds32                            alldefconfig
nios2                         10m50_defconfig
xtensa                       common_defconfig
sh                           sh2007_defconfig
powerpc                  iss476-smp_defconfig
mips                     cu1830-neo_defconfig
arm                            mmp2_defconfig
powerpc                    gamecube_defconfig
mips                          ath79_defconfig
arm                          simpad_defconfig
powerpc                 mpc832x_rdb_defconfig
sparc                            allyesconfig
microblaze                    nommu_defconfig
mips                  cavium_octeon_defconfig
arm                             mxs_defconfig
mips                             allyesconfig
microblaze                          defconfig
powerpc                   motionpro_defconfig
powerpc                 mpc837x_mds_defconfig
xtensa                           alldefconfig
arm                         nhk8815_defconfig
s390                       zfcpdump_defconfig
powerpc                       ppc64_defconfig
powerpc                     taishan_defconfig
arm                           spitz_defconfig
h8300                               defconfig
powerpc                      ppc6xx_defconfig
powerpc                    mvme5100_defconfig
arc                            hsdk_defconfig
m68k                           sun3_defconfig
arm                          pxa910_defconfig
sh                     magicpanelr2_defconfig
powerpc                      chrp32_defconfig
arm                           stm32_defconfig
x86_64                              defconfig
mips                      loongson3_defconfig
powerpc                      makalu_defconfig
arm                             pxa_defconfig
mips                           ip28_defconfig
arm                         hackkit_defconfig
sh                          rsk7269_defconfig
powerpc                      mgcoge_defconfig
arm                         axm55xx_defconfig
m68k                        m5307c3_defconfig
xtensa                  audio_kc705_defconfig
powerpc                          allmodconfig
microblaze                      mmu_defconfig
nios2                               defconfig
riscv                            alldefconfig
arm                         palmz72_defconfig
powerpc                     ksi8560_defconfig
sh                        sh7785lcr_defconfig
powerpc                 mpc8313_rdb_defconfig
s390                             alldefconfig
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
i386                                defconfig
sparc                               defconfig
mips                             allmodconfig
powerpc                          allyesconfig
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
x86_64               randconfig-a012-20201001
x86_64               randconfig-a015-20201001
x86_64               randconfig-a014-20201001
x86_64               randconfig-a013-20201001
x86_64               randconfig-a011-20201001
x86_64               randconfig-a016-20201001
i386                 randconfig-a011-20200930
i386                 randconfig-a015-20200930
i386                 randconfig-a012-20200930
i386                 randconfig-a014-20200930
i386                 randconfig-a016-20200930
i386                 randconfig-a013-20200930
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201001
x86_64               randconfig-a001-20201001
x86_64               randconfig-a002-20201001
x86_64               randconfig-a003-20201001
x86_64               randconfig-a005-20201001
x86_64               randconfig-a006-20201001
x86_64               randconfig-a001-20200930
x86_64               randconfig-a005-20200930
x86_64               randconfig-a003-20200930
x86_64               randconfig-a004-20200930
x86_64               randconfig-a002-20200930
x86_64               randconfig-a006-20200930

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
